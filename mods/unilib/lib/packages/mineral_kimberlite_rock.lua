---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_kimberlite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_kimberlite_rock.init()

    return {
        description = "Kimberlite rock (as mineral)",
        notes = "An alternative to the stone ores with kimberlite",
        depends = "mineral_kimberlite",
        optional = {"machine_polishing", "mineral_diamond"},
    }

end

function unilib.pkg.mineral_kimberlite_rock.exec()

    local c_lump = "unilib:mineral_kimberlite_lump"
    local c_gem = "unilib:mineral_diamond_gem"
    local hardness = unilib.global.mineral_table["kimberlite"]["hardness"]

    local drop_table = {
        max_items = 1,
        items = {
            {items = {"unilib:mineral_kimberlite_rock"}, rarity = (100 * hardness)},
            {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
            {items = {c_lump}},
        },
    }

    if unilib.global.pkg_executed_table["mineral_diamond"] ~= nil then

        -- (Drop lumps instead of gems, if the polishing machine is available)
        if unilib.setting.mtgame_tweak_flag and
                unilib.global.pkg_executed_table["machine_polishing"] ~= nil then
            c_gem = "unilib:mineral_diamond_lump"
        end

        table.insert(drop_table.items, 3, {items = {c_gem}, rarity = (100 * hardness)})

    end

    unilib.register_mineral_rock("kimberlite")

    unilib.register_node("unilib:mineral_kimberlite_rock", nil, mode, {
        -- Texture from AATO, kimberlite.png. Original code
        description = S("Kimberlite Rock"),
        tiles = {"unilib_mineral_kimberlite_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = drop_table,
    })

end
