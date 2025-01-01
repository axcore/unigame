---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_banana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_banana.init()

    return {
        description = "Banana plant",
        notes = "Does not produce bananas",
    }

end

function unilib.pkg.plant_shrub_banana.exec()

    unilib.register_node("unilib:plant_shrub_banana", "mapgen:bananaplant", mode, {
        -- From farlands, mapgen:bananaplant
        description = unilib.utils.annotate(S("Banana Plant"), "Musa"),
        tiles = {"unilib_plant_shrub_banana.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_shrub_banana.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_banana", "mapgen:bananaplant")

    unilib.register_decoration_generic("farlands_plant_shrub_banana", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_banana",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end
