---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_straw_plastered = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_straw_plastered.init()

    return {
        description = "Plastered straw bale",
        depends = "material_cob",
        at_least_one = {"misc_straw_ordinary", "roof_thatch"},
    }

end

function unilib.pkg.misc_straw_plastered.exec()

    unilib.register_node("unilib:misc_straw_plastered_bale", "earthbuild:strawbale", mode, {
        -- From earthbuild:strawbale
        description = S("Plastered Straw Bale"),
        tiles = {"unilib_material_wattle_and_daub.png"},
        groups = {crumbly = 1, falling_node = 1, snappy = 2},
        sounds = unilib.global.sound_table.dirt,

        drawtype = "normal",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
    })
    if unilib.global.pkg_executed_table["roof_thatch"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:strawbale
            output = "unilib:misc_straw_plastered_bale 6",
            recipe = {
                {"unilib:roof_thatch", "unilib:roof_thatch", "unilib:roof_thatch"},
                {"unilib:roof_thatch", "unilib:roof_thatch", "unilib:roof_thatch"},
                {"", "unilib:material_cob", ""},
            },
        })

    end
    if unilib.global.pkg_executed_table["misc_straw_ordinary"] ~= nil then

        local c_straw = "unilib:misc_straw_ordinary"

        unilib.register_craft({
            -- From earthbuild:strawbale
            output = "unilib:misc_straw_plastered_bale 6",
            recipe = {
                {c_straw, c_straw, c_straw},
                {c_straw, c_straw, c_straw},
                {"", "unilib:material_cob", ""},
            },
        })

    end

end
