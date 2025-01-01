---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_limonite_antipodean_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_limonite_antipodean_rock.init()

    return {
        description = "Antipodean limonite rock (as mineral)",
        notes = "Drops iron. There is no non-rock package",
        depends = "metal_iron",
    }

end

function unilib.pkg.mineral_limonite_antipodean_rock.exec()

    local c_lump = "unilib:metal_iron_lump"
    local hardness = 1

    unilib.register_node("unilib:mineral_limonite_antipodean_rock", "aotearoa:limonite", mode, {
        -- From aotearoa:limonite
        description = S("Antipodean Limonite Rock"),
        tiles = {"unilib_mineral_limonite_antipodean_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        -- N.B. Tweaked the drop table to behave like other mineral-rocks
--      drop = "unilib:metal_iron_lump",
        drop = {
            max_items = 1,
            items = {
                {
                    items = {"unilib:mineral_limonite_antipodean_rock"},
                    rarity = (100 * hardness),
                },
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
