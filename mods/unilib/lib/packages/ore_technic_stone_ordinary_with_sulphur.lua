---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_technic_stone_ordinary_with_sulphur = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_technic_stone_ordinary_with_sulphur.init()

    return {
        description = "Ordinary stone with sulphur as ore",
        depends = {"liquid_lava_ordinary", "stone_ordinary", "stone_ordinary_with_sulphur"},
    }

end

function unilib.pkg.ore_technic_stone_ordinary_with_sulphur.post()

    local sulphur_buf = {}
    local sulphur_noise

    minetest.register_on_generated(function(minp, maxp)

        local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
        local a = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
        local data = vm:get_data(sulphur_buf)
        local pr = PseudoRandom(17 * minp.x + 42 * minp.y + 101 * minp.z)
        sulphur_noise = sulphur_noise or minetest.get_perlin(9876, 3, 0.5, 100)

        local c_lava = minetest.get_content_id("unilib:liquid_lava_ordinary_source")
        local c_lava_flowing = minetest.get_content_id("unilib:liquid_lava_ordinary_flowing")
        local c_stone = minetest.get_content_id("unilib:stone_ordinary")
        local c_sulphur = minetest.get_content_id("unilib:stone_ordinary_with_sulphur")

        local grid_size = 5
        for x = minp.x + math.floor(grid_size / 2), maxp.x, grid_size do

            for y = minp.y + math.floor(grid_size / 2), maxp.y, grid_size do

                for z = minp.z + math.floor(grid_size / 2), maxp.z, grid_size do

                    local c = data[a:index(x, y, z)]
                    if (c == c_lava or c == c_lava_flowing)
                            and sulphur_noise:get3d({x = x, y = z, z = z}) >= 0.4 then

                        for i in a:iter(
                            math.max(minp.x, x - grid_size),
                            math.max(minp.y, y - grid_size),
                            math.max(minp.z, z - grid_size),
                            math.min(maxp.x, x + grid_size),
                            math.min(maxp.y, y + grid_size),
                            math.min(maxp.z, z + grid_size)
                        ) do

                            if data[i] == c_stone and pr:next(1, 10) <= 7 then
                                data[i] = c_sulphur
                            end

                        end

                    end

                end

            end

        end

        vm:set_data(data)
        vm:write_to_map(data)

    end)

end
