---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_amanita_deadly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_amanita_deadly.init()

    return {
        description = "Deadly amanita mushroom",
    }

end

function unilib.pkg.mushroom_amanita_deadly.exec()

    unilib.register_node("unilib:mushroom_amanita_deadly", "cropocalypse:deadly_amanita", mode, {
        -- From cropocalypse:deadly_amanita
        description = S("Deadly Amanita Mushroom"),
        tiles = {"unilib_mushroom_amanita_deadly.png"},
        -- N.B. mushroom = 1 not in original code
        groups = {attached_node = 1, flammable = 1, grave_plants = 1, mushroom = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_amanita_deadly.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_mushroom_amanita_deadly.png",
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_amanita_deadly", "cropocalypse:deadly_amanita")

    unilib.register_decoration_generic("cropocalypse_mushroom_amanita_deadly", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:mushroom_amanita_deadly",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 6891,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
