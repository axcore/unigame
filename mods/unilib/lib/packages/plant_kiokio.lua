---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kiokio = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kiokio.init()

    return {
        description = "Kiokio",
    }

end

function unilib.pkg.plant_kiokio.exec()

    unilib.register_node("unilib:plant_kiokio", "aotearoa:kiokio", mode, {
        -- From aotearoa:kiokio
        description = unilib.annotate(S("Kiokio"), "Parablechnum novae-zelandiae"),
        tiles = {"unilib_plant_kiokio.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "firelike",
        inventory_image = "unilib_plant_kiokio.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_kiokio.png",
    })
    unilib.register_craft({
        -- From aotearoa:kiokio
        type = "fuel",
        recipe = "unilib:plant_kiokio",
        burntime = 1,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("aotearoa_plant_kiokio_rare", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_kiokio",

        fill_ratio = 0.002,
        sidelen = 16,
    })
    unilib.register_decoration("aotearoa_plant_kiokio_normal", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_kiokio",

        fill_ratio = 0.01,
        sidelen = 16,
    })

end
