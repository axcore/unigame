---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_geminitinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_geminitinum.init()

    return {
        description = "Ordinary stone with geminitinum as ore",
        depends = {"metal_geminitinum", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_geminitinum.exec()

    unilib.register_node(
        -- From xtraores:stone_with_geminitinum
        "unilib:stone_ordinary_with_geminitinum",
        "xtraores:stone_with_geminitinum",
        mode,
        {
            description = unilib.brackets(S("Geminitinum Ore"), S("Ordinary Stone")),
            tiles = {{
                name = "unilib_stone_ordinary.png^unilib_metal_geminitinum.png",
                animation = {
                    type = "vertical_frames",
                    length = 2,
                    aspect_h = 16,
                    aspect_w = 16,
                },
            }},
            groups = {extrahard = 0},
            sounds = unilib.sound_table.stone,

            drop = "unilib:metal_geminitinum_lump",
        }
    )

end
