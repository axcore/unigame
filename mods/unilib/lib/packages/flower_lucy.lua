---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lucy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lucy.init()

    return {
        description = "Lucy flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_lucy.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:lucia. Creates unilib:flower_lucy
        part_name = "lucy",
        orig_name = "beautiflowers:lucia",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Lucy Flower"),
        dye = "red",
    })

end
