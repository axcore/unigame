---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pyrite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pyrite_rock.init()

    return {
        description = "Pyrite rock (as mineral)",
        notes = "An alternative to the stone ores with pyrite",
        depends = "mineral_pyrite",
    }

end

function unilib.pkg.mineral_pyrite_rock.exec()

    local c_lump = "unilib:mineral_pyrite_lump"
    local hardness = unilib.global.mineral_table["pyrite"]["hardness"]

    unilib.register_mineral_rock("pyrite")

    unilib.register_node("unilib:mineral_pyrite_rock", nil, mode, {
        -- Texture from AATO, pyrite.png. Original code
        description = S("Pyrite Rock"),
        tiles = {"unilib_mineral_pyrite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_pyrite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
