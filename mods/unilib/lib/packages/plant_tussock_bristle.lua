---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_tussock_bristle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_tussock_bristle.init()

    return {
        description = "Bristle tussock",
    }

end

function unilib.pkg.plant_tussock_bristle.exec()

    unilib.register_node("unilib:plant_tussock_bristle", "aotearoa:bristle_tussock", mode, {
        -- From aotearoa:bristle_tussock
        description = unilib.annotate(S("Bristle Tussock"), "Rytidosperma setifolium"),
        tiles = {"unilib_plant_tussock_bristle.png"},
        groups = {attached_node = 1, dry_grass = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_tussock_bristle.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_tussock_bristle.png",
    })
    unilib.register_craft({
        -- From aotearoa:bristle_tussock
        type = "fuel",
        recipe = "unilib:plant_tussock_bristle",
        burntime = 1,
    })
    unilib.register_plant_in_pot("unilib:plant_tussock_bristle", "aotearoa:bristle_tussock")

    unilib.register_decoration("aotearoa_plant_tussock_bristle", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_tussock_bristle",

        fill_ratio = 0.01,
        sidelen = 16,
    })

end
