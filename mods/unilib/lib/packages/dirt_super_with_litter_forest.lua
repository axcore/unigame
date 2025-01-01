---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_super_with_litter_forest = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_super_with_litter_forest.init()

    return {
        description = "Super dirts with forest litter",
        notes = "Uses an ABM to replace dirt and dirt-with-turf nodes near trees and ferns. The" ..
                " nodes are replaced by various forest litters based on the same dirt type. See" ..
                " also the \"dirt_ordinary_with_litter_forest\" package, which provides litters" ..
                " based on ordinary dirt only, as in the original mod's code",
        depends = "shared_woodsoils",
        excludes = "dirt_ordinary_with_litter_forest",
    }

end

function unilib.pkg.dirt_super_with_litter_forest.post()

    -- Create a set of covers for all super dirts
    for dirt_part_name, _ in pairs(unilib.global.super_dirt_table) do

        if unilib.global.dirt_with_turf_reverse_table[dirt_part_name] ~= nil then

            unilib.pkg.shared_woodsoils.do_dirt(unilib.global.fertile_dirt_table[dirt_part_name])

            for _, full_name in pairs(unilib.global.dirt_with_turf_reverse_table[dirt_part_name]) do

                unilib.pkg.shared_woodsoils.do_turf(
                    unilib.global.fertile_dirt_table[dirt_part_name], full_name
                )

            end

        end

    end

    -- ABM to place woodsoils around trees/ferns grown from saplings (over time)
    unilib.register_abm({
        label = "Place forest litter [dirt_super_with_litter_forest]",
        nodenames = {"group:tree", "group:fern"},

        -- (Tree takes half an hour on average to drop litter over the surrounding soil)
        chance = 60,
        interval = 60,

        action = function(pos)
            unilib.pkg.shared_woodsoils.place_litter(pos)
        end,
    })

    -- LBM to place woodsoils around trees/ferns placed as decorations (immediately)
    unilib.register_lbm({
        label = "Place forest litter around trees/ferns [dirt_super_with_litter_forest]",
        name = "unilib:lbm_dirt_super_with_litter_forest",
        nodenames = {"group:tree", "group:fern"},
        run_at_every_load = true,

        action = function(pos)
            unilib.pkg.shared_woodsoils.place_litter(pos)
        end,
    })

end
