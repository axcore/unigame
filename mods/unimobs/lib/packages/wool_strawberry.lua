---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.wool_strawberry = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.wool_strawberry.init()

    return {
        description = "Strawberry wool",
        notes = "Obtained by using shears on sheep with the \"strawberry\" skin (a mutation)",
    }

end

function unilib.pkg.wool_strawberry.exec()

    unilib.register_node("unilib:wool_strawberry", nil, mode, {
        -- Original to unimobs
        description = S("Strawberry Wool"),
        tiles = {"unilib_wool_strawberry.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 3, snappy = 2, wool = 1},
        sounds = unilib.global.sound_table.node,

        is_ground_content = false,
    })

end
