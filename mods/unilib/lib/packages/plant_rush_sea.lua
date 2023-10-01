---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_rush_sea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_rush_sea.init()

    return {
        description = "Sea rush",
    }

end

function unilib.pkg.plant_rush_sea.exec()

    unilib.register_node("unilib:plant_rush_sea", "aotearoa:sea_rush", mode, {
        -- From aotearoa:sea_rush
        description = unilib.annotate(S("Sea Rush"), "Juncus kraussii"),
        tiles = {"unilib_plant_rush_sea.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, grass = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_rush_sea.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_rush_sea.png",
    })
    unilib.register_craft({
        -- From aotearoa:sea_rush
        type = "fuel",
        recipe = "unilib:plant_rush_sea",
        burntime = 1,
    })
    unilib.register_plant_in_pot("unilib:plant_rush_sea", "aotearoa:sea_rush")

    unilib.register_decoration("aotearoa_plant_rush_sea", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_rush_sea",

        fill_ratio = 0.9,
        sidelen = 16,
    })

end
