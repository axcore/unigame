---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_ordinary_with_algae = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_ordinary_with_algae.init()

    return {
        description = "Ordinary gravel with algae",
        depends = {"mineral_flint", "gravel_ordinary"},
    }

end

function unilib.pkg.gravel_ordinary_with_algae.exec()

    unilib.register_node("unilib:gravel_ordinary_with_algae", "aotearoa:gravel_with_algae", mode, {
        -- From aotearoa:gravel_with_algae
        description = S("Gravel with Algae"),
        tiles = {"unilib_gravel_ordinary_with_algae.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.gravel,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_flint_lump"}, rarity = 16},
                {items = {"unilib:gravel_ordinary"}},
            },
        },
    })

end
