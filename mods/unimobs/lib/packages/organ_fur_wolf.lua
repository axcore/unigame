---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_fur_wolf = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_fur_wolf.init()

    return {
        description = "Wolf fur",
    }

end

function unilib.pkg.organ_fur_wolf.exec()

    unilib.register_craftitem("unilib:organ_fur_wolf", "petz:wolf_fur", mode, {
        -- From petz:wolf_fur
        description = S("Wolf Fur"),
        inventory_image = "unilib_organ_fur_wolf.png",
        groups = {flammable = 2, leather = 1}
    })

end
