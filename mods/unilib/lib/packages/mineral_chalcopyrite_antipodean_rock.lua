---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_chalcopyrite_antipodean_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_chalcopyrite_antipodean_rock.init()

    return {
        description = "Antipodean chalcopyrite rock (as mineral)",
        notes = "Drops copper. There is no non-rock package",
        depends = "metal_copper",
    }

end

function unilib.pkg.mineral_chalcopyrite_antipodean_rock.exec()

    local c_lump = "unilib:metal_copper_lump"
    local hardness = 2

    unilib.register_node(
        -- From aotearoa:chalcopyrite
        "unilib:mineral_chalcopyrite_antipodean_rock",
        "aotearoa:chalcopyrite",
        mode,
        {
            description = S("Antipodean Chalcopyrite Rock"),
            tiles = {"unilib_mineral_chalcopyrite_antipodean_rock.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            -- N.B. Tweaked the drop table to behave like other mineral-rocks
--          drop = "unilib:metal_copper_lump",
            drop = {
                max_items = 1,
                items = {
                    {
                        items = {"unilib:mineral_chalcopyrite_antipodean_rock"},
                        rarity = (100 * hardness),
                    },
                    {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                    {items = {c_lump}},
                },
            },
        }
    )

end
