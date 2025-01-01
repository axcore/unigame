---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.mapgen_darkage = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Local constants for the mapgen, set during the .post() function below
local c_air = core.CONTENT_AIR
local c_ignore = core.CONTENT_IGNORE
local c_lawn = nil
local c_dirt = nil
local c_sand = nil
local c_stone = nil
local c_water = nil
-- Associative array used in calls to .generate_stratus()
local stone_air_table = {}
-- Table with unknown purpose
local dbuf_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

-- Notes from darkage:
-- Makes a stratus of rocks
-- name of the rock to generate
-- c_wherein id of node to replace, for example core.get_content_id("default:stone")
-- ca_ceilin associative array
-- minp, maxp the corners of the map to be generated
-- seed random seed
-- stratus_chance inverse probability in a given radius 1:2, 1:3 etc
-- radius horizontal radius of the stratus
-- radius_y vertical radius of the stratus
-- deep how deep can be from the ground

local function generate_stratus(
    data, area, name, c_wherein, ca_ceilin, minp, maxp, seed, stratus_chance, radius, radius_y,
    deep, y_min, y_max
)
    if maxp.y < y_min or minp.y > y_max then
        return
    end

    local c_node = core.get_content_id(name)

    -- It will be only generate a stratus for every 100 m of area
    local stratus_per_volume=1
    local area_size = 45
    local y_min = math.max(minp.y, y_min)
    local y_max = math.min(maxp.y, y_max)
    local volume = ((maxp.x - minp.x + 1) / area_size) *
            ((y_max - y_min + 1) / area_size) *
            ((maxp.z - minp.z + 1) / area_size)
    local pr = PseudoRandom(seed)
    local blocks = math.floor(stratus_per_volume * volume)

    if blocks == 0 then
        blocks = 1
    end

    for i = 1,blocks do

        if pr:next(1,stratus_chance) == 1 then

            local y0 = y_max - radius_y + 1
            if y0 < y_min then
                y0 = y_min
            else
                y0 = pr:next(y_min, y0)
            end

            local x0 = maxp.x - radius + 1
            if x0 < minp.x then
                x0 = minp.x
            else
                x0 = pr:next(minp.x, x0)
            end

            local z0 = maxp.z - radius + 1
            if z0 < minp.z then
                x0 = minp.z
            else
                z0 = pr:next(minp.z, z0)
            end

            local n = data[area:index(x0, y0, z0)]
            local i = 0

            if ca_ceilin[n] then

                -- Search for the node to replace
                local vi = area:index(x0, y0-1, z0)
                for y1 = y0-1, y_min, -1 do

                    if data[vi] == c_wherein then

                        y0 = math.max(y1 - deep, y_min)
                        break

                    end

                    vi = vi - area.ystride

                end

                local rx=pr:next(radius / 2, radius) + 1
                local rz=pr:next(radius / 2, radius) + 1
                local ry=pr:next(radius_y / 2, radius_y) + 1

                vi = area:index(x0, y0, z0)
                for x1=0,rx do

                    local vi = vi + x1
                    rz = math.max(rz + 3 - pr:next(1,6), 1)

                    for z1 = pr:next(1,3), rz do

                        local vi = vi + z1 * area.zstride
                        for y1 = pr:next(1,3), ry + pr:next(1,3) do

                            local vi = vi + y1 * area.ystride
                            if data[vi] == c_wherein then

                                data[vi] = c_node
                                i = i + 1

                            end

                        end

                    end

                end

            end

        end

    end

end

local function generate_claylike(
    data, varea, name, minp, maxp, seed, chance, minh, maxh, needs_dirt
)
    if maxp.y >= maxh + 1 and minp.y <= minh - 1 then

        local c_ore = core.get_content_id(name)
        local pr = PseudoRandom(seed)

        local divlen = 4
        local divs = (maxp.x - minp.x) / divlen + 1

        for yy=minh, maxh do

            local x = pr:next(1,chance)
            if x == 1 then

                for divx = 0 + 1, divs - 1 - 1 do

                    for divz=0 + 1, divs - 1 - 1 do

                        local cx = minp.x + math.floor((divx + 0.5 ) * divlen)
                        local cz = minp.z + math.floor((divz + 0.5) * divlen)
                        local up = data[varea:index(cx, yy, cz)]
                        local down = data[varea:index(cx, yy - 1, cz)]

                        if (up == c_water or up == c_air) and (
                            down == c_sand or (needs_dirt and (down == c_dirt or down == c_lawn ))
                        ) then
                            local num_water_around = 0

                            if data[varea:index(cx - divlen * 2, yy, cz)] == c_water then
                                num_water_around = num_water_around + 1
                            end

                            if data[varea:index(cx + divlen * 2, yy, cz)] == c_water then
                                num_water_around = num_water_around + 1
                            end

                            if data[varea:index(cx, yy, cz - divlen * 2)] == c_water then
                                num_water_around = num_water_around + 1
                            end

                            if data[varea:index(cx, yy, cz + divlen * 2)] == c_water then
                                num_water_around = num_water_around + 1
                            end

                            if num_water_around < 3 then

                                for x1 = -divlen, divlen do

                                    for z1 = -divlen, divlen do

                                        local i = varea:index(cx + x1, yy - 1, cz + z1)
                                        local down = data[i]
                                        if down == c_sand or (needs_dirt and
                                                (down == c_dirt or down == c_lawn)) then

                                            data[i] = c_ore

                                        end

                                    end

                                end

                            end

                        end

                    end

                end

            end

        end

    end

end

local function generate_strati(minp, maxp, seed)

    local t1 = os.clock()

    local vm, emin, emax = core.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
    local data = vm:get_data(dbuf_table)

    if unilib.global.pkg_executed_table["dirt_mud_dry"] ~= nil then
        generate_claylike(data, area, "unilib:dirt_mud_dry", minp, maxp, seed + 1, 4, 0, 2, false)
    end

    if unilib.global.pkg_executed_table["sand_silt"] ~= nil then
        generate_claylike(data, area, "unilib:sand_silt", minp, maxp, seed + 2, 4, -1, 1, true)
    end

    if unilib.global.pkg_executed_table["stone_shale_brown"] ~= nil then

        generate_stratus(data, area,
            "unilib:stone_shale_brown",
            c_stone,
            stone_air_table,
            minp, maxp, seed + 5, 4, 23, 7, 50, -50,  20
        )

    end

    if unilib.global.pkg_executed_table["stone_slate_grey"] ~= nil then

        generate_stratus(data, area,
            "unilib:stone_slate_grey",
            c_stone,
            stone_air_table,
            minp, maxp, seed + 6, 6, 23, 5, 50, -500, 0
        )

    end

    if unilib.global.pkg_executed_table["stone_schist_grey"] ~= nil then

        generate_stratus(data, area,
            "unilib:stone_schist_grey",
            c_stone,
            stone_air_table,
            minp, maxp, seed + 7, 6, 19, 6, 50, unilib.constant.y_min, -10
        )

    end

    if unilib.global.pkg_executed_table["stone_basalt_dark"] ~= nil then

        generate_stratus(data, area,
            "unilib:stone_basalt_dark",
            c_stone,
            stone_air_table,
            minp, maxp, seed + 8, 5, 20, 5, 20, unilib.constant.y_min, -50
        )

    end

    if unilib.global.pkg_executed_table["stone_marble_grey"] ~= nil then

        generate_stratus(data, area,
            "unilib:stone_marble_grey",
            c_stone,
            stone_air_table,
            minp, maxp, seed + 9, 4, 25, 6, 50, unilib.constant.y_min,  -75
        )

    end

    if unilib.global.pkg_executed_table["stone_serpentine"] ~= nil then

        generate_stratus(data, area,
            "unilib:stone_serpentine",
            c_stone,
            stone_air_table,
            minp, maxp, seed + 10, 4, 28, 8, 50, unilib.constant.y_min,  -350
        )

    end

    if unilib.global.pkg_executed_table["stone_gneiss_white"] ~= nil then

        generate_stratus(data, area,
            "unilib:stone_gneiss_white",
            c_stone,
            stone_air_table,
            minp, maxp, seed + 11, 4, 15, 5, 50, unilib.constant.y_min, -250
        )

    end

    vm:set_data(data)
    vm:write_to_map()

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mapgen_darkage.init()

    return {
        description = "Shared functions for generating a mapgen stratus for each of various" ..
                " nodes (from darkage)",
        depends = {
            "dirt_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "stone_ordinary",
        },
        optional = {
            "dirt_mud_dry",
            "sand_silt",
            "stone_shale_brown",
            "stone_slate_grey",
            "stone_schist_grey",
            "stone_basalt_dark",
            "stone_marble_grey",
            "stone_serpentinite_pale",
            "stone_gneiss_white",
        },
    }

end

function unilib.pkg.mapgen_darkage.post()

    -- (The local variables can now be set. All of the parent packages are hard dependencies)
    c_dirt = core.get_content_id("unilib:dirt_ordinary")
    c_lawn = core.get_content_id("unilib:dirt_ordinary_with_turf")
    c_sand = core.get_content_id("unilib:sand_ordinary")
    c_stone = core.get_content_id("unilib:stone_ordinary")
    c_water = core.get_content_id("unilib:liquid_water_ordinary_source")
    stone_air_table = {[c_stone] = true, [c_air] = true}

    core.register_on_generated(generate_strati)

end
