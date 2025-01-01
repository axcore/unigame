---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/woodsoils
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_litter_forest = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.woodsoils.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_litter_forest.init()

    return {
        description = "Ordinary dirt with forest litter",
        notes = "Uses an ABM to replace dirt and dirt-with-turf nodes near trees and ferns. The" ..
                " nodes are replaced by various forest litters based on ordinary dirt, as in" ..
                " the original mod's code. See also the \"dirt_super_with_litter_forest\"" ..
                " package, which provides litters based on many different types of dirt",
        excludes = "dirt_super_with_litter_forest",
        depends = {"dirt_ordinary", "shared_woodsoils"},
    }

end

function unilib.pkg.dirt_ordinary_with_litter_forest.post()

    -- Create a set of covers for ordinary dirt-with-turf only
    unilib.pkg.shared_woodsoils.do_dirt("unilib:dirt_ordinary")
    unilib.pkg.shared_woodsoils.do_turf("unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf")

    -- ABM to place woodsoils around trees/ferns grown from saplings (over time)
    unilib.register_abm({
        label = "Place forest litter [dirt_ordinary_with_litter_forest]",
        nodenames = {"group:tree", "group:fern"},

        -- (Tree takes half an hour on average to drop litter over the surrounding soil)
        chance = 60,
        interval = 60,

        action = function(pos)

            unilib.pkg.shared_woodsoils.place_litter(
                pos, "unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf"
            )

        end,
    })

    -- LBM to place woodsoils around trees/ferns placed as decorations (immediately)
    unilib.register_lbm({
        label = "Place forest litter around trees/ferns [dirt_ordinary_with_litter_forest]",
        name = "unilib:lbm_dirt_ordinary_with_litter_forest",
        nodenames = {"group:tree", "group:fern"},
        run_at_every_load = true,

        action = function(pos)

            unilib.pkg.shared_woodsoils.place_litter(
                pos, "unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf"
            )

        end,
    })

end
