---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_arrow_arum = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_arrow_arum.init()

    return {
        description = "Arrow arum",
    }

end

function unilib.pkg.plant_arrow_arum.exec()

    unilib.register_node("unilib:plant_arrow_arum", "valleys_c:arrow_arum", mode, {
        -- From valleys_c:arrow_arum
        description = unilib.utils.annotate(S("Arrow Arum"), "Peltandra virginica"),
        tiles = {"unilib_plant_arrow_arum.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_arrow_arum.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        walkable = false,
        waving = 1,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("valleys_c_plant_arrow_arum", {
        -- From valleys_c, deco_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_arrow_arum",

        fill_ratio = 0.05,
    })

end
