---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_weed_bindweed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_weed_bindweed.init()

    return {
        description = "Bindweed",
    }

end

function unilib.pkg.plant_weed_bindweed.exec()

    unilib.register_node("unilib:plant_weed_bindweed", "mapgen:creeper", mode, {
        -- From farlands, mapgen:creeper
        description = unilib.annotate(S("Bindweed"), "Convolvulus"),
        tiles = {
            "unilib_plant_weed_bindweed.png",
            "blank.png",
            "unilib_plant_weed_bindweed.png",
        },
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "firelike",
        inventory_image = "unilib_plant_weed_bindweed.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("farlands_plant_weed_bindweed", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_weed_bindweed",

        fill_ratio = 0.05,
        height = 1,
        sidelen = 16,
    })

end
