---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.bed_primitive = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bed_primitive.init()

    return {
        description = "Primitive bed",
        depends = {"roof_thatch", "shared_beds"},
    }

end

function unilib.pkg.bed_primitive.exec()

    unilib.pkg.shared_beds.register_bed({
        -- From earthbuild:primitive_bed. Creates unilib:bed_primitive
        part_name = "primitive",
        orig_name_list = {"earthbuild:primitive_bed_bottom", "earthbuild:primitive_bed_top"},
        recipe_table = {
            {"unilib:roof_thatch", "unilib:roof_thatch", "unilib:roof_thatch"},
            {"group:wood", "group:wood", "group:wood"},
        },
        tile_table = {
            bottom = {
                "unilib_roof_thatch.png^[transformR90",
                "unilib_tree_apple_wood.png",
                "unilib_bed_primitive_side.png",
                "unilib_bed_primitive_side.png^[transformfx",
                "unilib_bed_primitive_side.png",
            },
            top = {
                "unilib_roof_thatch.png^[transformR90",
                "unilib_tree_apple_wood.png",
                "unilib_bed_primitive_side.png",
                "unilib_bed_primitive_side.png^[transformfx",
                "unilib_bed_primitive_side.png",
            },
        },

        replace_mode = mode,
        description = S("Primitive Bed"),
        inventory_image = "unilib_bed_primitive_inv.png",
        node_table = {
            bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
            top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
        },
        select_table = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
        wield_image = "unilib_bed_primitive_inv.png",
    })

end
