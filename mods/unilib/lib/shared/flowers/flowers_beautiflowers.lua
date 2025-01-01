---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flowers_beautiflowers.lua
--      API functions for flowers from the beautiflowers mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local seed_count = 2000

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
-- API functions for flowers from the beautiflowers mod
---------------------------------------------------------------------------------------------------

function unilib.flowers._register_beautiflower(data_table)

    -- Adapted from beautiflowers/init.lua
    -- An alternative to unilib.register_flower(), optimised for beautiflowers items
    -- (Since there are so many of them, it's cheaper to put a function here, rather than creating
    --      a shared package which must be checked dozens of times)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "arcoiris"
    --      orig_name (str): e.g. "beautiflowers:arcoiris"
    --      select_table (table): Table used in the .selection_box field in the core.register_node()
    --          call
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

    -- N.B. In original code, beautiflowers = 1 replaces the colour_XXX group
    local group_table = {attached_node = 1, flammable = 1, flora = 1, flower = 1, snappy = 3}
    if dye ~= nil then

        group_table["colour_" .. dye] = 1
        group_table["color_" .. dye] = 1

    end

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
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    if dye ~= nil and unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            output = "unilib:dye_" .. dye .. " 4",
            recipe = {
                {full_name},
            },
        })

    end

    unilib.register_decoration_generic("beautiflowers_flower_" .. part_name, {
        deco_type = "simple",
        decoration = full_name,

        fill_ratio = unilib.setting.beautiflowers_spawn_ratio / 10000,
        sidelen = 16,
    })

    unilib.register_flower_in_pot(full_name, orig_name)

    return full_name

end
