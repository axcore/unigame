---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_dirt_convert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_dirt_convert.init()

    return {
        description = "Replacement ABM from ethereal-ng, replacing the one specified by the" ..
                " \"abm_standard_dirt_convert\" package",
        notes = "Currently, the ABM created by this package is identical to the one in" ..
                " the \"abm_standard_dirt_convert\" package, but it might change in the future",
        depends = "dirt_ordinary",
        excludes = "abm_standard_dirt_convert",
        suggested = {
            "dirt_dried",                       -- group:dirt_dry
        },
    }

end

function unilib.pkg.abm_ethereal_dirt_convert.post()

    unilib.register_abm({
        -- From ethereal-ng/water.lua
        label = "Convert dry to wet dirt [abm_ethereal_dirt_convert]",
        --[[
        nodenames = {
            "unilib:dirt_dried",
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_dry",
            "unilib:dirt_dry_with_turf_dry"
        },
        ]]--
        -- N.B. the "dry_dirt" group has been created for the benefit of this ABM, and applies to
        --     all suitable nodes (with or without turf)
        nodenames = {"group:dry_dirt"},
        neighbors = {"group:water"},

        catch_up = false,
        chance = 3,
        interval = 15,

        action = function(pos, node)

            --[[
            if node.name == "unilib:dirt_dried" or
                    node.name == "unilib:dirt_dry" then
                core.swap_node(pos, {name = "unilib:dirt_ordinary"})
            else
                core.swap_node(pos, {name = "unilib:dirt_ordinary_with_turf_dry"})
            end
            ]]--

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

        end,
    })

end
