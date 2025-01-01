---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_pine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_pine.init()

    return {
        description = "Pine bush",
        -- (Allow crafting bush stem into pine tree wood)
        optional = "tree_pine",
    }

end

function unilib.pkg.bush_pine.exec()

    local burnlevel = 1
    -- (no sci_name)

    unilib.register_bush_stem({
        -- From default:pine_bush_stem. Creates unilib:bush_pine_stem
        part_name = "pine",
        orig_name = "default:pine_bush_stem",

        replace_mode = mode,
        common_group = 2,
        description = S("Pine Bush Stem"),
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    if unilib.global.pkg_executed_table["tree_pine"] ~= nil then

        unilib.register_craft({
            -- From default:pine_wood
            output = "unilib:tree_pine_wood",
            recipe = {
                {"unilib:bush_pine_stem"},
            },
        })

    end
    unilib.register_craft({
        -- From default:pine_bush_stem
        type = "fuel",
        recipe = "unilib:bush_pine_stem",
        burntime = unilib.global.bush_burn_table.stem[burnlevel],
    })

    unilib.register_bush_leaves({
        -- From default:pine_bush_needles. Creates unilib:bush_pine_leaves
        part_name = "pine",
        orig_name = "default:pine_bush_needles",

        replace_mode = mode,
        description = S("Pine Bush Needles"),
        img_list = {"unilib_tree_pine_leaves.png"},
    })
    unilib.register_quick_bush_leafdecay("pine")

    unilib.register_bush_sapling({
        -- From default:pine_bush_sapling. Creates unilib:bush_pine_sapling
        part_name = "pine",
        orig_name = "default:pine_bush_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Pine Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 1, z = 1},
        minp_table = {x = -1, y = 0, z = -1},
        offset_list = {1, 1, 1},
        select_Table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
    })
    unilib.register_craft({
        -- From default:pine_bush_sapling
        type = "fuel",
        recipe = "unilib:bush_pine_sapling",
        burntime = unilib.global.bush_burn_table.sapling[burnlevel],
    })

    unilib.register_decoration_generic("default_bush_pine", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_bush_pine.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.01,
            seed = 137,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
