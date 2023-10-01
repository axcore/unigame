---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_extract_vanilla = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_extract_vanilla.init()

    return {
        description = "Vanilla extract",
        depends = {"produce_vanilla", "vessel_bottle_glass_ethanol"},
        optional = "vessel_bottle_glass_empty",
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.ingredient_extract_vanilla.exec()

    unilib.register_node("unilib:ingredient_extract_vanilla", "farming:vanilla_extract", mode, {
        -- From farming:vanilla_extract
        description = S("Vanilla Extract"),
        tiles = {"unilib_ingredient_extract_vanilla.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_extract_vanilla.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_ingredient_extract_vanilla.png",
    })
    if unilib.pkg_executed_table["vessel_bottle_glass_empty"] ~= nil then

        unilib.register_craft({
            -- From farming:vanilla_extract
            type = "fuel",
            recipe = "unilib:ingredient_extract_vanilla",
            burntime = 25,
            replacements = {
                {"unilib:ingredient_extract_vanilla", "unilib:vessel_bottle_glass_empty"},
            },
        })

    end

end

function unilib.pkg.ingredient_extract_vanilla.post()

    unilib.register_craft( {
        -- From farming:vanilla_extract
        output = "unilib:ingredient_extract_vanilla",
        recipe = {
            {"group:food_vanilla", "group:food_vanilla", "group:food_vanilla"},
            {"group:food_vanilla", "unilib:vessel_bottle_glass_ethanol", "group:potable_bucket"},
        },
        replacements = unilib.potable_bucket_list,
    })

end
