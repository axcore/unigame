---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mossy_mushroom = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mossy_mushroom.init()

    return {
        description = "Mushroom Mossy Dirt",
        notes = "This item does not spawn in the world, as ethereal biomes do not specify it" ..
                " (but it can crafted, and is itself used as a crafting ingredient)",
        depends = {"dirt_ordinary", "grass_spore"},
    }

end

function unilib.pkg.dirt_mossy_mushroom.exec()

    unilib.register_node("unilib:dirt_mossy_mushroom", "ethereal:mushroom_moss", mode, {
        -- From ethereal:mushroom_moss
        description = S("Mushroom Mossy Dirt"),
        tiles = {"unilib_turf_mushroom_top.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From ethereal:mushroom_moss
        output = "unilib:dirt_mossy_mushroom",
        recipe = {
            {"unilib:dirt_ordinary", "unilib:grass_spore"},
        },
    })

end
