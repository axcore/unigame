---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_obscurite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_obscurite.init()

    return {
        description = "Obscurite",
    }

end

function unilib.pkg.stone_obscurite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "obscurite",
        description = S("Obscurite"),

        category = "other",
        fictional_flag = true,
        grinder_flag = false,
        hardness = 5,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_obscurite", "underch:obscurite", mode, {
        -- From underch:obscurite
        description = S("Obscurite"),
        tiles = {"unilib_stone_obscurite.png"},
        -- (no groups)
        sounds = unilib.sound_table.stone,
    })

    -- (no block/brick/cobble/rubble variants)

end
