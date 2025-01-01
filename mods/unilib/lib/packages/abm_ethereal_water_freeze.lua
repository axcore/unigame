---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_water_freeze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_water_freeze.init()

    return {
        description = "Replacement ABM from ethereal-ng, replacing the one specified by the" ..
                " \"abm_standard_water_freeze\" package",
        notes = "Unlike the standard \"water_freeze\" ABM, this ABM also acts when water is near" ..
                " crystal turf or crystallite spikes. This ABM does not act on other types of" ..
                " water (yet)",
        depends = "ice_ordinary",
        optional = {"dirt_ordinary_with_turf_crystal", "mineral_crystallite"},
        at_least_one = {"liquid_water_ordinary", "liquid_water_river"},
        excludes = "abm_standard_water_freeze",
        suggested = {
            "snow_ordinary",                    -- group:snowy
        },
    }

end

function unilib.pkg.abm_ethereal_water_freeze.post()

    unilib.register_abm({
        -- From ethereal-ng/water.lua
        label = "Freeze water [abm_ethereal_water_freeze]",
        --[[
        nodenames = {
            "unilib:mineral_crystallite_spike",
            -- N.B. In the original code, crystal dirt is mentioned in comments, but not actually
            --      implemented in the code
            "unilib:dirt_ordinary_with_turf_crystal",
            "unilib:snow_ordinary",
            "unilib:snow_ordinary_block",
            "unilib:snow_ordinary_brick"
        },
        ]]--
        nodenames = {
            "unilib:mineral_crystallite_spike",
            -- N.B. In the original code, crystal dirt is mentioned in comments, but not actually
            --      implemented in the code
            "unilib:dirt_ordinary_with_turf_crystal",
            "group:snowy",
        },
        neighbors = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},

        catch_up = false,
        chance = 4,
        interval = 15,

        action = function(pos, node)

            local near = core.find_node_near(
                pos,
                1,
                {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"}
            )

            if near then
                core.swap_node(near, {name = "unilib:ice_ordinary"})
            end

        end,
    })

end
