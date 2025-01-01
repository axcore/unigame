---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_baked_ethereal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_baked_ethereal.init()

    return {
        description = "Baked clay nodes from ethereal-ng, created only if the" ..
            " \"clay_baked_basic\" package is not loaded",
        optional = "clay_baked_basic",
    }

end

function unilib.pkg.clay_baked_ethereal.exec()

    if unilib.global.pkg_executed_table["clay_baked_basic"] == nil then

        unilib.register_node("unilib:clay_baked_red", "bakedclay:red", mode, {
            -- From ethereal-ng, bakedclay:red
            description = S("Red Baked Clay"),
            tiles = {"unilib_clay_baked_red.png"},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        })

        unilib.register_node("unilib:clay_baked_orange", "bakedclay:orange", mode, {
            -- From ethereal-ng, bakedclay:orange
            description = S("Orange Baked Clay"),
            tiles = {"unilib_clay_baked_orange.png"},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        })

        unilib.register_node("unilib:clay_baked_grey", "bakedclay:grey", mode, {
            -- From ethereal-ng, bakedclay:grey
            description = S("Grey Baked Clay"),
            tiles = {"unilib_clay_baked_grey.png"},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        })

        unilib.register_node("unilib:clay_baked_brown", "bakedclay:brown", mode, {
            -- From ethereal-ng, bakedclay:brown
            description = S("Brown Baked Clay"),
            tiles = {"unilib_clay_baked_brown.png"},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        })

    end

end
