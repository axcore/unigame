---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fachwerk
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_frame_timber_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fachwerk.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_frame_timber_basic.init()

    return {
        description = "Basic timber frame sets",
        depends = "shared_fachwerk",
    }

end

function unilib.pkg.decor_frame_timber_basic.post()

    -- Super stones. Firstly, a list of stone nodes that appeared in the original code
    local stone_list = {
        {
            part_name = "desert",
            smooth_orig_name = "default:desert_stone",
        },
        {
            part_name = "ordinary",
            brick_orig_name = "default:stone",
            cobble_orig_name = "default:stonebrick",
            smooth_orig_name = "default:cobble",
        },
    }

    -- Now compile a table of super stones
    local stone_table = {}
    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        stone_table[stone_type] = {
            part_name = stone_type,
            brick_orig_name = nil,
            cobble_orig_name = nil,
            smooth_orig_name = nil,
        }

    end

    for _, mini_table in pairs(stone_list) do

        if stone_table[mini_table.part_name] ~= nil then
            stone_table[mini_table.part_name] = mini_table
        end

    end

    -- Finally, create the new nodes
    for part_name, mini_table in pairs(stone_table) do

        if unilib.global.pkg_executed_table["stone_" .. mini_table.part_name] ~= nil then

            local smooth_ingredient = "unilib:stone_" .. part_name
            if core.registered_nodes[smooth_ingredient] ~= nil then

                unilib.pkg.shared_fachwerk.register_timber_frame({
                    ingredient = smooth_ingredient,
                    orig_name = mini_table.smooth_orig_name,

                    replace_mode = mode,
                    simple_flag = true,
                })

            end

            local brick_ingredient = "unilib:stone_" .. part_name .. "_brick"
            if core.registered_nodes[brick_ingredient] ~= nil then

                unilib.pkg.shared_fachwerk.register_timber_frame({
                    ingredient = brick_ingredient,
                    orig_name = mini_table.brick_orig_name,

                    replace_mode = mode,
                    simple_flag = true,
                })

            end

            local cobble_ingredient = "unilib:stone_" .. part_name .. "_cobble"
            if core.registered_nodes[cobble_ingredient] ~= nil then

                unilib.pkg.shared_fachwerk.register_timber_frame({
                    ingredient = cobble_ingredient,
                    orig_name = mini_table.cobble_orig_name,

                    replace_mode = mode,
                    simple_flag = true,
                })

            end

        end

    end

    -- Super trees. Firstly, a list of tree nodes that appeared in the original code
    local tree_list = {
        {
            part_name = "apple",
            orig_name = "default:wood",
        },
        {
            part_name = "jungle",
            orig_name = "default:junglewood",
        },
    }

    -- Now compile a table of super trees
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

            unilib.pkg.shared_fachwerk.register_timber_frame({
                ingredient = ingredient,
                orig_name = mini_table.orig_name,

                replace_mode = mode,
            })

        end

        -- This package provides deliberate craft recipe conflicts
        unilib.register_craft_conflicts({
            {
                "unilib:tree_" .. part_name .. "_wood_with_beam_oblique_down 8",
                "unilib:tree_" .. part_name .. "_wood_with_beam_oblique_up 8",
            },
            {
                "unilib:tree_" .. part_name .. "_wood_with_beam_oblique_down 8",
                "unilib:tree_" .. part_name .. "_wood_with_beam_diagonal_up 8",
            },
            {
                "unilib:tree_" .. part_name .. "_wood_with_beam_oblique_down 8",
                "unilib:tree_" .. part_name .. "_wood_with_beam_triangle_down 8",
            },
            {
                "unilib:tree_" .. part_name .. "_wood_with_beam_oblique_up 8",
                "unilib:tree_" .. part_name .. "_wood_with_beam_diagonal_up 8",
            },
        })

    end

end
