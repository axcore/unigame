---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_glass_with_firefly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fireflies.add_mode

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

    local firefly_list = {
        {"yellow",   true,       S("Yellow Firefly in a Glass Bottle")},
    }

    if unilib.setting.mtgame_tweak_flag then

        table.insert(firefly_list, {"orange",   false,      S("Orange Firefly in a Glass Bottle")})
        table.insert(firefly_list, {"red",      false,      S("Red Firefly in a Glass Bottle")})
        table.insert(firefly_list, {"white",    false,      S("White Firefly in a Glass Bottle")})

    end

    -- Register nodes
    for i in ipairs (firefly_list) do

        local part_name = firefly_list[i][1]
        local orig_flag = firefly_list[i][2]
        local description = firefly_list[i][3]

        local orig_name = nil
        if orig_flag then
            orig_name = "fireflies:firefly_bottle"
        end

        local bottle_name = "unilib:vessel_bottle_glass_with_firefly_" .. part_name
        local firefly_name = "unilib:misc_firefly_" .. part_name

        unilib.register_node(bottle_name, orig_name, mode, {
            -- From fireflies:firefly_bottle, etc
            description = description,
            tiles = {{
                name = "unilib_vessel_bottle_glass_with_firefly_" .. part_name .. "_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            }},
            groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
            sounds = unilib.global.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_vessel_bottle_glass_with_firefly_" .. part_name .. ".png",
            -- N.B. no .is_ground_content in original code
            is_ground_content = false,
            light_source = 9,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
            },
            sunlight_propagates = true,
            walkable = false,
            wield_image = "unilib_vessel_bottle_glass_with_firefly_" .. part_name .. ".png",

            on_rightclick = function(pos, node, player, itemstack, pointed_thing)

                local lower_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
                if core.is_protected(pos, player:get_player_name()) or
                        core.get_node(lower_pos).name ~= "air" then
                    return
                end

                local upper_pos = {x = pos.x, y = pos.y + 2, z = pos.z}
                local firefly_pos

                if not core.is_protected(upper_pos, player:get_player_name()) and
                        core.get_node(upper_pos).name == "air" then
                    firefly_pos = upper_pos
                elseif not core.is_protected(lower_pos, player:get_player_name()) then
                    firefly_pos = lower_pos
                end

                if firefly_pos then

                    core.set_node(pos, {name = "unilib:vessel_glass_bottle_empty"})
                    core.set_node(firefly_pos, {name = firefly_name})
                    core.get_node_timer(firefly_pos):start(1)

                end

            end,
        })
        unilib.register_craft({
            -- From fireflies:firefly_bottle
            output = bottle_name,
            recipe = {
                {firefly_name},
                {"unilib:vessel_bottle_glass_empty"},
            },
        })

    end

end
