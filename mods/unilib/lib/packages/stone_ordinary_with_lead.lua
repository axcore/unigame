---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_lead = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_lead.init()

    return {
        description = "Ordinary stone with lead as ore",
        depends = {"metal_lead", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_lead.exec()

    unilib.register_node("unilib:stone_ordinary_with_lead", "technic:mineral_lead", mode, {
        -- From technic:mineral_lead
        description = unilib.brackets(S("Lead Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_metal_lead.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:metal_lead_lump",
    })

end
