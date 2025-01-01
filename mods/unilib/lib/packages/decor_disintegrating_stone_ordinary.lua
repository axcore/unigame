---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_disintegrating_stone_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_disintegrating_stone_ordinary.init()

    return {
        description = "Disintegrating ordinary stone",
        notes = "Crumbles to dust when a player stands on it",
        depends = {"decor_stone_tiles", "stone_ordinary"},
        -- When the ABM package is loaded, disintegrating stones crumble to dust. To disable that
        --      effect, don't add the package to your remix
        optional = "abm_farlands_disintegrate",
    }

end

function unilib.pkg.decor_disintegrating_stone_ordinary.exec()

    unilib.register_node(
        -- From farlands, decoblocks:crumblestone
        "unilib:decor_disintegrating_stone_ordinary",
        "decoblocks:crumblestone",
        mode,
        {
            description = S("Disintegrating Ordinary Stone"),
            tiles = {"unilib_decor_disintegrating_stone_ordinary.png"},
            groups = {crumbly = 1},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code; added to match other decor items
            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- From farlands, decoblocks:crumblestone
        type = "shapeless",
        output = "unilib:decor_disintegrating_stone_ordinary 2",
        recipe = {
            "unilib:decor_stone_tiles",
            "unilib:stone_ordinary_cobble",
            "unilib:decor_stone_tiles",
        },
    })

end
