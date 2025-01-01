---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_diamond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_diamond.init()

    return {
        description = "Ordinary stone with diamond as ore",
        depends = {"mineral_diamond", "stone_ordinary"},
        optional = "machine_polishing",
    }

end

function unilib.pkg.stone_ordinary_with_diamond.exec()

    -- (Drop lumps instead of gems, if the polishing machine is available)
    local drop_name = "unilib:mineral_diamond_gem"
    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then
        drop_name = "unilib:mineral_diamond_lump"
    end

    unilib.register_node("unilib:stone_ordinary_with_diamond", "default:stone_with_diamond", mode, {
        -- From default:stone_with_diamond
        description = unilib.utils.brackets(S("Diamond Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_diamond.png"},
        -- N.B. ore = 1 not in original code
        groups = {cracky = 1, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = drop_name,
    })

end
