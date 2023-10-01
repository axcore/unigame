---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_adobe = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_adobe.init()

    return {
        description = "Adobe",
        depends = {"clay_ordinary", "misc_straw_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.misc_adobe.exec()

    unilib.register_node("unilib:misc_adobe", "darkage:adobe", mode, {
        -- From darkage:adobe
        description = S("Adobe"),
        tiles = {"unilib_misc_adobe.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.sand,
    })
    minetest.register_craft({
        -- From darkage:adobe
        output = "unilib:misc_adobe 4",
        recipe = {
            {"unilib:sand_ordinary", "unilib:sand_ordinary"},
            {"unilib:clay_ordinary_lump", "unilib:misc_straw_ordinary"},
        }
    })

end
