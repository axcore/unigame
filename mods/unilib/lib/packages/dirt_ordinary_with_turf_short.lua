---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_short = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_short.init()

    return {
        description = "Ordinary dirt with short turf",
        notes = "Turf can be shortened with a turf-cutting sickle",
        depends = "dirt_ordinary",
        optional = "misc_patch_grass",
    }

end

function unilib.pkg.dirt_ordinary_with_turf_short.exec()

    -- Short turf turns back into (ordinary) turf over time
    unilib.register_node("unilib:dirt_ordinary_with_turf_short", "dryplants:grass_short", mode, {
        -- From dryplants:grass_short
        description = S("Ordinary Dirt with Short Turf"),
        tiles = {
            "unilib_turf_ordinary_top.png^unilib_dirt_ordinary_with_turf_short_top_overlay.png",
            "unilib_dirt_ordinary.png",
            "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png" ..
                    "^unilib_dirt_ordinary_with_turf_short_side_overlay.png",
        },
        groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),
    })
    unilib.register_craft({
        -- From dryplants:grass_short
        output = "unilib:dirt_ordinary",
        recipe = {
            {"unilib:dirt_ordinary_with_turf_short"},
        }
    })
    -- (not compatible with flowerpots)

    unilib.register_abm({
        label = "Short turf grows [dirt_ordinary_with_turf_short]",
        nodenames = {"unilib:dirt_ordinary_with_turf_short"},

        chance = 100 / 5,
        interval = 1200,

        action = function(pos)

            -- Only become dirt with turf if no cut turf lies on top
            local above = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if above.name ~= "unilib:misc_patch_grass" and
                    above.name ~= "unilib:misc_patch_grass_dead" then
                minetest.swap_node(pos, {name = "unilib:dirt_ordinary_with_turf"})
            end

        end,
    })

end
