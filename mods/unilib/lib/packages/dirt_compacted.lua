---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_compacted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_compacted.init()

    return {
        description = "Compacted dirt (for floors)",
        notes = "Created by using a dirt compactor tool on dirt",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.dirt_compacted.exec()

    unilib.register_node("unilib:dirt_compacted", "earthbuild:compacted_dirt", mode, {
        -- From earthbuild:compacted_dirt
        description = S("Compacted Dirt"),
        tiles = {"unilib_dirt_compacted.png"},
        groups = {crumbly = 2},
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_ordinary",
        -- N.B. is_ground_content = false not in original code; added to match other dirts
        is_ground_content = false,
    })

end
