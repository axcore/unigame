---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_tall = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_tall.init()

    return {
        description = "Tall grass",
    }

end

function unilib.pkg.grass_tall.exec()

    unilib.register_node("unilib:grass_tall", "mapgen:tallgrass", mode, {
        -- From farlands, unilib:grass_tall
        description = S("Tall Grass"),
        tiles = {"unilib_grass_tall.png"},
        -- N.B. grass = 1, tall_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, snappy = 3, tall_grass = 1,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_grass_tall.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:grass_tall", "mapgen:tallgrass")

    unilib.register_decoration("farlands_grass_tall", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:grass_tall",

        height = 1,
        fill_ratio = 0.01,
        sidelen = 16,
    })

end
