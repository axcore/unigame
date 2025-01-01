---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ice_thin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ice_thin.init()

    return {
        description = "Thin ice",
    }

end

function unilib.pkg.ice_thin.exec()

    local img = "unilib_ice_ordinary.png^[opacity:80"

    unilib.register_node("unilib:ice_thin", "ethereal:thin_ice", mode, {
        -- From ethereal:thin_ice
        description = S("Thin Ice"),
        tiles = {img},
        groups = {cools_lava = 1, cracky = 3, crumbly = 3, slippery = 3},
        sounds = unilib.global.sound_table.glass,

        collision_box = {
            type = "fixed",
            fixed = {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
        },
        drawtype = "nodebox",
        drop = "",
        inventory_image = img,
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
        },
        paramtype = "light",
        use_texture_alpha = "blend",
        wield_image = img,

        on_walk_over = function(pos, node, player)

            -- The ice breaks if the player is unlucky...
            if math.random(50) == 13 then

                core.sound_play(
                    "unilib_ice_dug",
                    {pos = pos, gain = 0.5, pitch = 1.4, max_hear_distance = 5},
                    true
                )

                core.remove_node(pos)

            end

        end,
    })

end
