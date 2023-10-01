---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cavern_emerald = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cavern_emerald.init()

    return {
        description = "Cavern emerald",
        notes = "In the original code, these blocks are not ores (despite their original names)." ..
                " Instead, they are used to generate crystal structures. The structures have" ..
                " not been imported into unilib, so these items are now purely decorative",
    }

end

function unilib.pkg.misc_cavern_emerald.exec()

    unilib.register_node("unilib:misc_cavern_emerald_block", "caverealms:glow_emerald", mode, {
        -- From caverealms:glow_emerald
        description = S("Cavern Emerald Block"),
        tiles = {"unilib_misc_cavern_emerald_block.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        light_source = 13,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })

    unilib.register_node(
        -- From caverealms:glow_emerald_ore
        "unilib:misc_cavern_emerald_embedded",
        "caverealms:glow_emerald_ore",
        mode,
        {
            description = S("Embedded Cavern Emerald"),
            tiles = {"unilib_misc_cavern_emerald_embedded.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.glass,

            light_source = 10,
            paramtype = "light",
        }
    )

end
