---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_rice_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_rice_brown.init()

    return {
        description = "Brown rice flour",
        depends = "crop_rice_brown",
        at_least_one = {"stone_desert", "stone_ordinary", "utensil_mortar_pestle"},
    }

end

function unilib.pkg.ingredient_flour_rice_brown.exec()

    local c_cobble = "unilib:stone_ordinary_cobble"
    local c_desert_cobble = "unilib:stone_desert_cobble"
    local c_rice = "unilib:crop_rice_brown_harvest"
    local c_stone = "unilib:stone_ordinary"
    local c_desert_stone = "unilib:stone_desert"

    unilib.register_craftitem(
        -- From cucina_vegana:rice_flour
        "unilib:ingredient_flour_rice_brown",
        "cucina_vegana:rice_flour",
        mode,
        {
            description = S("Brown Rice Flour"),
            inventory_image = "unilib_ingredient_flour_rice_brown.png",
            groups = {food_flour = 1, food_vegan = 1},
        }
    )
    -- N.B. For unilib flours, mortar-and-pestle recipes are preferred, if available
    if unilib.global.pkg_executed_table["utensil_mortar_pestle"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_flour_rice_brown",
            recipe = {
                {c_rice, c_rice, c_rice},
                {"", "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    else

        if unilib.global.pkg_executed_table["stone_ordinary"] ~= nil then

            unilib.register_craft({
                -- From cucina_vegana:rice_flour
                output = "unilib:ingredient_flour_rice_brown",
                recipe = {
                    {c_stone, c_stone, c_stone},
                    {c_rice, c_rice, c_rice},
                    {c_cobble, c_cobble, c_cobble},
                },
                replacements = {
                    {c_stone, c_stone .. " 3"},
                    {c_cobble, c_cobble .. " 3"},
                },
            })

            if unilib.global.pkg_executed_table["stone_desert"] ~= nil then

                unilib.register_craft({
                    -- From cucina_vegana:rice_flour
                    output = "unilib:ingredient_flour_rice_brown",
                    recipe = {
                        {c_stone, c_stone, c_stone},
                        {c_rice, c_rice, c_rice},
                        {c_desert_cobble, c_desert_cobble, c_desert_cobble},
                    },
                    replacements = {
                        {c_stone, c_stone .. " 3"},
                        {c_desert_cobble, c_desert_cobble .. " 3"},
                    },
                })

            end

        end
        if unilib.global.pkg_executed_table["stone_desert"] ~= nil then

            unilib.register_craft({
                -- From cucina_vegana:rice_flour
                output = "unilib:ingredient_flour_rice_brown",
                recipe = {
                    {c_desert_stone, c_desert_stone, c_desert_stone},
                    {c_rice, c_rice, c_rice},
                    {c_desert_cobble, c_desert_cobble, c_desert_cobble},
                },
                replacements = {
                    {c_desert_stone, c_desert_stone .. " 3"},
                    {c_desert_cobble, c_desert_cobble .. " 3"},
                },
            })

            if unilib.global.pkg_executed_table["stone_ordinary"] ~= nil then

                unilib.register_craft({
                    -- From cucina_vegana:rice_flour
                    output = "unilib:ingredient_flour_rice_brown",
                    recipe = {
                        {c_desert_stone, c_desert_stone, c_desert_stone},
                        {c_rice, c_rice, c_rice},
                        {c_cobble, c_cobble, c_cobble},
                    },
                    replacements = {
                        {c_desert_stone, c_desert_stone .. " 3"},
                        {c_cobble, c_cobble .. " 3"},
                    },
                })

            end

        end

    end
    if unilib.setting.technic_extra_flag then

        technic.register_grinder_recipe({
            -- From cucina_vegana:rice_flour
            output = "unilib:ingredient_flour_rice_brown",
            input = {"unilib:crop_rice_brown_harvest 3"},
        })

    end

end
