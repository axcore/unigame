---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_anemone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_anemone.init()

    return {
        description = "Anemone",
    }

end

function unilib.pkg.plant_anemone.exec()

    unilib.register_node("unilib:plant_anemone", "mapgen:anemone", mode, {
        -- From farlands, mapgen:anemone
        description = unilib.annotate(S("Anemone"), "Anemone"),
        tiles = {"unilib_plant_anemone.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 1, flora = 1, sea = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_anemone.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        waving = 1,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:plant_anemone", "mapgen:anemone")

end
