---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_fungus_glowing_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_fungus_glowing_purple.init()

    return {
        description = "Ordinary stone with purple glowing fungus",
        depends = {"plant_fungus_glowing_purple", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_fungus_glowing_purple.exec()

    unilib.register_node(
        -- From valleys_c:glowing_fungal_stone
        "unilib:stone_ordinary_with_fungus_glowing_purple",
        "valleys_c:glowing_fungal_stone",
        mode,
        {
            description = S("Ordinary Stone with Purple Glowing Fungus"),
            tiles = {
                "unilib_stone_ordinary.png" ..
                        "^unilib_stone_ordinary_with_fungus_glowing_purple_overlay.png",
            },
            groups = {cracky = 3, stone = 1},
            sounds = unilib.global.sound_table.stone,

            drop = {
                items = {
                    {items = {"unilib:stone_ordinary_cobble"}},
                    {items = {"unilib:plant_fungus_glowing_purple"}},
                },
            },
            light_source = 8,
        }
    )

end
