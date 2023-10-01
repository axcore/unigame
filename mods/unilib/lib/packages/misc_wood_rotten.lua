---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_wood_rotten = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_wood_rotten.init()

    return {
        description = "Rotten wood",
    }

end

function unilib.pkg.misc_wood_rotten.exec()

    unilib.register_node("unilib:misc_wood_rotten", "aotearoa:rotten_wood", mode, {
        -- From aotearoa:rotten_wood
        description = S("Rotten Wood"),
        tiles = {
            "unilib_misc_wood_rotten_top.png",
            "unilib_misc_wood_rotten_top.png",
            "unilib_misc_wood_rotten.png"
        },
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_misc_wood_rotten_stump_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_misc_wood_rotten_stump_" .. i .. ".mts",

            fill_ratio = 0.00195,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration("aotearoa_misc_wood_rotten_stump_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_misc_wood_rotten_stump_" .. i .. ".mts",

            fill_ratio = 0.0039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end
    unilib.register_decoration("aotearoa_misc_wood_rotten_stump", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:misc_wood_rotten",

        fill_ratio = 0.002,
        sidelen = 16,
    })

end
