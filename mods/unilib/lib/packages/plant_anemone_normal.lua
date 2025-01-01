---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_anemone_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_anemone_normal.init()

    return {
        description = "Normal anemone",
    }

end

function unilib.pkg.plant_anemone_normal.exec()

    unilib.register_node("unilib:plant_anemone_normal", "mapgen:anemone", mode, {
        -- From farlands, mapgen:anemone
        description = unilib.utils.annotate(S("Normal Anemone"), "Anemone"),
        tiles = {"unilib_plant_anemone_normal.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 1, flora = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_anemone_normal.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        waving = 1,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:plant_anemone_normal", "mapgen:anemone")

    unilib.register_decoration_spare("unilib:plant_anemone_normal")

end
