---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_weather = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Used by unilib.pkg.shared_weather.do_splash()
local splash_size = 3
local splash_range = 8

-- Used by unilib.pkg.shared_weather.find_ground_below_pos()
local search_range = 16

-- Used by unilib.pkg.shared_weather.place_puddles()
local ground_range = 12
local ground_limit = 16
-- (Default value; the actual value is obtained from the "misc_puddle" package in code below)
local puddle_count = 1

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_node_cubic(def_table)

    -- Original to unilib
    -- Returns true if the node with the specified definition is a full cube, false if it's some
    --      other shape

    if def_table.drawtype ~= "normal" and
            def_table.drawtype ~= "allfaces" and
            def_table.drawtype ~= "allfaces_optional" then
        return false
    end

    -- If .node_box is defined at all, it must be "regular"
    if not def_table.node_box then
        return true
    else
        return def_table.node_box.type == "regular"
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_weather.do_splash(pname, pos, splash_density, splash_list)

    for i = 1, splash_density do

        local drop_pos = {
            x = pos.x + math.random(-splash_range, splash_range),
            y = math.floor(pos.y),
            z = pos.z + math.random(-splash_range, splash_range),
        }

        local ground_y = unilib.pkg.shared_weather.find_ground_below_pos(drop_pos)
        if ground_y then

            core.after(math.random(), function()

                core.add_particle({
                    acceleration = {x = 0, y = 0, z = 0},
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 0.5,
                    },
                    collisiondetection = false,
                    collision_removal = false,
                    expirationtime = 0.5,
                    playername = pname,
                    pos = {
                        x = drop_pos.x + math.random() - 0.5,
                        y = ground_y + 0.66,
                        z = drop_pos.z + math.random() - 0.5,
                    },
                    size = math.random(splash_size),
                    texture = splash_list[math.random(#splash_list)],
                    velocity = {x = 0, y = 0, z = 0},
                    vertical = true,
                })

            end)

        end

    end

end

function unilib.pkg.shared_weather.find_ground_below_pos(pos)

    local base_y = math.floor(pos.y)

    for y = base_y + search_range, base_y - search_range, -1 do

        local p = {x = pos.x, y = y, z = pos.z}
        local node = core.get_node(p)
        local def_table = core.registered_nodes[node.name]
        if def_table and def_table.walkable then
            return y
        end

    end

end

function unilib.pkg.shared_weather.place_puddles(pname, pos)

    -- N.B. Packages calling this function, must check that the "misc_puddle" and "shared_snow"
    --      package have been loaded

    local rpos = {
        x = pos.x - (ground_range * 2) + math.random(0, (ground_range * 4)),
        y = pos.y + ground_range,
        z = pos.z - (ground_range * 2) + math.random(0, (ground_range * 4)),
    }

    -- (The same logic used to place snowfall on the ground, can also be used for rain)
    local gpos = unilib.pkg.shared_snow.can_place_snow_on_ground(rpos)
    if gpos then

        local node = core.get_node_or_nil(gpos)
        if not node or not core.registered_nodes[node.name] then
            return
        end

        local def_table = core.registered_nodes[node.name]
        if not def_table or not def_table.walkable or not is_node_cubic(def_table) then
            return
        end

        gpos.y = gpos.y + 1
        local puddle_list = core.find_nodes_in_area(
            {x = gpos.x - ground_range, y = gpos.y - 1, z = gpos.z - ground_range},
            {x = gpos.x + ground_range, y = gpos.y + 1, z = gpos.z + ground_range},
            "group:puddle"
        )
        if #puddle_list <= ground_limit then
            core.set_node(gpos, {name = "unilib:misc_puddle_" .. math.random(puddle_count)})
        end

    end

end

function unilib.pkg.shared_weather.place_snowfall(pname, pos)

    -- N.B. Packages calling this function, must check that the "shared_snow" and "snow_ordinary"
    --      packages have been loaded

    local rpos = {
        x = pos.x - (ground_range * 2) + math.random(0, (ground_range * 4)),
        y = pos.y + ground_range,
        z = pos.z - (ground_range * 2) + math.random(0, (ground_range * 4)),
    }

    -- (On success, the function returns rpos adjusted to the ground level)
    local gpos = unilib.pkg.shared_snow.can_place_snow_on_ground(rpos)
    if gpos then
        unilib.pkg.shared_snow.place_snow_on_ground(gpos)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_weather.init()

    return {
        description = "Shared functions for weather packages (original to unilib)",
        optional = {"misc_puddle", "shared_snow", "snow_ordinary"},
    }

end

function unilib.pkg.shared_weather.exec()

    if unilib.global.pkg_executed_table["misc_puddle"] ~= nil and
            unilib.global.pkg_executed_table["shared_snow"] ~= nil then
        puddle_count = unilib.pkg.misc_puddle.get_puddle_count()
    end

end
