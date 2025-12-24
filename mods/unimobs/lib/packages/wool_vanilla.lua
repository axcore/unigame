---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.wool_vanilla = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.wool_vanilla.init()

    return {
        description = "Vanilla wool",
        notes = "Obtained by using shears on sheep with the \"vanilla\" skin (a mutation)",
    }

end

function unilib.pkg.wool_vanilla.exec()

    unilib.register_node("unilib:wool_vanilla", "petz:wool_vanilla", mode, {
        -- From petz:wool_vanilla
        description = S("Vanilla Wool"),
        tiles = {"unilib_wool_vanilla.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 3, snappy = 2, wool = 1},
        sounds = unilib.global.sound_table.node,

        is_ground_content = false,
    })
    core.register_alias("wool:vanilla", "unilib:wool_vanilla")

end
