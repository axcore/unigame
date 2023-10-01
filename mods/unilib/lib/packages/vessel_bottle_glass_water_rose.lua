---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_glass_water_rose = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_glass_water_rose.init()

    return {
        description = "Bottle of rose water",
        depends = {"flower_rose_red", "utensil_pot_cooking", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.vessel_bottle_glass_water_rose.exec()

    unilib.register_node("unilib:vessel_bottle_glass_water_rose", "farming:rose_water", mode, {
        -- From farming:rose_water
        description = S("Bottle of Rose Water"),
        tiles = {"unilib_vessel_bottle_glass_water_rose.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_rose_water = 1, vessel = 1},
        sounds = unilib.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_vessel_bottle_glass_water_rose.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        visual_scale = 0.80,
        wield_image = "unilib_vessel_bottle_glass_water_rose.png",
    })

end

function unilib.pkg.vessel_bottle_glass_water_rose.post()

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {"group:food_pot", "unilib:utensil_pot_cooking"})

    unilib.register_craft({
        -- From farming:rose_water
        output = "unilib:vessel_bottle_glass_water_rose",
        recipe = {
            {"unilib:flower_rose_red", "unilib:flower_rose_red", "unilib:flower_rose_red"},
            {"unilib:flower_rose_red", "unilib:flower_rose_red", "unilib:flower_rose_red"},
            {"group:potable_bucket", "group:food_pot", "unilib:vessel_bottle_glass_empty"},
        },
        replacements = replace_list,
    })

end
