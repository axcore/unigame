---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flowers_base.lua
--      Base API functions for flowers
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
-- Base API functions for flowers
---------------------------------------------------------------------------------------------------

function unilib.flowers._register_flower(data_table)

    -- Adapted from flowers/init.lua and flowers_plus/init.lua
    -- Registers the flower node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "rose_red"
    --      orig_name (str): e.g. "flowers:rose"
    --      select_table (table): Table used in the .selection_box field in the core.register_node()
    --          call
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      deco_part_name (str): e.g. "flowers", the first part of the generic decoration name
    --      description (str): e.g. "Red Rose"
    --      fill_ratio (float): e.g. 0.02. Used in the decoration. If not specified, a decoration
    --          with a .noise_params field is used instead
    --      group_table (table): Partial .groups field, typically specifying a colour group (for the
    --          benefit of dyes), and flamability (e.g. colour_red = 1, flammable = 1). The groups
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
        description = unilib.utils.annotate(description, sci_name),
        tiles = {img},
        groups = group_table,
        sounds = unilib.global.sound_table.leaves,

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
            unilib.register_decoration_generic(deco_name, {
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
            unilib.register_decoration_generic(deco_name, {
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
