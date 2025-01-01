---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lydia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lydia.init()

    return {
        description = "Lydia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_lydia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:lidia. Creates unilib:flower_lydia
        part_name = "lydia",
        orig_name = "beautiflowers:lidia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Lydia Flower"),
        dye = "red",
    })

end
