---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_aqua_farming = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aqua_farming.add_mode

-- Table showing the current growth stage of a crop, as the key, and the next growth stage as its
--      corresponding value
local replace_table = {}
-- The original code uses a separate ABM for each growth stage of each crop. Here, we combine them
--      all into a single ABM
-- Each crop has a different chance and interval. Each interval is a multiple of 2 seconds
local abm_interval = 2
-- Every time the ABM acts, it consults and updates this table, in the form
--      abm_table[part_name] = {chance, interval, current_time}
-- ...where "current_time" starts at 0, and is increased by 2 every time the ABM acts. When
--      "interval" equals "current_time", the ABM tests "chance", either increasing the crop's
--      growth stage or doing nothing. In either case, "current_time" is set back to 0
local abm_table = {}
-- A table converting each growth stage, e.g. "unilib:crop_undersea_anemone_grow_1", into the
--      "part_name" used as a key in "abm_table"
local convert_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_water(pos)

    -- Was aqua_farming.check_water()

    local above = core.get_node_or_nil({x = pos.x, y = pos.y + 2, z = pos.z})

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
    local meta = core.get_meta(pos)
    local light_level = meta:get_int("light_level")

    if core.get_node_or_nil(above) ~= nil then

        local light = core.get_node_light(above)
        if light >= light_level then
            return true
        end

    end

    return false

end

local function register_abm()

    -- Was aqua_farming.register_abm()
    -- The original code uses a separate ABM for each growth stage of each crop. Here, we combine
    --      them all into a single ABM

    local growth_stage_list = {}
    for growth_stage, _ in pairs(replace_table) do
        table.insert(growth_stage_list, growth_stage)
    end

    unilib.register_abm({
        label = "Aquatic crop growth [shared_aqua_farming]",
        nodenames = growth_stage_list,
        neighbors = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},

        chance = 1,
        interval = abm_interval,

        action = function(pos, node, active_object_count, active_object_count_wider)

            local part_name = convert_table[node.name]
            -- Test whether it's time to act on this node, or not. "abm_table" in the form
            --  abm_table[part_name] = {chance, interval, current_time}
            abm_table[part_name][3] = abm_table[part_name][3] + abm_interval
            if abm_table[part_name][3] >= abm_table[part_name][2] then

                abm_table[part_name][3] = 0
                if math.random(abm_table[part_name][1]) == 1 then

                    -- It's time to act, update the growth stage
                    local nodepos = pos
                    if check_water(nodepos) and check_light(nodepos) then
                            core.swap_node(nodepos, {name = replace_table[node.name]})
                    end

                end

            end

        end,
    })

end

--[[
local function can_plant_seed(seed_full_name, pointed_thing)

    -- Was aqua_farming.plant_seed()

    if pointed_thing.type == "node" then

        local node = core.get_node(core.get_pointed_thing_position(pointed_thing, false))
        if node.name == "unilib:soil_undersea" then

            core.set_node(pointed_thing.under, {name = seed_full_name})
            return true

        end

        return false

    end

end
]]--

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
    --      chance (int): e.g. 10, a 1 in 10 chance to grow during every ABM check
    --      drop_table (table): Drop table for the final growth stage
    --      interval (int): e.g. 10, interval of 10 seconds between chances to grow. Must be a
    --          multiple of 5
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
    local drop_table = data_table.drop_table or nil
    local interval = data_table.interval or 8
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
    elseif min_light >= unilib.constant.light_max then
        min_light = unilib.constant.light_max - 1
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
            core.set_node(pos, {name = "unilib:soil_undersea"})
        end,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            local meta = core.get_meta(pos)
            meta:set_int("light_level", min_light)

        end,

        --[[
        on_place = function(itemstack, placer, pointed_thing)

            if can_plant_seed(seed_full_name, pointed_thing) then
                itemstack:take_item()
            end

            return itemstack

        end,
        ]]--
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {
                    need_under = "unilib:soil_undersea",
                    displace_flag = true,
                }
            )

        end,
    })

    replace_table[seed_full_name] = "unilib:crop_undersea_" .. part_name .. "_grow_1"
    convert_table[seed_full_name] = part_name

    -- Growth stages
    for i = 1, steps - 1 do

        unilib.register_node(
            "unilib:crop_undersea_" .. part_name .. "_grow_" .. i,
            grow_orig_name[i],
            replace_mode,
            {
                description = unilib.utils.brackets(S("Crop"), S("Growing")),
                tiles = planted_img_list,
                groups = {
                    attached_node = 1, dig_immediate = 1, growing = 1,
                    not_in_creative_inventory = 1, plant = 1, snappy = 3,
                },
                sounds = unilib.global.sound_table.leaves,

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
                    core.set_node(pos, {name = "unilib:soil_undersea"})
                end,
            }
        )

        replace_table["unilib:crop_undersea_" .. part_name .. "_grow_" .. i] =
                "unilib:crop_undersea_" .. part_name .. "_grow_" .. (i + 1)
        convert_table["unilib:crop_undersea_" .. part_name .. "_grow_" .. i] = part_name

    end

    -- Final growth stage
    unilib.register_node(
        "unilib:crop_undersea_" .. part_name .. "_grow_" .. steps,
        grow_orig_name[steps],
        replace_mode,
        {
            description = unilib.utils.brackets(S("Crop"), S("Growing")),
            tiles = planted_img_list,
            groups = {
                attached_node = 1, dig_immediate = 1, not_in_creative_inventory = 1, plant = 1,
                snappy = 3,
            },
            sounds = unilib.global.sound_table.leaves,

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
                core.set_node(pos, {name = "unilib:soil_undersea"})
            end,
        }
    )

    convert_table["unilib:crop_undersea_" .. part_name .. "_grow_" .. steps] = part_name

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
            sounds = unilib.global.sound_table.leaves,

            drawtype = "plantlike_rooted",
            drop = drop_table,
            paramtype = "light",
            -- N.B. No .paramtype2 in original code
            paramtype2 = "facedir",
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
                core.set_node(pos, {name = base_node})
            end,
        }
    )

    -- Update the main table consulted by the ABM
    abm_table[part_name] = {chance, interval, 0}

    -- Update global variables
    unilib.flora.register_growth_stages({
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

function unilib.pkg.shared_aqua_farming.post()

    -- The original code uses a separate ABM for each growth stage of each crop. Here, we combine
    --      them all into a single ABM
    register_abm()

end
