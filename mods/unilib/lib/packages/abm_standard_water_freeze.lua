---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_water_freeze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_freeze(pos, node)

    local near = core.find_node_near(
        pos,
        1,
        {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"}
    )

    if near then
        core.swap_node(near, {name = "unilib:ice_ordinary"})
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_water_freeze.init()

    return {
        description = "ABM to handle freezing of water (from ethereal-ng)",
        depends = "ice_ordinary",
    }

end

function unilib.pkg.abm_standard_water_freeze.post()

    -- Adapted from ethereal-ng/water.lua
    -- Freezes ordinary/river water near snow

    unilib.register_abm({
        label = "Freeze water near snow [abm_standard_water_freeze]",
        nodenames = {"group:snowy"},
        neighbors = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},

        catch_up = false,
        chance = 4,
        interval = 15,

        action = function(...)
            do_freeze(...)
        end,
    })

end
