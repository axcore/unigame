---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mossy_fiery = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mossy_fiery.init()

    return {
        description = "Fiery Mossy Dirt",
        notes = "This item does not spawn in the world, as ethereal biomes do not specify it" ..
                " (but it can crafted, and is itself used as a crafting ingredient)",
        depends = {"dirt_ordinary", "plant_shrub_dry_fiery"}
    }

end

function unilib.pkg.dirt_mossy_fiery.exec()

    unilib.register_node("unilib:dirt_mossy_fiery", "ethereal:fiery_moss", mode, {
        -- From ethereal:fiery_moss
        description = S("Fiery Mossy Dirt"),
        tiles = {"unilib_turf_fiery_top.png"},
        groups = {crumbly = 3},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        is_ground_content = unilib.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From ethereal:fiery_moss
        type = "shapeless",
        output = "unilib:dirt_mossy_fiery",
        recipe = {"unilib:dirt_ordinary", "unilib:plant_shrub_dry_fiery"},
    })

end
