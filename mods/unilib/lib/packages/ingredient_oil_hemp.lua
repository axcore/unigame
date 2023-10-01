---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_hemp = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_hemp.init()

    return {
        description = "Bottle of hemp oil",
        depends = {"crop_hemp", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.ingredient_oil_hemp.exec()

    unilib.register_node("unilib:ingredient_oil_hemp", "farming:hemp_oil", mode, {
        -- From farming:hemp_oil
        description = S("Bottle of Hemp Oil"),
        tiles = {"unilib_ingredient_oil_hemp.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_oil = 1, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_oil_hemp.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_ingredient_oil_hemp.png",
    })
    unilib.register_craft({
        -- From farming:hemp_oil
        output = "unilib:ingredient_oil_hemp",
        recipe = {
            {"unilib:crop_hemp_harvest", "unilib:crop_hemp_harvest", "unilib:crop_hemp_harvest"},
            {"unilib:crop_hemp_harvest", "unilib:crop_hemp_harvest", "unilib:crop_hemp_harvest"},
            {"", "unilib:vessel_bottle_glass_empty", ""}
        }
    })
    unilib.register_craft({
        -- From farming:hemp_oil
        output = "unilib:ingredient_oil_hemp",
        recipe = {
            {"unilib:crop_hemp_seed", "unilib:crop_hemp_seed", "unilib:crop_hemp_seed"},
            {"unilib:crop_hemp_seed", "unilib:crop_hemp_seed", "unilib:crop_hemp_seed"},
            {"unilib:crop_hemp_seed", "unilib:vessel_bottle_glass_empty", "unilib:crop_hemp_seed"}
        }
    })
    unilib.register_craft({
        -- From farming:hemp_oil
        type = "fuel",
        recipe = "unilib:ingredient_oil_hemp",
        burntime = 20,
        replacements = {
            {"unilib:ingredient_oil_hemp", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
