---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wildlife
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.opt_wildlife = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.wildlife.add_mode

-- Localise math functions (for speed)
local max = math.max
local min = math.min
local random = math.random

-- Adapt values from Minetest settings
-- N.B. The original code used different default values in init.lua and settingtypes.txt; unimobs
--      uses the values from settingtypes.txt
local spawn_rate = 1 - max(min(unimobs.setting.wildlife_spawn_probability, 1), 0)
local spawn_reduction_factor = unimobs.setting.wildlife_spawn_reduction_factor

-- Other local variables
local abr = core.get_mapgen_setting("active_block_range")

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_spawn(dtime)

    -- From init.lua, was spawnstep()

    for _, player in ipairs(core.get_connected_players()) do

        -- Each player gets a spawn chance every 5s on average
        if random() < (dtime * 0.2) then

            local velocity = player:get_velocity()
            local speed = vector.length(velocity)
            -- e.g. spawn chance is quadrupled for speed = 4
            local chance = (spawn_rate * 1) / ((speed * 0.75) + 1)

            local yaw
            if speed > 1 then

                -- Spawn in the front arc
                yaw = player:get_look_horizontal() + (random() * 0.35) - 0.75

            else

                -- Random yaw
                yaw = (random() * math.pi * 2) - math.pi

            end

            local pos = player:get_pos()
            local dir = vector.multiply(core.yaw_to_dir(yaw), abr * 16)
            local pos2 = vector.add(pos, dir)
            pos2.y = pos2.y - 5
            local height, liquid_flag = unimobs.mobkit_api.get_walkable_terrain_height(pos2, 32)

            if height and  height >= 0 and not liquid_flag then

                local def_table = unimobs.mobkit_api.get_node_defn_at_pos(
                    {x = pos2.x, y = height - 0.01, z = pos2.z}
                )
                if def_table.is_ground_content then

                    local obj_list = core.get_objects_inside_radius(pos, (abr * 16) + 5)
                    local wolf_count = 0
                    local deer_count = 0

                    -- Count mobs in active block range
                    for _, obj in ipairs(obj_list) do

                        if not obj:is_player() then

                            local luaent = obj:get_luaentity()
--                          if luaent and luaent.name:find('wildlife:') then
                            if luaent and (
                                luaent.name == "unilib:mob_deer_simple" or
                                luaent.name == "unilib:mob_wolf_simple"
                            ) then

                                -- Chance reduced for every deer/wolf in range
                                chance = chance + (1 - chance) * spawn_reduction_factor
                                if luaent.name == "unilib:mob_wolf_simple" then
                                    wolf_count = wolf_count + 1
                                elseif luaent.name == "unilib:mob_deer_simple" then
                                    deer_count = deer_count + 1
                                end

                            end

                        end

                    end

                    if chance < random() then

                        -- If no wolves and at least one deer, then spawn a wolf, otherwise spawn a
                        --      deer
                        local mobname =
                                (deer_count > (wolf_count + 1) and "unilib:mob_wolf_simple") or
                                "unilib:mob_deer_simple"

                        pos2.y = height + 0.5
                        obj_list = core.get_objects_inside_radius(pos2, (abr * 16) - 2)
                        -- Do not spawn if there's another player around
                        for _, obj in ipairs(obj_list) do

                            if obj:is_player() then
                                return
                            end

                        end

                        -- Spawn the mob
                        local spawn_obj = core.add_entity(pos2, mobname)
                        if spawn_obj then

                            local luaent = spawn_obj:get_luaentity()
                            if luaent then

                                unilib.utils.log(
                                    "action",
                                    string.format(
                                        "[unimobs] Spawned %s at %s",
                                        luaent.name,
                                        unimobs.petz_api.pos_to_string(
                                            vector.round(spawn_obj:get_pos())
                                        )
                                    )
                                )

                            end

                        end

                    end

                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.opt_wildlife.init()

    return {
        description = "Optional spawning for mobs from the \"wildlife\" remix",
        notes = "Use this package if you want to emulate the behaviour of the \"wildlife\" mod," ..
                " in which simple deer and simple wolves spawn anywhere",
    }

end

function unilib.pkg.opt_wildlife.exec()
    core.register_globalstep(do_spawn)
end
