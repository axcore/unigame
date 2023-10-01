---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_fire = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place_coral(itemstack, placer, pointed_thing)
    return unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, "fire")
end

local function on_place_skeleton(itemstack, placer, pointed_thing)
    return unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, "fire_skeleton")
end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_fire.init()

    return {
        description = "Rooted fire coral",
        depends = {"coral_block_fire", "liquid_water_ordinary", "shared_xocean"},
    }

end

function unilib.pkg.coral_rooted_fire.exec()

    unilib.register_node("unilib:coral_rooted_fire", "xocean:fire", mode, {
        -- From xocean:fire
        description = S("Rooted Fire Coral"),
        tiles = {"unilib_coral_block_fire.png"},
        groups = {snappy = 3},
        sounds = unilib.node_sound_stone_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        drop = "unilib:coral_rooted_fire_skeleton",
        inventory_image = "unilib_coral_rooted_fire.png",
        node_dig_prediction = "unilib:coral_block_fire",
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
            {name = "unilib_coral_rooted_fire.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "unilib:coral_block_fire"})
        end,

        on_place = on_place_coral,
    })

    unilib.register_node("unilib:coral_rooted_fire_skeleton", "xocean:skeleton_fire", mode, {
        -- From xocean:skeleton_fire
        description = S("Rooted Fire Coral Skeleton"),
        tiles = {"unilib_coral_block_fire_skeleton.png"},
        groups = {snappy = 3},
        sounds = unilib.node_sound_stone_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_coral_rooted_fire_skeleton.png",
        node_dig_prediction = "unilib:coral_block_fire_skeleton",
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
            {name = "unilib_coral_rooted_fire_skeleton.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "unilib:coral_block_fire_skeleton"})
        end,

        on_place = on_place_skeleton,
    })

    unilib.register_decoration("xocean_coral_rooted_fire", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:coral_rooted_fire",

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

    unilib.register_decoration("xocean_coral_rooted_fire_skeleton", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:coral_rooted_fire_skeleton",

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
