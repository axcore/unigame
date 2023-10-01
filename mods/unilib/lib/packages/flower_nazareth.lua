---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_nazareth = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_nazareth.init()

    return {
        description = "Nazareth flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_nazareth.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:nazareth. Creates unilib:flower_nazareth
        part_name = "nazareth",
        orig_name = "beautiflowers:nazareth",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Nazareth Flower"),
        dye = "violet",
        sci_name = "Iris bismarckiana",
    })

end
