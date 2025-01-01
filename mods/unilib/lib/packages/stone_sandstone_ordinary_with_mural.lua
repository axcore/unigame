---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_ordinary_with_mural = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_ordinary_with_mural.init()

    return {
        description = "Sandstone with inscriptions",
        depends = {"dye_basic", "sand_ordinary", "stone_sandstone_ordinary_with_engraving"},
    }

end

function unilib.pkg.stone_sandstone_ordinary_with_mural.exec()

    local c_sand = "unilib:sand_ordinary"

    unilib.register_node(
        -- From farlands, decoblocks:sandstone_wall
        "unilib:stone_sandstone_ordinary_with_mural",
        "decoblocks:sandstone_wall",
        mode,
        {
            description = S("Sandstone with Inscriptions"),
            tiles = {
                "unilib_stone_sandstone_ordinary.png",
                "unilib_stone_sandstone_ordinary.png",
                "unilib_stone_sandstone_ordinary_with_mural_1.png",
                "unilib_stone_sandstone_ordinary_with_mural_2.png",
                "unilib_stone_sandstone_ordinary_with_mural_3.png",
                "unilib_stone_sandstone_ordinary_with_mural_4.png",
            },
            groups = {cracky = 3, stone = 2},
            sounds = unilib.global.sound_table.stone,

            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_ordinary_with_engraving_ankh",
        recipe = {
            {c_sand, "unilib:dye_white", c_sand},
            {"unilib:dye_red", c_sand, "unilib:dye_yellow"},
            {c_sand, "unilib:dye_brown", c_sand},
        },
    })

end
