---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_bushes = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bushes.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_grow_bush(pos, dir, part_name)

    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}
    local above_right_here = {x = pos.x, y = pos.y + 2, z = pos.z}

    local right_here_node = "unilib:" .. part_name .. "_arm"

    if dir ~= 5 and part_name == "bush_branching_yellow" then
        right_here_node = "unilib:bush_branching_yellow_arm"
    end

    if dir ~= 5 and part_name == "bush_branching_green" then
        right_here_node = "unilib:bush_branching_green_arm"
    end

    if dir == 5 and part_name == "bush_branching_yellow" then

        right_here_node = "unilib:bush_branching_yellow_stem"
        dir = 1

    end

    if dir == 5 and part_name == "bush_branching_green" then

        right_here_node = "unilib:bush_branching_green_stem"
        dir = 1

    end

    if minetest.get_node(right_here).name == "air" or
            minetest.get_node(right_here).name == "unilib:grass_jungle" then

        minetest.swap_node(
            right_here,
            {name = right_here_node, param2 = dir}
        )

        minetest.swap_node(
            above_right_here,
            {name ="unilib:" .. part_name .. "_leaves"}
        )

        local chance_of_high_leaves = math.random(1, 10)
        if chance_of_high_leaves > 5 then

            local two_above_right_here = {x = pos.x, y = pos.y + 3, z = pos.z}
            minetest.swap_node(
                two_above_right_here,
                {name = "unilib:" .. part_name .. "_leaves"}
            )

        end

    end

end

local function do_grow_shrub(pos, height)

    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}
    local above_right_here = {x = pos.x, y = pos.y + 2, z = pos.z}
    local two_above_right_here = {x = pos.x, y = pos.y + 3, z = pos.z}
    local three_above_right_here = {x = pos.x, y = pos.y + 4, z = pos.z}

    if minetest.get_node(right_here).name == "air" or
            minetest.get_node(right_here).name == "unilib:grass_jungle" then

        if height == 4 then

            local two_above_right_here_south = {x = pos.x, y = pos.y + 3, z = pos.z - 1}
            local three_above_right_here_south = {x = pos.x, y = pos.y + 4, z = pos.z - 1}
            minetest.swap_node(right_here, {name = "unilib:bush_branching_shrub"})
            minetest.swap_node(above_right_here, {name = "unilib:bush_branching_shrub"})
            minetest.swap_node(
                two_above_right_here,
                {name = "unilib:bush_branching_yellow_arm", param2 = 2}
            )
            minetest.swap_node(
                two_above_right_here_south,
                {name = "unilib:bush_branching_yellow_arm", param2 = 0}
            )
            minetest.swap_node(
                three_above_right_here,
                {name = "unilib:bush_branching_yellow_leaves"}
            )
            minetest.swap_node(
                three_above_right_here_south,
                {name = "unilib:bush_branching_yellow_leaves"}
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bushes.register_bush_stem(
    full_name, orig_name, description, leaves_img, centre_img
)
    unilib.register_node(full_name, orig_name, mode, {
        description = description,
        tiles = {leaves_img, centre_img},
        groups = {attached_node = 1, flammable = 2, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drop = "unilib:item_stick_ordinary 4",
        drawtype = "nodebox",
        inventory_image = centre_img,
        node_box = {
            type = "fixed",
            fixed = {
                {0, -1/2, -1/2, -1/4, 1/2, 1/2},
                {0, -1/2, -1/2, 1/4, 1/2, 1/2},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })

end

function unilib.pkg.shared_bushes.register_bush_arm(
    full_name, orig_name, description, leaves_img, centre_img, left_img, right_img
)
    unilib.register_node(full_name, orig_name, mode, {
        description = description,
        tiles = {leaves_img, centre_img, left_img, right_img, centre_img, right_img},
        groups = {attached_node = 1, flammable = 2, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drop = "unilib:item_stick_ordinary 3",
        drawtype = "nodebox",
        inventory_image = right_img,
        node_box = {
            type = "fixed",
            fixed = {
                {0.137748, -0.491944, 0.5, -0.125000, -0.179444, -0.007790},
                {0.262748, -0.185995, 0.5, -0.237252, 0.126505, -0.260269},
                {0.500000, 0.125000, 0.5, -0.500000, 0.500000, -0.500000},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })

end

function unilib.pkg.shared_bushes.register_bush_leaves(
    full_name, orig_name, description, leaves_img
)
    local inv_img = unilib.filter_leaves_img(leaves_img)

    unilib.register_node(full_name, orig_name, mode, {
        description = description,
        tiles = {leaves_img},
        groups = {attached_node = 1, flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "allfaces_optional",
        inventory_image = inv_img,
        paramtype = "light",
        use_texture_alpha = "clip",
        wield_img = inv_img,
    })

end

function unilib.pkg.shared_bushes.grow_bush(pos, part_name)

    local bush_side_height = math.random(0, 1)
    local chance_of_bush_node_right = math.random(1, 10)
    if chance_of_bush_node_right > 5 then

        local right_pos = {x = pos.x + 1, y = pos.y + bush_side_height, z = pos.z}
        do_grow_bush(right_pos, 3, part_name)

    end

    local chance_of_bush_node_left = math.random(1, 10)
    if chance_of_bush_node_left > 5 then

        bush_side_height = math.random(0, 1)
        local left_pos = {x = pos.x - 1, y = pos.y + bush_side_height, z = pos.z}
        do_grow_bush(left_pos, 1, part_name)

    end

    local chance_of_bush_node_front = math.random(1, 10)
    if chance_of_bush_node_front > 5 then

        bush_side_height = math.random(0, 1)
        local front_pos = {x = pos.x, y = pos.y + bush_side_height, z = pos.z + 1}
        do_grow_bush(front_pos, 2, part_name)

    end

    local chance_of_bush_node_back = math.random(1, 10)
    if chance_of_bush_node_back > 5 then

        bush_side_height = math.random(0, 1)
        local back_pos = {x = pos.x, y = pos.y + bush_side_height, z = pos.z - 1}
        do_grow_bush(back_pos, 0, part_name)

    end

    do_grow_bush(pos, 5, part_name)

end

function unilib.pkg.shared_bushes.grow_shrub(pos, part_name)

    -- N.B. In the original code, the value 5 is ignored, if specified
    --[[
    local height = math.random(4,5)
    do_grow_shrub(pos, height)
    ]]--

    do_grow_shrub(pos, 4)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bushes.init()

    return {
        description = "Shared functions for branching bushes (from bushes mod)",
    }

end

