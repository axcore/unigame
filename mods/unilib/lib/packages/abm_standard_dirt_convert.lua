---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_dirt_convert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_convert(pos, node)

    if unilib.global.dirt_with_turf_table[node.name] ~= nil then

        -- A dirt-with-turf node. Convert the dry-dirt-with-turf into the wettened
        --      equivalent, if it exists (we don't try to convert the turf as well)
        local wet_name = "unilib:dirt_ordinary_with_" ..
                unilib.global.dirt_with_turf_table[node.name]["turf_part_name"]

        if core.registered_nodes[wet_name] ~= nil then
            core.swap_node(pos, {name = wet_name})
        else
            core.swap_node(pos, {name = "unilib:dirt_ordinary"})
        end

    else

        -- A dirt node without turf
        core.swap_node(pos, {name = "unilib:dirt_ordinary"})

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_dirt_convert.init()

    return {
        description = "ABM to convert dry dirts to ordinary dirt when water is nearby (from" ..
                " ethereal-ng",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.abm_standard_dirt_convert.post()

    -- Adapted from ethereal-ng/water.lua
    -- Converts dry dirts to ordinary dirts when water is nearby

    unilib.register_abm({
        label = "Soak dry dirt [abm_standard_dirt_convert]",
        nodenames = {"group:dry_dirt"},
        neighbors = {"group:water"},

        catch_up = false,
        chance = 3,
        interval = 15,

        action = function(...)
            do_convert(...)
        end,
    })

end
