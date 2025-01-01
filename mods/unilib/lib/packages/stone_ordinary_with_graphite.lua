---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_graphite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_graphite.init()

    return {
        description = "Ordinary stone with graphite as ore",
        depends = {"mineral_graphite", "stone_ordinary"},
        optional = "mineral_coal",
    }

end

function unilib.pkg.stone_ordinary_with_graphite.exec()

    local drop_table = {
        max_items = 1,
        items = {
            {items = {"unilib:mineral_graphite_lump 2"}, rarity = 2},
            {items = {"unilib:mineral_graphite_lump"}},
        },
    }

    if unilib.global.pkg_executed_table["mineral_coal"] ~= nil then
        table.insert(drop_table.items, 1, {items = {"unilib:mineral_coal_lump"}, rarity = 10})
    end

    unilib.register_node(
        -- From real_minerals:graphite_in_default_stone
        "unilib:stone_ordinary_with_graphite",
        "real_minerals:graphite_in_default_stone",
        mode,
        {
            description = unilib.utils.brackets(S("Graphite Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^unilib_mineral_graphite.png"},
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = drop_table,
        }
    )

end
