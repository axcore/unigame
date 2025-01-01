---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_emerald = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_emerald.init()

    return {
        description = "Ordinary stone with emerald as ore",
        depends = {"mineral_emerald", "stone_ordinary"},
        optional = "machine_polishing",
    }

end

function unilib.pkg.stone_ordinary_with_emerald.exec()

    -- (Drop lumps instead of gems, if the polishing machine is available)
    local drop_name = "unilib:mineral_emerald_gem"
    if unilib.setting.underch_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then
        drop_name = "unilib:mineral_emerald_lump"
    end

    unilib.register_node("unilib:stone_ordinary_with_emerald", "underch:emerald_ore", mode, {
        -- From underch:emerald_ore
        description = unilib.utils.brackets(S("Emerald Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_emerald.png"},
        -- N.B. ore = 1 not in original code
        groups = {cracky = 2, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = drop_name,
    })

end
