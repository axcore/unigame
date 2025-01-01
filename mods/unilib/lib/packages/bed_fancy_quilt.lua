---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    colored_beds
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bed_fancy_quilt = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.colored_beds.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bed_fancy_quilt.init()

    return {
        description = "Fancy bed with quilt set (15 colours)",
        depends = {"shared_beds", "wool_basic"},
        optional = "bed_fancy",
    }

end

function unilib.pkg.bed_fancy_quilt.exec()

    local bed_list = {
        {"black",       "",             S("Fancy Bed with Black Quilt")},
        {"blue",        "",             S("Fancy Bed with Blue Quilt")},
        {"brown",       "",             S("Fancy Bed with Brown Quilt")},
        {"cyan",        "",             S("Fancy Bed with Cyan Quilt")},
        {"green",       "",             S("Fancy Bed with Green Quilt")},
        {"green_dark",  "dark_green",   S("Fancy Bed with Dark Green Quilt")},
        {"grey",        "",             S("Fancy Bed with Grey Quilt")},
        {"grey_dark",   "dark_grey",    S("Fancy Bed with Dark Grey Quilt")},
        {"magenta",     "",             S("Fancy Bed with Magenta Quilt")},
        {"orange",      "",             S("Fancy Bed with Orange Quilt")},
        {"pink",        "",             S("Fancy Bed with Pink Quilt")},
--      {"red",         "",             S("Fancy Bed with Red Quilt")},
        {"violet",      "",             S("Fancy Bed with Violet Quilt")},
        {"white",       "",             S("Fancy Bed with White Quilt")},
        {"yellow",      "",             S("Fancy Bed with Yellow Quilt")},
    }

    -- (Avoid craft recipe conflict with the minetest_game bed)
    if unilib.global.pkg_executed_table["bed_fancy"] == nil then

        table.insert(bed_list, {"red", "", S("Fancy Bed with Red Quilt")})

    else

        core.register_alias("unilib:bed_fancy_quilt_red_bottom", "beds:fancy_bed_bottom")
        core.register_alias("unilib:bed_fancy_quilt_red_top", "beds:fancy_bed_top")

    end

    for _, row_list in ipairs(bed_list) do

        local part_name = row_list[1]
        local orig_name = row_list[2]
        local description = row_list[3]

        local recipe_table = {}
        local c_wool = "unilib:wool_" .. part_name

        local inv_img = "unilib_bed_fancy_inv_overlay.png^unilib_wool_" .. part_name .. ".png" ..
                "^unilib_bed_fancy_inv_overlay.png^[makealpha:255,128,128"

        if not unilib.setting.mtgame_tweak_flag then

            -- Current minetest_game recipe
            recipe_table = {
                {"", "", "group:stick"},
                {c_wool, c_wool, c_wool},
                {"group:wood", "group:wood", "group:wood"},
            }

        else

            -- Traditional recipe
            recipe_table = {
                {"", "", "group:stick"},
                {c_wool, c_wool, "unilib:wool_white"},
                {"group:wood", "group:wood", "group:wood"},
            }

        end

        unilib.pkg.shared_beds.register_bed({
            -- Code adapted from the "bed_fancy" package, textures from "colored_beds" mod. Creates
            --      unilib:bed_fancy_quilt_black_bottom, unilib:bed_fancy_quilt_black_top, etc
            part_name = "fancy_quilt_" .. part_name,
            orig_name_list = {
                "beds:fancy_bed_" .. orig_name .. "_bottom",
                "beds:fancy_bed_" .. orig_name .. "_top",
            },
            recipe_table = recipe_table,
            tile_table = {
                bottom = {
                    "unilib_bed_" .. part_name .. "_top1.png",
                    "unilib_bed_generic_under.png",
                    "unilib_bed_" .. part_name .. "_side1.png",
                    "unilib_bed_" .. part_name .. "_side1.png^[transformFX",
                    "unilib_bed_" .. part_name .. "_foot.png",
                },
                top = {
                    "unilib_bed_" .. part_name .. "_top2.png",
                    "unilib_bed_generic_under.png",
                    "unilib_bed_" .. part_name .. "_side2.png",
                    "unilib_bed_" .. part_name .. "_side2.png^[transformfx",
                    "unilib_bed_generic_head.png",
                },
            },

            replace_mode = mode,
            burntime = 12,
            description = description,
            inventory_image = inv_img,
            node_table = {
                bottom = {
                    {-0.5, -0.5, -0.5, -0.375, -0.065, -0.4375},
                    {0.375, -0.5, -0.5, 0.5, -0.065, -0.4375},
                    {-0.5, -0.375, -0.5, 0.5, -0.125, -0.4375},
                    {-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
                    {0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
                    {-0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5},
                },
                top = {
                    {-0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5},
                    {0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5},
                    {-0.5, 0, 0.4375, 0.5, 0.125, 0.5},
                    {-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
                    {-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
                    {0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
                    {-0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375},
                },
            },
            select_table = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
            wield_image = inv_img,
        })

    end

end
