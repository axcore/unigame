---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_wood_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_wood_ordinary.init()

    return {
        description = "Ordinary wooden ladder",
    }

end

function unilib.pkg.ladder_wood_ordinary.exec()

    unilib.register_ladder({
        -- From default:ladder_wood. Creates unilib:ladder_wood_ordinary
        part_name = "wood_ordinary",
        orig_name = "default:ladder_wood",
        ingredient = "group:stick",

        replace_mode = mode,
        description = S("Ordinary Wooden Ladder"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 3},
        multiple = 5,
        sound_name = "wood",
    })
    unilib.register_craft({
        -- From default:ladder_wood
        type = "fuel",
        recipe = "unilib:ladder_wood_ordinary",
        burntime = 7,
    })

end
