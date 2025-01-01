---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seagrass_narrowleaf = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seagrass_narrowleaf.init()

    return {
        description = "Narrowleaf seagrass",
    }

end

function unilib.pkg.plant_seagrass_narrowleaf.exec()

    unilib.register_node("unilib:plant_seagrass_narrowleaf", "australia:sea_grass", mode, {
        -- From australia:sea_grass
        description = unilib.utils.annotate(S("Narrowleaf Seagrass"), "Halodule uninervis"),
        tiles = {"unilib_plant_seagrass_narrowleaf.png"},
        groups = {attached_node = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_plant_seagrass_narrowleaf.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_seagrass_narrowleaf.png",

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "unilib:sand_ordinary"}
            )

        end,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("australia_plant_seagrass_narrowleaf_1", {
        -- From australia:spinifex
        deco_type = "simple",
        decoration = "unilib:plant_seagrass_narrowleaf",

        fill_ratio = 0.005,
        flags = "force_placement",
        sidelen = 80,
    })
    unilib.register_decoration_generic("australia_plant_seagrass_narrowleaf_2", {
        -- From australia:spinifex
        deco_type = "simple",
        decoration = "unilib:plant_seagrass_narrowleaf",

        fill_ratio = 0.01,
        flags = "force_placement",
        sidelen = 80,
    })
    unilib.register_decoration_generic("australia_plant_seagrass_narrowleaf_3", {
        -- From australia:spinifex
        deco_type = "simple",
        decoration = "unilib:plant_seagrass_narrowleaf",

        fill_ratio = 0.02,
        flags = "force_placement",
        sidelen = 80,
    })

end
