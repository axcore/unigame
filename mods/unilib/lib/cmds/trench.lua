---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trench.lua
--      Set up command to cut deep trenches at intervals of 100 blocks. Code adapted from
--          rocks/rocks/init.lua and rocks/rocks/layers.lua
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local np_elv_table = {
    octaves = 2,
    offset = -4,
    persist = 0.4,
    scale = 28,
    seed = -546,
    spread = {x = 25, y = 25, z = 25},
}

local np_fault_table = {
    octaves = 2,
    offset = -5,
    persist = 0.4,
    scale = 10,
    seed = 632,
    spread = {x = 25, y = 25, z = 25},
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_trench(minp, maxp, seed, vm, area, param)

    local t1 = os.clock()
    local data = vm:get_data()

    local chunksize = maxp.x - minp.x + 1
    local pmapsize = {x = chunksize, y = chunksize, z = chunksize}
    local minpxz = {x = minp.x, y = minp.z}
    local c_stone= minetest.get_content_id("unilib:stone_ordinary")
    local c_sample = minetest.get_content_id("unilib:stone_ordinary")
    local c_air = minetest.get_content_id("air")

    local n_elv = minetest.get_perlin_map(np_elv_table, pmapsize) : get_2d_map_flat(minpxz)
    local n_fault = minetest.get_perlin_map(np_fault_table, pmapsize) : get_2d_map_flat(minpxz)

    local nixz=1
    for z = minp.z, maxp.z do

        for x = minp.x, maxp.x do

            local fault = n_fault[nixz]
            local lmh = -10
            if fault > 0 then
                lmh = lmh + 10
            end

            local lt = math.floor(n_elv[nixz])
            if lt > 0 then

                if lt > 18 then
                    lt = 18
                end

                local top = math.min(lmh, maxp.y)
                local bot = math.max(1 + lmh - lt, minp.y)
                for y = bot, top do
                    local di = area:index(x,y,z)
                    data[di] = c_sample
                end

            end

            nixz = nixz + 1
            if (z % 100) > param then

                for y = minp.y, maxp.y do
                    data[area:index(x, y, z)] = c_air
                end

            end

        end

    end

    vm:set_data(data)
    vm:set_lighting({day = 15, night = 15})

end

---------------------------------------------------------------------------------------------------
-- /cut_trench: Cuts deep trenches in newly-generated terrain
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("cut_trench", {
    params = "[<width>]",
    description = S(
        "Cuts deep trenches at intervals of 100 blocks in newly-generated terrain (useful for" ..
        " visualising ore distributions). See also the Minetest setting" ..
        " \"unilib_debug_xray_flag\""
    ),
    privs = {unilib_danger = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        -- Default width is 10; this is a change from rocks, when it was 50
        if tonumber(param) == nil then

            param = 10

        else

            param = tonumber(param)
            if param < 1 or param > 99 then

                return false, S("The trench width must be in the range 1-99")

            else

                minetest.chat_send_player(
                    name,
                    S(
                        "Digging deep trenches (width: @1) in all newly-generated terrain." ..
                        " Digging will cease when Minetest restarts.",
                        param
                    )
                )

                param = 100 - param

            end

        end

        minetest.register_on_generated(function(minp,maxp,seed)

            local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
            local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
            local pr = PseudoRandom(seed)

            do_trench(minp, maxp, seed, vm, area, param)
            vm:write_to_map()

        end)

    end,
})
