---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bush_underground_dead = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bush_underground_dead.init()

    return {
        description = "Underground dead bush",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.plant_bush_underground_dead.exec()

    local img = "unilib_plant_bush_underground_dead.png"

    unilib.register_node("unilib:plant_bush_underground_dead", "underch:dead_bush", mode, {
        -- From underch:dead_bush
        description = S("Underground Dead Bush"),
        tiles = {img},
        groups = {attached_node = 1, flammable = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = img,
    })
    unilib.register_craft({
        -- From underch:dead_bush
        type = "fuel",
        recipe = "unilib:plant_bush_underground_dead",
        burntime = 5,
    })
    if unilib.pkg_executed_table["item_stick_ordinary"] then

        unilib.register_craft({
            -- From underch:dead_bush
            type = "shapeless",
            output = "unilib:item_stick_ordinary",
            recipe = {"unilib:plant_bush_underground_dead"},
        })

    end
    unilib.register_plant_in_pot("unilib:plant_bush_underground_dead", "underch:dead_bush")

end
