---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_boletus = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_boletus.init()

    return {
        description = "Boletus mushroom",
    }

end

function unilib.pkg.mushroom_boletus.exec()

    unilib.register_node("unilib:mushroom_boletus", "herbs:mushroom_boletus", mode, {
        -- From herbs:mushroom_boletus
        description = unilib.annotate(S("Boletus Mushroom"), "Boletus"),
        tiles = {"unilib_mushroom_boletus.png"},
        groups = {attached_node = 1, flammable = 1, food_mushroom = 1, mushroom = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_boletus.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_mushroom_boletus.png",

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_boletus", 4),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_boletus", "herbs:mushroom_boletus")

    unilib.register_decoration("herbs_mushroom_boletus", {
        -- From herbs/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:mushroom_boletus",

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
