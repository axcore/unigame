---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_dirt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_dirt.init()

    return {
        description = "Desert stone with dirt",
    }

end

function unilib.pkg.stone_desert_with_dirt.exec()

    unilib.register_node("unilib:stone_desert_with_dirt", nil, mode, {
        -- Original to unilib, adapted from GLEMr4, lib_materials:dirt_stone
        description = S("Desert Stone with Dirt"),
        tiles = {
            "unilib_stone_desert.png^(unilib_dirt_ordinary.png^[mask:unilib_mask_stone.png)",
        },
        groups = {cracky = 3, stone = 2},
        -- N.B. sounds missing in original code
        sounds = unilib.sound_table.stone,
    })

    unilib.register_node(
        -- From GLEMr6, lib_materials:dirt_desert_cobble_stone
        "unilib:stone_desert_cobble_with_dirt",
        "lib_materials:dirt_desert_cobble_stone",
        mode,
        {
            description = S("Desert Cobblestone with Dirt"),
            tiles = {
                "unilib_stone_desert_cobble.png^" ..
                        "(unilib_dirt_ordinary.png^[mask:unilib_mask_stone_cobble.png)",
            },
            groups = {cracky = 3, stone = 2},
            -- N.B. sounds missing in original code
            sounds = unilib.sound_table.stone,
        }
    )

end
