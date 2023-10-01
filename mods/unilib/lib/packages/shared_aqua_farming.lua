---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_aqua_farming = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_water(pos)

    -- Was aqua_farming.check_water()

    local above = minetest.get_node_or_nil({x = pos.x, y = pos.y + 2, z = pos.z})

    if above ~= nil and (
        above.name == "unilib:liquid_water_ordinary_source" or
        above.name == "unilib:liquid_water_river_source"
    ) then
        return true
    end

    return false

end

local function check_light(pos)

    -- Was aqua_farming.check_light()

    local above = {x = pos.x, y = pos.y + 1, z = pos.z}
    local meta = minetest.get_meta(pos)
    local light_level = meta:get_int("light_level")

    if minetest.get_node_or_nil(above) ~= nil then

        local light = minetest.get_node_light(above)
        if light >= light_level then
            return true
        end

    end

    return false

end

--[[
local function register_abm(current_name, replace_name, delay, percent)

    -- Was aqua_farming.register_abm()

    if minetest.registered_nodes[current_name] ~= nil or
            minetest.registered_nodes[replace_name] ~= nil then

        if delay == nil then
            delay = 1
        end

        if percent == nil then
            percent = 1
        end

        unilib.register_abm({
            label = "Aquatic crop growth [shared_aqua_farming]",
            nodenames = {current_name},
            neighbors = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},

            -- By default, run every 5 seconds, select every 1 in 50 nodes
            chance = percent,
            interval = delay,

            action = function(pos, node, active_object_count, active_object_count_wider)

                local nodepos = pos
                if check_water(nodepos) and check_light(nodepos) then
                    minetest.swap_node(nodepos, {name = replace_name})
                end

            end,

        })

    end

end
]]--

local function register_abm(replace_table, delay, percent)

    -- Was aqua_farming.register_abm()
    -- In unilib, the original ABM function (which used a different ABM for each growth stage) has
    --      been redesigned to use a single ABM for each crop

    if delay == nil then
        delay = 1
    end

    if percent == nil then
        percent = 1
    end

    local growth_stage_list = {}
    for growth_stage, _ in pairs(replace_table) do
        table.insert(growth_stage_list, growth_stage)
    end

    unilib.register_abm({
        label = "Aquatic crop growth [shared_aqua_farming]",
        nodenames = growth_stage_list,
           neighbors = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},

        -- By default, run every 5 seconds, select every 1 in 50 nodes
        chance = percent,
        interval = delay,

        action = function(pos, node, active_object_count, active_object_count_wider)

            local nodepos = pos
            if check_water(nodepos) and check_light(nodepos) then
                    minetest.swap_node(nodepos, {name = replace_table[node.name]})
            end

        end,

    })

end

local function can_plant_seed(seed_full_name, pointed_thing)

    -- Was aqua_farming.plant_seed()

    if pointed_thing.type == "node" then

        local node = minetest.get_node(minetest.get_pointed_thing_position(pointed_thing, false))
        if node.name == "unilib:soil_undersea" then

            minetest.set_node(pointed_thing.under, {name = seed_full_name})
            return true

        end

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_aqua_farming.register_crop(data_table)

    -- Was aqua_farming.register_plant()
    -- Registers a crop that grows undersea, when planted on "unilib:soil_undersea"
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "anemone"
    --      grow_orig_name (list): e.g. { "aqua_farming:sea_anemone_1", ... }
    --      harvest_orig_name (str): e.g. "aqua_farming:sea_anemone_item"
    --      seed_orig_name (str): e.g. "aqua_farming:sea_anemone_seed"
    --      wild_orig_name (str): e.g. "aqua_farming:sea_anemone_wild"
    --      steps (int): 5
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_node (str): Replaces the soil node when it is dug, e.g. "unilib:gravel_ordinary"
    --      chance (int): e.g. 5, a 1 in 5 chance to grow
    --      delay (int): e.g. 8, delay of 8 seconds between chances to grow
    --      drop_table (table): Drop table for the final growth stage
    --      min_light (int): e.g. 8
    --      seed_description (str): e.g. "Sea Anemone Seed"
    --      wild_description (str): e.g. "Wild Sea Anemone"

    local part_name = data_table.part_name
    local grow_orig_name = data_table.grow_orig_name
    local harvest_orig_name = data_table.harvest_orig_name
    local seed_orig_name = data_table.seed_orig_name
    local wild_orig_name = data_table.wild_orig_name
    local steps = data_table.steps

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local base_node = data_table.base_node or "unilib:sand_ordinary"
    local chance = data_table.chance or 5
    local delay = data_table.delay or 8
    local drop_table = data_table.drop_table or nil
    local min_light = data_table.min_light or 8
    local seed_description = data_table.seed_description or S("Undersea Plant Seed")
    local wild_description = data_table.wild_description or S("Wild Undersea Plant")

    local seed_full_name = "unilib:crop_undersea_" .. part_name .. "_seed"
    local seed_img = "unilib_crop_undersea_" .. part_name .. "_seed.png"

    local planted_img_list = {
        "unilib_soil_undersea.png^unilib_soil_undersea_overlay.png",
        "unilib_soil_undersea.png",
    }

    if steps <= 0 or steps == nil then
        return
    end

    if min_light <= 0 then
        min_light = 0
    elseif min_light >= unilib.light_max then
        min_light = unilib.light_max - 1
    end

    -- Seed
    unilib.register_node(seed_full_name, seed_orig_name, replace_mode, {
        description = seed_description,
        tiles = planted_img_list,
        groups = {attached_node = 1, dig_immediate = 3},
        -- (no sounds)

        inventory_image = seed_img,
        special_tiles = {{name = seed_img, tileable_vertical = true}},
        wield_image = seed_img,

        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            minetest.set_node(pos, {name = "unilib:soil_undersea"})
        end,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            local meta = minetest.get_meta(pos)
            meta:set_int("light_level", min_light)

        end,

        on_place = function(itemstack, placer, pointed_thing)

            if can_plant_seed(seed_full_name, pointed_thing) then
                itemstack:take_item()
            end

            return itemstack

        end,
    })

--  register_abm(seed_full_name, "unilib:crop_undersea_" .. part_name .. "_grow_1", delay, chance)
    local replace_table = {}
    replace_table[seed_full_name] = "unilib:crop_undersea_" .. part_name .. "_grow_1"

    -- Growth stages
    for i = 1, steps - 1 do

        unilib.register_node(
            "unilib:crop_undersea_" .. part_name .. "_grow_" .. i,
            grow_orig_name[i],
            replace_mode,
            {
                description = unilib.brackets(S("Crop"), S("Growing")),
                tiles = planted_img_list,
                groups = {
                    attached_node = 1, dig_immediate = 1, growing = 1,
                    not_in_creative_inventory = 1, plant = 1, snappy = 3,
                },
                sounds = unilib.sound_table.leaves,

                drawtype = "plantlike_rooted",
                drop = {},
                paramtype = "light",
                selection_box = {
                    type = "fixed",
                    fixed = {
                        {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
                    },
                },
                special_tiles = {
                    {
                        name = "unilib_crop_undersea_" .. part_name .. "_grow_" .. i .. ".png",
                        tileable_vertical = false,
                    },
                },
                waving = 1,

                after_destruct = function(pos, oldnode)
                    minetest.set_node(pos, {name = "unilib:soil_undersea"})
                end,
            }
        )

        --[[
        register_abm(
            "unilib:crop_undersea_" .. part_name .. "_grow_" .. i,
            "unilib:crop_undersea_" .. part_name .. "_grow_" .. (i + 1),
            delay,
            chance
        )
        ]]--
        replace_table["unilib:crop_undersea_" .. part_name .. "_grow_" .. i] =
                "unilib:crop_undersea_" .. part_name .. "_grow_" .. (i + 1)

    end

    register_abm(replace_table, delay, chance)

    -- Final growth stage
    unilib.register_node(
        "unilib:crop_undersea_" .. part_name .. "_grow_" .. steps,
        grow_orig_name[steps],
        replace_mode,
        {
            description = unilib.brackets(S("Crop"), S("Growing")),
            tiles = planted_img_list,
            groups = {
                attached_node = 1, dig_immediate = 1, not_in_creative_inventory = 1, plant = 1,
                snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            drawtype = "plantlike_rooted",
            drop = drop_table,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
                },
            },
            special_tiles = {
                {
                    name = "unilib_crop_undersea_" .. part_name .. "_grow_" .. steps .. ".png",
                    tileable_vertical = false,
                },
            },
            waving = 1,

            after_dig_node = function(pos, oldnode, oldmetadata, digger)
                minetest.set_node(pos, {name = "unilib:soil_undersea"})
            end,
        }
    )

    -- Wild Plant
    unilib.register_node(
        "unilib:crop_undersea_" .. part_name .. "_wild",
        wild_orig_name,
        replace_mode,
        {
            description = wild_description,
            tiles = planted_img_list,
            groups = {
                attached_node = 1, dig_immediate = 1, not_in_creative_inventory = 1, plant = 1,
                snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            drawtype = "plantlike_rooted",
            drop = drop_table,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
                },
            },
            special_tiles = {
                {
                    name = "unilib_crop_undersea_" .. part_name .. "_grow_" .. steps .. ".png",
                    tileable_vertical = false,
                },
            },
            waving = 1,

            after_dig_node = function(pos, oldnode, oldmetadata, digger)
                minetest.set_node(pos, {name = base_node})
            end,
        }
    )

    -- Updated global variables
    unilib.register_growing({
        base_name = "unilib_crop_undersea_" .. part_name .. "_grow",
        mode = "other",
        stage_max = steps,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_aqua_farming.init()

    return {
        description = "Shared functions for undersea crops (from aqua_farming)",
        depends = {"sand_ordinary", "soil_undersea"},
    }

end
