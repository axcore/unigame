---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_iron_telluric_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_iron_telluric_rock.init()

    return {
        description = "Telluric iron rock (as mineral)",
        notes = "An alternative to the stone ores with telluric iron",
        depends = "mineral_iron_telluric",
    }

end

function unilib.pkg.mineral_iron_telluric_rock.exec()

    local c_lump = "unilib:mineral_iron_telluric_lump"
    local hardness = unilib.mineral_table["iron_telluric"]["hardness"]

    unilib.register_mineral_rock("iron_telluric")

    unilib.register_node("unilib:mineral_iron_telluric_rock", nil, mode, {
        -- Texture from AATO, telluric_iron.png. Original code
        description = S("Telluric Iron Mineral Rock"),
        tiles = {"unilib_mineral_iron_telluric_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_iron_telluric_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
