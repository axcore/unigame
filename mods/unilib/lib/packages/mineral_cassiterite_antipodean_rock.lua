---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_cassiterite_antipodean_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_cassiterite_antipodean_rock.init()

    return {
        description = "Antipodean cassiterite rock (as mineral)",
        notes = "Drops tin. There is no non-rock package",
        depends = "metal_tin",
    }

end

function unilib.pkg.mineral_cassiterite_antipodean_rock.exec()

    local c_lump = "unilib:metal_tin_lump"
    local hardness = 3

    unilib.register_node(
        -- From aotearoa:cassiterite
        "unilib:mineral_cassiterite_antipodean_rock",
        "aotearoa:cassiterite",
        mode,
        {
            description = S("Antipodean Cassiterite Rock"),
            tiles = {"unilib_mineral_cassiterite_antipodean_rock.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            -- N.B. Tweaked the drop table to behave like other mineral-rocks
    --      drop = "unilib:metal_tin_lump",
            drop = {
                max_items = 1,
                items = {
                    {
                        items = {"unilib:mineral_cassiterite_antipodean_rock"},
                        rarity = (100 * hardness),
                    },
                    {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                    {items = {c_lump}},
                },
            },
        }
    )

end
