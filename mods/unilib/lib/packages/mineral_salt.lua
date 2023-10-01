---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_salt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_salt.init()

    return {
        description = "Crystallised salt",
    }

end

function unilib.pkg.mineral_salt.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "salt",
        description = S("Salt"),

        hardness = 1,
        no_lump_flag = true,
    })

    unilib.register_node("unilib:mineral_salt_block", "caverealms:salt_crystal", mode, {
        -- From caverealms:salt_crystal
        description = S("Crystallised Salt Block"),
        tiles = {"unilib_mineral_salt_block.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        light_source = 11,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })

    unilib.register_node("unilib:mineral_salt_pure_block", "caverealms:stone_with_salt", mode, {
        -- From caverealms:stone_with_salt
        description = S("Crystallised Pure Salt Block"),
        tiles = {"unilib_mineral_salt_pure_block.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        light_source = 9,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })

end
