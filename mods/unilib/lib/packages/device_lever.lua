---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_lever = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_lever.init()

    return {
        description = "Door lever",
        notes = "Right-click to open or close any adjoining doors and trapdoors (for a few" ..
                " seconds)",
        depends = "shared_xdecor",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.device_lever.exec()

    unilib.register_node("unilib:device_lever_off", "xdecor:lever_off", mode, {
        -- From xdecor:lever_off
        description = S("Door Lever"),
        tiles = {"unilib_device_lever_off.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.stone,

        -- N.B. display_offset added for compatibility with display frames
        display_offset = -3.5,
        drawtype = "nodebox",
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_device_lever_off.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.4375, 0.4375, 0.375, 0.4375, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",

        on_rightclick = function(pos, node, clicker, itemstack)

            if not unilib.access.get_door then
                return itemstack
            end

            local minp = {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2}
            local maxp = {x = pos.x + 2, y = pos.y + 1, z = pos.z + 2}
            local doors = core.find_nodes_in_area(minp, maxp, "group:door")

            for i = 1, #doors do
                unilib.pkg.shared_xdecor.toggle_door(pos, doors[i], clicker)
            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From xdecor:lever_off
        output = "unilib:device_lever_off",
        recipe = {
            {"group:stick"},
            {"group:stone"},
        },
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:device_lever_off", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.register_node("unilib:device_lever_on", "xdecor:lever_on", mode, {
        -- From xdecor:lever_on
        -- (no description)
        tiles = {"unilib_device_lever_on.png"},
        groups = {cracky = 3, not_in_creative_inventory = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.stone,

        drawtype = "nodebox",
        drop = "unilib:device_lever_off",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.4375, 0.4375, 0.375, 0.4375, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:device_lever_on", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
