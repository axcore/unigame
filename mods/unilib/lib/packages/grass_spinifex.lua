---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_spinifex = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_spinifex.init()

    return {
        description = "Spinifex grass",
        notes = "Placed in the \"grass\" category to distinguish it from the spinifex plant" ..
                " in the \"australia\" mod",
    }

end

function unilib.pkg.grass_spinifex.exec()

    unilib.register_node("unilib:grass_spinifex", "aotearoa:spinifex", mode, {
        -- From aotearoa:spinifex
        description = unilib.annotate(S("Spinifex Grass"), "Spinifex sericeus"),
        tiles = {"unilib_grass_spinifex.png"},
        -- N.B. flora = 1, grass = 1, spinifex_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, snappy = 3, spinifex_grass = 1,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_grass_spinifex.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_spinifex.png",
    })
    unilib.register_craft({
        -- From aotearoa:spinifex
        type = "fuel",
        recipe = "unilib:grass_spinifex",
        burntime = 1,
    })
    unilib.register_plant_in_pot("unilib:grass_spinifex", "aotearoa:spinifex")

    unilib.register_decoration("aotearoa_grass_spinifex", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:grass_spinifex",

        fill_ratio = 0.9,
        sidelen = 16,
    })

end
