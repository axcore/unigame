---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_cement_industrial = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_cement_industrial.init()

    return {
        description = "Industrial cement",
        notes = "Used to produce industrial cement and concrete blocks",
        depends = {"dirt_ordinary", "dye_basic"},
    }

end

function unilib.pkg.material_cement_industrial.exec()

    unilib.register_craftitem(
        -- From basic_materials:wet_cement
        "unilib:material_cement_industrial_wet",
        {"basic_materials:wet_cement", "gloopblocks:wet_cement"},
        mode,
        {
            description = S("Wet Industrial Cement"),
            inventory_image = "unilib_material_cement_industrial_wet.png",
        }
    )

    unilib.register_node(
        -- From basic_materials:cement_block
        "unilib:material_cement_industrial_block",
        {"basic_materials:cement_block", "gloopblocks:cement"},
        mode,
        {
            description = S("Industrial Cement Block"),
            tiles = {"unilib_material_cement_industrial_block.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft({
        -- From basic_materials:cement_block
        type = "cooking",
        output = "unilib:material_cement_industrial_block",
        recipe = "unilib:material_cement_industrial_wet",
        cooktime = 8
    })

end

function unilib.pkg.material_cement_industrial.post()

    unilib.register_craft({
        -- From basic_materials:wet_cement
        type = "shapeless",
        output = "unilib:material_cement_industrial_wet 3",
        recipe = {
            "unilib:dirt_ordinary",
            "unilib:dye_grey_dark",
            "unilib:dye_grey_dark",
            "unilib:dye_grey_dark",
            "group:craftable_bucket",
        },
        replacements = unilib.craftable_bucket_list,
    })

end
