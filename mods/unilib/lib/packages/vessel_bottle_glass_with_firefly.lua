---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_glass_with_firefly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.fireflies.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_glass_with_firefly.init()

    return {
        description = "Firefly in a glass bottle",
        depends = {"misc_firefly", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.vessel_bottle_glass_with_firefly.exec()

    unilib.register_node(
        "unilib:vessel_bottle_glass_with_firefly",
        "fireflies:firefly_bottle",
        mode,
        {
            -- From fireflies:firefly_bottle
            description = S("Firefly in a Glass Bottle"),
            tiles = {{
                name = "unilib_vessel_bottle_glass_with_firefly_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            }},
            groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
            sounds = unilib.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_vessel_bottle_glass_with_firefly.png",
            light_source = 9,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
            },
            sunlight_propagates = true,
            walkable = false,
            wield_image = "unilib_vessel_bottle_glass_with_firefly.png",

            on_rightclick = function(pos, node, player, itemstack, pointed_thing)

                local lower_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
                if minetest.is_protected(pos, player:get_player_name()) or
                        minetest.get_node(lower_pos).name ~= "air" then
                    return
                end

                local upper_pos = {x = pos.x, y = pos.y + 2, z = pos.z}
                local firefly_pos

                if not minetest.is_protected(upper_pos, player:get_player_name()) and
                        minetest.get_node(upper_pos).name == "air" then
                    firefly_pos = upper_pos
                elseif not minetest.is_protected(lower_pos, player:get_player_name()) then
                    firefly_pos = lower_pos
                end

                if firefly_pos then

                    minetest.set_node(pos, {name = "unilib:vessel_glass_bottle_empty"})
                    minetest.set_node(firefly_pos, {name = "unilib:misc_firefly"})
                    minetest.get_node_timer(firefly_pos):start(1)

                end

            end,
        }
    )
    unilib.register_craft({
        -- From fireflies:firefly_bottle
        output = "unilib:vessel_bottle_glass_with_firefly",
        recipe = {
            {"unilib:misc_firefly"},
            {"unilib:vessel_bottle_glass_empty"}
        }
    })

end
