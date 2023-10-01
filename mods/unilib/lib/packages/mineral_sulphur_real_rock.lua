---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sulphur_real_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sulphur_real_rock.init()

    return {
        description = "Real sulphur rock (as mineral)",
        notes = "An alternative to the stone ores with real sulphur",
        depends = "mineral_sulphur_real",
    }

end

function unilib.pkg.mineral_sulphur_real_rock.exec()

    local c_lump = "unilib:mineral_sulphur_real_lump"
    local hardness = unilib.mineral_table["sulphur_real"]["hardness"]

    unilib.register_mineral_rock("sulphur_real")

    unilib.register_node("unilib:mineral_sulphur_real_rock", nil, mode, {
        -- Texture from AATO, sulphur.png. Original code
        description = S("Real sulphur Rock"),
        tiles = {"unilib_mineral_sulphur_real_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_sulphur_real_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
