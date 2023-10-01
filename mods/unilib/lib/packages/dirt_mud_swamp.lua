---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    30biomes
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mud_swamp = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table["30biomes"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mud_swamp.init()

    return {
        description = "Swamp mud",
        notes = "Solid-looking mud into which the player slowly sinks",
    }

end

function unilib.pkg.dirt_mud_swamp.exec()

    unilib.register_node("unilib:dirt_mud_swamp", "30biomes:mud", mode, {
        -- From 30biomes:mud
        description = S("Swamp Mud"),
        tiles = {"unilib_dirt_mud_swamp.png"},
        groups = {crumbly = 2},
        sounds = unilib.sound_table.dirt,

        drowning = 1,
        is_ground_content = unilib.caves_chop_dirt_flag,
        liquid_alternative_flowing = "unilib:dirt_mud_swamp",
        liquid_alternative_source = "unilib:dirt_mud_swamp",
        liquid_renewable = false,
        liquid_viscosity = 8,
        liquid_range = 0,
        liquidtype = "source",
        post_effect_color = {r = 115, g = 61, b = 31, a = 255},
        walkable = false,
    })

end
