---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_dirt_soak = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_dirt_soak.init()

    return {
        description = "Replacment \"dirt_soak\" ABM",
        notes = "Currently, the ABM created by this package is identical to the one in" ..
                " ../lib/system/abms.lua, but it might change in the future",
        depends = "dirt_ordinary",
        suggested = {
            "dirt_dried",                       -- group:dirt_dry
        },
    }

end

function unilib.pkg.abm_ethereal_dirt_soak.post()

    unilib.abm_replace_table.dirt_soak = function()

        unilib.register_abm({
            -- From ethereal-ng/water.lua
            label = "Convert dry to wet dirt [abm_ethereal_dirt_soak]",
            --[[
            nodenames = {
                "unilib:dirt_dried",
                "unilib:dirt_ordinary_with_turf_dry",
                "unilib:dirt_dry",
                "unilib:dirt_dry_with_turf_dry"
            },
            ]]--
            -- N.B. the "dry_dirt" group has been created for the benefit of this ABM, and applies
            --      to all suitable nodes (with or without turf)
            nodenames = {"group:dry_dirt"},
            neighbors = {"group:water"},

            catch_up = false,
            chance = 2,
            interval = 15,

            action = function(pos, node)

                --[[
                if node.name == "unilib:dirt_dried" or
                        node.name == "unilib:dirt_dry" then
                    minetest.swap_node(pos, {name = "unilib:dirt_ordinary"})
                else
                    minetest.swap_node(pos, {name = "unilib:dirt_ordinary_with_turf_dry"})
                end
                ]]--

                if unilib.dirt_with_turf_table[node.name] ~= nil then

                    -- A dirt-with-turf node. Convert the dry-dirt-with-turf into the wettened
                    --      equivalent, if it exists (we don't try to convert the turf as well)
                    local wet_name = "unilib:dirt_ordinary_with_" ..
                            unilib.dirt_with_turf_table[node.name]["turf_part_name"]

                    if minetest.registered_nodes[wet_name] ~= nil then
                        minetest.swap_node(pos, {name = wet_name})
                    else
                        minetest.swap_node(pos, {name = "unilib:dirt_ordinary"})
                    end

                else

                    -- A dirt node without turf
                    minetest.swap_node(pos, {name = "unilib:dirt_ordinary"})

                end

            end,
        })

    end

end
