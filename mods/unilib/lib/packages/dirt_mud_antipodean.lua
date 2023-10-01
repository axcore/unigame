---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mud_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mud_antipodean.init()

    return {
        description = "Antipodean mud",
        notes = "Wet and dry varities. Players can sink in the wet mud. The dry mud drops silt",
        depends = "sand_silt_antipodean",
    }

end

function unilib.pkg.dirt_mud_antipodean.exec()

    unilib.register_node("unilib:dirt_mud_antipodean_dry", "aotearoa:mud", mode, {
        -- From aotearoa:mud
        description = S("Dry Antipodean Mud"),
        tiles = {"unilib_dirt_mud_antipodean_dry.png"},
        groups = {crumbly = 3, puts_out_fire = 1},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
            dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
        }),

        drop = "unilib:sand_silt_antipodean",
        is_ground_content = unilib.caves_chop_dirt_flag,
    })

    unilib.register_node("unilib:dirt_mud_antipodean_wet", "aotearoa:mud_sinking", mode, {
        -- From aotearoa:mud_sinking
        description = S("Wet Antipodean Mud"),
        tiles = {
            {
                name = "unilib_dirt_mud_antipodean_wet_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            },
        },
        groups = {cools_lava = 1, crumbly = 3, puts_out_fire = 1},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_water_footstep", gain = 0.2},
            dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
        }),

        buildable_to = true,
        drop = "unilib:sand_silt_antipodean",
        drowning = 1,
        is_ground_content = unilib.caves_chop_dirt_flag,
        paramtype = "light",
        post_effect_color = {r = 20, g = 20, b = 20, a = 250},
        walkable = false,
    })

end
