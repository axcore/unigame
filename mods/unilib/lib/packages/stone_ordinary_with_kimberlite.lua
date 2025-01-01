---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_kimberlite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_kimberlite.init()

    return {
        description = "Ordinary stone with kimberlite as ore",
        depends = {"mineral_kimberlite", "stone_ordinary"},
        optional = {"machine_polishing", "mineral_diamond"},
    }

end

function unilib.pkg.stone_ordinary_with_kimberlite.exec()

    -- (Drop lumps instead of gems, if the polishing machine is available)
    local drop_name = "unilib:mineral_diamond_gem"
    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then
        drop_name = "unilib:mineral_diamond_lump"
    end

    local drop_table = {
        max_items = 1,
        items = {
            {items = {"unilib:mineral_kimberlite_lump 2"}, rarity = 2},
            {items = {"unilib:mineral_kimberlite_lump"}},
        },
    }

    if unilib.global.pkg_executed_table["mineral_coal"] ~= nil then
        table.insert(drop_table.items, 1, {items = {drop_name}, rarity = 100})
    end

    unilib.register_node(
        -- From real_minerals:kimberlite_in_default_stone
        "unilib:stone_ordinary_with_kimberlite",
        "real_minerals:kimberlite_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Kimberlite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_kimberlite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = drop_table,
        }
    )

end
