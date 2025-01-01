---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_pile_logs = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- Local function
---------------------------------------------------------------------------------------------------

local function do_register(data_table)

    -- Adapted from GLEMr4, lib_ecology:logpile
    -- Create a log pile for the specified tree type
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "apple"
    --      ingredient (str): e.g. "unilib:tree_apple_trunk"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Log Pile (Apple Tree Wood)"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Log Pile")

    local full_name = "unilib:misc_pile_logs_" .. part_name
    local orig_name = ""
    if part_name == "apple" then
        orig_name = "lib_ecology:logpile"
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {
            "unilib_tree_" .. part_name .. "_trunk.png^[transformR90",
            "unilib_tree_" .. part_name .. "_trunk.png^[transformR90",
            "unilib_tree_" .. part_name .. "_trunk.png^[transformR90",
            "unilib_tree_" .. part_name .. "_trunk.png^[transformR90",
            "unilib_tree_" .. part_name .. "_trunk_top.png",
            "unilib_tree_" .. part_name .. "_trunk_top.png"
        },
        groups = {choppy = 3, falling_node = 1, flammable = 1, oddly_breakable_by_hand = 1},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        drop = ingredient .. " 3",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.4375, -0.5, -0.0625, -0.125, 0.5},
                {0.0625, -0.4375, -0.5, 0.5, -0.125, 0.5},
                {0.125, -0.5, -0.5, 0.4375, -0.0625, 0.5},
                {-0.4375, -0.5, -0.5, -0.125, -0.0625, 0.5},
                {-0.125, -0.0625, -0.5, 0.1875, 0.375, 0.5},
                {-0.1875, 0, -0.5, 0.25, 0.3125, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", ingredient, ""},
            {ingredient, "", ingredient}
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_pile_logs.init()

    return {
        description = "Log pile set",
        notes = "This package creates log piles from the full range of super trees",
    }

end

function unilib.pkg.misc_pile_logs.post()

    for tree_type, _ in pairs(unilib.global.super_tree_table) do

        local data_table = unilib.global.tree_table[tree_type]
        local ingredient = "unilib:tree_" .. tree_type .. "_trunk"

        if unilib.global.pkg_executed_table["tree_" .. tree_type] ~= nil and
                core.registered_nodes[ingredient] ~= nil then

            do_register({
                part_name = tree_type,
                ingredient = ingredient,

                replace_mode = mode,
                description = unilib.utils.brackets(S("Log Pile"), data_table.description),
            })

        end

    end

end
