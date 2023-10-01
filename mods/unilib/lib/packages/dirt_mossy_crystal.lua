---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mossy_crystal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mossy_crystal.init()

    return {
        description = "Crystal Mossy Dirt",
        notes = "This item does not spawn in the world, as ethereal biomes do not specify it" ..
                " (but it can crafted, and is itself used as a crafting ingredient)",
        depends = {"dirt_ordinary", "tree_frost"}
    }

end

function unilib.pkg.dirt_mossy_crystal.exec()

    unilib.register_node("unilib:dirt_mossy_crystal", "ethereal:crystal_moss", mode, {
        -- From ethereal:crystal_moss
        description = S("Crystal Mossy Dirt"),
        tiles = {"unilib_turf_crystal_top.png"},
        groups = {crumbly = 3},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        is_ground_content = unilib.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From ethereal:crystal_moss
        type = "shapeless",
        output = "unilib:dirt_mossy_crystal",
        recipe = {"unilib:dirt_ordinary", "unilib:tree_frost_leaves"},
    })

end
