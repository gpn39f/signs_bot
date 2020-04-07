--[[

	Signs Bot
	=========

	Copyright (C) 2019-2020 Joachim Stolberg

	GPL v3
	See LICENSE.txt for more information
	
	Bot flower cutting command
]]--

-- for lazy programmers
local S = function(pos) if pos then return minetest.pos_to_string(pos) end end
local P = minetest.string_to_pos
local M = minetest.get_meta

-- Load support for intllib.
local MP = minetest.get_modpath("signs_bot")
local I,_ = dofile(MP.."/intllib.lua")

local lib = signs_bot.lib

local bot_inv_put_item = signs_bot.bot_inv_put_item
local bot_inv_take_item = signs_bot.bot_inv_take_item

local Flowers = {}
local Mushrooms = {}

function signs_bot.register_flower(name)
	Flowers[name] = true
end

function signs_bot.register_mushroom(name)
	Mushrooms[name] = true
end

minetest.after(1, function()
	for name,_ in pairs(minetest.registered_decorations) do
		if type(name) == "string" then
			local mod = string.split(name, ":")
			if #mod > 1 and mod[1] == "flowers" then
				local typ = string.split(mod[2], "_")
				if #typ > 1 and typ[1] == "mushroom" then
					signs_bot.register_mushroom(name)
				else
					signs_bot.register_flower(name)
				end
			end
		end
	end
end)

local function soil_availabe(pos)
	local node = minetest.get_node_or_nil(pos)
	if node.name == "air" then
		node = minetest.get_node_or_nil({x=pos.x, y=pos.y-1, z=pos.z})
		if node and minetest.get_item_group(node.name, "soil") >= 1 then
			return true
		end
	end
	return false
end

local function is_mushroom(name)
	return Mushrooms[name]
end

local function is_flower(name)
	return Flowers[name]
end

bitOR, bitXOR, bitAND = 1, 3, 4

local function bitoper(a, b, oper)
   local r, m, s = 0, 2^52
   repeat
      s,a,b = a+b+m, a%m, b%m
      r,m = r + m*oper%(s-a-b), m/2
   until m < 1
   return r
end

local function harvesting(base_pos, mem, active) -- 1 = doFlowers, 2 = doMushrooms 
	active = active or 0
	local doMushroom = bitoper(active, 2, bitAND) == 2
    local doFlower = bitoper(active, 1, bitAND) == 1
	local pos = mem.pos_tbl and mem.pos_tbl[mem.steps]
	mem.steps = (mem.steps or 1) + 1
	if pos and lib.not_protected(base_pos, pos) then
		local node = minetest.get_node_or_nil(pos)
		if is_flower(node.name) and doFlower then			
			minetest.remove_node(pos)
			bot_inv_put_item(base_pos, 0,  ItemStack(node.name))
		end
		if is_mushroom(node.name) and doMushroom then
			minetest.remove_node(pos)
			bot_inv_put_item(base_pos, 0,  ItemStack(node.name))
		end
	end
end

signs_bot.register_botcommand("cutting", {
	mod = "farming",
	params = "",	
	description = I("Cutting flowers\nin front of the robot\non a 3x3 field."),
	cmnd = function(base_pos, mem)
		if not mem.steps then
			mem.pos_tbl = signs_bot.lib.gen_position_table(mem.robot_pos, mem.robot_param2, 3, 3, 0)
			mem.steps = 1
		end
		mem.pos_tbl = mem.pos_tbl or {}
		harvesting(base_pos, mem, 1)
		if mem.steps > #mem.pos_tbl then
			mem.steps = nil
			return lib.DONE
		end
		return lib.BUSY
	end,
})

signs_bot.register_botcommand("gathering", {
	mod = "farming",
	params = "",	
	description = I("gather mushrooms\nin front of the robot\non a 3x3 field."),
	cmnd = function(base_pos, mem)
		if not mem.steps then
			mem.pos_tbl = signs_bot.lib.gen_position_table(mem.robot_pos, mem.robot_param2, 3, 3, 0)
			mem.steps = 1
		end
		mem.pos_tbl = mem.pos_tbl or {}
		harvesting(base_pos, mem, 2)
		if mem.steps > #mem.pos_tbl then
			mem.steps = nil
			return lib.DONE
		end
		return lib.BUSY
	end,
})

local CMD1 = [[dig_sign 1
move
cutting
backward
place_sign 1
turn_around]]

signs_bot.register_sign({
	name = "flowers", 
	description = I('Sign "flowers"'), 
	commands = CMD1, 
	image = "signs_bot_sign_flowers.png",
})

minetest.register_craft({
	output = "signs_bot:flowers 2",
	recipe = {
		{"group:wood", "default:stick", "group:wood"},
		{"dye:black", "default:stick", "dye:yellow"},
		{"dye:red", "", ""}
	}
})

if minetest.get_modpath("doc") then
	doc.add_entry("signs_bot", "flowers", {
		name = I("Sign 'flowers'"),
		data = {
			item = "signs_bot:flowers",
			text = table.concat({
				I("Used to cut flowers on a 3x3 field."),
				I("Place the sign in front of the field."), 
				I("When needed place Sign-Mushroom into 2"),
				I("When finished, the bot turns."),
			}, "\n")		
		},
	})
end

local CMD2 = [[dig_sign 2
move
gathering
backward
place_sign 2
turn_around]]

signs_bot.register_sign({
	name = "mushroom", 
	description = I('Sign "mushroom"'), 
	commands = CMD2, 
	image = "signs_bot_sign_mushrooms.png",
})

minetest.register_craft({
	output = "signs_bot:mushroom 2",
	recipe = {
		{"group:wood", "default:stick", "group:wood"},
		{"dye:black", "default:stick", "dye:red"},
		{"dye:yellow", "", ""}
	}
})

if minetest.get_modpath("doc") then
	doc.add_entry("signs_bot", "mushroom", {
		name = I("Sign 'mushroom'"),
		data = {
			item = "signs_bot:mushroom",
			text = table.concat({
				I("Used to cut mushroom on a 3x3 field."),
				I("Place the sign in front of the field."), 
				I("When needed place Sign-Flower into 1"),
				I("When finished, the bot turns."),
			}, "\n")		
		},
	})
end