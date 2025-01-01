---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_tussock_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_tussock_red.init()

    return {
        description = "Red tussock",
    }

end

function unilib.pkg.plant_tussock_red.exec()

    unilib.register_node("unilib:plant_tussock_red", "aotearoa:red_tussock", mode, {
        -- From aotearoa:red_tussock
        description = unilib.utils.annotate(S("Red Tussock"), "Chionochloa rubra"),
        tiles = {"unilib_plant_tussock_red.png"},
        groups = {attached_node = 1, dry_grass = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "firelike",
        inventory_image = "unilib_plant_tussock_red.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_tussock_red.png",
    })
    unilib.register_craft({
        -- From aotearoa:red_tussock
        type = "fuel",
        recipe = "unilib:plant_tussock_red",
        burntime = 1,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("aotearoa_plant_tussock_red", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_tussock_red",

        fill_ratio = 0.9,
        sidelen = 16,
    })

end
