---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_baked_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_baked_basic.init()

    return {
        description = "Basic baked clay set (16 clays), with matching glazed terracotta",
        depends = {"dye_basic", "shared_bakedclay"},
        optional = "brick_ordinary",
        at_least_one = {"clay_brown", "clay_ordinary"},
    }

end

function unilib.pkg.clay_baked_basic.exec()

    -- Basic baked clay set (the same colours used in the "dye_basic" package, plus an extra
    --      "natural" colour)
    local clay_list = {
        {"black",       "",             S("Black"),         S("Black Baked Clay")},
        {"blue",        "",             S("Blue"),          S("Blue Baked Clay")},
        {"brown",       "",             S("Brown"),         S("Brown Baked Clay")},
        {"cyan",        "",             S("Cyan"),          S("Cyan Baked Clay")},
        {"green",       "",             S("Green"),         S("Green Baked Clay")},
        {"green_dark",  "dark_green",   S("Dark Green"),    S("Dark Green Baked Clay")},
        {"grey",        "",             S("Grey"),          S("Grey Baked Clay")},
        {"grey_dark",   "dark_grey",    S("Dark Grey"),     S("Dark Grey Baked Clay")},
        {"magenta",     "",             S("Magenta"),       S("Magenta Baked Clay")},
        {"natural",     "",             S("Natural"),       S("Natural Baked Clay")},
        {"orange",      "",             S("Orange"),        S("Orange Baked Clay")},
        {"pink",        "",             S("Pink"),          S("Pink Baked Clay")},
        {"red",         "",             S("Red"),           S("Red Baked Clay")},
        {"violet",      "",             S("Violet"),        S("Violet Baked Clay")},
        {"white",       "",             S("White"),         S("White Baked Clay")},
        {"yellow",      "",             S("Yellow"),        S("Yellow Baked Clay")},
    }

    for _, row_list in ipairs(clay_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local translated_name = row_list[3]
        local description = row_list[4]

        unilib.pkg.shared_bakedclay.register_baked_clay({
            -- From bakedclay:black, etc. Creates unilib:clay_baked_black, etc
            part_name = part_name,
            orig_name = "bakedclay:" .. orig_name,

            replace_mode = mode,
            description = description,
            translated_name = translated_name,
        })

        if part_name ~= "natural" then

            local img = "unilib_clay_terracotta_" .. part_name ..".png"

            unilib.register_node(
                -- From bakedclay:terracotta_black, etc. Creates unilib:clay_terracotta_baked_black,
                --      etc
                "unilib:clay_terracotta_" .. part_name,
                "bakedclay:terracotta_" .. part_name,
                mode,
                {
                    description = unilib.utils.brackets(S("Glazed Terracotta"), translated_name),
                    tiles = {
                        img,
                        img,
                        img .. "^[transformR180",
                        img,
                        img .. "^[transformR270",
                        img .. "^[transformR90",
                    },
                    groups = {cracky = 3, terracotta = 1},
                    sounds = unilib.global.sound_table.stone,

                    paramtype2 = "facedir",

                    on_place = core.rotate_node,
                }
            )
            unilib.register_craft({
                -- From bakedclay:terracotta_black, etc
                type = "cooking",
                output = "unilib:clay_terracotta_" .. part_name,
                recipe = "unilib:clay_baked_" .. part_name,
            })

        end

    end

    -- Cook clays to make the "natural" baked clay, from which coloured baked clays can be crafted
    if unilib.global.pkg_executed_table["clay_ordinary"] ~= nil then

        unilib.register_craft({
            -- From bakedclay:natural
            type = "cooking",
            output = "unilib:clay_baked_natural",
            recipe = "unilib:clay_ordinary",
        })

        -- (Can also craft ordinary bricks)
        if unilib.global.pkg_executed_table["brick_ordinary"] ~= nil then

            unilib.register_craft({
                -- From default:clay_brick
                output = "unilib:brick_ordinary 16",
                recipe = {
                    {"unilib:clay_baked_red", "unilib:clay_baked_red"},
                    {"unilib:clay_baked_red", "unilib:clay_baked_red"},
                },
            })

        end

    end

    if unilib.global.pkg_executed_table["clay_brown"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:clay_baked_natural",
            recipe = "unilib:clay_brown",
        })

    end

end
