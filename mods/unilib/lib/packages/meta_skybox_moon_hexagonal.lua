---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_skybox_moon_hexagonal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_skybox_moon_hexagonal.init()

    return {
        description = "Replaces the default moon with a hexagonal moon",
    }

end

function unilib.pkg.meta_skybox_moon_hexagonal.exec()

    -- Original code; textures from farlands/mapgen
    core.register_on_joinplayer(function(player)
        player:set_moon({texture = "unilib_meta_skybox_moon_hexagonal.png"})
    end)

end
