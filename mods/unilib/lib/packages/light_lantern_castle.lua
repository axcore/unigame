---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_lighting
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_castle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_lighting.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_castle.init()

    return {
        description = "Castle lantern",
        depends = {"item_stick_ordinary", "glass_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_castle.exec()

    unilib.register_node("unilib:light_lantern_castle", "castle_lighting:light", mode, {
        -- From castle_lighting:light
        description = S("Castle Lantern"),
        tiles = {"unilib_light_lantern_castle.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        light_source = 14,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From castle_lighting:light
        output = "unilib:light_lantern_castle",
        recipe = {
            {"unilib:item_stick_ordinary", "unilib:glass_ordinary", "unilib:item_stick_ordinary"},
            {"unilib:glass_ordinary", "unilib:torch_ordinary", "unilib:glass_ordinary"},
            {"unilib:item_stick_ordinary", "unilib:glass_ordinary", "unilib:item_stick_ordinary"},
        }
    })

end
