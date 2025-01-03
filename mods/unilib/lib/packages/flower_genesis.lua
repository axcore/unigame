---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_genesis = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_genesis.init()

    return {
        description = "Genesis flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_genesis.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:genesis. Creates unilib:flower_genesis
        part_name = "genesis",
        orig_name = "beautiflowers:genesis",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Genesis Flower"),
        dye = "white",
    })

end
