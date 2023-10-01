---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beds
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bed_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beds.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bed_ordinary.init()

    return {
        description = "Ordinary bed",
        depends = "wool_basic",
    }

end

function unilib.pkg.bed_ordinary.exec()

    local recipe_table = {}
    if not unilib.mtgame_tweak_flag then

        -- Current minetest_game recipe
        recipe_table = {
            {"", "", ""},
            {"unilib:wool_white", "unilib:wool_white", "unilib:wool_white"},
            {"group:wood", "group:wood", "group:wood"}
        }

    else

        -- Traditional recipe
        recipe_table = {
            {"", "", ""},
            {"unilib:wool_red", "unilib:wool_red", "unilib:wool_white"},
            {"group:wood", "group:wood", "group:wood"}
        }

    end

    unilib.register_bed({
        -- From beds:bed. Creates unilib:bed_ordinary
        part_name = "ordinary",
        orig_name = {"beds:bed_bottom", "beds:bed_top"},
        recipe_table = recipe_table,
        tile_table = {
            bottom = {
                "unilib_bed_generic_top_bottom.png^[transformR90",
                "unilib_bed_generic_under.png",
                "unilib_bed_generic_side_bottom_r.png",
                "unilib_bed_generic_side_bottom_r.png^[transformfx",
                "blank.png",
                "unilib_bed_generic_side_bottom.png"
            },
            top = {
                "unilib_bed_generic_top_top.png^[transformR90",
                "unilib_bed_generic_under.png",
                "unilib_bed_generic_side_top_r.png",
                "unilib_bed_generic_side_top_r.png^[transformfx",
                "unilib_bed_generic_side_top.png",
                "blank.png",
            }
        },

        replace_mode = mode,
        burntime = 12,
        description = S("Ordinary Bed"),
        inventory_image = "unilib_bed_ordinary_inv.png",
        node_table = {
            bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
            top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
        },
        select_table = {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5},
        wield_image = "unilib_bed_ordinary_inv.png",
    })

end
