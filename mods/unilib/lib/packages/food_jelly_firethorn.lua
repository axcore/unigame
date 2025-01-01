---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_jelly_firethorn = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_jelly_firethorn.init()

    return {
        description = "Firethorn jelly",
        depends = {
            "plant_shrub_firethorn",
            "utensil_bowl_wooden",
            "utensil_mortar_pestle",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.food_jelly_firethorn.exec()

    unilib.register_craftitem("unilib:food_jelly_firethorn", "ethereal:firethorn_jelly", mode, {
        -- From ethereal:firethorn_jelly
        description = S("Firethorn Jelly"),
        inventory_image = "unilib_food_jelly_firethorn.png",
        -- N.B. food_jelly = 1 not in original code
        groups = {flammable = 2, food_jelly = 1, vessel = 1},

        wield_image = "unilib_food_jelly_firethorn.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_jelly_firethorn", 2, "unilib:vessel_bottle_glass_empty"
        ),
    })

end

function unilib.pkg.food_jelly_firethorn.post()

    local c_plant = "unilib:plant_shrub_firethorn"

    local replace_list = {}
    for _, mini_list in pairs(unilib.global.potable_bucket_list) do
        table.insert(replace_list, {mini_list[1], mini_list[2] .. " 3"})
    end

    table.insert(replace_list, {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"})

    if unilib.global.pkg_executed_table["utensil_bowl_wooden"] ~= nil and
            unilib.global.pkg_executed_table["utensil_mortar_pestle"] ~= nil then

        unilib.register_craft({
            -- From ethereal:firethorn_jelly
            output = "unilib:food_jelly_firethorn",
            recipe = {
                {"unilib:utensil_mortar_pestle", "unilib:vessel_bottle_glass_empty", ""},
                {c_plant, c_plant, c_plant},
                {"group:potable_bucket", "group:potable_bucket", "group:potable_bucket"},
            },
            replacements = replace_list,
        })

    end

end
