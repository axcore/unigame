---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_stephanite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_stephanite_rock.init()

    return {
        description = "Stephanite rock (as mineral)",
        notes = "An alternative to the stone ores with stephanite",
        depends = "mineral_stephanite",
    }

end

function unilib.pkg.mineral_stephanite_rock.exec()

    local c_lump = "unilib:mineral_stephanite_lump"
    local hardness = unilib.global.mineral_table["stephanite"]["hardness"]

    unilib.register_mineral_rock("stephanite")

    unilib.register_node("unilib:mineral_stephanite_rock", nil, mode, {
        -- Texture from AATO, stephanite.png. Original code
        description = S("Stephanite Rock"),
        tiles = {"unilib_mineral_stephanite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_stephanite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
