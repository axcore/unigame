---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_sunflower_seed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_sunflower_seed.init()

    return {
        description = "Sunflower seed flour",
        depends = "food_seed_sunflower_dwarf",
        at_least_one = {"stone_desert", "stone_ordinary", "utensil_mortar_pestle"},
    }

end

function unilib.pkg.ingredient_flour_sunflower_seed.exec()

    local c_cobble = "unilib:stone_ordinary_cobble"
    local c_desert_cobble = "unilib:stone_desert_cobble"
    local c_seeds = "unilib:food_seed_sunflower_dwarf"
    local c_stone = "unilib:stone_ordinary"
    local c_desert_stone = "unilib:stone_desert"

    unilib.register_craftitem(
        -- From cucina_vegana:sunflower_seeds_flour
        "unilib:ingredient_flour_sunflower_seed",
        "cucina_vegana:sunflower_seeds_flour",
        mode,
        {
            description = S("Sunflower Seed Flour"),
            inventory_image = "unilib_ingredient_flour_sunflower_seed.png",
            groups = {food_flour = 1, food_vegan = 1},
        }
    )
    -- N.B. For unilib flours, mortar-and-pestle recipes are preferred, if available
    if unilib.pkg_executed_table["utensil_mortar_pestle"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_flour_sunflower_seed",
            recipe = {
                {c_seeds, c_seeds, c_seeds},
                {"", "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    else

        if unilib.pkg_executed_table["stone_ordinary"] ~= nil then

            unilib.register_craft({
                -- From cucina_vegana:sunflower_seeds_flour
                output = "unilib:ingredient_flour_sunflower_seed",
                recipe = {
                    {c_stone, c_stone, c_stone},
                    {c_seeds, c_seeds, c_seeds},
                    {c_cobble, c_cobble, c_cobble},
                },
                replacements = {
                    {c_stone, c_stone .. " 3"},
                    {c_cobble, c_cobble .. " 3"},
                },
            })

            if unilib.pkg_executed_table["stone_desert"] ~= nil then

                unilib.register_craft({
                    -- From cucina_vegana:sunflower_seeds_flour
                    output = "unilib:ingredient_flour_sunflower_seed",
                    recipe = {
                        {c_stone, c_stone, c_stone},
                        {c_seeds, c_seeds, c_seeds},
                        {c_desert_cobble, c_desert_cobble, c_desert_cobble},
                    },
                    replacements = {
                        {c_stone, c_stone .. " 3"},
                        {c_desert_cobble, c_desert_cobble .. " 3"},
                    },
                })

            end

        end
        if unilib.pkg_executed_table["stone_desert"] ~= nil then

            unilib.register_craft({
                -- From cucina_vegana:sunflower_seeds_flour
                output = "unilib:ingredient_flour_sunflower_seed",
                recipe = {
                    {c_desert_stone, c_desert_stone, c_desert_stone},
                    {c_seeds, c_seeds, c_seeds},
                    {c_desert_cobble, c_desert_cobble, c_desert_cobble},
                },
                replacements = {
                    {c_desert_stone, c_desert_stone .. " 3"},
                    {c_desert_cobble, c_desert_cobble .. " 3"},
                },
            })

            if unilib.pkg_executed_table["stone_ordinary"] ~= nil then

                unilib.register_craft({
                    -- From cucina_vegana:sunflower_seeds_flour
                    output = "unilib:ingredient_flour_sunflower_seed",
                    recipe = {
                        {c_desert_stone, c_desert_stone, c_desert_stone},
                        {c_seeds, c_seeds, c_seeds},
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
    if unilib.technic_extra_flag then

        technic.register_grinder_recipe({
            -- From cucina_vegana:sunflower_seeds_flour
            output = "unilib:ingredient_flour_sunflower_seed",
            input = {"unilib:food_seed_sunflower_dwarf 3"},
        })

    end

end
