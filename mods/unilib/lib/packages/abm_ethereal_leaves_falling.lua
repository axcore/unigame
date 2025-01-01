---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_leaves_falling = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

-- N.B. Original code uses a list, which is walked every time the ABM is called
-- Let's simplify matters by using a lookup table, and by pre-calculating the texture used for each
--      particle
local leaf_table = {
    ["unilib:tree_acacia_leaves"] = {"296600", nil},
    ["unilib:tree_apple_leaves"] = {"223a20", nil},
    ["unilib:tree_aspen_leaves"] = {"395d16", nil},
    ["unilib:tree_bamboo_leaves"] = {"445811", nil},
    ["unilib:tree_banana_leaves"] = {"28581e", nil},
    ["unilib:tree_birch_leaves"] = {"274527", nil},
    ["unilib:tree_frost_leaves"] = {"331b37", 9},
    ["unilib:tree_healing_leaves"] = {"8b5f00", 9},
    ["unilib:tree_jungle_leaves"] = {"141e10", nil},
    ["unilib:tree_lemon_leaves"] = {"507c1e", nil},
    ["unilib:tree_olive_leaves"] = {"416531", nil},
    ["unilib:tree_orange_leaves"] = {"1a3b1b", nil},
    ["unilib:tree_palm_leaves"] = {"2b6000", nil},
    ["unilib:tree_pine_leaves"] = {"00280e", nil},
    ["unilib:tree_redwood_leaves"] = {"15342a", nil},
    ["unilib:tree_sakura_leaves"] = {"c281a9", nil},
    ["unilib:tree_sakura_leaves_white"] = {"d4cbac", nil},
    ["unilib:tree_willow_weeping_leaves"] = {"0b9445", nil},
}

for _, mini_list in pairs(leaf_table) do
    mini_list[1] = "unilib_particle_leaf_falling.png^[multiply:#" .. mini_list[1] .. "70"
end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_leaves_falling.init()

    return {
        description = "Replacement ABM from ethereal-ng, replacing the one specified by the" ..
                " \"abm_standard_leaves_falling\" package",
        notes = "Currently, the ABM created by this package is identical to the one in the" ..
                " \"abm_standard_leaves_falling\" package, but it might change in the future",
    }

end

function unilib.pkg.abm_ethereal_leaves_falling.post()

    unilib.register_abm({
        label = "Falling leaves particles [abm_ethereal_leaves_falling]",
        nodenames = {"group:leaves"},
        neighbors = {"air"},

        catch_up = false,
        chance = 50,
        interval = 7,

        action = function(pos, node)

            local mini_list = leaf_table[node.name]
            if mini_list ~= nil then

                core.add_particlespawner({
                    amount = 1,
                    time = 2,
                    texture = mini_list[1],

                    maxacc = {x = 0.2, y = -3, z = 0.2},
                    minacc = {x = -0.1, y = -1, z = -0.1},
                    maxexptime = 10,
                    minexptime = 5,
                    maxpos = {x = pos.x + 1, y = pos.y, z = pos.z + 1},
                    minpos = {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
                    maxsize = 4,
                    minsize = 3,
                    maxvel = {x = 0.8, y = -3, z = 0.8},
                    minvel = {x = -0.8, y = -1, z = -0.8},

                    collisiondetection = true,
                    collision_removal = true,
                    glow = mini_list[2],
                    vertical = true,
                })

            end

        end,
    })

end
