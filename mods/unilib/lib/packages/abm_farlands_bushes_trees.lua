---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_farlands_bushes_trees = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_farlands_bushes_trees.init()

    return {
        description = "ABM to handle farlands trees/bushes (original to unilib)",
        notes = "The original \"farlands\" code uses ore distributions to place" ..
                " leaves-with-fruit nodes in certain trees/bushes. This does not work well on" ..
                " modern Minetest (perhaps it worked better on earlier engines). If ore packages" ..
                " like \"ore_farlands_tree_acacia_exotic\" and \"ore_farlands_bush_exotic\" are" ..
                " not executed, then this package uses an ABM to replace leaves with" ..
                " leaves-with-fruit nodes instead",
    }

end

function unilib.pkg.abm_farlands_bushes_trees.post()

    if not unilib.setting.regrow_fruit_flag then
        return
    end

    local convert_table = {}
    local leaves_list = {}

    if unilib.global.pkg_executed_table["ore_farlands_bush_exotic"] == nil and
            unilib.global.pkg_executed_table["fruit_berry_exotic"] ~= nil then

        convert_table["unilib:bush_exotic_leaves"] = "unilib:bush_exotic_leaves_with_berry"
        table.insert(leaves_list, "unilib:bush_exotic_leaves")

    end

    if unilib.global.pkg_executed_table["ore_farlands_tree_acacia_exotic"] == nil and
            unilib.global.pkg_executed_table["fruit_orange_exotic"] ~= nil then

        convert_table["unilib:tree_acacia_exotic_leaves"] =
                "unilib:tree_acacia_exotic_leaves_with_orange"
        table.insert(leaves_list, "unilib:tree_acacia_exotic_leaves")

    end

    if unilib.global.pkg_executed_table["ore_farlands_tree_exotic"] == nil then

        local match_flag = false

        if unilib.global.pkg_executed_table["fruit_apple_exotic"] ~= nil then

            convert_table["unilib:tree_exotic_leaves"] = "unilib:tree_exotic_leaves_with_apple"
            match_flag = true

        end

        if unilib.global.pkg_executed_table["fruit_peach_exotic"] ~= nil then

            convert_table["unilib:tree_exotic_leaves"] = "unilib:tree_exotic_leaves_with_peach"
            match_flag = true

        end

        if unilib.global.pkg_executed_table["fruit_pear_exotic"] ~= nil then

            convert_table["unilib:tree_exotic_leaves"] = "unilib:tree_exotic_leaves_with_pear"
            match_flag = true

        end

        if unilib.global.pkg_executed_table["fruit_plum_exotic"] ~= nil then

            convert_table["unilib:tree_exotic_leaves"] = "unilib:tree_exotic_leaves_with_plum"
            match_flag = true

        end

        if match_flag then
            table.insert(leaves_list, "unilib:tree_exotic_leaves")
        end

    end

    if unilib.global.pkg_executed_table["ore_farlands_tree_jungle_exotic"] == nil and
            unilib.global.pkg_executed_table["fruit_mango_exotic"] ~= nil then

        convert_table["unilib:tree_jungle_exotic_leaves"] =
                "unilib:tree_jungle_exotic_leaves_with_mango"
        table.insert(leaves_list, "unilib:tree_jungle_exotic_leaves")

    end

    if unilib.global.pkg_executed_table["ore_farlands_tree_palm_exotic"] == nil and
            unilib.global.pkg_executed_table["fruit_coconut_exotic"] ~= nil then

        convert_table["unilib:tree_palm_exotic_leaves"] =
                "unilib:tree_palm_exotic_leaves_with_coconut"
        table.insert(leaves_list, "unilib:tree_palm_exotic_leaves")

    end

    -- Now set up the ABM
    unilib.register_abm({
        label = "Replace tree/bush leaves with leaves-with-fruits [abm_farlands_bushes_trees]",
        nodenames = leaves_list,

        chance = 1,
        interval = math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max),

        action = function(pos, node, active_object_count, active_object_count_wider)

            -- Avoid excessive fruit growth
            local fruit_list = core.find_nodes_in_area(
                {x = pos.x - 3, y = pos.y, z = pos.z - 3},
                {x = pos.x + 3, y = pos.y, z = pos.z + 3},
                convert_table[node.name]
            )

            if #fruit_list == 0 then

                -- Replace a random leaf node, so that the leaves-with-fruit nodes don't appear
                --      in a regular pattern
                local leaves_list = core.find_nodes_in_area(
                    {x = pos.x - 1, y = pos.y, z = pos.z - 1},
                    {x = pos.x + 1, y = pos.y, z = pos.z + 1},
                    node.name
                )

                if #leaves_list > 0 then

                    core.swap_node(
                        leaves_list[math.random(1, #leaves_list)],
                        {name = convert_table[node.name]}
                    )

                end

            end

        end,
    })

end
