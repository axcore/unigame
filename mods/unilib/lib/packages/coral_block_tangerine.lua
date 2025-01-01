---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_tangerine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_tangerine.init()

    return {
        description = "Tangerine coral block",
        depends = {"coral_block_skeleton", "shared_decorations_sea"},
    }

end

function unilib.pkg.coral_block_tangerine.exec()

    unilib.register_block_coral({
        -- From decorations_sea:coral_02. Creates unilib:coral_block_tangerine
        part_name = "tangerine",
        orig_name = "decorations_sea:coral_02",

        replace_mode = mode,
        description = S("Tangerine Coral Block"),
    })

    for i = 1, 3 do

        -- From decorations_sea/mapgen.lua
        unilib.pkg.shared_decorations_sea.register_coral_decoration("tangerine_" .. i, "coral")

    end

end
