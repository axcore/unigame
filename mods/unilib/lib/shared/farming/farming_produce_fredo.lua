---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- farming_produce_fredo.lua
--      Registry functions for farming_redo produce
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Registry functions for farming_redo produce
---------------------------------------------------------------------------------------------------

function unilib.farming._register_produce_fredo(data_table)

    -- Adapted from farming_redo/crops/artichoke.lua
    -- Creates related produce items: various growth stage items, and the harvested produce item
    --      (which can also be placed as a seed)
    -- Uses the growing code from farming_redo
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "artichoke" (used by the harvested item and growth stage items)
    --      grow_orig_name (list): e.g. {"farming:artichoke_1", "farming:artichoke_2", ...}. The
    --          size of this list should the size of .grow_list
    --      harvest_orig_name (str): e.g. "farming:artichoke"
    --      description (str): e.g. "Artichoke"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      eat (int): e.g. 4 (used in the core.item_eat() call). If not specified, the harvested
    --          item is not eatable
    --      fertility_list (list): List of node groups for compatible soils. If not specified, the
    --          crop can grow on any soil
    --      grow_list (table): List containing a sequence of mini-tables, one for each growth stage.
    --          Each mini-table can be empty, or can contain extra key-value pairs for that growth
    --          stage. The extra key-value pairs, if any, are added to the unilib.register_node()
    --          call. If the mini-table contains [complete_flag] = true, then that mini-table is
    --          the complete node definition for the growth stage, replacing all other fields
    --      grow_group_table (table): Table used in the .groups field for the growth stage
    --      harvest_group_table (table): Table used in the .groups field for the harvested item
    --      max_light (int): Maximum light required for growth. If not specified, the value in
    --          ../lib/shared/farming/farming_base.lua is used (default 15)
    --      min_light (int): Minimum light required for growth. If not specified, the value in
    --          ../lib/shared/farming/farming_base.lua is used (default 12)
    --      no_harvest_flag (bool): If true, the harvested item is the last growth stage (e.g.
    --          unilib:produce_pumpkin_yellow_grow_8). The name of what would have been the
    --          harvested item (e.g. unilib:produce_pumpkin_yellow_harvest) is aliased onto the last
    --          growth stage
    --      seed_name (str): The full_name of an item used as the seed (e.g. pumpkins are grown by
    --          planting a pumpkin slice, unilib:produce_pumpkin_yellow_slice). If not specified,
    --          the harvested item is used as the seed (e.g. harvested artichokes can be re-planted
    --          to grow more artichokes)
    --      waving (int): e.g. 1 to make the growth stage wave in the wind

    local part_name = data_table.part_name
    local grow_orig_name = data_table.grow_orig_name
    local harvest_orig_name = data_table.harvest_orig_name
    local description = data_table.description

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local eat = data_table.eat or nil
    local fertility_list = data_table.fertility_list or {}
    local grow_list = data_table.grow_list or {{}}
    local grow_group_table = data_table.grow_group_table or {
        attached_node = 1, flammable = 2, growing = 1, not_in_creative_inventory = 1, plant = 1,
        snappy = 3,
    }
    local harvest_group_table = data_table.harvest_group_table or {flammable = 2, seed = 2}
    local max_light = data_table.max_light or unilib.farming.get_max_light()
    local min_light = data_table.min_light or unilib.farming.get_min_light()
    local no_harvest_flag = data_table.no_harvest_flag or false
    local seed_name = data_table.seed_name or nil
    local waving = data_table.waving or nil

    local grow_name = "unilib:produce_" .. part_name .. "_grow"
    local harvest_full_name = "unilib:produce_" .. part_name .. "_harvest"

    -- (As for seeds created in calls to unilib.register_crop_mtgame(), everything in fertility_list
    --      is added to the groups field of the growth stages)
    for k, v in pairs(fertility_list) do
        grow_group_table[v] = 1
    end

    -- Register the harvested produce item (which can also be placed as a seed)
    if not no_harvest_flag then

        local harvest_def_table = {
            description = description,
            inventory_image = "unilib_produce_" .. part_name .. "_harvest.png",
            groups = harvest_group_table,
        }

        if seed_name == nil then

            -- The harvested item is the seed
            harvest_def_table.on_place = function(itemstack, placer, pointed_thing)

                return unilib.farming.place_item_as_seed(
                    itemstack, placer, pointed_thing, grow_name .. "_1", "fredo"
                )

            end

        end

        if eat ~= nil then
            harvest_def_table.on_use = unilib.cuisine.eat_on_use(harvest_full_name, eat)

        end

        unilib.register_craftitem(
            harvest_full_name, harvest_orig_name, replace_mode, harvest_def_table
        )

    else

        -- No separate harvested item
        -- If a craftitem has been specified as the seed, make it plantable
        if seed_name and core.registered_craftitems[seed_name] ~= nil then

            unilib.override_item(seed_name, {
                on_place = function(itemstack, placer, pointed_thing)

                    return unilib.farming.place_item_as_seed(
                        itemstack, placer, pointed_thing, grow_name .. "_1", "fredo"
                    )

                end
            })

        end

    end

    -- Register growth stages
    local grow_def_table = {
        description = unilib.utils.brackets(description, S("Growing")),
        -- (tiles defined below)
        groups = grow_group_table,
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "",
        fertility = fertility_list,
        maxlight = max_light,
        minlight = min_light,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    }

    if waving then
        grow_def_table.waving = waving
    end

    for i = 1, #grow_list do

        local this_def_table = table.copy(grow_def_table)

        if grow_list[i]["complete_flag"] == nil then

            this_def_table.tiles = {"unilib_produce_" .. part_name .. "_grow_" .. i .. ".png"}

            if i == #grow_list then
                this_def_table.groups.growing = nil
            end

            for k, v in pairs(grow_list[i]) do
                this_def_table[k] = v
            end

            unilib.register_node(
                grow_name .. "_" .. i, grow_orig_name[i], replace_mode, this_def_table
            )

        else

            grow_list[i]["complete_flag"] = nil
            unilib.register_node(
                grow_name .. "_" .. i, grow_orig_name[i], replace_mode, grow_list[i]
            )

        end

    end

    -- Update global variables
    unilib.flora.register_growth_stages({
        base_name = grow_name,
        mode = "produce",
        stage_max = #grow_list,
    })

    if no_harvest_flag and
            core.registered_nodes[harvest_full_name] == nil and
            core.registered_craftitems[harvest_full_name] == nil then

        -- No separate harvested item, so alias what would have been the harvested item's name onto
        --      the last growth stage (unless a separate harvest item has been defined by the
        --      package, e.g. in the garlic/pineapple packages)
        core.register_alias(harvest_full_name, grow_name .. "_" .. tostring(#grow_list))

    end

    -- Update the table of basic crop/produce items, so that the later call to
    --      unilib.farming.register_growth_stages() can use it
    unilib.farming.add_to_fredo_grow_list(grow_name)

end
