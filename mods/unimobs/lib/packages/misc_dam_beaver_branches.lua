---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_dam_beaver_branches = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_dam_beaver_branches.init()

    return {
        description = "Beaver dam branches",
        notes = "A node used in the beaver dam schematic; if the setting is enabled, beavers" ..
                " at suitable locations will \"build a dam\" (place the schematic) about once" ..
                " an hour",
    }

end

function unilib.pkg.misc_dam_beaver_branches.exec()

    unilib.register_node("unilib:misc_dam_beaver_branches", "petz:beaver_dam_branches", mode, {
        -- From petz:beaver_dam_branches
        description = S("Beaver Dam Branches"),
        tiles = {"unilib_misc_dam_beaver_branches.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "allfaces_optional",
        is_ground_content = false,
        paramtype = "light",
        walkable = true,
    })

end
