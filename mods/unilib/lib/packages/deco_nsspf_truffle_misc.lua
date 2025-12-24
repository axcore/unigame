---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_nsspf_truffle_misc = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_nsspf_truffle_misc.init()

    return {
        description = "NSSPF truffles as decoration",
        notes = "Provides pseudo-decorations for mushrooms growing on or near trees",
        depends = "shared_nsspf",
        at_least_one = {
            "plant_tuber_truffle_bianchetto",
            "plant_tuber_truffle_black",
            "plant_tuber_truffle_desert",
            "plant_tuber_truffle_white",
        },
        optional = {
            "dirt_dry_with_turf_dry",
            "dirt_ordinary_with_turf",
            "tree_acacia",
            "tree_apple",
            "tree_aspen",
        },
    }

end

function unilib.pkg.deco_nsspf_truffle_misc.post()

    if unilib.global.pkg_executed_table["plant_tuber_truffle_bianchetto"] ~= nil and
            unilib.global.pkg_executed_table["tree_aspen"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf"] ~= nil then

        unilib.pkg.shared_nsspf.register_truffle_location({
            wall_name = "unilib:tree_aspen_trunk",
            part_name = "bianchetto",
            surface_list = {"unilib:dirt_ordinary_with_turf"},
        })

    end

    if unilib.global.pkg_executed_table["plant_tuber_truffle_black"] ~= nil and
            unilib.global.pkg_executed_table["tree_apple"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf"] ~= nil then

        unilib.pkg.shared_nsspf.register_truffle_location({
            wall_name = "unilib:tree_apple_trunk",
            part_name = "black",
            surface_list = {"unilib:dirt_ordinary_with_turf"},
        })

    end

    if unilib.global.pkg_executed_table["plant_tuber_truffle_desert"] ~= nil and
            unilib.global.pkg_executed_table["tree_acacia"] ~= nil and
            unilib.global.pkg_executed_table["dirt_dry_with_turf_dry"] ~= nil then

        unilib.pkg.shared_nsspf.register_truffle_location({
            wall_name = "unilib:tree_acacia_trunk",
            part_name = "desert",
            surface_list = {"unilib:dirt_dry_with_turf_dry"},
        })

    end

    if unilib.global.pkg_executed_table["plant_tuber_truffle_white"] ~= nil and
            unilib.global.pkg_executed_table["tree_apple"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf"] ~= nil then

        unilib.pkg.shared_nsspf.register_truffle_location({
            wall_name = "unilib:tree_apple_trunk",
            part_name = "white",
            surface_list = {"unilib:dirt_ordinary_with_turf"},
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
]]--
