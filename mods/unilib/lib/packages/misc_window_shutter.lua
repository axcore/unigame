---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_window_shutter = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

-- Change interval to 600 if your machine is too slow
local update_interval = 20
if unilib.cottages_slow_flag then
    update_interval = 600
end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function update_shutter(pos, old_node_state_name, new_node_state_name)

    -- When shutters are opened/closed (either manually, or due to the ABMs), successively propogate
    --      the new state to any shutters placed above or below them

    local offsets = {-1, 1, -2, 2, -3, 3}
    local stop_up = 0
    local stop_down = 0

    for i, v in ipairs(offsets) do

        local node = minetest.get_node_or_nil({x = pos.x, y = (pos.y + v), z = pos.z })
        if node and
                node.name and
                node.name == old_node_state_name and
                ((v > 0 and stop_up == 0) or (v < 0 and stop_down == 0)) then

            minetest.swap_node(
                {x = pos.x, y = (pos.y + v), z = pos.z},
                {name = new_node_state_name, param2 = node.param2}
            )

        -- Found a different node, so no need to search further up
        elseif v > 0 and stop_up == 0 then

            stop_up = 1

        elseif v < 0 and stop_down == 0 then

            stop_down = 1

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_window_shutter.init()

    return {
        description = "Window shutters",
        notes = "Shutters open when clicked and at daybreak, close at night",
    }

end

function unilib.pkg.misc_window_shutter.exec()

    unilib.register_node("unilib:misc_window_shutter", "cottages:window_shutter_open", mode, {
        -- From cottages:window_shutter_open
        description = unilib.brackets(S("Window Shutters"), S("Open")),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        -- Larger than one node but slightly smaller than a half node so that wallmounted torches
        --      pose no problem
        node_box = {
            type = "fixed",
            fixed = {
                {-0.90, -0.5, 0.4, -0.45, 0.5, 0.5},
                { 0.45, -0.5, 0.4, 0.9, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.9, -0.5, 0.4, 0.9, 0.5, 0.5},
            },
        },

        on_rightclick = function(pos, node, puncher)

            minetest.swap_node(
                pos,
                {name = "unilib:misc_window_shutter_closed", param2 = node.param2}
            )

            update_shutter(
                pos,
                "unilib:misc_window_shutter",
                "unilib:misc_window_shutter_closed"
            )

        end,
    })
    unilib.register_craft({
        -- From cottages:window_shutter_open
        output = "unilib:misc_window_shutter",
        recipe = {
            {"group:wood", "", "group:wood"},
        }
    })
    -- (For convenience, convert open/closed shutters)
    unilib.register_craft({
        -- From cottages:window_shutter_open
        output = "unilib:misc_window_shutter",
        recipe = {
            {"unilib:misc_window_shutter_closed"},
        }
    })
    unilib.register_craft({
        -- From cottages:window_shutter_closed
        output = "cottages:window_shutter_closed",
        recipe = {
            {"unilib:misc_window_shutter_closed"},
        }
    })

    unilib.register_node(
        -- From cottages:window_shutter_closed
        "unilib:misc_window_shutter_closed",
        "cottages:window_shutter_closed",
        mode,
        {
            description = unilib.brackets(S("Window Shutters"), S("Closed")),
            tiles = {"unilib_misc_wood_rustic.png"},
            groups = {
                choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1, snappy = 2,
            },
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            drop = "unilib:misc_window_shutter",
            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, 0.4, -0.05, 0.5, 0.5},
                    { 0.05, -0.5, 0.4, 0.5, 0.5, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5},
                },
            },

            on_rightclick = function(pos, node, puncher)

                minetest.swap_node(
                    pos,
                    {name = "unilib:misc_window_shutter", param2 = node.param2}
                )

                update_shutter(
                    pos,
                    "unilib:misc_window_shutter_closed",
                    "unilib:misc_window_shutter"
                )

            end,
        }
    )

    -- ABM to open shutters in the morning
    -- Change is set to 3, as not all people wake up at the same time
    unilib.register_abm({
        -- From cottages/nodes_doorlike.lua
        label = "Open window shutters in the morning [misc_window_shutter]",
        nodenames = {"unilib:misc_window_shutter_closed"},

        chance = 3,
        interval = update_interval,

        action = function(pos)

            -- At this time, sleeping in a bed is not possible
            if not(minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.805) then

                local old_node = minetest.get_node(pos)
                minetest.swap_node(
                    pos,
                    {name = "unilib:misc_window_shutter", param2 = old_node.param2}
                )

                update_shutter(
                    pos,
                    "unilib:misc_window_shutter_closed",
                    "unilib:misc_window_shutter"
                )

            end

        end,
    })

    -- ABM to close shutters at night
    unilib.register_abm({
        -- From cottages/nodes_doorlike.lua
        label = "Close window shutters at night [misc_window_shutter]",
        nodenames = {"unilib:misc_window_shutter"},

        chance = 2,
        interval = update_interval,

        action = function(pos)

            -- The same time at which sleeping is allowed in beds
            if minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.805 then

                local old_node = minetest.get_node(pos)
                minetest.swap_node(
                    pos,
                    {name = "unilib:misc_window_shutter_closed", param2 = old_node.param2}
                )

                update_shutter(
                    pos,
                    "unilib:misc_window_shutter",
                    "unilib:misc_window_shutter_closed"
                )
            end

        end,
    })

end
