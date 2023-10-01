---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_ice_snow_melt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_ice_snow_melt.init()

    return {
        description = "Replacement \"ice_snow_melt\" ABM",
        depends = {"liquid_water_ordinary", "liquid_water_river"},
        suggested = {
            "dirt_ordinary",                    -- group:snowy
            "fire_ordinary",                    -- group:fire
            "liquid_lava_ordinary",             -- group:lava
            "machine_furnace_ordinary",         -- group:active_furnace
            "snow_ordinary",                    -- group:cools_lava
            "torch_ordinary",                   -- group:torch
        },
    }

end

function unilib.pkg.abm_ethereal_ice_snow_melt.post()

    unilib.abm_replace_table.ice_snow_melt = function()

        unilib.register_abm({
            -- From ethereal-ng/water.lua
            label = "Melt snow/ice [abm_ethereal_ice_snow_melt]",
            --[[
            nodenames = {
                "unilib:dirt_ordinary_with_cover_snow",
                "unilib:ice_ordinary",
                "unilib:ice_ordinary_brick",
                "unilib:snow_ordinary",
                "unilib:snow_ordinary_block",
                "unilib:snow_ordinary_brick",
            },
            ]]--
            nodenames = {"group:cools_lava", "group:snowy"},
            --[[
            neighbors = {
                "unilib:fire_ordinary",
                "unilib:liquid_lava_ordinary_source",
                "unilib:liquid_lava_ordinary_flowing",
                "unilib:machine_furnace_ordinary_active",
                "unilib:torch_ordinary",
                "unilib:torch_ordinary_wall",
                "unilib:torch_ordinary_ceiling",
            },
            ]]--
            neighbors = {"group:active_furnace", "group:fire", "group:lava", "group:torch"},

            catch_up = false,
            chance = 4,
            interval = 5,

            action = function(pos, node)

                local water_name = "unilib:liquid_water_ordinary"
                if pos.y > 2 then
                    water_name = "unilib:liquid_water_river"
                end

                --[[
                if node.name == "unilib:ice_ordinary" or
                        node.name == "unilib:snow_ordinary_block" or
                        node.name == "unilib:ice_ordinary_brick" or
                        node.name == "unilib:snow_ordinary_brick" then
                    minetest.swap_node(pos, {name = water_name .. "_source"})
                elseif node.name == "unilib:snow_ordinary" then
                    minetest.swap_node(pos, {name = water_name .. "_flowing"})
                elseif node.name == "unilib:dirt_ordinary_with_cover_snow" then
                    minetest.swap_node(pos, {name = "unilib:dirt_ordinary_with_turf"})
                end
                ]]--

                if unilib.dirt_with_turf_table[node.name] ~= nil then

                    -- unilib.dirt_with_turf_table includes, among its keys,
                    --      unilib:dirt_ordinary_with_cover_snow
                    -- With this, and similar nodes, the .turf_part_name is set to "turf", etc,
                    --      instead of "cover_snow"; we can use that to our advantage here
                    local dirt_name = "unilib:" ..
                            unilib.dirt_with_turf_table[node.name]["dirt_part_name"]
                    local turf_name = dirt_name .. "_with_" ..
                            unilib.dirt_with_turf_table[node.name]["turf_part_name"]

                    if minetest.registered_nodes[turf_name] ~= nil then
                        minetest.swap_node(pos, {name = turf_name})
                    else
                        minetest.swap_node(pos, {name = dirt_name})
                    end

                elseif minetest.get_item_group(node.name, "snowy") > 0 then

                    -- For "unilib:snow_ordinary", etc
                    minetest.swap_node(pos, {name = water_name .. "_flowing"})

                else

                    -- For every other matching node
                    minetest.swap_node(pos, {name = water_name .. "_source"})

                end

                minetest.check_for_falling(pos)

            end,
        })

    end

end
