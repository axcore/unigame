---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_silt = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_silt.init()

    return {
        description = "Silty sand",
        optional = {"clay_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.sand_silt.exec()

    unilib.register_node("unilib:sand_silt", "darkage:silt", mode, {
        -- From darkage:silt
        description = S("Silty Sand"),
        tiles = {"unilib_sand_silt.png"},
        -- N.B. sand = 1 not in original code
        groups = {crumbly = 3, sand = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = "",
        }),

        drop = "unilib:sand_silt_lump 4",
    })
    unilib.register_craft_2x2({
        -- From darkage:silt
        output = "unilib:sand_silt",
        ingredient = "unilib:sand_silt_lump",
    })
    if unilib.global.pkg_executed_table["clay_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_craft({
            -- From darkage:silt
            output = "unilib:sand_silt 3",
            recipe = {
                {"unilib:sand_ordinary", "unilib:sand_ordinary"},
                {"unilib:clay_ordinary_lump", "unilib:clay_ordinary_lump"},
            },
        })

    end

    unilib.register_craftitem("unilib:sand_silt_lump", "darkage:silt_lump", mode, {
        -- From darkage:silt_lump
        description = S("Silt Lump"),
        inventory_image = "unilib_sand_silt_lump.png",
    })

end
