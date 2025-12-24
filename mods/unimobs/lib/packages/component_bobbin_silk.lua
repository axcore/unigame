---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.component_bobbin_silk = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.component_bobbin_silk.init()

    return {
        description = "Silk bobbin",
        depends = {"item_stick_ordinary", "misc_cocoon_silkworm"},
    }

end

function unilib.pkg.component_bobbin_silk.exec()

    local c_cocoon = "unilib:misc_cocoon_silkworm"
    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_craftitem("unilib:component_bobbin_silk", "petz:silk_bobbin", mode, {
        -- From petz:silk_bobbin
        description = S("Silk Bobbin"),
        inventory_image = "unilib_component_bobbin_silk.png",
        stack_max = 25,
    })
    unilib.register_craft({
        -- From petz:silk_bobbin
        type = "shaped",
        output = "unilib:component_bobbin_silk",
        recipe = {
            {c_cocoon, c_stick, c_cocoon},
            {c_cocoon, c_stick, c_cocoon},
            {c_cocoon, c_stick, c_cocoon},
        },
    })

end
