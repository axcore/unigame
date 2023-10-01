---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- jbiomes.lua
--      Set up shared functions for creating pseudo-biomes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- When placing ore distributions in unilib.jbiome_scatter() and unilib.jbiome_blob(), introduce
--      randomness
local x_off = math.random()
local y_off = math.random()
local z_off = math.random()

-- The number of biomes specified in the calls to unilib.jbiome_setup_matrix() and
--      unilib.jbiome_setup_converted (upper limit: unilib.underch_max_biomes)
local biome_count = 0

-- A table used to convert matrix nodes into pseudo-biome appropriate items (see the comments in
--      unilib.jbiome_setup_converted() )
local biome_convert_table = {}
-- Tables used to place ore distributions, just before converting matrix nodes
local ore_blob_table = {}
local ore_scatter_table = {}

-- Don't permite multiple sets of JIT pseudo-biomes, because we only have one "biome_convert_table",
--      etc
local called_flag = false

-- Set to the return values of minetest.get_content_id(), during a call to unilib.setup_matrix()
local c_bulk = nil
local c_crust = nil
local c_stone = nil

-- unilib.jbiome_reveal() calls check_neighbours(), which in turn calls unilib.jbiome_reveal().
--      This can cause a Minetest stack overflow crash, especially when placing scatters, and
--      even more especially when placing blobs
-- Place a limit on recursion. This number seems to be about right, but you can reduce it if you're
--      getting stack overflow errors
local recursion_count = 0
local recursion_count_max = 2048

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- Adapted from the JIT version of the "underch" mod, which creates a number or underground biomes,
--      named "pseudo-biomes" in unilib code, generated only when required (Just In Time)
-- For an example of how to create JIT pseudo-biomes, see the "mapgen_underch_jit" and
--      "mapgen_underch_jit_unilib" packages
--
-- A brief summary of the process:
--      - The "misc_matrix" package creates two matrix nodes, "bulk" and "crust"
--      - There are two stages of conversion
--      - The first stage is triggered by a call to unilib.jbiome_setup_matrix(), which (among other
--          things)  converts all "unilib:stone_ordinary" nodes to matrix nodes; "crust" if exposed
--          to the air, "bulk" if not. Some ornaments such as mushrooms can also be placed at this
--          stage
--      - The second stage is triggered by a call to unilib.jbiome_setup_converted(), which handles
--          matrix nodes when they are exposed to the air
--      - An individual matrix node, when exposed to the air, triggers a call to
--          unilib.jbiome_reveal(). This replaces the node with a stone that's characteristic of
--          the pseudo-biome, but will sometimes place an alternative node, creating ores
--      - unilib.jbiome_reveal() will call itself recursively in order to handle conversion of any
--          neighbouring matrix nodes
--      - The recursion ends when all of a matrix block's neighbours are in the .jit_shadow group
--
-- As in the original mod, code in this file is inadequately documented

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_neighbours(pos, crust_flag)

    -- Adapted from underch/jit.lua, underch.jit.check_neighbours()

    local positions = {}

    local i = 1
    local pc = 0

    local function add_pos(p)
        positions[pc + 1] = {x = p.x + 1, y = p.y, z = p.z}
        positions[pc + 2] = {x = p.x - 1, y = p.y, z = p.z}
        positions[pc + 3] = {x = p.x, y = p.y + 1, z = p.z}
        positions[pc + 4] = {x = p.x, y = p.y - 1, z = p.z}
        positions[pc + 5] = {x = p.x, y = p.y, z = p.z + 1}
        positions[pc + 6] = {x = p.x, y = p.y, z = p.z - 1}
        pc = pc + 6
    end

    add_pos(pos)

    while i <= pc do

        local name = minetest.get_node(positions[i]).name
        if name == "unilib:misc_matrix_bulk" or name == "unilib:misc_matrix_crust" then

            if unilib.jbiome_reveal(positions[i], false, crust_flag) and (not crust_flag) then
                add_pos(positions[i])
            end

        end

        i = i + 1

    end

end

local function is_crust(x, y, z, vi, area, data)

    -- Adapted from underch/functions.lua, underch.functions.is_crust()

    local dai = data[area:index(x + 1, y, z)]
    if (dai ~= c_crust and dai ~= c_bulk and dai ~= c_stone) then
        return true
    end

    dai = data[area:index(x - 1, y, z)]
    if (dai ~= c_crust and dai ~= c_bulk and dai ~= c_stone) then
        return true
    end

    dai = data[area:index(x, y + 1, z)]
    if (dai ~= c_crust and dai ~= c_bulk and dai ~= c_stone) then
        return true
    end

    dai = data[area:index(x, y - 1, z)]
    if (dai ~= c_crust and dai ~= c_bulk and dai ~= c_stone) then
        return true
    end

    dai = data[area:index(x, y, z + 1)]
    if (dai ~= c_crust and dai ~= c_bulk and dai ~= c_stone) then
        return true
    end

    dai = data[area:index(x, y, z - 1)]
    if (dai ~= c_crust and dai ~= c_bulk and dai ~= c_stone) then
        return true
    end

    return false

end

---------------------------------------------------------------------------------------------------
-- Shared functions (from underch/jit.lua)
---------------------------------------------------------------------------------------------------

function unilib.jbiome_dig_shadow(pos, oldnode, oldmetadata, digger)

    -- Adapted from underch/jit.lua, underch.jit.dig_shadow()

    check_neighbours(pos, false)

end

function unilib.jbiome_ore(pos, node1, node2, chance)

    -- Adapted from underch/jit.lua, underch.jit.ore()

    if (node1 == nil or minetest.get_node(pos).name == node1) and math.random() < chance then
        minetest.set_node(pos, {name = node2})
    end

end

function unilib.jbiome_scatter(pos, y_min, y_max, node1, node2, scarcity, period, period2, period3)

    -- Adapted from underch/jit.lua, underch.jit.scatter()

    if (pos.y < y_min) or (pos.y > y_max) then
        return
    end

    if node1 ~= nil and minetest.get_node(pos).name ~= node1 then
        return
    end

    local xx = math.abs(pos.x + x_off * period2)
    local yy = math.abs(pos.y + y_off * period3)
    local zz = math.abs(pos.z + z_off * period)

    local x_ = (xx % period) / period + (yy % period2) / period2 + (zz % period3) / period3 +
            x_off / 10
    local y_ = (yy % period) / period + (zz % period2) / period2 + (xx % period3) / period3 +
            y_off / 10
    local z_ = (zz % period) / period + (xx % period2) / period2 + (yy % period3) / period3 +
            z_off / 10

    local a = math.tan(math.atan(x_ * y_))
    local b = math.tan(math.atan(x_ * z_))
    local c = math.tan(math.atan(y_ * z_))

    local t = math.sqrt(a * b / c) + math.sqrt(a * c / b) + math.sqrt(b * c / a) - math.abs(x_) -
            math.abs(y_) - math.abs(z_)

    if math.abs(t * 1E17) > scarcity then
        minetest.set_node(pos, {name = node2})
    end

end

function unilib.jbiome_blob(pos, y_min, y_max, node1, node2, size2, period, period2, period3)

    -- Adapted from underch/jit.lua, underch.jit.blob()

    if (pos.y < y_min) or (pos.y > y_max) then
        return
    end

    if node1 ~= nil and minetest.get_node(pos).name ~= node1 then
        return
    end

    local xx = math.abs(pos.x + x_off * period3)
    local yy = math.abs(pos.y + y_off * period)
    local zz = math.abs(pos.z + z_off * period2)
    local xn = math.fmod(math.floor(xx / period2) * 0.56432123 + x_off, 1)
    local yn = math.fmod(math.floor(yy / period2) * 0.23478634 + y_off, 1)
    local zn = math.fmod(math.floor(zz / period2) * 0.35487542 + z_off, 1)
    local xr = math.fmod(math.floor(xx / period3) * 0.76845311, 2) + 1
    local yr = math.fmod(math.floor(yy / period3) * 0.35735452, 2) + 1
    local zr = math.fmod(math.floor(zz / period3) * 0.75343545, 2) + 1
    local x_ = (xx % period) / period * xr - yn * zn
    local y_ = (yy % period) / period * yr - xn * zn
    local z_ = (zz % period) / period * zr - zn * yn
    local t1 = x_ * x_ + y_ * y_ + z_ * z_

    if (t1 < size2) then
        minetest.set_node(pos, {name = node2})
    end

end

function unilib.jbiome_is_shadow(pos)

    -- Adapted from underch/jit.lua, underch.jit.gc()

    local node = minetest.get_node(pos).name
    if node == "ignore" or minetest.registered_nodes[node] == nil then
        return false
    end

    local value = minetest.registered_nodes[node].groups.jit_shadow
    return value == nil or value == 0

end

function unilib.jbiome_is_visible(pos)

    -- Adapted from underch/jit.lua, underch.jit.is_visible()

    return unilib.jbiome_is_shadow({x = pos.x + 1, y = pos.y, z = pos.z}) or
            unilib.jbiome_is_shadow({x = pos.x, y = pos.y + 1, z = pos.z}) or
            unilib.jbiome_is_shadow({x = pos.x, y = pos.y, z = pos.z + 1}) or
            unilib.jbiome_is_shadow({x = pos.x - 1, y = pos.y, z = pos.z}) or
            unilib.jbiome_is_shadow({x = pos.x, y = pos.y - 1, z = pos.z}) or
            unilib.jbiome_is_shadow({x = pos.x, y = pos.y, z = pos.z - 1})

end

function unilib.jbiome_reveal(pos, recursion_flag, crust_flag)

    -- Adapted from underch/jit.lua, underch.jit.reveal()

    -- Basic checks
    if not unilib.jbiome_is_visible(pos) then
        return false
    end

    -- Place ore-distributions around this position
    for _, t in ipairs(ore_blob_table) do
        unilib.jbiome_blob(pos, t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8])
    end

    for _, t in ipairs(ore_scatter_table) do
        unilib.jbiome_scatter(pos, t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8])
    end

    -- Find the pseudo-biome for this position, specified in the earlier call to
    --      unilib.jbiome_setup_converted()
    local darkness = minetest.get_perlin(unilib.pbiome_np_darkness):get_3d(pos)
    local water = minetest.get_perlin(unilib.pbiome_np_water):get_3d(pos)
    local pressure = unilib.pbiome_get_pressure(
        pos.y,
        minetest.get_perlin(unilib.pbiome_np_pressure):get_3d(pos)
    )
    local biome = unilib.pbiome_get_biome(darkness, water, pressure) + 1

    -- The calling code may specify fewer than 62 pseudo-biomes; only show an error if the calling
    --      code has specified a pseudo-biome outside the maximum range of 1-62
    if (biome < 1) or (biome > biome_count) then

        biome = 1

        if biome > unilib.underch_max_biomes then
            unilib.show_warning("unilib.jbiome_reveal(): Invalid pseudo-biome", biome)
        end

    end

    -- Call the function for that pseudo-biome
    biome_convert_table[biome](pos)

    -- Call this function recursively, via an intermediate call to .check_neighbours(), so that any
    --      neighbouring matrix nodes also exposed to air can be converted
    -- Guard against stack overflow errors by placing a recursion limit (this was in the original
    ---     underch code)
    if recursion_flag or (crust_flag and unilib.jbiome_is_shadow(pos)) then

        if recursion_count < recursion_count_max then

            recursion_count = recursion_count + 1
            check_neighbours(pos, crust_flag)
            recursion_count = recursion_count - 1

        end

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- Shared functions (from underch/functions.lua)
---------------------------------------------------------------------------------------------------

function unilib.jbiome_on_wall_f(
    x, y, z, vi, area, data, p2data, def_wall, def1, def2, chance, lastlayer
)
    -- Adapted from underch/functions.lua, underch.functions.on_wall_f()

    if data[vi] ~= def1 or math.random() > chance then
        return
    end

    local dirs = {}
    local dirs_c = 0

    local dai = data[area:index(x, y - 1, z)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 0
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x, y, z - 1)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 4
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x, y, z + 1)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 8
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x - 1, y, z)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 12
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x + 1, y, z)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 16
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x, y + 1, z)]
    if (dai == def_wall or dai == c_crust or dai == c_bulk) and (not lastlayer) then

        dirs[dirs_c] = 20
        dirs_c = dirs_c + 1

    end

    if dirs_c == 0 then
        return
    end

    data[vi] = def2
    p2data[vi] = dirs[math.floor(dirs_c * math.random())] + math.floor(4 * math.random())

end

function unilib.jbiome_on_wall_w(
    x, y, z, vi, area, data, p2data, def_wall, def1, def2, chance, lastlayer
)
    -- Adapted from underch/functions.lua, underch.functions.on_wall_w()

    if data[vi] ~= def1 or math.random() > chance then
        return
    end

    local dirs = {}
    local dirs_c = 0

    local dai = data[area:index(x, y + 1, z)]
    if (dai == def_wall or dai == c_crust or dai == c_bulk) and (not lastlayer) then

        dirs[dirs_c] = 0
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x, y - 1, z)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 1
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x + 1, y, z)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 2
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x - 1, y, z)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 3
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x, y, z + 1)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 4
        dirs_c = dirs_c + 1

    end

    dai = data[area:index(x, y, z - 1)]
    if dai == def_wall or dai == c_crust or dai == c_bulk then

        dirs[dirs_c] = 5
        dirs_c = dirs_c + 1

    end

    if dirs_c == 0 then
        return
    end

    data[vi] = def2
    p2data[vi] = dirs[math.floor(dirs_c * math.random())]

end

---------------------------------------------------------------------------------------------------
-- Shared functions (stage 1, convert ordinary stone to matrix nodes)
---------------------------------------------------------------------------------------------------

function unilib.jbiome_setup_matrix(biome_table)

    -- Adapted from underch/worldgen.lua
    --
    -- Can be called by any package to set up pseudo-biomes using JIT
    -- See the "mapgen_underch_jit" package for calling examples
    -- Any package creating pseudo-biomes must enable the "stone_ordinary" package
    --
    -- During map generation, ordinary stone nodes (unilib:stone_ordinary) are converted to matrix
    --      nodes. Some other items, such as mushrooms, can be placed at this stage. Those other
    --      items are specified by "biome_table", and are placed in an appropriate pseudo-biome
    --
    -- Args:
    --      biome_table (table): A table with keys in the range 1-62, with corresponding values
    --          which are a function to be called, every time the mapgen generates a block

    -- Remixes should not attempt to create multiple sets of JIT pseudo-biomes, because we only have
    --      one copy of "biome_convert_table", etc
    if called_flag then

        unilib.show_warning(
            "unilib.jbiome_setup_matrix() Multiple calls to this function may have undesirable" ..
                    " results"
        )

    else

        called_flag = true

    end

    -- The calling code might specify fewer than 62 biomes
    biome_count = #biome_table

    -- (The local variables used throughout this file can now be set)
    c_bulk = minetest.get_content_id("unilib:misc_matrix_bulk")
    c_crust = minetest.get_content_id("unilib:misc_matrix_crust")
    c_stone = minetest.get_content_id("unilib:stone_ordinary")

    minetest.register_on_generated(function(minp, maxp, seed)

        -- Called after generating a piece of world
        -- minp/maxp encompasses a 5x5x5 volume of map blocks (80x80x80 nodes)
        -- Modifying nodes is a lot faster if voxel manipulation is used

        -- Easy reference to commonly used values
        local x1 = maxp.x
        local y1 = maxp.y
        local z1 = maxp.z
        local x0 = minp.x
        local y0 = minp.y
        local z0 = minp.z

        -- A mapgen object is a construct used in map generation
        -- Get the VoxelManip object (as userdata), minimum and maximum emerged position (as a
        --      table)
        local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
        -- Create the helper class for voxel areas
        local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
        local data = vm:get_data()
        local p2data = vm:get_param2_data()

        -- Mandatory values
        -- Length of a mapblock
        local sidelen = x1 - x0 + 1
        -- Table of chunk edges
        local chulens = {x = sidelen, y = sidelen, z = sidelen}
        local chulens2D = {x = sidelen, y = sidelen, z = 1}
        -- Bottom corner
        local minposxyz = {x = x0, y = y0, z = z0}
        -- 2D bottom corner
        local minposxz = {x = x0, y = z0}

        -- minetest.get_perlin_map() is a fast, bulk perlin noise generator
        -- Use it to get values for darkness, water and pressure, the three values used to determine
        --      the pseudo-biome
        local nvals_darkness
        = minetest.get_perlin_map(unilib.pbiome_np_darkness, chulens):get_3d_map_flat(minposxyz)
        local nvals_water
        = minetest.get_perlin_map(unilib.pbiome_np_water, chulens):get_3d_map_flat(minposxyz)
        local nvals_pressure
        = minetest.get_perlin_map(unilib.pbiome_np_pressure, chulens):get_3d_map_flat(minposxyz)

        -- 3D node index
        local nixyz = 1
        -- 2D node index
        local nixz = 1
        -- Second 3D index for second loop
        local nixyz2 = 1

        -- For each xy plane progressing northwards
        for z = z0, z1 do

            -- Increment indices
            nixyz = nixyz + 1

            -- For each x row progressing upwards
            for y = y0, y1 do

                local vi = area:index(x0, y, z)

                -- For each node
                for x = x0, x1 do

                    -- Decide which pseudo-biome applies to this position
                    local darkness = nvals_darkness[nixyz2]
                    local water = nvals_water[nixyz2]
                    local pressure = unilib.pbiome_get_pressure(y, nvals_pressure[nixyz2])
                    local biome = unilib.pbiome_get_biome(darkness, water, pressure) + 1

                    -- The calling code may specify fewer than 62 pseudo-biomes; only show an error
                    --      if the calling code has specified a pseudo-biome outside the maximum
                    --      range of 1-62
                    if (biome < 1) or (biome > biome_count) then

                        biome = 1

                        if biome > unilib.underch_max_biomes then

                            unilib.show_warning(
                                "unilib.jbiome_setup_matrix(): Invalid pseudo-biome", biome
                            )

                        end

                    end

                    -- Call the item-generation function for this pseudo-biome (generates mushrooms
                    --      etc)
                    biome_table[biome](x, y, z, vi, data, p2data, area, y == y1)

                    -- Any remaininig unilib:stone_ordinary nodes are converted to matrix nodes
                    if data[vi] == c_stone then

                        if is_crust(x, y, z, vi, area, data) then
                            data[vi] = c_crust
                        else
                            data[vi] = c_bulk
                        end

                    end

                    nixyz2 = nixyz2 + 1
                    nixz = nixz + 1
                    vi = vi + 1

                end

                --Shift the 2D index back
                nixz = nixz - sidelen

            end

            -- Shift the 2D index up a layer
            nixz = nixz + sidelen

        end

        -- Send data back to VoxelManip
        vm:set_data(data)
        vm:set_param2_data(p2data)
        -- Calculate lighting
        vm:set_lighting({day = 0, night = 0})
        vm:calc_lighting()
        -- Write it to world
        vm:write_to_map(data)

    end)

end

function unilib.jbiome_replace_in_matrix(vi, data, def1, def2)

    -- Adapted from underch/functions.lua, underch.functions.replace(). Not to be confused with
    --      underch.jit.replace()

    if data[vi] == def1 then
        data[vi] = def2
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (stage 2, convert matrix nodes to biome-appropriate nodes)
---------------------------------------------------------------------------------------------------

function unilib.jbiome_setup_converted(biome_table, blob_table, scatter_table)

    -- Original to unilib
    --
    -- Can be called by any package to set up pseudo-biomes using JIT
    -- See the "mapgen_underch_jit" package for calling examples
    --
    -- When matrix nodes are exposed to air, they are converted to pseudo-biome appropriate items,
    --      using "biome_table"
    --
    -- Args:
    --      biome_table (table): A table with keys in the range 1-62, with corresponding values
    --          which are a function to be called, every time the mapgen generates a block

    -- Basic checks
    if #biome_table ~= biome_count then

        unilib.show_warning(
            "unilib.jbiome_setup_converted(): Pseudo-biome mismatch", #biome_table, biome_count
        )

    end

    -- These table are used by unilib.jbiome_reveal()
    biome_convert_table = biome_table
    ore_blob_table = blob_table
    ore_scatter_table = scatter_table

end

function unilib.jbiome_replace_in_converted(pos, node1, node2)

    -- Adapted from underch/jit.lua, underch.jit.replace(). Not to be confused with
    --      underch.functions.replace()

    if minetest.get_node(pos).name == node1 then
        minetest.set_node(pos, {name = node2})
    end

end
