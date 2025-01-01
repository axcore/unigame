---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    simple_furniture
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.simple_furniture.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_bench(data_table)

    -- Adapted from simple_furniture/sf_benches.lua
    -- Creates a wooden bench (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.global.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_bench"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Basic Wooden Bench (Aspen Wood)"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Basic Wooden Bench")

    local full_name = "unilib:furniture_bench_basic_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        -- N.B. sf_aspen_wood_bench = 1 (etc) in original code
        groups = {bench = 1, choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
                {-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
                {0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
                {0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
                {-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
                {-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
                {-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
                {0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
                {-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
                {-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        -- Not in original code; adapted from xdecor (see below)
        can_dig = unilib.furniture.can_dig_chair,

        -- Not in original code; adapted from xdecor (see below)
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            pos.y = pos.y + 0
            unilib.furniture.do_sit_chair(pos, node, clicker, pointed_thing)
            return itemstack

        end,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", "", slab_name},
            {slab_name, slab_name, slab_name},
            {slab_name, "", slab_name},
        },
    })

    return full_name

end

local function register_cabinet(data_table)

    -- Adapted from simple_furniture/sf_cabinets.lua
    -- Creates a wooden cabinets (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.global.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_cabinet"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Basic Wooden Cabinet (Aspen Wood)"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Basic Wooden Cabinet")

    local full_name = "unilib:furniture_cabinet_basic_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        -- N.B. Removed chest textures as it doesn't look good
        --[[
        tiles = {
            img,
            img,
            "unilib_container_chest_ordinary_top.png",
            "unilib_container_chest_ordinary_top.png",
            "unilib_container_chest_ordinary_side.png",
            img,
        },
        ]]--
        tiles = {img},
        -- N.B. sf_aspen_wood_cabinet = 1 (etc) in original code
        groups = {cabinet = 1, choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {0.5, -0.5, 0.5, -0.5, -0.4375, -0.375},
                {0.5, -0.4375, 0.5, 0.4375, 0.4375, -0.375},
                {-0.5, -0.4375, 0.5, -0.4375, 0.4375, -0.375},
                {0.4375, -0.4375, 0.5, -0.4375, 0.4375, 0.4375},
                {0.4375, -0.4375, -0.3125, -0.4375, 0.4375, -0.375},
                {0.4375, -0.4375, -0.375, 0.0625, 0.375, -0.4375},
                {-0.4375, -0.4375, -0.375, -0.0625, 0.375, -0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {slab_name, slab_name, slab_name},
            {"unilib:trapdoor_wood_ordinary", slab_name, "unilib:trapdoor_wood_ordinary"},
            {slab_name, slab_name, slab_name},
        },
    })

    unilib.furniture.convert_to_container(full_name, 3, description, "wooden cabinet")

    return full_name

end

local function register_chair(data_table)

    -- Adapted from simple_furniture/sf_chairs.lua
    -- Creates a wooden chair (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.global.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_chair"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Basic Wooden Chair (Aspen Wood)"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Basic Wooden Chair")

    local full_name = "unilib:furniture_chair_basic_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local stick_name = "unilib:item_stick_ordinary"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        -- N.B. sf_aspen_wood_chair = 1 (etc) in original code
        groups = {chair = 1, choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
                {-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
                {0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
                {0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
                {-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
                {-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
                {0.375, 0, 0.375, 0.3125, 0.5, 0.25},
                {-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        -- Not in original code; adapted from xdecor (see below)
        can_dig = unilib.furniture.can_dig_chair,

        -- Not in original code; adapted from xdecor (see below)
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            pos.y = pos.y + 0
            unilib.furniture.do_sit_chair(pos, node, clicker, pointed_thing)
            return itemstack

        end,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", "", stick_name},
            {slab_name, slab_name, slab_name},
            {stick_name, "", stick_name},
        },
    })

    return full_name

end

local function register_dining_table(data_table)

    -- Adapted from simple_furniture/sf_dining_tables.lua
    -- Creates a wooden dining table (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.global.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_dining_table"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Basic Wooden Dining Table (Aspen Wood)"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Basic Wooden Dining Table")

    local full_name = "unilib:furniture_table_dining_basic_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local stick_name = "unilib:item_stick_ordinary"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        -- N.B. sf_aspen_wood_dining_table = 1 (etc) in original code
        groups = {choppy = 3, dining_table = 1, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
                {-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
                {-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
                {-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {slab_name, slab_name, slab_name},
            {"", stick_name, ""},
            {"", slab_name, ""},
        },
    })

    return full_name

end

local function register_end_table(data_table)

    -- Adapted from simple_furniture/sf_end_tables.lua
    -- Creates a wooden end table (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.global.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_end_table"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Basic Wooden End Table (Aspen Wood)"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Basic Wooden End Table")

    local full_name = "unilib:furniture_table_end_basic_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local stick_name = "unilib:item_stick_ordinary"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        -- N.B. sf_aspen_wood_end_table = 1 (etc) in original code
        groups = {choppy = 3, end_table = 1, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
                {-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
                {0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
                {0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
                {-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
                {0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
                {-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {slab_name, slab_name, slab_name},
            {stick_name, "", stick_name},
            {stick_name, "", stick_name},
        },
    })

    return full_name

end

local function do_register(part_name, orig_part_name)

    -- Fallback check; the code below checks that the package has been loaded
    if unilib.global.tree_table[part_name] == nil then
        return
    end

    local description = unilib.global.tree_table[part_name]["description"]

    if orig_part_name == nil then

        -- Tree types not from minetest_game
        register_bench({
            part_name = part_name,
            orig_name = nil,

            replace_mode = mode,
            description = unilib.utils.brackets(S("Basic Wooden Bench"), description),
        })

        if unilib.global.pkg_executed_table["trapdoor_wood_ordinary"] ~= nil then

            register_cabinet({
                part_name = part_name,
                orig_name = nil,

                replace_mode = mode,
                description = unilib.utils.brackets(S("Basic Wooden Cabinet"), description),
            })

        end

        if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

            register_chair({
                part_name = part_name,
                orig_name = nil,

                replace_mode = mode,
                description = unilib.utils.brackets(S("Basic Wooden Chair"), description),
            })

            register_dining_table({
                part_name = part_name,
                orig_name = nil,

                replace_mode = mode,
                description = unilib.utils.brackets(S("Basic Wooden Dining Table"), description),
            })

            register_end_table({
                part_name = part_name,
                orig_name = nil,

                replace_mode = mode,
                description = unilib.utils.brackets(S("Basic Wooden End Table"), description),
            })

        end

    else

        -- Tree types from minetest_game. Luckily, the original mod's name component is the same as
        --      the one used in unilib (e.g. "apple")
        register_bench({
            part_name = part_name,
            orig_name = "simple_furniture:" .. part_name .. "_wood_bench",

            replace_mode = mode,
            description = unilib.utils.brackets(S("Basic Wooden Bench"), description),
        })

        if unilib.global.pkg_executed_table["trapdoor_wood_ordinary"] ~= nil then

            register_cabinet({
                part_name = part_name,
                orig_name = "simple_furniture:" .. part_name .. "_wood_cabinet",

                replace_mode = mode,
                description = unilib.utils.brackets(S("Basic Wooden Cabinet"), description),
            })

        end

        if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

            register_chair({
                part_name = part_name,
                orig_name = "simple_furniture:" .. part_name .. "_wood_chair",

                replace_mode = mode,
                description = unilib.utils.brackets(S("Basic Wooden Chair"), description),
            })

            register_dining_table({
                part_name = part_name,
                orig_name = "simple_furniture:" .. part_name .. "_wood_dining_table",

                replace_mode = mode,
                description = unilib.utils.brackets(S("Basic Wooden Dining Table"), description),
            })

            register_end_table({
                part_name = part_name,
                orig_name = "simple_furniture:" .. part_name .. "_wood_end_table",

                replace_mode = mode,
                description = unilib.utils.brackets(S("Basic Wooden End Table"), description),
            })

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_basic.init()

    return {
        description = "Basic furniture set",
        notes = "This package creates furniture from the full range of super trees. No" ..
                " furniture is generated if basic stairs are disabled",
        optional = {"item_stick_ordinary", "trapdoor_wood_ordinary"},
    }

end

function unilib.pkg.furniture_basic.post()

    if not unilib.setting.add_stairs_basic_flag then
        return
    end

    -- (The original mod's code and unilib both use identical strings to describe the tree_type)
    local check_table = {}
    for _, tree_type in pairs({"acacia", "apple", "aspen", "jungle", "pine"}) do
        check_table[tree_type] = tree_type
    end

    local furniture_table = {}
    for tree_type, _ in pairs(unilib.global.super_tree_table) do

        furniture_table[tree_type] = {
            -- Set to "acacia", "apple" etc (for the minetest_game trees), but nil for all others
            orig_name = check_table[tree_type],
        }

    end

    for tree_type, mini_list in pairs(furniture_table) do

        local ingredient = "unilib:tree_" .. tree_type .. "_wood"

        if unilib.global.pkg_executed_table["tree_" .. tree_type] ~= nil and
                core.registered_nodes[ingredient] ~= nil then
            do_register(tree_type, mini_list.orig_name)
        end

    end

end
