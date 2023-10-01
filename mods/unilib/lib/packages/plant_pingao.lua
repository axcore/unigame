---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_pingao = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_pingao.init()

    return {
        description = "Pingao",
    }

end

function unilib.pkg.plant_pingao.exec()

    unilib.register_node("unilib:plant_pingao", "aotearoa:pingao", mode, {
        -- From aotearoa:pingao
        description = unilib.annotate(S("Pingao"), "Ficinia spiralis"),
        tiles = {"unilib_plant_pingao.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_pingao.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_pingao.png",
    })
    unilib.register_craft({
        -- From aotearoa:pingao
        type = "fuel",
        recipe = "unilib:plant_pingao",
        burntime = 1,
    })
    unilib.register_plant_in_pot("unilib:plant_pingao", "aotearoa:pingao")

    unilib.register_decoration("aotearoa_plant_pingao", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_pingao",

        fill_ratio = 0.1,
        sidelen = 16,
    })

end
