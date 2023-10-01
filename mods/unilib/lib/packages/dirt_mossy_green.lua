---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mossy_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mossy_green.init()

    return {
        description = "Green Mossy Dirt",
        notes = "This item does not spawn in the world, as ethereal biomes do not specify it" ..
                " (but it can crafted, and is itself used as a crafting ingredient)",
        depends = {"dirt_ordinary", "tree_jungle"},
    }

end

function unilib.pkg.dirt_mossy_green.exec()

    unilib.register_node("unilib:dirt_mossy_green", "ethereal:green_moss", mode, {
        -- From ethereal:green_moss
        description = S("Green Mossy Dirt"),
        tiles = {"unilib_turf_ordinary_top.png"},
        groups = {crumbly = 3},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        is_ground_content = unilib.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From ethereal:green_moss
        type = "shapeless",
        output = "unilib:dirt_mossy_green",
        recipe = {"unilib:dirt_ordinary", "unilib:tree_jungle_leaves"},
    })

end
