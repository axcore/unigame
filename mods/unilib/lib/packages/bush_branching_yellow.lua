---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_branching_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bushes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_branching_yellow.init()

    return {
        description = "Yellow branching bush",
        depends = {"item_stick_ordinary", "shared_bushes"},
    }

end

function unilib.pkg.bush_branching_yellow.exec()

    unilib.pkg.shared_bushes.register_bush_stem(
        -- From bushes:bushbranches1
        "unilib:bush_branching_yellow_stem",
        "bushes:bushbranches1",
        S("Yellow Branching Bush"),
        "unilib_bush_branching_yellow_leaves.png",
        "unilib_bush_branching_yellow_centre.png"
    )

    unilib.pkg.shared_bushes.register_bush_arm(
        -- From bushes:bushbranches2
        "unilib:bush_branching_yellow_arm",
        "bushes:bushbranches2",
        S("Yellow Branching Bush"),
        "unilib_bush_branching_yellow_leaves.png",
        "unilib_bush_branching_yellow_centre.png",
        "unilib_bush_branching_yellow_left.png",
        "unilib_bush_branching_yellow_right.png"
    )

    unilib.pkg.shared_bushes.register_bush_leaves(
        -- From bushes:BushLeaves1
        "unilib:bush_branching_yellow_leaves",
        "bushes:BushLeaves1",
        S("Yellow Branching Bush Leaves"),
        "unilib_bush_branching_yellow_leaves.png"
    )

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_bush_branching_yellow"
        part_name = "bush_branching_yellow",
        convert_func = unilib.pkg.shared_bushes.grow_bush,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 99.9,
                rarity_fertility = 1.5,
                plantlife_limit = -1,
            }),
        },
    })

end
