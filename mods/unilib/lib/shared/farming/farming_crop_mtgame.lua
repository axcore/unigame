---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- farming_crop_mtgame.lua
--      Registry functions for mtgame crops
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Registry functions for mtgame crops
---------------------------------------------------------------------------------------------------

function unilib.farming._register_crop_mtgame(data_table)

    -- Adapted from farming/api.lua
    -- Creates related crop items: a seed, various growth stage items, and the harvested item
    -- Uses the growing code from minetest_game/farming
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "cotton" (used by the harvested item and growth stage items)
    --      grow_orig_name (or list): e.g. { "farming:cotton_1", "farming:cotton_2", ... }. The size
    --          of this list should match the "steps" field
    --      harvest_orig_name (str): e.g. "farming:cotton"
    --      seed_orig_name (str): e.g. "farming:seed_cotton"
    --      steps (int): e.g. 8
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      eat (int): e.g. 4 (used in the core.item_eat() call). If not specified, the harvested
    --          item is not eatable
    --      fertility_list (list): List of node groups for compatible soils. If not specified, the
    --          crop can grow on any soil
    --      grow_group_table (table): e.g. {attached_node = 1, flammable = 2,
    --          not_in_creative_inventory = 1, plant = 1, snappy = 3}
    --      harvest_description (str): e.g. "Cotton"
    --      harvest_group_table (table): e.g. {flammable = 2}
    --      harvest_override (str): If specified, this function does not create a harvested
    --          craftitem; instead, it uses the specified item (which must be created by the calling
    --          code)
    --      max_light (int): Maximum light required for growth. If not specified, 14 is used
    --      min_light (int): Minimum light required for growth. If not specified, 1 is used
    --      paramtype2 (str): e.g. "meshoptions". If specified, used for the seed only
    --      place_param2 (int): e.g. 3. If specified, used for the seed and growth stages
    --      seed_description (str): e.g. "Cotton Seed"
    --      seed_group_table (table): e.g. {attached_node = 1, flammable = 2, seed = 1, snappy = 3}

    local part_name = data_table.part_name
    local grow_orig_name = data_table.grow_orig_name
    local harvest_orig_name = data_table.harvest_orig_name
    local seed_orig_name = data_table.seed_orig_name
    local steps = data_table.steps

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local eat = data_table.eat or nil
    local fertility_list = data_table.fertility_list or {}
    local grow_group_table = data_table.grow_group_table or
            {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, plant = 1, snappy = 3}
    local harvest_description = data_table.harvest_description or
            part_name:gsub("^%l", string.upper)
    local harvest_group_table = data_table.harvest_group_table or {flammable = 2}
    local harvest_override = data_table.harvest_override or nil
    local max_light = data_table.max_light or 14
    local min_light = data_table.min_light or 11
    local paramtype2 = data_table.paramtype2 or nil
    local place_param2 = data_table.place_param2 or nil
    local seed_description = data_table.seed_description or S("Seed")
    local seed_group_table = data_table.seed_group_table or
            {attached_node = 1, flammable = 2, seed = 1, snappy = 3}

    local grow_name = "unilib:crop_" .. part_name .. "_grow"
    local harvest_full_name = "unilib:crop_" .. part_name .. "_harvest"
    local seed_full_name = "unilib:crop_" .. part_name .. "_seed"
    local seed_img = "unilib_crop_" .. part_name .. "_seed.png"

    -- Basic checks
    if not steps then
        return
    end

    -- Register seed
    for k, v in pairs(fertility_list) do
        seed_group_table[v] = 1
    end

    unilib.register_node(seed_full_name, seed_orig_name, replace_mode, {
        description = seed_description,
        tiles = {seed_img},
        groups = seed_group_table,
        sounds = unilib.sound.generate_dirt({
            dig = {name = "", gain = 0},
            dug = {name = "unilib_grass_footstep", gain = 0.2},
            place = {name = "unilib_place_node", gain = 0.25},
        }),

        drawtype = "signlike",
        fertility = fertility_list,
        inventory_image = seed_img,
        maxlight = max_light,
        minlight = min_light,
        next_plant = grow_name .. "_1",
        paramtype = "light",
        paramtype2 = "wallmounted",
        place_param2 = place_param2,   -- This isn't actually used for placement
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = seed_img,

        on_place = function(itemstack, placer, pointed_thing)

            local under = pointed_thing.under
            local node = core.get_node(under)
            local udef = core.registered_nodes[node.name]
            if udef and udef.on_rightclick and not (
                placer and
                placer:is_player() and
                placer:get_player_control().sneak
            ) then

                return udef.on_rightclick(under, node, placer, itemstack, pointed_thing) or
                        itemstack

            else

                return unilib.farming.place_item_as_seed(
                    itemstack, placer, pointed_thing, seed_full_name, "mtgame"
                )

            end

        end,

        on_timer = unilib.farming.grow_crop,
    })

    if harvest_override == nil then

        -- Register the harvested crop as a craftitem
        local harvest_def_table = {
            description = harvest_description,
            inventory_image = "unilib_crop_" .. part_name .. "_harvest.png",
            groups = harvest_group_table,
        }

        if eat ~= nil then
            harvest_def_table.on_use = unilib.cuisine.eat_on_use(harvest_full_name, eat)
        end

        unilib.register_craftitem(
            harvest_full_name, harvest_orig_name, replace_mode, harvest_def_table
        )

    else

        -- Use the specified harvested item
        harvest_full_name = harvest_override

    end

    -- Each crop has a group named after itself
    grow_group_table[part_name] = 1
    -- Register growth stages
    for i = 1, steps do

        local base_rarity = 1
        if steps ~= 1 then
            base_rarity = 8 - (i - 1) * 7 / (steps - 1)
        end

        -- When harvested, drop a random quantity of harvested items/seeds
        local drop_table = {
            items = {
                {items = {harvest_full_name}, rarity = base_rarity},
                {items = {harvest_full_name}, rarity = base_rarity * 2},
                {items = {seed_full_name}, rarity = base_rarity},
                {items = {seed_full_name}, rarity = base_rarity * 2},
            }
        }

        local next_plant = nil

        if i < steps then
            next_plant = grow_name .. "_" .. (i + 1)
        end

        -- Register each growth stage for the crop
        unilib.register_node(grow_name .. "_" .. i, grow_orig_name[i], replace_mode, {
            description = unilib.utils.brackets(S("Crop"), S("Growing")),
            tiles = {"unilib_crop_" .. part_name .. "_grow_" .. i .. ".png"},
            groups = grow_group_table,
            sounds = unilib.global.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = drop_table,
            maxlight = max_light,
            minlight = min_light,
            next_plant = next_plant,
            paramtype = "light",
            paramtype2 = paramtype2 or nil,
            place_param2 = place_param2 or nil,
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
            },
            walkable = false,
            waving = 1,

            on_timer = unilib.farming.grow_crop,
        })

    end

    -- Update global variables
    unilib.flora.register_growth_stages({
        base_name = grow_name,
        mode = "mtgame",
        stage_max = steps,
    })

    -- All crops are trimmable with a sickle
    unilib.tools.make_trimmable(grow_name .. "_" .. steps, grow_name .. "_2")

end
