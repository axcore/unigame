---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_copper_dense = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_copper_dense.init()

    return {
        description = "Ordinary stone with copper as dense ore",
        depends = {"metal_copper", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_copper_dense.exec()

    local img = "unilib_metal_copper.png"

    unilib.register_node(
        -- From underch:copper_dense_ore
        "unilib:stone_ordinary_with_copper_dense",
        "underch:copper_dense_ore",
        mode,
        {
            description = unilib.brackets(S("Dense Copper Ore"), S("Ordinary Stone")),
            tiles = {"unilib_stone_ordinary.png^" .. img .. "^(" .. img .. "^[transform7)"},
            groups = {cracky = 1},
            sounds = unilib.sound_table.stone,

            drop = {
                items = {
                    {items = {"unilib:metal_copper_lump" .. " 2"}},
                    {items = {"unilib:metal_copper_lump"}, rarity = 2},
                }
            },
        }
    )

end
