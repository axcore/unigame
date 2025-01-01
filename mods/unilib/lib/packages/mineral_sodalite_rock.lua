---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sodalite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sodalite_rock.init()

    return {
        description = "Sodalite rock (as mineral)",
        notes = "An alternative to the stone ores with sodalite",
        depends = "mineral_sodalite",
    }

end

function unilib.pkg.mineral_sodalite_rock.exec()

    local c_lump = "unilib:mineral_sodalite_lump"
    local hardness = unilib.global.mineral_table["sodalite"]["hardness"]

    unilib.register_mineral_rock("sodalite")

    unilib.register_node("unilib:mineral_sodalite_rock", nil, mode, {
        -- From decoblocks, default:sodalite
        description = S("Sodalite Rock"),
        tiles = {"unilib_mineral_sodalite_rock.png"},
        -- N.B. stone = 1 in original code, omitted here
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_sodalite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
