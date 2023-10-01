---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_bonsai = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(i, dye, select_box)

    local full_name = "unilib:plant_shrub_bonsai_" .. tostring(i)
    local img = "unilib_plant_shrub_bonsai_" .. tostring(i) .. ".png"

    -- N.B. In original code, beautiflowers = 1 replaces the color-XXX group
    -- N.B. removed flora = 1, flower = 1 to prevent additional spreading
    local group_table = {attached_node = 1, flammable = 1, snappy = 3}
    if dye ~= nil then
        group_table["color_" .. dye] = 1
    end

    unilib.register_node(full_name, "beautiflowers:bonsai_" .. tostring(i), mode, {
        -- From beautiflowers:bonsai_1, etc
        description = S("Bonsai Tree"),
        tiles = {img},
        groups = group_table,
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = select_box,
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From beautiflowers:bonsai_1, etc
            output = "unilib:dye_" .. dye .. " 4",
            recipe = {
                {full_name},
            },
        })

    end
    unilib.register_plant_in_pot(full_name, "beautiflowers:bonsai_" .. tostring(i))

    unilib.register_decoration("beautiflowers_plant_shrub_bonsaid_" .. tostring(i), {
        -- From beautiflowers:bonsai_1, etc
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 3,
            offset = -0.006,
            persist = 0.66,
            scale = 0.07,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end

local function do_spread(pos, node)

    if minetest.get_node_light(pos, 0.5) > 3 then

        if minetest.get_node_light(pos, nil) == 15 then
            minetest.remove_node(pos)
        end

        return

    end

    local positions = minetest.find_nodes_in_area_under_air(
        {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
        {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
        {"group:stone"}
    )

    if #positions == 0 then
        return
    end

    local pos2 = positions[math.random(#positions)]
    pos2.y = pos2.y + 1
    if minetest.get_node_light(pos2, 0.5) <= 3 then
        minetest.set_node(pos2, {name = node.name})
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_bonsai.init()

    return {
        description = "Five varieties of bonsai tree",
        notes = "Bonsai trees die in bright light, and only spread in very shady conditions",
        optional = {"dye_basic", "tree_apple"},
    }

end

function unilib.pkg.plant_shrub_bonsai.exec()

    local c_cobble = "group:cobble"
    local c_sapling = "unilib:tree_apple_sapling"

    do_register(1, "green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375})
    unilib.register_craft({
        -- From beautiflowers:bonsai_1
        output = "unilib:plant_shrub_bonsai_1",
        recipe = {
            {c_cobble, c_cobble, c_cobble},
            {c_cobble, c_sapling, c_cobble},
            {c_cobble, c_cobble, c_cobble},
        },
    })

    do_register(2, "brown", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375})
    unilib.register_craft({
        -- From beautiflowers:bonsai_2
        output = "unilib:plant_shrub_bonsai_2",
        recipe = {
            {c_cobble, c_sapling, c_cobble},
            {c_cobble, c_cobble, c_cobble},
            {c_cobble, c_sapling, c_cobble},
        },
    })

    do_register(3, "green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16})
    unilib.register_craft({
        -- From beautiflowers:bonsai_3
        output = "unilib:plant_shrub_bonsai_3",
        recipe = {
            {c_cobble, c_sapling, c_cobble},
            {c_cobble, c_sapling, c_cobble},
            {c_cobble, c_sapling, c_cobble},
        },
    })

    do_register(4, "brown", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375})
    unilib.register_craft({
        -- From beautiflowers:bonsai_4
        output = "unilib:plant_shrub_bonsai_4",
        recipe = {
            {c_cobble, c_sapling, c_cobble},
            {c_sapling, c_cobble, c_sapling},
            {c_cobble, c_sapling, c_cobble},
        },
    })

    do_register(5, "green_dark", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375})
    unilib.register_craft({
        -- From beautiflowers:bonsai_5
        output = "unilib:plant_shrub_bonsai_5",
        recipe = {
            {c_cobble, c_sapling, c_cobble},
            {c_sapling, c_sapling, c_sapling},
            {c_cobble, c_sapling, c_cobble},
        },
    })

    unilib.register_abm({
        -- From beautiflowers/spawn.lua
        label = "Bonsai spread [plant_shrub_bonsai]",
        nodenames = {
            "unilib:plant_shrub_bonsai_1",
            "unilib:plant_shrub_bonsai_2",
            "unilib:plant_shrub_bonsai_3",
            "unilib:plant_shrub_bonsai_4",
            "unilib:plant_shrub_bonsai_5",
        },

        chance = 150,
        interval = 11,

        action = function(...)
            do_spread(...)
        end,
    })

end
