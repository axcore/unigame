---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_geminitium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_geminitium.init()

    return {
        description = "Ordinary stone with geminitium as ore",
        depends = {"metal_geminitium", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_geminitium.exec()

    unilib.register_node(
        -- From xtraores:stone_with_geminitinum
        "unilib:stone_ordinary_with_geminitium",
        "xtraores:stone_with_geminitium",
        mode,
        {
            description = unilib.utils.brackets(S("Geminitium Ore"), S("Ordinary Stone")),
            tiles = {{
                name = "unilib_stone_ordinary.png^unilib_metal_geminitium.png",
                animation = {
                    type = "vertical_frames",
                    length = 2,
                    aspect_h = 16,
                    aspect_w = 16,
                },
            }},
            -- N.B. ore = 1 not in original code
            groups = {extrahard = 0, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:metal_geminitium_lump",
        }
    )

end
