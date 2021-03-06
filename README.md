Signs Bot [signs_bot]
=====================

**A robot controlled by signs.**

Browse on: ![GitHub](https://github.com/joe7575/signs_bot)

Download: ![GitHub](https://github.com/joe7575/signs_bot/archive/master.zip)

![Signs Bot](https://github.com/joe7575/signs_bot/blob/master/screenshot.png)


The bot can only be controlled by signs that are placed in its path.
The bot starts running after starting until it encounters a sign. There, the commands are then processed on the sign.
The bot can also put himself signs in the way, which he then works off.
There is also a sign that can be programmed by the player, which then are processed by the bot.

There are also the following blocks:
- Sensors: These can send a signal to an actuator if they are connected to the actuator.
- Actuators: These perform an action when they receive a signal from a sensor.

Sensors must be connected (paired) with actuators. This is what the Connection Tool does. Click on both blocks one after the other.
A successful pairing is indicated by a ping / pong noise.
When pairing, the state of the actuator is important. In the case of the bot box, for example, the states "on" and "off", in the case of the control unit 1,2,3,4, etc.
The state of the actuator is saved with the pairing and restored by the signal. For example, the robot can be switched on via a node sensor.

An actuator can receive signals from many sensors. A sensor can only be connected to an actuator. However, if several actuators are to be controlled by one sensor, a signal extender block must be used. This connects to a sensor when it is placed next to the sensor. This extender can then be paired with another actuator.

Sensors are:
- Bot Sensor: Sends a signal when the robot passes by
- Node Sensor: Sends a signal when it detects a change (tree, cactus, flower, etc.) in front of the sensor (over 3 positions)
- Crop Sensor: Sends a signal when, for example, the wheat is fully grown
- Bot Chest: Sends a signal depending on the chest state. Possible states are "empty", "not empty", "almost full". The state to be sent is defined while pairing.

Actuators are:
- Control Unit: Can place up to 4 signs and steer the bot e.g. in different directions.
- Signs Bot Box: Can be turned off and on

In addition, there are currently the following blocks:
- The duplicator is used to copy Command Signs, i.e. the signs with their own commands.
- Bot Flap: The "cat flap" is a door for the bot, which he opens automatically and closes behind him.
- Sensor Extender for controlling additional actuators from one sensor signal
- A Timer can be used to start the Bot cyclically
- A Delayer can be used to delay and queue signals

More information:
- Using the signs "take" and "add", the bot can pick items from Chests and put them in. The signs must be placed on the box. So far, only a few blocks are supported with Inventory.
- The Control Unit can be charged with up to 4 labels. To do this, place a label next to the Control Unit and click on the Control Unit. The sign is only stored under this number.
- The inventory of the Signs Bot Box is intended to represent the inventory of the Robot. As long as the robot is on the road, of course you have no access.

The copy function can be used to clone node cubes up to 5x3x3 nodes. There is the pattern shield for the template position and the copy shield for the "3x3x3" copy. Since the bot also copies air blocks, the function can also be used for mining or tunnels. The items to be placed must be in the inventory. Items that the bot degrades are in Inventory afterwards. If there are missing items in the inventory during copying, he will set "missing items" blocks, which dissolve into air when degrading.

In-game help:
The mod has an in-game help to all blocks and signs. Therefore, it is highly recommended that you have installed the mods 'doc' and 'unified_inventory'.

Commands:
The commands are also all described as help in the "Sign command" node.
All blocks or signs that are set are taken from the bot inventory.
Any blocks or signs removed will be added back to the Bot Inventory.
For all Inventory commands applies: If the inventory stack specified by <slot> is full, so that nothing more can be done, or just empty, so that nothing more can be removed, the next slot will automatically be used.

    move <steps>              - to follow one or more steps forward without signs
    cond_move                 - walk to the next sign and work it off
    turn_left                 - turn left
    turn_right                - turn right
    turn_around               - turn around
    backward                  - one step backward
    turn_off                  - turn off the robot / back to the box
    pause <sec>               - wait one or more seconds
    move_up                   - move up (maximum 2 times)
    move_down                 - move down
    take_item <num> <slot>    - take one or more items from a box
    add_item <num> <slot>     - put one or more items in a box
    add_fuel <num> <slot>     - for furnaces or similar
    place_front <slot> <lvl>  - Set block in front of the robot
    place_left <slot> <lvl>   - Set block to the left
    place_right <slot> <lvl>  - set block to the right
    place_below <slot>        - set block under the robot
    place_above <slot>        - set block above the robot
    dig_front <slot> <lvl>    - remove block in front of the robot
    dig_left <slot> <lvl>     - remove block on the left
    dig_right <slot> <lvl>    - remove block on the right
    dig_below <slot>          - dig block under the robot
    dig_above <slot>          - dig block above the robot
    place_sign <slot>         - set sign
    place_sign_behind <slot>  - put a sign behind the bot
    dig_sign <slot>           - remove the sign
    trash_sign <slot>         - Remove the sign, clear data and add to the item Inventory
    stop                      - Bot stops until the shield is removed
    pickup_items <slot>       - pickup items (in a 3x3 field)
    drop_items <num> <slot>   - drop items
    harvest                   - harvest a 3x3 field (farming)
    cutting                   - cut a 3x3 flower field
    sow_seed <slot>           - a 3x3 field sowing / planting
    plant_sapling <slot>      - plant a sapling in front of the robot
    pattern                   - save the blocks behind the shield (up to 5x3x3) as template
    copy <size>               - make a copy of "pattern". Size is e.g. 3x3 (see ingame help)
    punch_cart                - Punch a rail cart to start it

### License
Copyright (C) 2019-2020 Joachim Stolberg  
Code: Licensed under the GNU GPL version 3 or later. See LICENSE.txt  


### Dependencies 
default, farming, basic_materials, tubelib2
optional: farming redo, node_io, doc, techage, minecart


### History
- 2019-03-23  v0.01  * first draft
- 2019-04-06  v0.02  * completely reworked
- 2019-04-08  v0.03  * 'plant_sapling', 'place_below', 'dig_below' added, many bugs fixed
- 2019-04-11  v0.04  * support for 'node_io' added, chest added, further commands added
- 2019-04-14  v0.05  * timer added, user signs added, bug fixes
- 2019-04-15  v0.06  * nodes remove bugfix, punch_cart command added, cart sensor added
- 2019-04-18  v0.07  * node_io is now optional, support for MTG chests and furnace added
- 2019-05-22  v0.08  * recipe bug fixes and prepared for techage
- 2019-05-25  v0.09  * in-game help added for the mod 'doc'
- 2019-07-05  v0.10  * Timer, sensor and cart handling improvements
- 2019-07-08  v0.11  * Delayer added
- 2019-08-09  v0.12  * bug fixes
- 2019-08-14  v0.13  * Signs Bot Chest recipe added, Minecart signs added
- 2020-01-02  v1.00  * bot inventory filter added, documentation enhanced
- 2020-03-27  v1.01  * flower command and sign added

