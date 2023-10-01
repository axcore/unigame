---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bush_underground = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bush_underground.init()

    return {
        description = "Underground bush (plant-like)",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.plant_bush_underground.exec()

    local img = "unilib_plant_bush_underground.png"

    unilib.register_node("unilib:plant_bush_underground", "underch:underground_bush", mode, {
        -- From underch:underground_bush
        description = S("Underground Bush"),
        tiles = {img},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "allfaces",
        is_ground_content = false,
        paramtype = "light",
        special_tiles = {img},
        waving = 1,
    })
    unilib.register_craft({
        -- From underch:underground_bush
        type = "fuel",
        recipe = "unilib:plant_bush_underground",
        burntime = 5,
    })
    if unilib.pkg_executed_table["item_stick_ordinary"] then

        unilib.register_craft({
            -- From underch:underground_bush
            type = "shapeless",
            output = "unilib:item_stick_ordinary 2",
            recipe = {"unilib:plant_bush_underground"},
        })

    end
    -- (not compatible with flowerpots)

end
