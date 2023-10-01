---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_mossy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_mossy.init()

    return {
        description = "Mossy gravel",
        depends = {"dirt_ordinary", "gravel_ordinary"},
    }

end

function unilib.pkg.gravel_mossy.exec()

    unilib.register_node("unilib:gravel_mossy", "underch:mossy_gravel", mode, {
        -- From underch:mossy_gravel
        description = S("Mossy Gravel"),
        tiles = {"unilib_gravel_mossy.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })
    unilib.register_craft({
        -- From underch:mossy_gravel
        type = "shapeless",
        output = "unilib:gravel_mossy 2",
        recipe = {"group:leaves", "group:leaves", "unilib:dirt_ordinary", "unilib:gravel_ordinary"},
    })

end
