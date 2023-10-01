#Mod developer’s documentation for the Pedology mod for Minetest
##Nodes
###Ground nodes
The ground nodes are the most basic nodes in this mod. They mainly differ in density. Except coarse sand, all ground nodes can be wet between a wetness level between 0 (dry) and 5 (slurry). Each ground type has a maximum wetness level. It is intended for later versions to reserve wetness levels 4 and 5 for mud (high-viscosity liquids), whereas levels 0-3 are used for solid blocks.

Here is the list of ground blocks with the maximum wetness level:

* clay: 5
* fine silt: 5
* medium silt: 4
* coarse silt: 3
* fine sand: 2
* medium sand: 1
* coarse sand: 0
* fine gravel: 1
* medium gravel: 2
* coarse gravel: 2

Currently, sand and gravel are *not* affected by gravity.

###Air and vacuum
As an experimental feature, Pedology adds two new air node type and a vacuum node type:

* thin air
* very thin air
* vacuum

All three behave like the ordinary air. The vacuum is special as it removes 4 hearts per seconds for any lifeform which is inside it. The other node types have no special properties.

It has yet to be decided wheather these nodes are kept.

###Liquids
Yes, there are some water and lava nodes, but are currently experimental.

##Itemstrings

###Ground nodes
The itemstrings of all ground nodes follow this pattern:

    pedology:<type>_<wetness>

where “`<type>`” is replaced with the ground type and “`wetness`” with the wetness level

####Types
* clay: `clay`
* fine silt: `silt_fine`
* medium silt: `silt_medium`
* coarse silt: `silt_coarse`
* fine sand: `sand_fine`
* medium sand: `sand_medium`
* coarse sand: `sand_coarse`
* fine gravel: `gravel_fine`
* medium gravel: `gravel_medium`
* coarse gravel: `gravel_coarse`

####Example
The itemstring for “dry clay” is “`pedology:clay_0`”

###Air
- thin air: `pedology:air_thinair1`
- very thin air: `pedology:air_thinair2`
- vacuum: `pedology:vacuum`

##Groups
###Used groups
The mod uses the following existing groups:
* `water`: A value of 1 means the node is water. This group is used to wetten `sucky` nodes.
* `not_in_creative_inventory`: For value of 1: This node type should not be added into creative inventories. This group is used by the `creative` mod of `minetest_game`, for example.
* `crumbly`: Used for compatibility with `minetest_game`. Usage may change in the future.
* `sand`: 1 means the node is sand. Used for compatiblity with `minetest_game`. Usage may change in the future.
* `flammable`: Used by turf (value: 1), indicates the nodes are flammable. Value can range from 1-3, 1 being the slowest.

###New groups
The mod introduces the following groups:

* `wet`: Wetness level. Currently, the wetness level ranges from 0 to 5. The wetness descriptions are:
 * `0`: dry (solid) (node is not member of the `wet` group)
 * `1`: wet (solid)
 * `2`: watery (solid)
 * `3`: sludgy (solid)
 * `4`: muddy (now solid, liquid in later versions)
 * `5`: slurry (now solid, liquid in later versions)
* `sucky`: Suckyness. Declares a node to “suck” wetness from `water` and `oozing` nodes. Any non-zero value makes the node a “sucky” node
* `oozing`: Oozing level. Members of this group can transfer their wetness to `sucky` nodes. Any non-zero value makes the node an “oozing” node. Maybe different oozing levels will be used in future.
Nodes should be only added to this group if they are also wet.
* `melting_point`: the minimal temperature at which the node becomes destroyed. This depends on the `hot`ness of neighbor nodes. Planned for later versions.
* `hot`: The temperature of the node. Not used yet, but intended for lava, therefore planned for late versions.
* `sun_dry`: If 1, the node may dry off over time when it is in direct sun light

##Functions
###`pedology.dry(pos)`
Reduces the `wet`ness level of the node at `pos` by `1`, if possible. This is done by replacing the node with a “drier” version of it, if available.
####Parameters
* `pos`: Position of node, specified as a table of the format `{ x = x, y = y, z = z}`

####Return value
`nil`

###`pedology.wetten(pos)`
Increases the `wet`ness level of the node at `pos` by `1`, if possible. This is done by replacing the node with a “wetter” version of it, if available.
####Parameters
* `pos`: Position of node, specified as a table of the format `{ x = x, y = y, z = z}`
####Return value
`nil`

###`pedology.register_sucky_group(basename, basedescription, lumpdescription, maxwet, oozeinterval, oozechance, melttable, dropcount, sounds, additional_groups)`
Registers a bunch of `sucky` and `oozing` nodes to Pedology . This function assumes that textures are ready for the node, one texture for each `wet`ness level (up to `maxwet`). They have to be named according to the pattern `pedology_<basename>_<wetness>.png` and must reside in the `textures` folder. Example name: `pedology_clay_0.png` is the texture for dry clay, `pedology_clay_1.png` is texture for wet clay, and so on.
####Parameters
* `basename`: A part of the internal itemstring of all the nodes to be registered. The full itemstring for a node would be “`pedology:<basename>_<wetness>`, where “`<basename>`” is replaced with the given `basename` and “`<wetness`>” is replaced with the wetness level (a single digit). This parameter is also used to find the textures.
* `basedescription`: A part of the user-visible description for each node. The full description is built from the template “`<wetnessstring> <basedescription>`. `<wetnessstring>` would be “dry”, “wet”, “watery”, “sludgy”, “muddy” or “slurry”.
* `lumpdescription`: The full description of the “lump” version of the block (if any)
* `maxwet`: The maximum `wet`ness level of the nodes. Must be at least 0 and at most 5.
* `oozeinterval`: The interval in seconds in which the node may ooze its wetness to other nodes (Minimum: 1)
* `oozechance`: The interted chance (`1/oozechance`) to ooze each time the `oozeinterval` has passed.
* `melttable`: Table of `melting_point` values for each `wet`ness level. The table length must equal `maxwet+1`. This parameter may alternatively be nil (all nodes are indestructible by heat then). Note that lava and melting points are not implemented yet.
* `dropcount`: How many lumps nodes of this group drop, when mined. If 0, they simply drop themselves (NOT recommended)
* `sounds`: Sound specification for every node (Definition is the same as for `minetest.register_node`).
* `additional_groups`: Table of additional groups for every node. May also be empty or nil, meaning no additional groups will be added.

####Return value
`nil`
