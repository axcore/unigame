---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cavern_amethyst = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cavern_amethyst.init()

    return {
        description = "Cavern amethyst",
        notes = "In the original code, these blocks are not ores (despite their original names)." ..
                " Instead, they are used to generate crystal structures. The structures have" ..
                " not been imported into unilib, so these items are now purely decorative",
    }

end

function unilib.pkg.misc_cavern_amethyst.exec()

    unilib.register_node("unilib:misc_cavern_amethyst_block", "caverealms:glow_amethyst", mode, {
        -- From caverealms:glow_amethyst
        description = S("Cavern Amethyst Block"),
        tiles = {"unilib_misc_cavern_amethyst_block.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike",
        light_source = 13,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })

    unilib.register_node(
        -- From caverealms:glow_amethyst_ore
        "unilib:misc_cavern_amethyst_embedded",
        "caverealms:glow_amethyst_ore",
        mode,
        {
            description = S("Embedded Cavern Amethyst"),
            tiles = {"unilib_misc_cavern_amethyst_embedded.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.glass,

            light_source = 10,
            paramtype = "light",
        }
    )

end
