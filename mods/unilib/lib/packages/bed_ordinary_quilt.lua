---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    colored_beds
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bed_ordinary_quilt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.colored_beds.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bed_ordinary_quilt.init()

    return {
        description = "Ordinary bed with quilt set (15 colours)",
        depends = "wool_basic",
        optional = "bed_ordinary",
    }

end

function unilib.pkg.bed_ordinary_quilt.exec()

    local bed_list = {
        {"black",       "",             S("Ordinary Bed with Black Quilt")},
        {"blue",        "",             S("Ordinary Bed with Blue Quilt")},
        {"brown",       "",             S("Ordinary Bed with Brown Quilt")},
        {"cyan",        "",             S("Ordinary Bed with Cyan Quilt")},
        {"green",       "",             S("Ordinary Bed with Green Quilt")},
        {"green_dark",  "dark_green",   S("Ordinary Bed with Dark Green Quilt")},
        {"grey",        "",             S("Ordinary Bed with Grey Quilt")},
        {"grey_dark",   "dark_grey",    S("Ordinary Bed with Dark Grey Quilt")},
        {"magenta",     "",             S("Ordinary Bed with Magenta Quilt")},
        {"orange",      "",             S("Ordinary Bed with Orange Quilt")},
        {"pink",        "",             S("Ordinary Bed with Pink Quilt")},
--      {"red",         "",             S("Ordinary Bed with Red Quilt")},
        {"violet",      "",             S("Ordinary Bed with Violet Quilt")},
        {"white",       "",             S("Ordinary Bed with White Quilt")},
        {"yellow",      "",             S("Ordinary Bed with Yellow Quilt")},
    }

    -- (Avoid craft recipe conflict with the minetest_game bed)
    if unilib.pkg_executed_table["bed_ordinary"] == nil then

        table.insert(bed_list, {"red", "", S("Ordinary Bed with Red Quilt")})

    else

        minetest.register_alias("unilib:bed_ordinary_quilt_red_bottom", "beds:bed_bottom")
        minetest.register_alias("unilib:bed_ordinary_quilt_red_top", "beds:bed_top")

    end

    for _, row_list in ipairs(bed_list) do

        local part_name = row_list[1]
        local orig_name = row_list[2]
        local description = row_list[3]

        local recipe_table = {}
        local c_wool = "unilib:wool_" .. part_name
        local inv_img = "unilib_bed_ordinary_inv_overlay.png^unilib_wool_" .. part_name .. ".png" ..
                "^unilib_bed_ordinary_inv_overlay.png^[makealpha:255,128,128"

        if not unilib.mtgame_tweak_flag then

            -- Current minetest_game recipe
            recipe_table = {
                {"", "", ""},
                {c_wool, c_wool, c_wool},
                {"group:wood", "group:wood", "group:wood"}
            }

        else

            -- Traditional recipe
            recipe_table = {
                {"", "", ""},
                {c_wool, c_wool, "unilib:wool_white"},
                {"group:wood", "group:wood", "group:wood"}
            }

        end

        unilib.register_bed({
            -- Code adapted from the "bed_ordinary" package, textures from "colored_beds" mod.
            --      Creates unilib:bed_ordinary_quilt_black_bottom,
            --      unilib:bed_ordinary_quilt_black_top, etc
            part_name = "ordinary_quilt_" .. part_name,
            orig_name = {"beds:bed_" .. orig_name .. "_bottom", "beds:bed_" .. orig_name .. "_top"},
            recipe_table = recipe_table,
            tile_table = {
                bottom = {
                    "unilib_wool_" .. part_name .. ".png",
                    "unilib_bed_generic_under.png",
                    "unilib_bed_" .. part_name .. "_side_bottom_r.png",
                    "unilib_bed_" .. part_name .. "_side_bottom_r.png^[transformfx",
                    "unilib_bed_" .. part_name .. "_side_bottom.png"
                },
                top = {
                    "unilib_bed_" .. part_name .. "_top_top.png",
                    "unilib_bed_generic_under.png",
                    "unilib_bed_" .. part_name .. "_side_top_r.png",
                    "unilib_bed_" .. part_name .. "_side_top_r.png^[transformfx",
                    "unilib_bed_generic_side_top.png",
                },
            },

            replace_mode = mode,
            burntime = 12,
            description = description,
            inventory_image = inv_img,
            node_table = {
                bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
                top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
            },
            select_table = {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5},
            wield_image = inv_img,
        })

    end

end
