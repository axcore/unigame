---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- clays.lua
--      Set up shared functions for clays
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register baked clays
---------------------------------------------------------------------------------------------------

function unilib.register_clay_baked(data_table)

    -- Adapted from bakedclay/init.lua
    -- Creates a baked clay in a specified colour and updates global variables
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "black"
    --      orig_name (str): e.g. "bakedclay:black"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Black Baked Clay"
    --      translated_name (str): e.g. "Black" (used to create derivative nodes)
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Baked Clay")
    local translated_name = data_table.translated_name or S("Colour")

    local full_name = "unilib:clay_baked_" .. part_name
    local img = "unilib_clay_baked_" .. part_name ..".png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        groups = {bakedclay = 1, cracky = 3},
        sounds = unilib.sound_table.stone,
    })
    if part_name ~= "natural" then

        unilib.register_craft({
            output = full_name .. " 8",
            recipe = {
                {"group:bakedclay", "group:bakedclay", "group:bakedclay"},
                {"group:bakedclay", "unilib:dye_" .. part_name, "group:bakedclay"},
                {"group:bakedclay", "group:bakedclay", "group:bakedclay"},
            },
        })

    end
    unilib.register_stairs(full_name)
    unilib.register_carvings(full_name, {
        facade_flag = true,
    })

    -- Register baked clays for use in the technic_cnc mod
    if unilib.technic_update_flag then

        technic_cnc.register_all(
            full_name,
            {cracky = 3, not_in_creative_inventory = 1},
            {img},
            description
        )

    end

    -- Update the unilib registry
    unilib.clay_baked_table[part_name] = translated_name

    return full_name

end
