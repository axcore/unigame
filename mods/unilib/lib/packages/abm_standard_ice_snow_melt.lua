---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_ice_snow_melt = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_melt(pos, node)

    -- Default water, in case no specific water is specified
    local c_source = "unilib:liquid_water_ordinary_source"
    local c_flowing = "unilib:liquid_water_ordinary_flowing"

    if unilib.global.ice_snow_melting_table[node.name] ~= nil then

        c_source = unilib.global.ice_snow_melting_table[node.name]["source"]
        c_flowing = unilib.global.ice_snow_melting_table[node.name]["flowing"]

    end

    local intensity = core.get_item_group(node.name, "melts")
    if intensity == 1 then
        core.set_node(pos, {name = c_source})
    elseif intensity == 2 then
        core.set_node(pos, {name = c_flowing, param2 = 7})
    elseif intensity >= 3 then
        core.set_node(pos, {name = c_flowing, param2 = 3})
    end

    -- N.B. No sound effect in original code
    if intensity >= 1 then

        core.sound_play(
            "unilib_ice_melt",
            {pos = pos, max_hear_distance = 16, gain = 0.25},
            true
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_ice_snow_melt.init()

    return {
        description = "ABM to handle melting of ice and snow (from snow)",
    }

end

function unilib.pkg.abm_standard_ice_snow_melt.post()

    -- Adapted from snow/srcs/abms.lua
    -- Any node with the "melts" group will melt when near warm nodes (lava, fire, torches etc)
    -- The amount of water that replaces the node is defined by the group number:
    --      1         - water source node
    --      2         - deep flowing water
    --      3 or more - shallow flowing water

    unilib.register_abm({
        label = "Ice/snow melting [abm_standard_ice_snow_melt]",
        nodenames = {"group:melts"},
        neighbors = {
            "group:igniter",
            -- N.B. default:torch in original code
            "group:torch",
            "group:hot",
            -- N.B. Compatibility with earthen furnace (etc) not in original code
            "group:active_furnace",
        },

        chance = 2,
        interval = 10,

        action = function(...)
            do_melt(...)
        end,
    })

end
