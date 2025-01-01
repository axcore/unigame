---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_iron.init()

    return {
        description = "Desert stone with iron as ore",
        depends = {"metal_iron", "stone_desert"},
    }

end

function unilib.pkg.stone_desert_with_iron.exec()

    unilib.register_node(
        -- From darkage:desert_stone_with_iron
        "unilib:stone_desert_with_iron",
        "darkage:desert_stone_with_iron",
        mode,
        {
            description = unilib.utils.brackets(S("Iron Ore"), S("Desert Stone")),
            tiles = {"unilib_stone_desert.png^unilib_metal_iron.png"},
            -- N.B. ore = 1 not in original code
            groups = {cracky = 3, ore = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:metal_iron_lump",
        }
    )

end
