---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_ant_misc = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_ant_misc.init()

    return {
        description = "Ant body parts",
    }

end

function unilib.pkg.organ_ant_misc.exec()

    unilib.register_craftitem("unilib:organ_ant_head", "petz:ant_head", mode, {
        -- From petz:ant_head
        description = S("Ant Head"),
        inventory_image = "unilib_organ_ant_head.png",
    })

    unilib.register_craftitem("unilib:organ_ant_body", "petz:ant_body", mode, {
        -- From petz:ant_body
        description = S("Ant Body"),
        inventory_image = "unilib_organ_ant_body.png",
    })

    unilib.register_craftitem("unilib:organ_ant_leg", "petz:ant_leg", mode, {
        -- From petz:ant_leg
        description = S("Ant Leg"),
        inventory_image = "unilib_organ_ant_leg.png",
    })

end
