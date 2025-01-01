---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sulphur_rare_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sulphur_rare_rock.init()

    return {
        description = "Rare sulphur rock (as mineral)",
        notes = "An alternative to the stone ores with rare sulphur",
        depends = "mineral_sulphur_rare",
    }

end

function unilib.pkg.mineral_sulphur_rare_rock.exec()

    local c_lump = "unilib:mineral_sulphur_rare_lump"
    local hardness = unilib.global.mineral_table["sulphur_rare"]["hardness"]

    unilib.register_mineral_rock("sulphur_rare")

    unilib.register_node("unilib:mineral_sulphur_rare_rock", nil, mode, {
        -- Texture from AATO, sulphur.png. Original code
        description = S("Rare sulphur Rock"),
        tiles = {"unilib_mineral_sulphur_rare_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_sulphur_rare_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
