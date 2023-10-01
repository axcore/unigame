---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_salt_sea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_salt_sea.init()

    return {
        description = "Sea salt",
    }

end

function unilib.pkg.ingredient_salt_sea.exec()

    unilib.register_node("unilib:ingredient_salt_sea", "bbq:sea_salt", mode, {
        -- From bbq:sea_salt
        description = S("Sea Salt"),
        tiles = {"unilib_ingredient_salt_sea.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_salt = 1, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_salt_sea.png",
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_salt_sea.png",
    })

end

function unilib.pkg.ingredient_salt_sea.post()

    -- N.B. As this is salt, only use ordinary water as an ingredient

    for bucket_type, _ in pairs(unilib.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- From bbq:sea_salt
            type = "cooking",
            output = "unilib:ingredient_salt_sea",
            recipe = c_water_bucket,
            replacements = {
                {c_water_bucket, c_empty_bucket},
            },
            cooktime = 8,
        })

    end

end
