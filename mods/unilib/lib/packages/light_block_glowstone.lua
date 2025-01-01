---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_glowstone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_glowstone.init()

    return {
        description = "Glowstone lamp",
        depends = {"dye_basic", "torch_ordinary"},
    }

end

function unilib.pkg.light_block_glowstone.exec()

    unilib.register_node("unilib:light_block_glowstone", "ethereal:glostone", mode, {
        -- From ethereal:glostone
        description = S("Glowstone Lamp"),
        tiles = {"unilib_light_block_glowstone.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        light_source = 13,
    })
    unilib.register_craft({
        -- From ethereal:glostone
        output = "unilib:light_block_glowstone",
        -- N.B. unilib:stone_ordinary in original code
        recipe = {
            {"", "unilib:torch_ordinary", ""},
            {"unilib:torch_ordinary", "group:stone", "unilib:torch_ordinary"},
            {"", "unilib:dye_yellow", ""},
        },
    })

end
