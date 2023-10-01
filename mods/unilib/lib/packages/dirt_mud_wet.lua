---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mud_wet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mud_wet.init()

    return {
        description = "Wet mud",
        notes = "Players will sink slowly and take damage",
    }

end

function unilib.pkg.dirt_mud_wet.exec()

    unilib.register_node("unilib:dirt_mud_wet", "lib_materials:mud_wet", mode, {
        -- From GLEMr6, lib_materials:mud_wet
        description = S("Wet Mud"),
        tiles = {"unilib_dirt_mud_wet.png"},
        groups = {crumbly = 2},
        sounds = unilib.sound_table.dirt,

        drowning = 1,
        is_ground_content = unilib.caves_chop_dirt_flag,
        liquid_alternative_flowing = "unilib:dirt_mud_wet",
        liquid_alternative_source = "unilib:dirt_mud_wet",
        liquid_range = 0,
        liquid_renewable = false,
        liquid_viscosity = 8,
        liquidtype = "source",
        post_effect_color = {r = 115, g = 61, b = 31, a = 255},
        walkable = false,
    })

end
