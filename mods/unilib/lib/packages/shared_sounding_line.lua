---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sounding_line
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_sounding_line = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.sounding_line.add_mode

local particles_flag = core.settings:get_bool("enable_particles", true)

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_sounding_line.on_rightclick(pos, node, player, itemstack, pointed_thing)

    local full_name = node.name
    local top = pos.y - 1
    local bottom = pos.y - 15
    local voxel_manip = core.get_voxel_manip()

    local end_depth, water_depth, lava_depth
    local encountered_lava_flag, encountered_ignore_flag
    local data_table = {}

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
            local name = core.get_name_from_content_id(data_table[index])
            if name == "ignore" then

                encountered_ignore_flag = true
                end_depth = pos.y - y

            end

            if not water_depth and core.get_item_group(name, "water") > 0 then
                water_depth = pos.y - y
            end

            if not lava_depth and core.get_item_group(name, "lava") > 0 then

                lava_depth = pos.y - y
                if node.name ~= "unilib:misc_line_sounding_reinforced" then

                    end_depth = pos.y - y
                    encountered_lava_flag = true

                end

            end

            local def_table = core.registered_nodes[name]
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
        core.chat_send_player(player_name, result)
        status = status .. "\n" .. result

    end

    if lava_depth and not encountered_lava_flag then

        local result = S("There is lava @1m down", lava_depth)
        core.chat_send_player(player_name, result)
        status = status .. "\n" .. result

    end

    if encountered_lava_flag then

        local result = S("The line burned up @1m down", end_depth)
        core.chat_send_player(player_name, result)
        status = status .. "\n" .. result

    elseif encountered_ignore_flag then

        local result = S("There is an unknown void @1m down", end_depth)
        core.chat_send_player(player_name, result)
        status = status .. "\n" .. result

    else

        local result = S("There is an obstruction @1m down", end_depth)
        core.chat_send_player(player_name, result)
        status = status .. "\n" .. result

    end

    local meta = core.get_meta(pos)
    meta:set_string("infotext", status)

    if particles_flag then

        local img = "unilib_particle_misc_line_sounding_normal.png"
        if node.name == "unilib:misc_line_sounding_reinforced" then
            img = "unilib_particle_misc_line_sounding_reinforced.png"
        end

        core.add_particlespawner({
            amount = 50,
            time = 1,
            texture = img,

            maxacc = {x = 0, y = 0, z = 0},
            minacc = {x = 0, y = 0, z = 0},
            maxexptime = 1,
            minexptime = 1,
            maxpos = pos,
            minpos = pos,
            maxsize = 8,
            minsize = 8,
            maxvel = {x = 0, y = -10, z = 0},
            minvel = {x = 0, y = -10, z = 0},

            collisiondetection = true,
            vertical = true,
        })

    end

    core.sound_play("unilib_misc_line_sounding", {pos = pos, gain = 0.5})

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_sounding_line.init()

    return {
        description = "Shared functions for sounding lines (from sounding_line)",
    }

end
