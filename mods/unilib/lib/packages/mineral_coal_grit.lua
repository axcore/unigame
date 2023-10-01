---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_coal_grit = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_coal_grit.init()

    return {
        description = "Gritty coal",
        notes = "Renamed from the original code\'s dust to grit, because a different coal dust" ..
                " already exists",
        depends = "mineral_coal",
    }

end

function unilib.pkg.mineral_coal_grit.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "coal_grit",
        description = S("Gritty Coal"),

        hardness = 1,
        no_lump_flag = true,
    })

    unilib.register_node("unilib:mineral_coal_grit", "caverealms:coal_dust", mode, {
        -- From caverealms:coal_dust
        description = S("Gritty Coal"),
        tiles = {"unilib_mineral_coal_grit.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })
    unilib.register_craft_3x3({
        -- From caverealms:coal_dust
        output = "unilib:mineral_coal_block",
        ingredient = "unilib:mineral_coal_grit",
    })

end
