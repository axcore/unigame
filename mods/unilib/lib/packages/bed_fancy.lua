---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beds
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bed_fancy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beds.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bed_fancy.init()

    return {
        description = "Fancy bed",
        depends = "wool_basic",
    }

end

function unilib.pkg.bed_fancy.exec()

    local recipe_table = {}
    if not unilib.mtgame_tweak_flag then

        -- Current minetest_game recipe
        recipe_table = {
            {"", "", "group:stick"},
            {"unilib:wool_white", "unilib:wool_white", "unilib:wool_white"},
            {"group:wood", "group:wood", "group:wood"}
        }

    else

        -- Traditional recipe
        recipe_table = {
            {"", "", "group:stick"},
            {"unilib:wool_red", "unilib:wool_red", "unilib:wool_white"},
            {"group:wood", "group:wood", "group:wood"}
        }

    end

    unilib.register_bed({
        -- From beds:fancy_bed. Creates unilib:bed_fancy
        part_name = "fancy",
        orig_name = {"beds:fancy_bed_bottom", "beds:fancy_bed_top"},
        recipe_table = recipe_table,
        tile_table = {
            bottom = {
                "unilib_bed_generic_top1.png",
                "unilib_bed_generic_under.png",
                "unilib_bed_generic_side1.png",
                "unilib_bed_generic_side1.png^[transformFX",
                "unilib_bed_generic_foot.png",
            },
            top = {
                "unilib_bed_generic_top2.png",
                "unilib_bed_generic_under.png",
                "unilib_bed_generic_side2.png",
                "unilib_bed_generic_side2.png^[transformFX",
                "unilib_bed_generic_head.png",
            }
        },

        replace_mode = mode,
        burntime = 12,
        description = S("Fancy Bed"),
        inventory_image = "unilib_bed_fancy_inv.png",
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
            }
        },
        select_table = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
        wield_image = "unilib_bed_fancy_inv.png",
    })

end
