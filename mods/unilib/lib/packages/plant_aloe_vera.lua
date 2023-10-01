---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_aloe_vera = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_aloe_vera.init()

    return {
        description = "Aloe vera",
    }

end

function unilib.pkg.plant_aloe_vera.exec()

    unilib.register_node("unilib:plant_aloe_vera", "mapgen:aloe_vera", mode, {
        -- From farlands, mapgen:aloe_vera
        description = unilib.annotate(S("Aloe Vera"), "Aloe vera"),
        tiles = {"unilib_plant_aloe_vera.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_aloe_vera.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:plant_aloe_vera", "mapgen:aloe_vera")

    unilib.register_decoration("farlands_plant_aloe_vera", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_aloe_vera",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end
