---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cavern_ruby = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cavern_ruby.init()

    return {
        description = "Cavern ruby",
        notes = "In the original code, these blocks are not ores (despite their original names)." ..
                " Instead, they are used to generate crystal structures. The structures have" ..
                " not been imported into unilib, so these items are now purely decorative",
    }

end

function unilib.pkg.misc_cavern_ruby.exec()

    unilib.register_node("unilib:misc_cavern_ruby_block", "caverealms:glow_ruby", mode, {
        -- From caverealms:glow_ruby
        description = S("Cavern Ruby Block"),
        tiles = {"unilib_misc_cavern_ruby_block.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        light_source = 13,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })

    unilib.register_node("unilib:misc_cavern_ruby_embedded", "caverealms:glow_ruby_ore", mode, {
        -- From caverealms:glow_ruby_ore
        description = S("Embedded Cavern Ruby"),
        tiles = {"unilib_misc_cavern_ruby_embedded.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.glass,

        is_ground_content = true,
        light_source = 10,
        paramtype = "light",
    })

end
