---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_nsspf_mushroom_misc = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_nsspf_mushroom_misc.init()

    return {
        description = "NSSPF mushrooms as decoration",
        notes = "Provides pseudo-decorations for mushrooms growing on or near trees",
        depends = {"dirt_ordinary_with_litter_rainforest", "shared_nsspf", "tree_jungle"},
        at_least_one = {
            "mushroom_azurea",
            "mushroom_reishi",
            "mushroom_pink_bonnet",
            "mushroom_hairy",
        },
    }

end

function unilib.pkg.deco_nsspf_mushroom_misc.post()

    -- unilib.pkg.shared_nsspf.register_mushroom()

    if unilib.global.pkg_executed_table["mushroom_azurea"] ~= nil then

        unilib.pkg.shared_nsspf.register_mushroom({
            -- Code original to unilib, replacing an ABM in the original code
            wall_name = "unilib:tree_jungle_trunk",
            plant_name = "unilib:mushroom_azurea",

            surface_list = {"unilib:dirt_ordinary_with_litter_rainforest"},
        })

    end

    if unilib.global.pkg_executed_table["mushroom_reishi"] ~= nil then

        unilib.pkg.shared_nsspf.register_mushroom({
            -- Code original to unilib, replacing an ABM in the original code
            wall_name = "unilib:tree_jungle_trunk",
            plant_name = "unilib:mushroom_reishi",

            surface_list = {"unilib:dirt_ordinary_with_litter_rainforest"},
        })

    end

    -- unilib.pkg.shared_nsspf.register_special

    -- (These mushrooms grow on the top surface of a jungle tree trunk)
    if unilib.global.pkg_executed_table["mushroom_hairy"] ~= nil then

        unilib.pkg.shared_nsspf.register_special(
            "unilib:mushroom_hairy",
            "unilib:tree_jungle_trunk"
        )

    end

    if unilib.global.pkg_executed_table["mushroom_pink_bonnet"] ~= nil then

        unilib.pkg.shared_nsspf.register_special(
            "unilib:mushroom_pink_bonnet",
            "unilib:tree_jungle_trunk"
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
]]--
