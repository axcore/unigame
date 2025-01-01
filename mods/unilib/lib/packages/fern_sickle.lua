---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_sickle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_sickle.init()

    return {
        description = "Sickle fern",
    }

end

function unilib.pkg.fern_sickle.exec()

    unilib.register_node("unilib:fern_sickle", "australia:small_fern", mode, {
        -- From australia:small_fern
        description = unilib.utils.annotate(S("Sickle Fern"), "Pellaea falcata"),
        tiles = {"unilib_fern_sickle.png"},
        -- N.B. "not_in_creative_inventory = 1" in original code, but removed
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
--      drop = "unilib:fern_sickle",
        inventory_image = "unilib_fern_sickle.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        visual_scale = 1,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:fern_sickle", "australia:small_fern")

    unilib.register_decoration_generic("australia_fern_sickle_1", {
        -- From australia:small_fern
        deco_type = "simple",
        decoration = "unilib:fern_sickle",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.008,
            seed = 81,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })
    unilib.register_decoration_generic("australia_fern_sickle_2", {
        -- From australia:small_fern
        deco_type = "simple",
        decoration = "unilib:fern_sickle",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.007,
            seed = 81,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
