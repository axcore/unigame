---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriflame
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_artisanal_clear = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.abriflame.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_artisanal_clear.init()

    return {
        description = "Clear artisanal glass",
        notes = "Used in craft recipes for many other glasses",
    }

end

function unilib.pkg.glass_artisanal_clear.exec()

    unilib.register_node("unilib:glass_artisanal_clear", "abriglass:clear_glass", mode, {
        -- From abriglass:clear_glass
        description = S("Clear Artisanal Glass"),
        tiles = {"unilib_glass_artisanal_clear.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })
    -- Notes from abriglass: intentional lower yield
    minetest.register_craft({
        output = "unilib:glass_artisanal_clear 4",
        recipe = {
            {"unilib:glass_ordinary", "", "unilib:glass_ordinary"},
            {"", "unilib:glass_ordinary", ""},
            {"unilib:glass_ordinary", "", "unilib:glass_ordinary"},
        },
    })

end
