---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.material_adobe = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_adobe.init()

    return {
        description = "Adobe",
        depends = {"clay_ordinary", "misc_straw_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.material_adobe.exec()

    unilib.register_node("unilib:material_adobe", "darkage:adobe", mode, {
        -- From darkage:adobe
        description = S("Adobe"),
        tiles = {"unilib_material_adobe.png"},
        groups = {crumbly = 3},
        sounds = unilib.global.sound_table.sand,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
    })
    unilib.register_craft({
        -- From darkage:adobe
        output = "unilib:material_adobe 4",
        recipe = {
            {"unilib:sand_ordinary", "unilib:sand_ordinary"},
            {"unilib:clay_ordinary_lump", "unilib:misc_straw_ordinary"},
        },
    })

end
