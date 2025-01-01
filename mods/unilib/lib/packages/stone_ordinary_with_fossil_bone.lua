---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_fossil_bone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_fossil_bone.init()

    return {
        description = "Ordinary stone with bone fossil",
    }

end

function unilib.pkg.stone_ordinary_with_fossil_bone.exec()

    unilib.register_node("unilib:stone_ordinary_with_fossil_bone", "mapgen:stone_with_bone", mode, {
        -- From farlands, mapgen:stone_with_bone
        description = S("Ordinary Stone with Bone Fossil"),
        tiles = {"unilib_stone_ordinary_with_fossil_bone.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,
    })

end
