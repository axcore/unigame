---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mossy_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mossy_grey.init()

    return {
        description = "Grey Mossy Dirt",
        notes = "This item does not spawn in the world, as ethereal biomes do not specify it" ..
                " (but it can crafted, and is itself used as a crafting ingredient)",
        depends = {"dirt_ordinary", "plant_shrub_snowy"}
    }

end

function unilib.pkg.dirt_mossy_grey.exec()

    unilib.register_node("unilib:dirt_mossy_grey", "ethereal:gray_moss", mode, {
        -- From ethereal:gray_moss
        description = S("Grey Mossy Dirt"),
        tiles = {"unilib_turf_grey_top.png"},
        groups = {crumbly = 3},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        is_ground_content = unilib.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From ethereal:gray_moss
        type = "shapeless",
        output = "unilib:dirt_mossy_grey",
        recipe = {"unilib:dirt_ordinary", "unilib:plant_shrub_snowy"},
    })

end
