---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_terracotta = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_terracotta.init()

    return {
        description = "Terracotta",
        depends = {"clay_ordinary", "gravel_ordinary"},
    }

end

function unilib.pkg.material_terracotta.exec()

    unilib.register_craftitem(
        -- From basic_materials:terracotta_base
        "unilib:material_terracotta_base",
        {"basic_materials:terracotta_base", "homedecor:terracotta_base"},
        mode,
        {
            description = S("Uncooked Terracotta Base"),
            inventory_image = "unilib_material_terracotta_base.png",
        }
    )

end

function unilib.pkg.material_terracotta.post()

    unilib.register_craft({
        -- From basic_materials:terracotta_base
        type = "shapeless",
        output = "unilib:material_terracotta_base 8",
        recipe = {"group:craftable_bucket", "unilib:clay_ordinary_lump", "unilib:gravel_ordinary"},
        replacements = unilib.global.craftable_bucket_list,
    })

end
