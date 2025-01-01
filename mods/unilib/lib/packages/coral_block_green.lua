---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_green.init()

    return {
        description = "Green coral block",
        depends = {"coral_block_skeleton", "coral_seawhip_green", "shared_decorations_sea"},
    }

end

function unilib.pkg.coral_block_green.exec()

    unilib.register_block_coral({
        -- From decorations_sea:coral_08. Creates unilib:coral_block_green
        part_name = "green",
        orig_name = "decorations_sea:coral_08",

        replace_mode = mode,
        description = S("Green Coral Block"),
    })

    for i = 1, 3 do

        -- From decorations_sea/mapgen.lua
        unilib.pkg.shared_decorations_sea.register_coral_decoration("green_" .. i, "coral")

    end

end
