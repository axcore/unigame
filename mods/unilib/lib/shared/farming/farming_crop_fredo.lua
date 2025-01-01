---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- farming_crop_fredo.lua
--      Registry functions for farming_redo crops
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Registry functions for farming_redo crops
---------------------------------------------------------------------------------------------------

function unilib.farming._register_crop_fredo(data_table)

    -- Adapted from farming_redo/init.lua
    -- Creates related crop items: a seed, various growth stage items, and the harvested item
    -- Uses the growing code from farming_redo
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "rye" (used by the harvested item and growth stage items)
    --      grow_orig_name (list): e.g. { "farming:rye_1", "farming:rye_2", ... }. The size of this
    --          list should match the "steps" field
    --      harvest_orig_name (str): e.g. "farming:rye"
    --      seed_orig_name (str): e.g. "farming:seed_rye"
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
    --      grow_list (table): List containing a sequence of mini-tables, one for each growth stage.
    --          Each mini-table can be empty, or can contain extra key-value pairs for that growth
    --          stage. The extra key-value pairs, if any, are added to the unilib.register_node()
    --          call. Note that there is no "complete_flag" field for replacing the complete node
    --          definition for the growth stage
    --      harvest_description (str): e.g. "Cotton"
    --      harvest_group_table (table): e.g. {flammable = 2}
    --      harvest_override (str): If specified, this function does not create a harvested
    --          craftitem; instead, it uses the specified item (which must be created by the calling
    --          code)
    --      max_light (int): Maximum light required for growth. If not specified, 15 is used
    --      min_light (int): Minimum light required for growth. If not specified, 12 is used
    --      no_early_drop_flag (bool): Ignored if "grow_list" is specified. Otherwise, the standard
    --          algorithm for determining growth stage drops is being used; if the flag is true,
    --          no drops are permitted at growth stages 1-3
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
    local grow_list = data_table.grow_list or nil
    local harvest_description = data_table.harvest_description or
            part_name:gsub("^%l", string.upper)
    local harvest_group_table = data_table.harvest_group_table or {flammable = 2}
    local harvest_override = data_table.harvest_override or nil
    local max_light = data_table.max_light or 15
    local min_light = data_table.min_light or 12
    local no_early_drop_flag = data_table.no_early_drop_flag or false
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
        -- (.sounds field not in farming_redo code, so use the code from minetest_game/farming)
        sounds = unilib.sound.generate_dirt({
            dig = {name = "", gain = 0},
            dug = {name = "unilib_grass_footstep", gain = 0.2},
            place = {name = "unilib_place_node", gain = 0.25},
        }),

        drawtype = "signlike",
        fertility = fertility_list,
        inventory_image = seed_img,
        next_plant = grow_name .. "_1",
        paramtype = "light",
        paramtype2 = "wallmounted",
        place_param2 = place_param2 or nil,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = seed_img,

        on_place = function(itemstack, placer, pointed_thing)

            return unilib.farming.place_item_as_seed(
                itemstack, placer, pointed_thing, grow_name .. "_1", "fredo"
            )

        end,
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

    -- Register growth stages
    local grow_def_table = {
        description = unilib.utils.brackets(S("Crop"), S("Growing")),
        -- (tiles defined below)
        -- (groups defined below)
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        fertility = fertility_list,
        maxlight = max_light,
        minlight = min_light,
        paramtype = "light",
        -- (In both cases, "or nil" is missing in the farming_redo code)
        paramtype2 = paramtype2 or nil,
        place_param2 = place_param2 or nil,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    }

    for i = 1, steps do

        local this_def_table = table.copy(grow_def_table)
        this_def_table.tiles = {"unilib_crop_" .. part_name .. "_grow_" .. i .. ".png"}

        -- Standard algorithm for determining growth stage drops
        local base_rarity = 1
        if steps ~= 1 then
            base_rarity = 8 - (i - 1) * 7 / (steps - 1)
        end

        -- When harvested, drop a random quantity of crops/seeds
        local drop_table = {
            items = {
                {items = {harvest_full_name}, rarity = base_rarity},
                {items = {harvest_full_name}, rarity = base_rarity * 2},
                {items = {seed_full_name}, rarity = base_rarity},
                {items = {seed_full_name}, rarity = base_rarity * 2},
            },
        }

        if no_early_drop_flag and i <= 3 then
            drop_table = {}
        end

        this_def_table.drop = drop_table

        -- (Unlike the unilib.register_crop_mtgame() code, crops don't have a growth stage named
        --      after themselves)
        local this_grow_group_table = table.copy(grow_group_table)
        if i == steps then
            this_grow_group_table.growing = 0
        else
            this_grow_group_table.growing = 1
        end

        this_def_table.groups = this_grow_group_table

        local next_plant = nil

        if i < steps then
            next_plant = grow_name .. "_" .. (i + 1)
        end

        this_def_table.next_plant = next_plant

        -- Customise this growth stage, if "grow_list" was specified
        if grow_list ~= nil and grow_list[i] ~= nil then

            if i == #grow_list then
                this_def_table.groups.growing = nil
            end

            for k, v in pairs(grow_list[i]) do
                this_def_table[k] = v
            end

        end

        unilib.register_node(
            grow_name .. "_" .. i, grow_orig_name[i], replace_mode, this_def_table
        )

    end

    -- Update the table of basic crop/produce items, so that the later call to
    --      unilib.farming.register_growth_stages() can use it
    unilib.farming.add_to_fredo_grow_list(grow_name)

    -- Update global variables
    unilib.flora.register_growth_stages({
        base_name = grow_name,
        mode = "fredo",
        stage_max = steps,
    })

    -- All crops are trimmable with a sickle
    unilib.tools.make_trimmable(grow_name .. "_" .. steps, grow_name .. "_2")

end
