---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_obsidian_hot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_obsidian_hot.init()

    return {
        description = "Hot obsidian",
    }

end

function unilib.pkg.stone_obsidian_hot.exec()

    unilib.register_node("unilib:stone_obsidian_hot", "caverealms:glow_obsidian", mode, {
        -- From caverealms:glow_obsidian
        description = S("Hot Obsidian"),
        tiles = {"unilib_stone_obsidian_hot.png"},
        groups = {crumbly = 1},
        sounds = unilib.sound.generate_stone({
            footstep = {name = "unilib_stone_footstep", gain = 0.25},
        }),

        light_source = 7,
    })

    unilib.register_node("unilib:stone_obsidian_molten", "caverealms:glow_obsidian_2", mode, {
        -- From caverealms:glow_obsidian_2
        description = S("Molten Obsidian"),
        tiles = {"unilib_stone_obsidian_molten.png"},
        groups = {crumbly = 1, hot = 1},
        sounds = unilib.sound.generate_stone({
            footstep = {name = "unilib_stone_footstep", gain = 0.25},
        }),

        damage_per_second = 1,
        light_source = 9,
    })

end
