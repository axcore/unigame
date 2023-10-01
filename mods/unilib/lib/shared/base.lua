---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- base.lua
--      Set up shared functions for base packages
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Base package functions
---------------------------------------------------------------------------------------------------

function unilib.setup_standard_base_pkg(mode)

    -- Called by several base packages, for which the .exec() function code is identical
    -- We assume that any package calling this function, has an .init() function very similar in
    --      form to the "base_default" package's init.() function

    -- (Only need to replace mapgen aliases if unilib nodes are preferred over nodes from default)
    if mode ~= "defer" then

        if unilib.pkg_executed_table["stone_ordinary"] ~= nil then
            minetest.register_alias_force("mapgen_stone", "unilib:stone_ordinary")
        end

        if unilib.pkg_executed_table["liquid_water_ordinary"] ~= nil then

            minetest.register_alias_force(
                "mapgen_water_source",
                "unilib:liquid_water_ordinary_source"
            )

        end

        if unilib.pkg_executed_table["liquid_water_river"] ~= nil then

            minetest.register_alias_force(
                "mapgen_river_water_source",
                "unilib:liquid_water_river_source"
            )

        end

        if unilib.pkg_executed_table["liquid_lava_ordinary"] ~= nil then
            minetest.register_alias_force("mapgen_lava_source", "unilib:liquid_lava_ordinary")
        end

    end

end

function unilib.activate_standard_abm_lbm()

    -- Called by any base package that wants to activate unili standard ABMs/LBMs (replacing the
    --      ABMs/LBMs from the original source game/modpack/mod, which either provided a "default"
    --      mod, or had code that acted like a "default" mod)
    -- Whether standard ABMs/LBMs are actually enabled, or not, depends on Minetest settings

    unilib.activate_standard_abm_lbm_flag = true

end
