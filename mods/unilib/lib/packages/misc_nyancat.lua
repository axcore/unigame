---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nyancat
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_nyancat = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nyancat.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function place(pos, facedir, length)

    if facedir > 3 then
        facedir = 0
    end

    local tailvec = core.facedir_to_dir(facedir)
    local p = {x = pos.x, y = pos.y, z = pos.z}

    core.set_node(p, {name = "unilib:misc_nyancat", param2 = facedir})
    for i = 1, length do

        p.x = p.x + tailvec.x
        p.z = p.z + tailvec.z
        core.set_node(p, {name = "unilib:misc_nyancat_rainbow", param2 = facedir})

    end

end

local function generate(minp, maxp, seed)

    local height_min = unilib.constant.y_min
    local height_max = -32
    if maxp.y < height_min or minp.y > height_max then
        return
    end

    local y_min = math.max(minp.y, height_min)
    local y_max = math.min(maxp.y, height_max)
    local volume = (maxp.x - minp.x + 1) * (y_max - y_min + 1) * (maxp.z - minp.z + 1)
    local pr = PseudoRandom(seed + 9324342)
    local max_num_nyancats = math.floor(volume / (16 * 16 * 16))

    for i = 1, max_num_nyancats do

        if pr:next(0, 1000) == 0 then

            local x0 = pr:next(minp.x, maxp.x)
            local y0 = pr:next(minp.y, maxp.y)
            local z0 = pr:next(minp.z, maxp.z)
            local p0 = {x = x0, y = y0, z = z0}
            place(p0, pr:next(0, 3), pr:next(3, 15))

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_nyancat.init()

    return {
        description = "Nyancat",
        notes = "Rare decorative item that generates anywhere below level -32",
    }

end

function unilib.pkg.misc_nyancat.exec()

    unilib.register_node("unilib:misc_nyancat", "nyancat:nyancat", mode, {
        -- From nyancat:nyancat
        description = S("Nyan Cat"),
        tiles = {
            "unilib_misc_nyancat_side.png",
            "unilib_misc_nyancat_side.png",
            "unilib_misc_nyancat_side.png",
            "unilib_misc_nyancat_side.png",
            "unilib_misc_nyancat_back.png",
            "unilib_misc_nyancat_front.png",
        },
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.node,

        is_ground_content = false,
        light_source = unilib.constant.light_max,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From nyancat:nyancat
        type = "fuel",
        recipe = "unilib:misc_nyancat",
        burntime = 1,
    })

    unilib.register_node("unilib:misc_nyancat_rainbow","nyancat:nyancat_rainbow", mode, {
        -- From nyancat:nyancat_rainbow
        description = S("Nyan Cat Rainbow"),
        tiles = {
            "unilib_misc_nyancat_rainbow.png^[transformR90",
            "unilib_misc_nyancat_rainbow.png^[transformR90",
            "unilib_misc_nyancat_rainbow.png"
        },
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.node,

        is_ground_content = false,
        light_source = unilib.constant.light_max,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From nyancat:nyancat_rainbow
        type = "fuel",
        recipe = "unilib:misc_nyancat_rainbow",
        burntime = 1,
    })

    -- Mapgen
    core.register_on_generated(function(minp, maxp, seed)
        generate(minp, maxp, seed)
    end)

end
