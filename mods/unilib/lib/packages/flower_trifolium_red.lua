---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_trifolium_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_trifolium_red.init()

    return {
        description = "Red trifolium",
    }

end

function unilib.pkg.flower_trifolium_red.exec()

    unilib.register_node("unilib:flower_trifolium_red", "herbs:trifolium_red", mode, {
        -- From herbs:trifolium_red
        description = unilib.annotate(S("Red Trifolium"), "Trifolium"),
        tiles = {"unilib_flower_trifolium_red.png"},
        groups = {
            attached_node = 1, color_violet = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_trifolium_red.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 5 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_trifolium_red.png",
    })
    unilib.register_flower_in_pot("unilib:flower_trifolium_red", "herbs:trifolium_red")

    unilib.register_decoration("herbs_flower_trifolium_red", {
        -- From herbs/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:flower_trifolium_red",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.04,
            seed = 1770624,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
