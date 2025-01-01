---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pulp_cactus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pulp_cactus.init()

    return {
        description = "Bucket of cactus pulp",
        depends = "plant_cactus_ordinary",
    }

end

function unilib.pkg.food_pulp_cactus.post()

    for bucket_type, def_table in pairs(unilib.global.generic_bucket_table) do

        local c_pulp_bucket = "unilib:" .. bucket_type .. "_with_pulp_cactus"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        local img = "unilib_" .. bucket_type .. "_empty.png^unilib_bucket_pulp_cactus_overlay.png"

        unilib.register_craftitem(c_pulp_bucket, "ethereal:bucket_cactus", mode, {
            -- From ethereal:bucket_cactus
            description = unilib.utils.brackets(def_table.description, S("Cactus Pulp")),
            inventory_image = img,
            -- N.B. food_cactus = 1 not in original code; flammable = 2 omitted from original code
            groups = {drink = 1, food_cactus = 1, vessel = 1},

            stack_max = 1,
            wield_image = img,

            on_use = unilib.cuisine.eat_on_use(c_pulp_bucket, 2, c_empty_bucket),
        })
        unilib.register_craft({
            -- From ethereal:bucket_cactus
            output = c_pulp_bucket,
            recipe = {
                {c_empty_bucket, "unilib:plant_cactus_ordinary"},
            },
        })

    end

end
