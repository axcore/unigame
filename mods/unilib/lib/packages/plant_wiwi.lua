---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_wiwi = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_wiwi.init()

    return {
        description = "Wiwi",
    }

end

function unilib.pkg.plant_wiwi.exec()

    unilib.register_node("unilib:plant_wiwi", "aotearoa:wiwi", mode, {
        -- From aotearoa:wiwi
        description = unilib.annotate(S("Wiwi"), "Ficinia nodosa"),
        tiles = {"unilib_plant_wiwi.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, grass = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "firelike",
        inventory_image = "unilib_plant_wiwi.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_wiwi.png",
    })
    unilib.register_craft({
        -- From aotearoa:wiwi
        type = "fuel",
        recipe = "unilib:plant_wiwi",
        burntime = 1,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("aotearoa_plant_wiwi", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_wiwi",

        fill_ratio = 0.01,
        sidelen = 16,
    })

end
