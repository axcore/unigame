---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_tube = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place_coral(itemstack, placer, pointed_thing)
    return unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, "tube")
end

local function on_place_skeleton(itemstack, placer, pointed_thing)
    return unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, "tube_skeleton")
end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_tube.init()

    return {
        description = "Rooted tube coral",
        depends = {"coral_block_tube", "liquid_water_ordinary", "shared_xocean"},
    }

end

function unilib.pkg.coral_rooted_tube.exec()

    unilib.register_node("unilib:coral_rooted_tube", nil, mode, {
        -- From xocean, default:coral_cyan
        description = S("Rooted Tube Coral"),
        tiles = {"unilib_coral_block_tube.png"},
        groups = {snappy = 3},
        sounds = unilib.node_sound_stone_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        drop = "unilib:coral_rooted_tube_skeleton",
        inventory_image = "unilib_coral_rooted_tube.png",
        node_dig_prediction = "unilib:coral_block_tube",
        node_placement_prediction = "",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = "unilib_coral_rooted_tube.png", tileable_vertical = true},
        },
        tiles = {"unilib_coral_block_tube.png"},
        waving = 1,

        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "unilib:coral_block_tube"})
        end,

        on_place = on_place_coral,
    })

    unilib.register_node("unilib:coral_rooted_tube_skeleton", "xocean:skeleton_tube", mode, {
        -- From xocean:skeleton_tube
        description = S("Rooted Tube Coral Skeleton"),
        tiles = {"unilib_coral_block_tube_skeleton.png"},
        groups = {snappy = 3},
        sounds = unilib.node_sound_stone_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_coral_rooted_tube_skeleton.png",
        node_dig_prediction = "unilib:coral_block_tube_skeleton",
        node_placement_prediction = "",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = "unilib_coral_rooted_tube_skeleton.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "unilib:coral_block_tube_skeleton"})
        end,

        on_place = on_place_skeleton,
    })

    unilib.register_decoration("xocean_coral_rooted_tube", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:coral_rooted_tube",

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 1.0,
            seed = 87112,
            spread = {x = 20, y = 20, z = 20},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        sidelen = 16,
    })

    unilib.register_decoration("xocean_coral_rooted_tube_skeleton", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:coral_rooted_tube_skeleton",

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 1.0,
            seed = 87112,
            spread = {x = 20, y = 20, z = 20},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        sidelen = 16,
    })

end
