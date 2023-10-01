---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_plate_ceramic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_plate_ceramic.init()

    return {
        description = "Ceramic plate",
        depends = "clay_ordinary",
    }

end

function unilib.pkg.utensil_plate_ceramic.exec()

    unilib.register_node("unilib:utensil_plate_ceramic", "cucina_vegana:plate", mode, {
        -- From cucina_vegana:plate
        description = S("Ceramic Plate"),
        tiles = {"unilib_utensil_plate_ceramic.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_plate = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_utensil_plate_ceramic.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        walkable = false,
        wield_image = "unilib_utensil_plate_ceramic.png",
    })
    -- N.B. Omitted all but one craft recipe; the others were nonsensical. To compensate, increased
    --          output from 2 to 5
    -- N.B. In all craft recipes, group:cobble was default:cobble in the original code
    unilib.register_craft({
        -- From cucina_vegana:plate
        output = "unilib:utensil_plate_ceramic 5",
        recipe = {
            {"unilib:clay_ordinary_lump", "", "unilib:clay_ordinary_lump"},
            {"unilib:clay_ordinary_lump", "group:cobble", "unilib:clay_ordinary_lump"}
        },
    })

end
