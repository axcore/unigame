---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    dye
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.dye_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.dye.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.dye_basic.dye_list = {
    {"black",       "",             S("Black"),         S("Black Dye")},
    {"blue",        "",             S("Blue"),          S("Blue Dye")},
    {"brown",       "",             S("Brown"),         S("Brown Dye")},
    {"cyan",        "",             S("Cyan"),          S("Cyan Dye")},
    {"green",       "",             S("Green"),         S("Green Dye")},
    {"green_dark",  "dark_green",   S("Dark Green"),    S("Dark Green Dye")},
    {"grey",        "",             S("Grey"),          S("Grey Dye")},
    {"grey_dark",   "dark_grey",    S("Dark Grey"),     S("Dark Grey Dye")},
    {"magenta",     "",             S("Magenta"),       S("Magenta Dye")},
    {"orange",      "",             S("Orange"),        S("Orange Dye")},
    {"pink",        "",             S("Pink"),          S("Pink Dye")},
    {"red",         "",             S("Red"),           S("Red Dye")},
    {"violet",      "",             S("Violet"),        S("Violet Dye")},
    {"white",       "",             S("White"),         S("White Dye")},
    {"yellow",      "",             S("Yellow"),        S("Yellow Dye")},
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dye_basic.init()

    return {
        description = "Basic dye set (15 dyes)",
        -- Craft violet dye from blueberries
        optional = {"bush_blueberry_ordinary", "plant_cactus_ordinary", "plant_shrub_dry"},
    }

end

function unilib.pkg.dye_basic.exec()

    for i, row_list in ipairs(unilib.pkg.dye_basic.dye_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local translated_name = row_list[3]
        local description = row_list[4]

        unilib.register_dye({
            -- From dye:black, etc. Creates unilib:dye_black, etc
            part_name = part_name,
            orig_name = "dye:" .. orig_name,

            replace_mode = mode,
            description = description,
            palette_pos = i,
            translated_name = translated_name,
        })

    end

    -- Manual craft recipes for (some) basic dyes
    unilib.register_craft({
        output = "unilib:dye_black 4",
        recipe = {
            {"group:coal"},
        },
    })

    if unilib.global.pkg_executed_table["bush_blueberry_ordinary"] ~= nil then

        unilib.register_craft({
            output = "unilib:dye_violet 2",
            recipe = {
                {"unilib:fruit_blueberry_ordinary"},
            },
        })

    end

    -- Extra manual craft recipes from bakedclay mod
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:dye_grey_dark 3",
        recipe = {"unilib:dye_black", "unilib:dye_black", "unilib:dye_white"},
    })

    if not core.get_modpath("unifieddyes") then

        -- (Conflicts with a unifieddyes recipe)
        unilib.register_craft({
            type = "shapeless",
            output = "unilib:dye_grey 3",
            recipe = {"unilib:dye_black", "unilib:dye_white", "unilib:dye_white"}
        })

    end

    if unilib.global.pkg_executed_table["plant_cactus_ordinary"] ~= nil then

        unilib.register_craft({
            type = "shapeless",
            output = "unilib:dye_green 4",
            recipe = {"unilib:plant_cactus_ordinary"},
        })

    end

    if unilib.global.pkg_executed_table["plant_shrub_dry"] ~= nil then

        unilib.register_craft({
            type = "shapeless",
            output = "unilib:dye_brown 4",
            recipe = {"unilib:plant_shrub_dry"},
        })

    end

    -- Some dyes from the set have craft recipes. Other dyes can be crafted using combinations of
    --      those dyes
    local recipe_list = {
        -- source1, source2, destination
        -- RYB mixes
        {"red", "blue", "violet"},
        {"yellow", "red", "orange"},
        {"yellow", "blue", "green"},
        -- RYB complementary mixes
        {"yellow", "violet", "grey_dark"},
        {"blue", "orange", "grey_dark"},
        -- CMY mixes - approximation
        {"cyan", "yellow", "green"},
        {"cyan", "magenta", "blue"},
        {"yellow", "magenta", "red"},
        -- Other mixes that result in a colour we have
        {"red", "green", "brown"},
        {"magenta", "blue", "violet"},
        {"green", "blue", "cyan"},
        {"pink", "violet", "magenta"},
        -- Mixes with black
        {"white", "black", "grey"},
        {"grey", "black", "grey_dark"},
        {"green", "black", "green_dark"},
        {"orange", "black", "brown"},
        -- Mixes with white
        {"white", "red", "pink"},
        {"white", "grey_dark", "grey"},
        {"white", "green_dark", "green"},
    }

    for _, mix_list in pairs(recipe_list) do

        unilib.register_craft({
            type = "shapeless",
            output = "unilib:dye_" .. mix_list[3] .. " 2",
            recipe = {"unilib:dye_" .. mix_list[1], "unilib:dye_" .. mix_list[2]},
        })

    end

    -- This package provides a craft recipe with deliberately missing ingredients
    unilib.register_craft_missing_ingredients({
        -- Package "dye_basic"; no flower package provides dark grey dye (which is instead crafted
        --      from black and white dyes)
        {"unilib:dye_grey_dark", "group:flower,colour_grey_dark"},
    })

end
