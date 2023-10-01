---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_coal_dense = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_coal_dense.init()

    return {
        description = "Ordinary stone with coal as dense ore",
        depends = {"mineral_coal", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_coal_dense.exec()

    local img = "unilib_mineral_coal.png"

    unilib.register_node("unilib:stone_ordinary_with_coal_dense", "underch:coal_dense_ore", mode, {
        -- From underch:coal_dense_ore
        description = unilib.brackets(S("Dense Coal Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^" .. img .. "^(" .. img .. "^[transform7)"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = {
            items = {
                {items = {"unilib:mineral_coal_lump" .. " 2"}},
                {items = {"unilib:mineral_coal_lump"}, rarity = 2},
            }
        },
    })

end
