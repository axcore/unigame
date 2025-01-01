---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_frame_reinforced_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_frame_reinforced_basic.init()

    return {
        description = "Reinforced tree nodes",
        depends = "shared_darkage",
        optional = {"decor_bricks_stone_chalked", "stone_chalk_white"},
    }

end

function unilib.pkg.decor_frame_reinforced_basic.post()

    -- Super trees. Firstly, a list of tree nodes that appeared in the original code
    local tree_list = {
        {
            part_name = "apple",
            orig_name = "default:wood",
        },
    }

    local tree_table = {}
    for tree_type, _ in pairs(unilib.global.super_tree_table) do

        tree_table[tree_type] = {
            part_name = tree_type,
            orig_name = nil,
        }

    end

    for _, mini_table in pairs(tree_list) do

        if tree_table[mini_table.part_name] ~= nil then
            tree_table[mini_table.part_name] = mini_table
        end

    end

    -- Finally, create the new nodes
    for part_name, mini_table in pairs(tree_table) do

        local ingredient = "unilib:tree_" .. part_name .. "_wood"

        if unilib.global.pkg_executed_table["tree_" .. part_name] ~= nil and
                core.registered_nodes[ingredient] ~= nil then

            unilib.pkg.shared_darkage.register_reinforced_frame({
                ingredient = ingredient,
                orig_name = mini_table.orig_name,

                replace_mode = mode,
                group_table = {choppy = 3, flammable = 3, snappy = 2},
                sound_table = unilib.global.sound_table.wood,
                tile_table = {"unilib_tree_" .. part_name .. "_wood.png"},
            })

        end

    end

    -- Other reinforcable nodes
    if unilib.global.pkg_executed_table["decor_bricks_stone_chalked"] ~= nil then

        unilib.pkg.shared_darkage.register_reinforced_frame({
            -- Creates unilib:decor_bricks_stone_chalked_with_frame_reinforced, etc
            ingredient = "unilib:decor_bricks_stone_chalked",
            orig_name = "darkage:chalked_bricks",

            replace_mode = mode,
            group_table = {cracky = 2, stone = 1},
            sound_table = unilib.global.sound_table.stone,
            tile_table = {"unilib_decor_bricks_stone_chalked.png"},
        })

    end

    if unilib.global.pkg_executed_table["stone_chalk_white"] ~= nil then

        unilib.pkg.shared_darkage.register_reinforced_frame({
            -- Creates unilib:stone_chalk_white_powder_with_frame_reinforced, etc
            ingredient = "unilib:stone_chalk_white_powder",
            orig_name = "darkage:chalk_powder",

            replace_mode = mode,
            group_table = {cracky = 3},
            sound_table = unilib.global.sound_table.stone,
            tile_table = {"unilib_stone_chalk_white.png"},
        })

    end

end
