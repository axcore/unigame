---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_hot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_hot.init()

    return {
        description = "Hot ordinary cobblestone",
    }

end

function unilib.pkg.stone_ordinary_hot.exec()

    unilib.register_node("unilib:stone_ordinary_cobble_hot", "caverealms:hot_cobble", mode, {
        -- From caverealms:hot_cobble
        description = S("Molten Ordinary Cobblestone"),
        tiles = {"unilib_stone_ordinary_cobble_hot.png"},
        groups = {crumbly = 2, hot = 1},
        sounds = unilib.sound.generate_stone({
            footstep = {name="unilib_stone_footstep", gain = 0.25},
        }),

        damage_per_second = 1,
        light_source = 3,
    })

end
