---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.roof_slate_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.roof_slate_normal.init()

    return {
        description = "Normal roofing slates",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.roof_slate_normal.exec()

    unilib.register_node("unilib:roof_slate_normal", "cottages:slate_vertical", mode, {
        -- From cottages:slate_vertical
        description = S("Normal Roofing Slates"),
        tiles = {
            "unilib_roof_slate_normal.png",
            "unilib_tree_apple_wood.png",
            "unilib_roof_slate_normal.png",
            "unilib_roof_slate_normal.png",
            "unilib_tree_apple_wood.png",
            "unilib_roof_slate_normal.png",
        },
        groups = {cracky = 2, stone = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From cottages:slate_vertical
        output = "unilib:roof_slate_normal",
        recipe = {
            {"unilib:stone_ordinary", "group:wood"},
        }
    })

end
