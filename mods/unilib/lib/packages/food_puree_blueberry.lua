---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_puree_blueberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_puree_blueberry.init()

    return {
        description = "Blueberry purée",
        at_least_one = {
            "bush_ornamental_blueberry",
            "fruit_blueberry_ordinary",
            "produce_blueberry_highbush",
            "stone_desert",
            "stone_ordinary",
            "utensil_mortar_pestle",
        },
    }

end

function unilib.pkg.food_puree_blueberry.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:blueberry_puree
        "unilib:food_puree_blueberry",
        "cucina_vegana:blueberry_puree",
        mode,
        {
            description = S("Blueberry Purée"),
            inventory_image = "unilib_food_puree_blueberry.png",
            groups = {food = 1, food_berry = 1, food_blueberry = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_puree_blueberry", 4)
        }
    )

    local berry_list= {}
    if unilib.global.pkg_executed_table["fruit_blueberry_ordinary"] ~= nil then
        table.insert(berry_list, "unilib:fruit_blueberry_ordinary")
    end
    if unilib.global.pkg_executed_table["produce_blueberry_highbush"] ~= nil then
        table.insert(berry_list, "unilib:produce_blueberry_highbush_harvest")
    end
    -- N.B. This recipe is removed, because unilib:fruit_blueberry_ordinary can craft
    --      unilib:fruit_blueberry_picked)
    --[[
    if unilib.global.pkg_executed_table["bush_ornamental_blueberry"] ~= nil then
        table.insert(berry_list, "unilib:fruit_blueberry_picked")
    end
    ]]--

    if unilib.global.pkg_executed_table["utensil_mortar_pestle"] ~= nil then

        for _, berry_name in ipairs(berry_list) do

            -- N.B. The original craft recipes are unsatisfactory, so this new one is preferred, if
            --      a mortar and pestle is available
            unilib.register_craft({
                -- Original to unilib
                output = "unilib:food_puree_blueberry",
                recipe = {
                    {berry_name, berry_name, berry_name},
                    {berry_name, berry_name, berry_name},
                    {"", "unilib:utensil_mortar_pestle", ""},
                },
                replacements = {
                    {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
                },
            })

        end

    else

        local stone_list = {}
        if unilib.global.pkg_executed_table["stone_ordinary"] ~= nil then

            table.insert(stone_list, "unilib:stone_ordinary")
            table.insert(stone_list, "unilib:stone_ordinary_cobble")

        end
        if unilib.global.pkg_executed_table["stone_desert"] ~= nil then

            table.insert(stone_list, "unilib:stone_desert")
            table.insert(stone_list, "unilib:stone_desert_cobble")

        end

        for _, berry_name in ipairs(berry_list) do

            for _, stone_name in ipairs(stone_list) do

                unilib.register_craft({
                    output = "unilib:food_puree_blueberry",
                    recipe = {
                        {stone_name, berry_name, berry_name},
                        {stone_name, berry_name, berry_name},
                        {stone_name, berry_name, berry_name},
                    },
                    replacements = {
                        {stone_name, stone_name .. " 3"},
                    },
                })

            end

        end

    end

    if unilib.setting.technic_extra_flag then

        for _, berry_name in ipairs(berry_list) do

            technic.register_compressor_recipe({
                -- From cucina_vegana:blueberry_puree
                output = "unilib:food_puree_blueberry",
                input = {berry_name .. " 6"},
            })

        end

    end

end
