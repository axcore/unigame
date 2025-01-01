---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_gravel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_gravel.init()

    return {
        description = "Gravel dirt",
        notes = "Similar to ordinary dirt, but does not spread grass",
        depends = {"dirt_ordinary", "gravel_ordinary"},
    }

end

function unilib.pkg.dirt_gravel.exec()

    unilib.register_node("unilib:dirt_gravel", "mtg_plus:graveldirt", mode, {
        -- From mtg_plus:graveldirt
        description = S("Gravel Dirt"),
        tiles = {"unilib_dirt_gravel.png"},
        groups = {crumbly = 2, level = 1, soil = 1},
        sounds = unilib.global.sound_table.dirt,

        drop = {
            items = {
                {items = {"unilib:gravel_ordinary"}},
                {items = {"unilib:dirt_ordinary"}},
            },
        },
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From mtg_plus:graveldirt
        type = "shapeless",
        output = "unilib:dirt_gravel",
        recipe = {"unilib:gravel_ordinary", "unilib:dirt_ordinary"},
    })

end
