---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_clover = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_clover.init()

    return {
        description = "Clover",
    }

end

function unilib.pkg.plant_clover.exec()

    unilib.register_node("unilib:plant_clover", "moreplants:clover", mode, {
        -- From moreplants:clover
        description = unilib.utils.annotate(S("Clover"), "Trifolium"),
        tiles = {
            "unilib_plant_clover.png",
            "blank.png",
            "unilib_plant_clover.png",
            "unilib_plant_clover.png",
            "unilib_plant_clover.png",
            "unilib_plant_clover.png"
        },
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "firelike",
        inventory_image = "unilib_plant_clover.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("moreplants_plant_clover", {
        -- From moreplants:clover
        deco_type = "simple",
        decoration = "unilib:plant_clover",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
