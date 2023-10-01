---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_pillar_bone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_pillar_bone.init()

    return {
        description = "Decorative bone pillar",
        depends = "item_bone",
    }

end

function unilib.pkg.decor_pillar_bone.exec()

    unilib.register_node("unilib:decor_pillar_bone", "decoblocks:bone_pillar", mode, {
        -- From farlands, decoblocks:bone_pillar
        description = S("Bone Pillar"),
        tiles = {
            "unilib_decor_pillar_bone_top.png",
            "unilib_decor_pillar_bone_top.png",
            "unilib_decor_pillar_bone.png",
        },
        groups = {cracky = 3, stone = 2},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })
    unilib.register_craft({
        -- From farlands, decoblocks:bone_pillar
        output = "unilib:decor_pillar_bone",
        recipe = {
            {"unilib:item_bone", "unilib:item_bone"},
            {"unilib:item_bone", "unilib:item_bone"},
        }
    })
    unilib.register_craft({
        -- Original to unilib, but marked as TODO in the original code
        output = "unilib:item_bone 4",
        recipe = {
            {"unilib:decor_pillar_bone"},
        },
    })

end
