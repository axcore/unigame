---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    simple_furniture
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_basic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.simple_furniture.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(part_name, orig_part_name)

    -- Fallback check; the code below checks that the package has been loaded
    if unilib.tree_table[part_name] == nil then
        return
    end

    local description = unilib.tree_table[part_name]["description"]

    if orig_part_name == nil then

        -- Tree types not from minetest_game
        unilib.register_wooden_bench({
            part_name = part_name,
            orig_name = nil,

            replace_mode = mode,
            description = unilib.brackets(S("Wooden Bench"), description),
        })

        if unilib.pkg_executed_table["trapdoor_wood_ordinary"] ~= nil then

            unilib.register_wooden_cabinet({
                part_name = part_name,
                orig_name = nil,

                replace_mode = mode,
                description = unilib.brackets(S("Wooden Cabinet"), description),
            })

        end

        if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

            unilib.register_wooden_chair({
                part_name = part_name,
                orig_name = nil,

                replace_mode = mode,
                description = unilib.brackets(S("Wooden Chair"), description),
            })

            unilib.register_wooden_table_dining({
                part_name = part_name,
                orig_name = nil,

                replace_mode = mode,
                description = unilib.brackets(S("Wooden Dining Table"), description),
            })

            unilib.register_wooden_table_end({
                part_name = part_name,
                orig_name = nil,

                replace_mode = mode,
                description = unilib.brackets(S("Wooden End Table"), description),
            })

        end

    else

        -- Tree types from minetest_game. Luckily, the original mod's name component is the same as
        --      the one used in unilib (e.g. "apple")
        unilib.register_wooden_bench({
            part_name = part_name,
            orig_name = "simple_furniture:" .. part_name .. "_wood_bench",

            replace_mode = mode,
            description = unilib.brackets(S("Wooden Bench"), description),
        })

        if unilib.pkg_executed_table["trapdoor_wood_ordinary"] ~= nil then

            unilib.register_wooden_cabinet({
                part_name = part_name,
                orig_name = "simple_furniture:" .. part_name .. "_wood_cabinet",

                replace_mode = mode,
                description = unilib.brackets(S("Wooden Cabinet"), description),
            })

        end

        if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

            unilib.register_wooden_chair({
                part_name = part_name,
                orig_name = "simple_furniture:" .. part_name .. "_wood_chair",

                replace_mode = mode,
                description = unilib.brackets(S("Wooden Chair"), description),
            })

            unilib.register_wooden_table_dining({
                part_name = part_name,
                orig_name = "simple_furniture:" .. part_name .. "_wood_dining_table",

                replace_mode = mode,
                description = unilib.brackets(S("Wooden Dining Table"), description),
            })

            unilib.register_wooden_table_end({
                part_name = part_name,
                orig_name = "simple_furniture:" .. part_name .. "_wood_end_table",

                replace_mode = mode,
                description = unilib.brackets(S("Wooden End Table"), description),
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

    if not unilib.add_stairs_basic_flag then
        return
    end

    -- (The original mod's code and unilib both use identical strings to describe the tree_type)
    local check_table = {}
    for _, tree_type in pairs({"acacia", "apple", "aspen", "jungle", "pine"}) do
        check_table[tree_type] = tree_type
    end

    local furniture_table = {}
    for tree_type, _ in pairs(unilib.super_tree_table) do

        furniture_table[tree_type] = {
            -- Set to "acacia", "apple" etc (for the minetest_game trees), but nil for all others
            orig_name = check_table[tree_type],
        }

    end

    for tree_type, mini_list in pairs(furniture_table) do

        local ingredient = "unilib:tree_" .. tree_type .. "_wood"

        if unilib.pkg_executed_table["tree_" .. tree_type] ~= nil and
                minetest.registered_nodes[ingredient] ~= nil then
            do_register(tree_type, mini_list.orig_name)
        end

    end

end
