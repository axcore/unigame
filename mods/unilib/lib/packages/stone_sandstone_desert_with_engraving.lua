---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_desert_with_engraving = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.tsm_pyramids.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_desert_with_engraving.init()

    return {
        description = "Desert sandstone engravings",
        depends = {"dye_basic", "sand_desert"},
    }

end

function unilib.pkg.stone_sandstone_desert_with_engraving.exec()

    local c_sand = "unilib:sand_desert"

    unilib.register_node(
        -- From tsm_pyramids:deco_stone1
        "unilib:stone_sandstone_desert_with_engraving_eye",
        "tsm_pyramids:deco_stone1",
        mode,
        {
            description = S("Desert Sandstone with Eye Engraving"),
            tiles = {"unilib_stone_sandstone_desert.png^unilib_stone_engraving_eye_overlay.png"},
            groups = {cracky = 3, crumbly = 2},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_desert_with_engraving_eye",
        recipe = {
            {c_sand, "unilib:dye_blue", c_sand},
            {"unilib:dye_blue", c_sand, "unilib:dye_blue"},
            {c_sand, "unilib:dye_blue", c_sand},
        },
    })

    unilib.register_node(
        -- From tsm_pyramids:deco_stone2
        "unilib:stone_sandstone_desert_with_engraving_man",
        "tsm_pyramids:deco_stone2",
        mode,
        {
            description = S("Desert Sandstone with Man Engraving"),
            tiles = {"unilib_stone_sandstone_desert.png^unilib_stone_engraving_man_overlay.png"},
            groups = {cracky = 3, crumbly = 2},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_desert_with_engraving_man",
        recipe = {
            {c_sand, "unilib:dye_brown", c_sand},
            {c_sand, "unilib:dye_brown", c_sand},
            {"unilib:dye_brown", c_sand, "unilib:dye_brown"},
        },
    })

    unilib.register_node(
        -- From tsm_pyramids:deco_stone3
        "unilib:stone_sandstone_desert_with_engraving_sun",
        "tsm_pyramids:deco_stone3",
        mode,
        {
            description = S("Desert Sandstone with Sun Engraving"),
            tiles = {"unilib_stone_sandstone_desert.png^unilib_stone_engraving_sun_overlay.png"},
            groups = {cracky = 3, crumbly = 2},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_desert_with_engraving_sun",
        recipe = {
            {c_sand, "unilib:dye_yellow", c_sand},
            {"unilib:dye_yellow", c_sand, "unilib:dye_yellow"},
            {c_sand, "unilib:dye_yellow", c_sand},
        },
    })

    unilib.register_node(
        -- From tsm_pyramids:deco_stone4
        "unilib:stone_sandstone_desert_with_engraving_ankh",
        "tsm_pyramids:deco_stone4",
        mode,
        {
            description = S("Desert Sandstone with Ankh Engraving"),
            tiles = {"unilib_stone_sandstone_desert.png^unilib_stone_engraving_ankh_overlay.png"},
            groups = {cracky = 3, crumbly = 2},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_desert_with_engraving_ankh",
        recipe = {
            {c_sand, "unilib:dye_white", c_sand},
            {"unilib:dye_white", c_sand, "unilib:dye_white"},
            {c_sand, "unilib:dye_white", c_sand},
        },
    })

    unilib.register_node(
        -- From tsm_pyramids:deco_stone5
        "unilib:stone_sandstone_desert_with_engraving_scarab",
        "tsm_pyramids:deco_stone5",
        mode,
        {
            description = S("Desert Sandstone with Scarab Engraving"),
            tiles = {"unilib_stone_sandstone_desert.png^unilib_stone_engraving_scarab_overlay.png"},
            groups = {cracky = 3, crumbly = 2},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_desert_with_engraving_scarab",
        recipe = {
            {c_sand, "unilib:dye_red", c_sand},
            {"unilib:dye_red", c_sand, "unilib:dye_red"},
            {c_sand, "unilib:dye_red", c_sand},
        },
    })

    unilib.register_node(
        -- From tsm_pyramids:deco_stone6
        "unilib:stone_sandstone_desert_with_engraving_cactus",
        "tsm_pyramids:deco_stone6",
        mode,
        {
            description = S("Desert Sandstone with Cactus Engraving"),
            tiles = {"unilib_stone_sandstone_desert.png^unilib_stone_engraving_cactus_overlay.png"},
            groups = {cracky = 3, crumbly = 2},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_desert_with_engraving_cactus",
        recipe = {
            {"unilib:dye_green", c_sand, "unilib:dye_green"},
            {c_sand, "unilib:dye_green", c_sand},
            {c_sand, "unilib:dye_green", c_sand},
        },
    })

end
