---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flowers.lua
--      Set up shared functions for flowers (including mushrooms and waterlilies)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local seed_count = 1000

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_new_seed()

    -- Generate non-random seeds for each call to unilib.register_flower() that doesn't specify its
    --      own seed
    -- The generated seeds should be the same unless flower packages begin calling
    --      unilib.register_flower() in a different order

    seed_count = seed_count + 1
    return seed_count

end

---------------------------------------------------------------------------------------------------
-- Register flowers
---------------------------------------------------------------------------------------------------

function unilib.register_flower(data_table)

    -- Adapted from flowers/init.lua and flowers_plus/init.lua
    -- Registers the flower node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "rose_red"
    --      orig_name (str): e.g. "flowers:rose"
    --      select_table (table): Table used in the .selection_box field in the
    --          minetest.register_node() call
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      deco_part_name (str): e.g. "flowers", the first part of the generic decoration name
    --      description (str): e.g. "Red Rose"
    --      fill_ratio (float): e.g. 0.02. Used in the decoration. If not specified, a decoration
    --          with a .noise_params field is used instead
    --      group_table (table): Partial .groups field, typically specifying a colour group (for the
    --          benefit of dyes), and flamability (e.g. color_red = 1, flammable = 1). The groups
    --          .attached_node, .flora, .flower and .snappy are set by this function
    --      no_deco_flag (bool): If true, the calling code creates the decoration definition
    --      sci_name (str): e.g. "Rosa". The string may contain just the genus if the species isn't
    --          identifiable, or can be omitted entirely when necessary
    --      seed (int): A mapgen seed (e.g. 436)
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local select_table = data_table.select_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local deco_part_name = data_table.deco_part_name or nil
    local description = data_table.description or S("Flower")
    local fill_ratio = data_table.fill_ratio or nil
    local group_table = data_table.group_table or {}
    local no_deco_flag = data_table.no_deco_flag or false
    local sci_name = data_table.sci_name or nil
    local seed = data_table.seed or get_new_seed()

    local full_name = "unilib:flower_" .. part_name
    local img = "unilib_flower_" .. part_name .. ".png"

    -- (Common groups for flowers)
    group_table["attached_node"] = 1
    group_table["flora"] = 1
    group_table["flower"] = 1
    group_table["snappy"] = 3

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.annotate(description, sci_name),
        tiles = {img},
        groups = group_table,
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = select_table,
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })

    if not no_deco_flag then

        local deco_name = "flower_" .. part_name
        if deco_part_name ~= nil then
            deco_name = deco_part_name .. "_" .. deco_name
        end

        if fill_ratio == nil then

            -- (Based in decorations in the flowers mod)
            unilib.register_decoration(deco_name, {
                deco_type = "simple",
                decoration = full_name,

                noise_params = {
                    octaves = 3,
                    offset = -0.02,
                    persist = 0.6,
                    scale = 0.04,
                    seed = seed,
                    spread = {x = 200, y = 200, z = 200},
                },
                sidelen = 16,
            })

        else

            -- (Based in decorations in the flowers_plus mod)
            unilib.register_decoration(deco_name, {
                deco_type = "simple",
                decoration = full_name,

                fill_ratio = fill_ratio,
                height = 1,
                sidelen = 16,
            })

        end

    end

    unilib.register_flower_in_pot(full_name, orig_name)

    return full_name

end

function unilib.register_beautiflower(data_table)

    -- Adapted from beautiflowers/init.lua
    -- An alternative to unilib.register_flower(), optimised for beautiflowers items
    -- (Since there are so many of them, it's cheaper to put a function here, rather than creating
    --      a shared package which must be checked dozens of times)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "arcoiris"
    --      orig_name (str): e.g. "beautiflowers:arcoiris"
    --      select_table (table): Table used in the .selection_box field in the
    --          minetest.register_node() call
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Arcoiris Flower"
    --      dye (str): e.g. "red", one of the dye types specified by the "dye_basic" package
    --      sci_name (str): e.g. "Rosa". Note that most items from the "beautiflowers" mod seem to
    --          be fictional, or are using Spanish names; so few packages calling this function
    --          specify a scientific name
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local select_table = data_table.select_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Flower")
    local dye = data_table.dye or nil
    local sci_name = data_table.sci_name or nil

    local full_name = "unilib:flower_" .. part_name
    local img = "unilib_flower_" .. part_name .. ".png"

    -- N.B. In original code, beautiflowers = 1 replaces the color_XXX group
    local group_table = {attached_node = 1, flammable = 1, flora = 1, flower = 1, snappy = 3}
    if dye ~= nil then
        group_table["color_" .. dye] = 1
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.annotate(description, sci_name),
        tiles = {img},
        groups = group_table,
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = select_table,
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    if dye ~= nil and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            output = "unilib:dye_" .. dye .. " 4",
            recipe = {
                {full_name},
            },
        })

    end

    unilib.register_decoration("beautiflowers_flower_" .. part_name, {
        deco_type = "simple",
        decoration = full_name,

        fill_ratio = unilib.beautiflowers_spawn_ratio / 10000,
        sidelen = 16,
    })

    unilib.register_flower_in_pot(full_name, orig_name)

    return full_name

end
