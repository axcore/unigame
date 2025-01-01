---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_amanita_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_amanita_green.init()

    return {
        description = "Green amanita mushroom",
    }

end

function unilib.pkg.mushroom_amanita_green.exec()

    unilib.register_node("unilib:mushroom_amanita_green", "herbs:mushroom_amanita_green", mode, {
        -- From herbs:mushroom_amanita_green
        description = unilib.utils.annotate(S("Green Amanita Mushroom"), "Amanita"),
        tiles = {"unilib_mushroom_amanita_green.png"},
        groups = {attached_node = 1, flammable = 1, food_mushroom = 1, mushroom = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_amanita_green.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_mushroom_amanita_green.png",

        on_use = unilib.cuisine.eat_on_use("unilib:mushroom_amanita_green", 1),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_amanita_green", "herbs:mushroom_amanita_green")

    unilib.register_decoration_generic("herbs_mushroom_amanita_green", {
        -- From herbs/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:mushroom_amanita_green",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
