---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_steel.init()

    return {
        description = "Steel ladder",
        depends = "metal_steel",
    }

end

function unilib.pkg.ladder_steel.exec()

    unilib.register_ladder({
        -- From default:ladder_steel. Creates unilib:ladder_steel
        part_name = "steel",
        orig_name = "default:ladder_steel",
        ingredient = "unilib:metal_steel_ingot",

        replace_mode = mode,
        description = S("Steel Ladder"),
        group_table = {cracky = 2},
        multiple = 15,
        sound_name = "metal",
    })

end
