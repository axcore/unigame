---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_copper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_copper.init()

    return {
        description = "Copper ladder",
        depends = "metal_copper",
    }

end

function unilib.pkg.ladder_copper.exec()

    unilib.register_ladder({
        -- From mtg_plus:ladder_copper. Creates unilib:ladder_copper
        part_name = "copper",
        orig_name = "mtg_plus:ladder_copper",
        ingredient = "unilib:metal_copper_ingot",

        replace_mode = mode,
        description = S("Copper Ladder"),
        group_table = {cracky = 2},
        multiple = 15,
        sound_name = "metal",
    })

end
