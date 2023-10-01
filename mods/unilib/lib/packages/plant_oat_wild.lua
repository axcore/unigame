---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_oat_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_oat_wild.init()

    return {
        description = "Wild oat plant",
        notes = "Does not drop seeds and is not edible",
    }

end

function unilib.pkg.plant_oat_wild.exec()

    unilib.register_node("unilib:plant_oat_wild", "mapgen:wild_oat", mode, {
        -- From farlands, mapgen:wild_oat
        description = unilib.annotate(S("Wild Oat Plant"), "Avena sativa"),
        tiles = {"unilib_plant_oat_wild.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_oat_wild.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:plant_oat_wild", "mapgen:wild_oat")

    unilib.register_node("unilib:plant_oat_wild_dry", "mapgen:wild_oat_dry", mode, {
        -- From farlands, mapgen:wild_oat_dry
        description = S("Dry Wild Oat Plant"),
        tiles = {"unilib_plant_oat_wild_dry.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_oat_wild_dry.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:plant_oat_wild_dry", "mapgen:wild_oat_dry")

    unilib.register_decoration("farlands_plant_oat_wild", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_oat_wild",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 6,
    })

    unilib.register_decoration("farlands_plant_oat_wild_dry", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_oat_wild_dry",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 6,
    })

end
