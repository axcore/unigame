---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_omphyrite_extra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_omphyrite_extra.init()

    return {
        description = "Extra omphyrite items",
        depends = {"liquid_lava_ordinary", "stone_omphyrite"},
    }

end

function unilib.pkg.stone_omphyrite_extra.exec()

    unilib.register_node("unilib:stone_omphyrite_crack_lava", "underch:lava_crack", mode, {
        -- From underch:lava_crack
        description = S("Omphyrite Lava Crack"),
        tiles = {"unilib_stone_omphyrite.png^unilib_crack_lava_overlay.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:stone_omphyrite_cobble",
        light_source = 12,

        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            core.place_node(pos, {name = "unilib:liquid_lava_ordinary_source"}, digger)
        end
    })

end
