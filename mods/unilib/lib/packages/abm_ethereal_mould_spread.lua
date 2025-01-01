---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_mould_spread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_mould_spread.init()

    return {
        description = "ABM to handle the spread of slime mould (ethereal-ng)",
        depends = "plant_mould_slime",
        at_least_one = {"flower_fire", "grass_spore"},
    }

end

function unilib.pkg.abm_ethereal_mould_spread.post()

    unilib.register_abm({
        label = "Slime mould spread [abm_ethereal_mould_spread]",
        nodenames = {"unilib:plant_mould_slime"},
        neighbors = {"unilib:grass_spore", "unilib:flower_fire"},

        catch_up = false,
        chance = 4,
        interval = 15,

        action = function(pos, node)

            if core.find_node_near(pos, 1, {"unilib:flower_fire"}) then

                core.sound_play(
                    "unilib_extinguish_flame",
                    {pos = pos, gain = 0.05, max_hear_distance = 3},
                    true
                )

                core.remove_node(pos)
                return

            end

            local near_pos = core.find_node_near(pos, 1, {"unilib:grass_spore"})
            if near_pos then

                core.sound_play(
                    "unilib_gravel_dug",
                    {pos = near_pos, gain = 0.3, max_hear_distance = 3},
                    true
                )

                core.set_node(near_pos, {name = "unilib:plant_mould_slime"})

            end

        end,
    })

end
