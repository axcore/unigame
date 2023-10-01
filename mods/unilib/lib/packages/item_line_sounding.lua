---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sounding_line
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_line_sounding = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sounding_line.add_mode

local data_table = {}
local particles_flag = minetest.settings:get_bool("enable_particles", true)

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_line_sounding.init()

    return {
        description = "Sounding line",
        notes = "Use for measuring depths of holes, caves or water. Right-click to activate",
        depends = "metal_steel",
        optional = "crop_cotton",
        suggested = {
            "rope_mining",                      -- group:vines
        },
    }

end

function unilib.pkg.item_line_sounding.exec()

    unilib.register_node("unilib:item_line_sounding", "sounding_line:sounding_line", mode, {
        -- From sounding_line:sounding_line
        description = S("Sounding Line"),
        tiles = {
            "unilib_item_line_sounding_top.png",
            "unilib_item_line_sounding_bottom.png",
            "unilib_item_line_sounding_side.png",
            "unilib_item_line_sounding_side.png^[transformFX",
            "unilib_item_line_sounding_front.png",
            "unilib_item_line_sounding_front.png^[transformFX",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        drop = "unilib:item_line_sounding",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, 0.125, -0.0625, 0.375, 0.25, 0.0625},
                {-0.5, 0.125, -0.5, -0.375, 0.25, 0.5},
                {0.375, 0.125, -0.5, 0.5, 0.25, 0.5},
                {0.1875, -0.125, -0.3125, 0.3125, 0.5, 0.3125},
                {-0.3125, -0.125, -0.3125, -0.1875, 0.5, 0.3125},
                {-0.1875, -0.0625, -0.25, 0.1875, 0.4375, 0.25},
                {-0.0625, -0.25, -0.25, 0, -0.0625, -0.1875},
                {-0.125, -0.5, -0.3125, 0.0625, -0.25, -0.125},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = false,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            local top = pos.y - 1
            local bottom = pos.y - 15
            local voxel_manip = minetest.get_voxel_manip()

            local end_depth, water_depth
            local encountered_lava, encountered_ignore

            while not end_depth do

                local emin, emax = voxel_manip:read_from_map(
                    {x = pos.x, y = bottom, z = pos.z},
                    {x = pos.x, y = top, z = pos.z}
                )

                voxel_manip:get_data(data_table)
                local voxel_area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
                bottom = emin.y

                for y = top, bottom, -1 do

                    local index = voxel_area:index(pos.x, y, pos.z)
                    local name = minetest.get_name_from_content_id(data_table[index])
                    if name == "ignore" then

                        encountered_ignore = true
                        end_depth = pos.y - y

                    end

                    if not water_depth and minetest.get_item_group(name, "water") > 0 then
                        water_depth = pos.y - y
                    end

                    if not encountered_lava and minetest.get_item_group(name, "lava") > 0 then

                        end_depth = pos.y - y
                        encountered_lava = true

                    end

                    local def_table = minetest.registered_nodes[name]
                    if def_table.walkable then
                        end_depth = pos.y - y
                    end

                    if end_depth then
                        break
                    end

                end

                top = bottom - 1
                bottom = bottom - 15

            end

            local player_name = player:get_player_name()

            local status = S("Most recent sounding line reading:")
            if water_depth then

                local result = S("There is water @1m down", water_depth)
                minetest.chat_send_player(player_name, result)
                status = status .. "\n" .. result

            end

            if encountered_lava then

                local result = S("The line burned up @1m down", end_depth)
                minetest.chat_send_player(player_name, result)
                status = status .. "\n" .. result

            elseif encountered_ignore then

                local result = S("There is an unknown void @1m down", end_depth)
                minetest.chat_send_player(player_name, result)
                status = status .. "\n" .. result

            else

                local result = S("There is an obstruction @1m down", end_depth)
                minetest.chat_send_player(player_name, result)
                status = status .. "\n" .. result

            end

            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", status)

            if particles_flag then

                minetest.add_particlespawner({
                    amount = 50,
                    time = 1,

                    collisiondetection = true,
                    minacc = {x = 0, y = 0, z = 0},
                    maxacc = {x = 0, y = 0, z = 0},
                    minexptime = 1,
                    maxexptime = 1,
                    minpos = pos,
                    maxpos = pos,
                    minsize = 8,
                    maxsize = 8,
                    minvel = {x = 0, y = -10, z = 0},
                    maxvel = {x = 0, y = -10, z = 0},
                    texture = "unilib_item_line_sounding_particle.png",
                    vertical = true,
                })
            end

            minetest.sound_play("unilib_item_line_sounding", {pos = pos, gain = 0.5})

        end,
    })
    -- N.B. group:thread is provided by unilib:crop_cotton_harvest
    unilib.register_craft({
        -- From sounding_line:sounding_line
        output = "unilib:item_line_sounding",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {"group:thread", "group:thread", "group:thread"},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })
    unilib.register_craft({
        -- From sounding_line:sounding_line
        output = "unilib:item_line_sounding",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {"", "group:vines", ""},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })

end
