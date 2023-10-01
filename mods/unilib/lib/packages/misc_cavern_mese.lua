---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cavern_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cavern_mese.init()

    return {
        description = "Cavern mese",
        notes = "In the original code, these blocks are not ores (despite their original names)." ..
                " Instead, they are used to generate crystal structures. The structures have" ..
                " not been imported into unilib, so these items are now purely decorative",
        depends = "mushroom_mycena",
    }

end

function unilib.pkg.misc_cavern_mese.exec()

    local c_fragment = "unilib:mineral_mese_crystal_fragment"

    unilib.register_node("unilib:misc_cavern_mese_block", "caverealms:glow_mese", mode, {
        -- From caverealms:glow_mese
        description = S("Cavern Mese Block"),
        tiles = {"unilib_misc_cavern_mese_block.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        light_source = 13,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })
    unilib.register_craft({
        -- From caverealms:glow_mese
        output = "unilib:misc_cavern_mese_block",
        recipe = {
            {c_fragment, c_fragment, c_fragment},
            {c_fragment, "unilib:mushroom_mycena_powder", c_fragment},
            {c_fragment, c_fragment, c_fragment},
        }
    })
    unilib.register_craft({
        -- From caverealms:glow_mese
        output = c_fragment .. " 8",
        type = "shapeless",
        recipe = {"unilib:misc_cavern_mese_block"},
    })

end
