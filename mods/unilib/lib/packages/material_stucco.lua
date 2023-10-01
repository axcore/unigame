---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.material_stucco = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_stucco.init()

    return {
        description = "Stucco",
        depends = "stone_limestone_white",
    }

end

function unilib.pkg.material_stucco.exec()

    unilib.register_node("unilib:material_stucco_block", "decoblocks:stucco", mode, {
        -- From farlands, decoblocks:stucco
        description = S("Stucco Block"),
        tiles = {"unilib_material_stucco_block.png"},
        groups = {cracky = 3, stone = 2},
        sounds = unilib.sound_table.stone,
    })

end

function unilib.pkg.material_stucco.post()

    unilib.register_craft({
        -- From farlands, decoblocks:stucco
        type = "shapeless",
        output = "unilib:material_stucco_block 8",
        recipe = {
            "unilib:stone_limestone_white",
            "unilib:stone_limestone_white",
            "unilib:stone_limestone_white",
            "unilib:stone_limestone_white",
            -- N.B. In original code, group:water_bucket
            "group:craftable_bucket",
            "group:sand",
            "group:sand",
            "group:sand",
            "group:sand",
        },
        replacements = unilib.craftable_bucket_list,
    })

end
