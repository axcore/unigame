---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_shell_turtle = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_shell_turtle.init()

    return {
        description = "Turtle shell",
    }

end

function unilib.pkg.organ_shell_turtle.exec()

    unilib.register_craftitem("unilib:organ_shell_turtle", "petz:turtle_shell", mode, {
        -- From petz:turtle_shell
        description = S("Turtle Shell"),
        inventory_image = "unilib_organ_shell_turtle.png",
        groups = {},

        wield_image = "unilib_organ_shell_turtle.png",
    })

end
