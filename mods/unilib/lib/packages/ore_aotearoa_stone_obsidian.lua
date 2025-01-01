---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_obsidian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_obsidian.init()

    return {
        description = "Obsidian as ore",
        depends = "stone_obsidian",
        at_least_one = {
            "stone_andesite_antipodean",
            "stone_basalt_black",
            "stone_granite_antipodean",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.ore_aotearoa_stone_obsidian.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_obsidian",
        wherein                 = {
            "unilib:stone_andesite_antipodean",
            "unilib:stone_basalt_black",
            "unilib:stone_granite_antipodean",
            "unilib:stone_ordinary",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 10,
        noise_params            = {
            octaves = 1,
            offset = 0,
            persist = 0.0,
            scale = 1,
            seed = -316,
            spread = {x = 15, y = 15, z = 15},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = unilib.constant.y_min,
    })

end
