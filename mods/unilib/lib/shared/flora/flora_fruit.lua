---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora_fruit.lua
--      Register regrowing fruit
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register regrowing fruit
---------------------------------------------------------------------------------------------------

function unilib.flora._register_regrowing_fruit(data_table)

    -- Adapted from default:apple and default:apple_mark
    -- Creates a placeholder which enables regrowing fruit, and sets up the regrowth code
    --      (e.g. "unilib:fruit_apple" can be regrown using "unilib:placeholder_fruit_apple")
    -- This function is designed for fruit and other things growing on trees (e.g. blossoms, nuts),
    --      but could be used in any comparable situation
    --
    -- N.B. This function should be called from within a package's .post() function. See the
    --      "fruit_apple" package for an example
    --
    -- data_table compulsory fields:
    --      fruit_name (str): The thing to regrow, e.g. "unilib:fruit_apple"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      leaves_list (list): A surrounding node which must still exist, in order for the fruit to
    --          regrow, e.g. "unilib:tree_apple_leaves". If not specified or an empty list,
    --          "fruit_name" regrows regardless of its surroundings
    --      min_light(int): Minimum light for regrowth (1-14, default 11)
    --      orig_name (str): The placeholder's original name, e.g. "default:apple_mark"
    --      pkg_list (list): The package(s) that provides one or more of the items in "leaves_list".
    --          If not specified or an empty list, we assume that the calling package provides both
    --          the fruit and leaves nodes
    --      regrow_time (int): Regrowth time in seconds. If not specified, the regrowth time is the
    --          same as the standard sapling growth time (a random value between two limits)
    --
    -- Return values:
    --      The full name of the placeholder node, or nil if no placeholder was created

    local fruit_name = data_table.fruit_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local leaves_list = data_table.leaves_list or nil
    local min_light = data_table.min_light or 11
    local orig_name = data_table.orig_name or nil
    local pkg_list = data_table.pkg_list or nil
    local regrow_time = data_table.regrow_time or
            math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)

    local pkg_loaded_flag = false
    if pkg_list ~= nil then

        for _, pkg in pairs(pkg_list) do

            if unilib.global.pkg_executed_table[pkg] ~= nil then

                pkg_loaded_flag = true
                break

            end

        end

    end

    if unilib.setting.regrow_fruit_flag and pkg_loaded_flag then

        local placeholder_name = "unilib:placeholder_" .. unilib.utils.get_item_name(fruit_name)

        unilib.register_node(placeholder_name, orig_name, replace_mode, {
            -- (no description)
            -- (no tiles)
            groups = {not_in_creative_inventory = 1},
            -- (no sounds)

            buildable_to = true,
            diggable = false,
            drawtype = "airlike",
            drop = "",
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,

            on_timer = function(pos, elapsed)

                if not core.find_node_near(pos, 1, leaves_list) then
                    core.remove_node(pos)
                elseif core.get_node_light(pos) < min_light then
                    core.get_node_timer(pos):start(regrow_time)
                else
                    core.set_node(pos, {name = fruit_name})
                end

            end,
        })

        unilib.override_item(fruit_name, {
            after_dig_node = function(pos, oldnode, oldmetadata, digger)

                if oldnode.param2 == 0 then

                    core.set_node(pos, {name = placeholder_name})
                    core.get_node_timer(pos):start(regrow_time)

                end

            end,
        })

        return placeholder_name

    else

        return nil

    end

end
