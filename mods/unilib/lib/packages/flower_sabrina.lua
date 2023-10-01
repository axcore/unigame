---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_sabrina = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_sabrina.init()

    return {
        description = "Sabrina flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_sabrina.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:sabrina. Creates unilib:flower_sabrina
        part_name = "sabrina",
        orig_name = "beautiflowers:sabrina",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Sabrina Flower"),
        dye = "red",
    })

end
