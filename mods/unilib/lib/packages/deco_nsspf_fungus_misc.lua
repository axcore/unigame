---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_nsspf_fungus_misc = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_nsspf_fungus_misc.init()

    return {
        description = "NSSPF fungi as decoration",
        notes = "Provides pseudo-decorations for fungi growing on or near trees",
        depends = "shared_nsspf",
        at_least_one = {
            "plant_fungus_beefsteak",
            "plant_fungus_honey",
            "plant_fungus_nightlight",
            "plant_fungus_pingpong_bats",
            "plant_fungus_tinder",
        },
        optional = {
            "dirt_ordinary",
            "dirt_ordinary_with_cover_snow",
            "dirt_ordinary_with_litter_coniferous",
            "dirt_ordinary_with_turf",
            "snow_ordinary",
            "tree_apple",
            "tree_aspen",
            "tree_pine",
        },
    }

end

function unilib.pkg.deco_nsspf_fungus_misc.post()

    if unilib.global.pkg_executed_table["plant_fungus_beefsteak"] ~= nil and
            unilib.global.pkg_executed_table["tree_pine"] ~= nil and
            unilib.global.pkg_executed_table["snow_ordinary"] ~= nil and (
                unilib.global.pkg_executed_table["dirt_ordinary_with_cover_snow"] ~= nil or
                unilib.global.pkg_executed_table["dirt_ordinary_with_litter_coniferous"] ~= nil
            ) then

        unilib.pkg.shared_nsspf.register_fungus({
            -- Code original to unilib, replacing an ABM in the original code
            wall_name = "unilib:tree_pine_trunk",
            plant_name = "unilib:plant_fungus_beefsteak",

            surface_list = {
                "unilib:dirt_ordinary_with_cover_snow",
                "unilib:dirt_ordinary_with_litter_coniferous",
            },
            dust_list = {"unilib:snow_ordinary"},
        })

    end

    if unilib.global.pkg_executed_table["plant_fungus_honey"] ~= nil and
            unilib.global.pkg_executed_table["tree_apple"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf"] ~= nil then

        unilib.pkg.shared_nsspf.register_fungus({
            -- Code original to unilib, replacing an ABM in the original code
            wall_name = "unilib:tree_apple_trunk",
            plant_name = "unilib:plant_fungus_honey",

            surface_list = {"unilib:dirt_ordinary_with_turf"},
        })

    end

    if unilib.global.pkg_executed_table["plant_fungus_nightlight"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.pkg.shared_nsspf.register_fungus({
            -- Code original to unilib, replacing an ABM in the original code
            -- N.B. Grows on the side of a dirt node, rather than on a tree node, as usual
            wall_name = "unilib:dirt_ordinary",
            plant_name = "unilib:plant_fungus_nightlight",
        })

    end

    if unilib.global.pkg_executed_table["plant_fungus_pingpong_bats"] ~= nil and
            unilib.global.pkg_executed_table["tree_apple"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf"] ~= nil then

        unilib.pkg.shared_nsspf.register_fungus({
            -- Code original to unilib, replacing an ABM in the original code
            wall_name = "unilib:tree_apple_trunk",
            plant_name = "unilib:plant_fungus_pingpong_bats",

            surface_list = {"unilib:dirt_ordinary_with_turf"},
        })

    end

    if unilib.global.pkg_executed_table["plant_fungus_tinder"] ~= nil and
            unilib.global.pkg_executed_table["tree_aspen"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf"] ~= nil then

        unilib.pkg.shared_nsspf.register_fungus({
            -- Code original to unilib, replacing an ABM in the original code
            wall_name = "unilib:tree_aspen_trunk",
            plant_name = "unilib:plant_fungus_tinder",

            surface_list = {"unilib:dirt_ordinary_with_turf"},
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
]]--
