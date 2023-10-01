---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_cassandra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_cassandra.init()

    return {
        description = "Cassandra flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_cassandra.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:casandra. Creates unilib:flower_cassandra
        part_name = "cassandra",
        orig_name = "beautiflowers:casandra",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Cassandra Flower"),
        dye = "blue",
    })

end
