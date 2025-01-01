---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_red.init()

    return {
        description = "Red coral block",
        depends = {"coral_block_skeleton", "coral_seawhip_red", "shared_decorations_sea"},
    }

end

function unilib.pkg.coral_block_red.exec()

    unilib.register_block_coral({
        -- From decorations_sea:coral_05. Creates unilib:coral_block_red
        part_name = "red",
        orig_name = "decorations_sea:coral_05",

        replace_mode = mode,
        description = S("Red Coral Block"),
    })

    for i = 1, 3 do

        -- From decorations_sea/mapgen.lua
        unilib.pkg.shared_decorations_sea.register_coral_decoration("red_" .. i, "coral")

    end

end
