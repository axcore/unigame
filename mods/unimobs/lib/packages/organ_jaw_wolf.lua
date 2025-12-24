---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_jaw_wolf = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_jaw_wolf.init()

    return {
        description = "Wolf jaw",
    }

end

function unilib.pkg.organ_jaw_wolf.exec()

    unilib.register_craftitem("unilib:organ_jaw_wolf", "petz:wolf_jaw", mode, {
        -- From petz:wolf_jaw
        description = S("Wolf Jaw"),
        inventory_image = "unilib_organ_jaw_wolf.png",
    })

end
