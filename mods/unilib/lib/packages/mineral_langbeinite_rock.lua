---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_langbeinite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_langbeinite_rock.init()

    return {
        description = "Langbeinite rock (as mineral)",
        notes = "An alternative to the stone ores with langbeinite",
        depends = "mineral_langbeinite",
    }

end

function unilib.pkg.mineral_langbeinite_rock.exec()

    local c_lump = "unilib:mineral_langbeinite_lump"
    local hardness = unilib.mineral_table["langbeinite"]["hardness"]

    unilib.register_mineral_rock("langbeinite")

    unilib.register_node("unilib:mineral_langbeinite_rock", nil, mode, {
        -- Texture from AATO, langbeinite.png. Original code
        description = S("Langbeinite Rock"),
        tiles = {"unilib_mineral_langbeinite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_langbeinite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
