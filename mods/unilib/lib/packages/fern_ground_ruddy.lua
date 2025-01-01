---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_ground_ruddy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_ground_ruddy.init()

    return {
        description = "Ruddy ground fern",
    }

end

function unilib.pkg.fern_ground_ruddy.exec()

    unilib.register_node("unilib:fern_ground_ruddy", "australia:fern", mode, {
        -- From australia:fern
        description = unilib.utils.annotate(S("Ruddy Ground Fern"), "Hypolepis rugosula"),
        tiles = {"unilib_fern_ground_ruddy.png"},
        -- N.B. "not_in_creative_inventory = 1" in original code, but removed
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
--      drop = "unilib:fern_ground_ruddy",
        inventory_image = "unilib_fern_ground_ruddy.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        visual_scale = 2,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:fern_ground_ruddy", "australia:fern")

    unilib.register_decoration_generic("australia_fern_ground_ruddy_1", {
        -- From australia:fern
        deco_type = "simple",
        decoration = "unilib:fern_ground_ruddy",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006,
            seed = 80,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })
    unilib.register_decoration_generic("australia_fern_ground_ruddy_2", {
        -- From australia:fern
        deco_type = "simple",
        decoration = "unilib:fern_ground_ruddy",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.005,
            seed = 80,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
