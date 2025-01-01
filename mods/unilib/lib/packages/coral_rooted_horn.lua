---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_horn = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

--[[
local function on_place_coral(itemstack, placer, pointed_thing)
    return unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, "horn")
end

local function on_place_skeleton(itemstack, placer, pointed_thing)
    return unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, "horn_skeleton")
end
]]--

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_horn.init()

    return {
        description = "Rooted horn coral",
        depends = {"coral_block_horn", "liquid_water_ordinary"},
    }

end

function unilib.pkg.coral_rooted_horn.exec()

    unilib.register_node("unilib:coral_rooted_horn", "xocean:horn", mode, {
        -- From xocean:horn
        description = S("Rooted Horn Coral"),
        tiles = {"unilib_coral_block_horn.png"},
        -- N.B. No coral = 1 in original code
        groups = {coral = 1, snappy = 3},
        sounds = unilib.sound.generate_stone({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        drop = "unilib:coral_rooted_horn_skeleton",
        inventory_image = "unilib_coral_rooted_horn.png",
        node_dig_prediction = "unilib:coral_block_horn",
        node_placement_prediction = "",
        paramtype = "light",
        -- N.B. No .paramtype2 in original code
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = "unilib_coral_rooted_horn.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            core.set_node(pos, {name = "unilib:coral_block_horn"})
        end,

--      on_place = on_place_coral,
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {
                    need_under = "unilib:coral_block_horn",
                    need_above = "unilib:liquid_water_ordinary_source",
                    displace_flag = true,
                }
            )

        end,
    })

    unilib.register_node("unilib:coral_rooted_horn_skeleton", "xocean:skeleton_horn", mode, {
        -- From xocean:skeleton_horn
        description = S("Rooted Horn Coral Skeleton"),
        tiles = {"unilib_coral_block_horn_skeleton.png"},
        -- N.B. No coral = 1 in original code
        groups = {coral = 1, snappy = 3},
        sounds = unilib.sound.generate_stone({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        drop = "unilib:coral_rooted_horn_skeleton",
        inventory_image = "unilib_coral_rooted_horn_skeleton.png",
        node_dig_prediction = "unilib:coral_block_horn_skeleton",
        node_placement_prediction = "",
        paramtype = "light",
        -- N.B. No .paramtype2 in original code
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = "unilib_coral_rooted_horn_skeleton.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            core.set_node(pos, {name = "unilib:coral_block_horn_skeleton"})
        end,

--      on_place = on_place_skeleton,
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {
                    need_under = "unilib:coral_block_horn_skeleton",
                    need_above = "unilib:liquid_water_ordinary_source",
                    displace_flag = true,
                }
            )

        end,
    })

    unilib.register_decoration_generic("xocean_coral_rooted_horn", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:coral_rooted_horn",

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 1.0,
            seed = 87112,
            spread = {x = 20, y = 20, z = 20},
        },
        -- N.B. Replaced apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        param2 = 0,
        param2_max = 3,
        place_offset_y = -1,
        sidelen = 16,
    })

    unilib.register_decoration_generic("xocean_coral_rooted_horn_skeleton", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:coral_rooted_horn_skeleton",

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 1.0,
            seed = 87112,
            spread = {x = 20, y = 20, z = 20},
        },
        -- N.B. Replaced apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        param2 = 0,
        param2_max = 3,
        place_offset_y = -1,
        sidelen = 16,
    })

end
