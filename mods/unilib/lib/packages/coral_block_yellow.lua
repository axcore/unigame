---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_yellow.init()

    return {
        description = "Yellow coral block",
        depends = {"coral_block_skeleton", "coral_seawhip_yellow", "shared_decorations_sea"},
    }

end

function unilib.pkg.coral_block_yellow.exec()

    unilib.register_block_coral({
        -- From decorations_sea:coral_06. Creates unilib:coral_block_yellow
        part_name = "yellow",
        orig_name = "decorations_sea:coral_06",

        replace_mode = mode,
        description = S("Yellow Coral Block"),
    })

    for i = 1, 3 do

        -- From decorations_sea/mapgen.lua
        unilib.pkg.shared_decorations_sea.register_coral_decoration("yellow_" .. i, "coral")

    end

end
