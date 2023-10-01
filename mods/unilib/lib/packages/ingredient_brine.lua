---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_brine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_brine.init()

    return {
        description = "Brine",
        suggested = {
            "ingredient_salt_normal",           -- group:food_salt
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.ingredient_brine.exec()

    unilib.register_node("unilib:ingredient_brine", "bbq:brine", mode, {
        -- From bbq:brine
        description = S("Brine"),
        tiles = {"unilib_ingredient_brine.png"},
        groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
        sounds = default.node_sound_glass_defaults(),

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_brine.png",
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_brine.png",
    })

end

function unilib.pkg.ingredient_brine.post()

    -- N.B. As this is salt, use ordinary water rather than potable waters

    for bucket_type, _ in pairs(unilib.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- From bbq:brine
            type = "shapeless",
            output = "unilib:ingredient_brine",
            recipe = {
                "group:food_salt",
                "group:food_sugar",
                c_water_bucket,
                "unilib:vessel_glass_empty",
            },
            replacements = {
                {c_water_bucket, c_empty_bucket},
            },
        })

    end

end
