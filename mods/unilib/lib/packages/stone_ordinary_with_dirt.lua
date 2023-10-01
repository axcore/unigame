---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_dirt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_dirt.init()

    return {
        description = "Ordinary stone with dirt",
    }

end

function unilib.pkg.stone_ordinary_with_dirt.exec()

    unilib.register_node("unilib:stone_ordinary_with_dirt", "lib_materials:dirt_stone", mode, {
        -- From GLEMr4, lib_materials:dirt_stone
        description = S("Ordinary Stone with Dirt"),
        tiles = {
            "unilib_stone_ordinary.png^(unilib_dirt_ordinary.png^[mask:unilib_mask_stone.png)",
        },
        groups = {cracky = 3, stone = 2},
        -- N.B. sounds missing in original code
        sounds = unilib.sound_table.stone,
    })

    unilib.register_node(
        -- From GLEMr4, lib_materials:dirt_cobble_stone
        "unilib:stone_ordinary_cobble_with_dirt",
        "lib_materials:dirt_cobble_stone",
        mode,
        {
            description = S("Ordinary Cobblestone with Dirt"),
            tiles = {
                "unilib_stone_ordinary_cobble.png^" ..
                        "(unilib_dirt_ordinary.png^[mask:unilib_mask_stone_cobble.png)",
            },
            groups = {cracky = 3, stone = 2},
            -- N.B. sounds missing in original code
            sounds = unilib.sound_table.stone,
        }
    )

end
