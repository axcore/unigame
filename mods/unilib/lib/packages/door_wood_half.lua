---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_half = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_half.init()

    return {
        description = "Wooden half-door",
        notes = "Usually used in pairs, one above the other, so that the top and bottom halves" ..
                " of the door can be opened/closed separately. These doors are not compatible" ..
                " with mesecons",
        depends = "door_wood_ordinary",
    }

end

function unilib.pkg.door_wood_half.exec()

    unilib.register_node("unilib:door_wood_half", "cottages:half_door", mode, {
        -- From cottages:half_door
        description = S("Wooden Half-Door"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0.4, 0.48, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0.4, 0.48, 0.5, 0.5},
            },
        },

        on_rightclick = function(pos, node, puncher)

            local node2 = minetest.get_node({x = pos.x, y = (pos.y + 1), z = pos.z})

            local param2 = node.param2
            if param2 % 4 == 1 then
                param2 = param2 + 1     -- 2
            elseif param2 % 4 == 2 then
                param2 = param2 - 1     -- 1
            elseif param2 % 4 == 3 then
                param2 = param2 - 3     -- 0
            elseif param2 % 4 == 0 then
                param2 = param2 + 3     --3
            end

            minetest.swap_node(pos, {name = "unilib:door_wood_half", param2 = param2})

            -- If the node above consists of a door of the same type, open it as well
            -- But don't do that for doors beneath this one, so that the combined door can be
            --      partly opened
            if node2 ~= nil and node2.name == node.name and node2.param2 == node.param2 then

                minetest.swap_node(
                    {x = pos.x, y = (pos.y + 1), z = pos.z},
                    {name = "unilib:door_wood_half", param2 = param2}
                )

            end

        end,
    })
    unilib.register_craft({
        -- From cottages:half_door
        output = "unilib:door_wood_half 2",
        recipe = {
            {"", "group:wood", ""},
            {"", "unilib:door_wood_ordinary", ""},
        }
    })
    -- (For convenience, convert open/closed half-doors)
    unilib.register_craft({
        -- From cottages:half_door
        output = "unilib:door_wood_half",
        recipe = {
            {"unilib:door_wood_half_inverted"},
        }
    })
    unilib.register_craft({
        -- From cottages:half_door_inverted
        output = "unilib:door_wood_half_inverted",
        recipe = {
            {"unilib:door_wood_half"},
        }
    })

    unilib.register_node("unilib:door_wood_half_inverted", "cottages:half_door_inverted", mode, {
        -- From cottages:half_door_inverted
        description = S("Inverted Wooden Half-Door"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- (no sounds)

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.48, 0.5, -0.4},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.48, 0.5, -0.4},
            },
        },

        on_rightclick = function(pos, node, puncher)

            local node2 = minetest.get_node({x = pos.x, y = (pos.y + 1), z = pos.z})

            local param2 = node.param2
            if param2 % 4 == 1 then
                param2 = param2 - 1     -- 0
            elseif param2 % 4 == 0 then
                param2 = param2 + 1     -- 1
            elseif param2 % 4 == 2 then
                param2 = param2 + 1     -- 3
            elseif param2 % 4 == 3 then
                param2 = param2 - 1     -- 2
            end

            minetest.swap_node(pos, {name = "unilib:door_wood_half_inverted", param2 = param2})

            -- If the node above consists of a door of the same type, open it as well
            if node2 ~= nil and node2.name == node.name and node2.param2 == node.param2 then

                minetest.swap_node(
                    {x = pos.x, y = (pos.y + 1), z = pos.z},
                    {name = "unilib:door_wood_half_inverted", param2 = param2}
                )

            end

        end,
    })

end
