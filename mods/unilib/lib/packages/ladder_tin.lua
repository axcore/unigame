---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_tin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_tin.init()

    return {
        description = "Tin ladder",
        depends = "metal_tin",
    }

end

function unilib.pkg.ladder_tin.exec()

    unilib.register_ladder({
        -- From mtg_plus:ladder_tin. Creates unilib:ladder_tin
        part_name = "tin",
        orig_name = "mtg_plus:ladder_tin",
        ingredient = "unilib:metal_tin_ingot",

        replace_mode = mode,
        description = S("Tin Ladder"),
        group_table = {cracky = 2},
        multiple = 15,
        sound_name = "metal",
    })

end
