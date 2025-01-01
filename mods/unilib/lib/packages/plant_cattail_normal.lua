---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cattail_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cattail_normal.init()

    return {
        description = "Normal cattail plant",
    }

end

function unilib.pkg.plant_cattail_normal.exec()

    unilib.register_node("unilib:plant_cattail_normal", "mapgen:cattail", mode, {
        -- From farlands, mapgen:cattail
        description = unilib.utils.annotate(S("Normal Cattail"), "Typha"),
        tiles = {"unilib_plant_cattail_normal.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_cattail_normal.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_cattail_normal", "mapgen:cattail")

    unilib.register_decoration_spare("unilib:plant_cattail_normal")

end
