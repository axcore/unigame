---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_rammed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_rammed.init()

    return {
        description = "Rammed earth",
        at_least_one = {"dirt_dry", "dirt_ordinary"},
    }

end

function unilib.pkg.dirt_rammed.exec()

    unilib.register_node("unilib:dirt_rammed", "earthbuild:rammed_earth", mode, {
        -- From earthbuild:rammed_earth
        description = S("Rammed Earth"),
        tiles = {
            "unilib_dirt_rammed_top.png",
            "unilib_dirt_rammed_side.png",
            "unilib_dirt_rammed_side.png",
            "unilib_dirt_rammed_side.png",
            "unilib_dirt_rammed_side.png",
            "unilib_dirt_rammed_side.png"
        },
        groups = {cracky = 3, crumbly = 1, falling_node = 1},
        sounds = unilib.sound_table.dirt,

        drawtype = "normal",
        paramtype = "light",
    })
    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:rammed_earth
            output = "unilib:dirt_rammed",
            recipe = {
                {"unilib:dirt_ordinary"},
                {"unilib:dirt_ordinary"},
                {"unilib:dirt_ordinary"},
            },
        })

    end
    if unilib.pkg_executed_table["dirt_dry"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:rammed_earth
            output = "unilib:dirt_rammed",
            recipe = {
                {"unilib:dirt_dry"},
                {"unilib:dirt_dry"},
                {"unilib:dirt_dry"},
            },
        })

    end
    unilib.register_stairs("unilib:dirt_rammed", {
        basic_flag = true,
    })

end
