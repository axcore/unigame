---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_rose = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place_coral(itemstack, placer, pointed_thing)
    return unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, "rose")
end

local function on_place_skeleton(itemstack, placer, pointed_thing)
    return unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, "rose_skeleton")
end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_rose.init()

    return {
        description = "Rooted rose coral",
        notes = "In original code, replaces pink coral from minetest_game; here, it is a" ..
                " separate item",
        depends = {"coral_block_rose", "liquid_water_ordinary", "shared_xocean"},
    }

end

function unilib.pkg.coral_rooted_rose.exec()

    unilib.register_node("unilib:coral_rooted_rose", nil, mode, {
        -- From xocean, default:coral_pink
        description = S("Rooted Rose Coral"),
        tiles = {"unilib_coral_block_rose.png"},
        groups = {snappy = 3},
        sounds = unilib.node_sound_stone_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_coral_rooted_rose.png",
        node_dig_prediction = "unilib:coral_block_rose",
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
            {name = "unilib_coral_rooted_rose.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "unilib:coral_block_rose"})
        end,

        on_place = on_place_coral,
    })

    -- N.B. The brain coral provided by the australia mod looks much more like the real thing, so
    --      this item's name has been changed to remove the "brain" component
    unilib.register_node("unilib:coral_rooted_rose_skeleton", "xocean:skeleton_brain", mode, {
        -- From xocean:skeleton_brain
        description = S("Rooted Rose Coral Skeleton"),
        tiles = {"unilib_coral_block_rose_skeleton.png"},
        groups = {snappy = 3},
        sounds = unilib.node_sound_stone_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_coral_rooted_rose_skeleton.png",
        node_dig_prediction = "unilib:coral_block_rose_skeleton",
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
            {name = "unilib_coral_rooted_rose_skeleton.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "unilib:coral_block_rose_skeleton"})
        end,

        on_place = on_place_skeleton,
    })

    unilib.register_decoration("xocean_coral_rooted_rose", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:coral_rooted_rose",

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

    unilib.register_decoration("xocean_coral_rooted_rose_skeleton", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:coral_rooted_rose_skeleton",

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
