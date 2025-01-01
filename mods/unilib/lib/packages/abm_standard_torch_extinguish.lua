---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_torch_extinguish = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_extinguish(pos, node)

    local num = #core.find_nodes_in_area(
        {x = pos.x - 1, y = pos.y, z = pos.z},
        {x = pos.x + 1, y = pos.y, z = pos.z},
        {"group:water"}
    )

    if num == 0 then

        num = num + #core.find_nodes_in_area(
            {x = pos.x, y = pos.y, z = pos.z - 1},
            {x = pos.x, y = pos.y, z = pos.z + 1},
            {"group:water"}
        )

    end

    if num == 0 then

        num = num + #core.find_nodes_in_area(
            {x = pos.x, y = pos.y + 1, z = pos.z},
            {x = pos.x, y = pos.y + 1, z = pos.z},
            {"group:water"}
        )

    end

    if num > 0 then

        core.set_node(pos, {name = "air"})

        core.sound_play(
            "unilib_extinguish_flame",
            {pos = pos, gain = 0.2, max_hear_distance = 10}
        )

        core.add_item(pos, {name = "unilib:torch_ordinary"})

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_torch_extinguish.init()

    return {
        description = "ABM to handle extinguishing torches (from ethereal-ng)",
        depends = "torch_ordinary",
    }

end

function unilib.pkg.abm_standard_torch_extinguish.post()

    -- Adapted from ethereal-ng/water.lua
    -- Drops ordinary torches that touch water

    unilib.register_abm({
        label = "Extinguish torches [abm_standard_torch_extinguish]",
        nodenames = {
            "unilib:torch_ordinary",
            "unilib:torch_ordinary_wall",
            "unilib:torch_ordinary_ceiling",
        },
        neighbors = {"group:water"},

        catch_up = false,
        chance = 1,
        interval = 5,

        action = function(...)
            do_extinguish(...)
        end,
    })

end
