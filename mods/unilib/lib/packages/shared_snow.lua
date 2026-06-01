---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_snow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

-- unilib nodes names; if the nodes are not available, the code below replaces them with
--      minetest_game nodes
local c_dirt = "unilib:dirt_ordinary"                           -- default:dirt
local c_dirt_with_turf = "unilib:dirt_ordinary_with_turf"       -- default:dirt_with_grass
local c_dirt_with_snow = "unilib:dirt_ordinary_with_cover_snow" -- default:dirt_with_snow
local c_ice = "unilib:ice_ordinary"                             -- default:ice
local c_snow = "unilib:snow_ordinary"                           -- default:snow
local c_snow_block = "unilib:snow_ordinary_block"               -- default:snowblock

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_uneven(pos)

    -- From snow/init.lua, was uneven()
    -- Checks if the snow level is even at any given pos
    -- Converts ordinary dirts with covers, into ordinary dirt with snow cover (but not other types
    --      of dirt)

    local num = core.get_node_level(pos)
    local get_node_func = core.get_node
    local add_node_func = core.add_node
    local found_x, found_z

    for z = -1, 1 do

        for x = -1, 1 do

            local p = {x = pos.x + x, y = pos.y, z = pos.z + z}
            local node = get_node_func(p)
            p.y = p.y - 1
            local below_node = get_node_func(p)

            if node and
                    core.registered_nodes[node.name] and
                    core.registered_nodes[node.name].drawtype == "plantlike" and (
                        below_node.name == c_dirt_with_turf or (
                            unilib.global.dirt_with_turf_table[below_node.name] and
                            unilib.global.dirt_with_turf_table[below_node.name]["dirt_part_name"] ==
                                "dirt_ordinary"
                        )
                    ) then

                add_node_func(p, {name = c_dirt_with_snow})
                return true

            end

            p.y = p.y + 1
            if not (x == 0 and z == 0) and
                    node.name == c_snow and
                    core.get_node_level(p) < num then

                found_x = x
                found_z = z

            elseif node.name == "air" and
                    below_node.name ~= "air" and
                    below_node.name ~= c_snow then

                p.y = p.y - 1
                unilib.pkg.shared_snow.place_snow_on_ground(p)
                return true

            end

        end

    end

    if found_x then

        local p = {x = pos.x + found_x, y = pos.y, z = pos.z + found_z}
        if not is_uneven(p) then
            core.add_node_level(p, 7)
        end

        return true

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_snow.can_place_snow_on_ground(pos)

    -- "pos" is some position at or above the surface, where snow is falling
    -- Check that the area above and below "pos" is empty (so there are no obstructions for any
    --      snowflakes), and also find the surface position
    -- If snow can be placed at the surface position, return its position; otherwise return nil

    local ground_y = nil
    for y = pos.y + 10, pos.y + 20, 1 do

        local full_name = core.get_node({x = pos.x, y = y, z = pos.z}).name
        if full_name ~= "air" and full_name ~= "ignore" then
            return
        end

    end

    for y = pos.y + 9, pos.y - 15, -1 do

        local full_name = core.get_node({x = pos.x, y = y, z = pos.z}).name
        if full_name ~= "air" and full_name ~= "ignore" then

            ground_y = y
            break

        end

    end

    if not ground_y then
        return
    end

    -- Can place snow here
    return {x = pos.x, y = ground_y, z = pos.z}

end

function unilib.pkg.shared_snow.place_snow_on_ground(pos)

    -- From snow/init.lua, was snow.place()
    -- This function places snow checking at the same time for snow level and increasing as needed
    -- This also takes into account sourrounding snow and makes snow even

    local node = core.get_node_or_nil(pos)
    if not node or not core.registered_nodes[node.name] then
        return
    end

    if node.name == c_snow then

        local level = core.get_node_level(pos)
        if level < 63 then

            if core.get_item_group(
                core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name,
                "leafdecay"
            ) == 0 and not is_uneven(pos) then

                core.sound_play("unilib_snow_footstep", {pos = pos})
                core.add_node_level(pos, 7)

            end

        elseif level == 63 then

            local p = core.find_node_near(
                pos, 10, {"default:dirt_with_grass", "group:spreading_dirt"}
            )
            if p and core.get_node_light(p, 0.5) == 15 then

                core.sound_play("unilib_grass_footstep", {pos = pos})
                core.place_node(
                    {x = pos.x, y = pos.y + 1, z = pos.z}, {name = c_snow}
                )

            else

                core.sound_play("unilib_snow_footstep", {pos = pos})
                core.add_node(pos, {name = c_snow_block})

            end

        end

    elseif node.name ~= c_ice and
            core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ~= "air" then

        local def_table = core.registered_nodes[node.name]
        local drawtype = def_table.drawtype
        if drawtype == "normal" or drawtype == "allfaces_optional" then

            pos.y = pos.y + 1
            local sound = def_table.sounds
            if sound then

                sound = sound.footstep
                if sound then
                    core.sound_play(sound.name, {pos = pos, gain = sound.gain})
                end

            end

            core.place_node(pos, {name = c_snow})

        elseif drawtype == "plantlike" then

            pos.y = pos.y - 1
            local below_node = core.get_node(pos)
            if below_node.name == c_dirt_with_turf or (
                unilib.global.dirt_with_turf_table[below_node.name] and
                unilib.global.dirt_with_turf_table[below_node.name]["dirt_part_name"] ==
                        "dirt_ordinary"
            ) then

                core.sound_play("unilib_grass_footstep", {pos = pos})
                core.add_node(pos, {name = c_dirt_with_snow})

            end

        end

    end

end

function unilib.pkg.shared_snow.place_snow_on_dirt(pos)

    -- Called by .on_construct() in various packages

    pos.y = pos.y - 1
    local node = core.get_node(pos)
    if node.name == c_dirt or
        node.name == c_dirt_with_turf or (
            unilib.global.dirt_with_turf_table[node.name] and
            unilib.global.dirt_with_turf_table[node.name]["dirt_part_name"] == "dirt_ordinary"
    ) then
        core.set_node(pos, {name = c_dirt_with_snow})
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_snow.init()

    return {
        description = "Shared functions for customised snow effects and items (from snow mod)",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_cover_snow",
            "dirt_ordinary_with_turf",
            "ice_ordinary",
            "snow_ordinary",
        },
    }

end

function unilib.pkg.shared_snow.exec()

    -- Swap unavailable nodes for minetest_game equivalents
    if core.registered_nodes[c_dirt] == nil then
        c_dirt_with_turf = "default::"
    end
    if core.registered_nodes[c_dirt_with_turf] == nil then
        c_dirt_with_turf = "default:dirt_with_grass"
    end
    if core.registered_nodes[c_dirt_with_snow] == nil then
        c_dirt_with_snow = "default:dirt_with_snow"
    end
    if core.registered_nodes[c_ice] == nil then
        c_ice = "default:ice"
    end
    if core.registered_nodes[c_ice] == nil then
        c_ice = "default:snow"
    end
    if core.registered_nodes[c_snow_block] == nil then
        c_snow_block = "default:snowblock"
    end

    -- Shared craft recipes
    unilib.register_craft({
        -- From snow/crafting.lua
        type = "cooking",
        output = c_ice,
        recipe = "group:cooks_into_ice",
        cooktime = 12,
    })

end
