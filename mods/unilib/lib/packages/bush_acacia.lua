---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_acacia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_acacia.init()

    return {
        description = "Acacia bush",
        -- (Allow crafting bush stem into acacia tree wood)
        optional = "tree_acacia",
    }

end

function unilib.pkg.bush_acacia.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_bush_stem({
        -- From default:acacia_bush_stem. Creates unilib:bush_acacia_stem
        part_name = "acacia",
        orig_name = "default:acacia_bush_stem",

        replace_mode = mode,
        common_group = 2,
        description = S("Acacia Bush Stem"),
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    if unilib.global.pkg_executed_table["tree_acacia"] ~= nil then

        unilib.register_craft({
            -- From default:acacia_wood
            output = "unilib:tree_acacia_wood",
            recipe = {
                {"unilib:bush_acacia_stem"},
            },
        })

    end
    unilib.register_craft({
        -- From default:acacia_bush_stem
        type = "fuel",
        recipe = "unilib:bush_acacia_stem",
        burntime = unilib.global.bush_burn_table.stem[burnlevel],
    })

    unilib.register_bush_leaves({
        -- From default:acacia_bush_leaves. Creates unilib:bush_acacia_leaves
        part_name = "acacia",
        orig_name = "default:acacia_bush_leaves",

        replace_mode = mode,
        description = S("Acacia Bush Leaves"),
        img_list = {"unilib_tree_acacia_leaves_simple.png"},
    })
    unilib.register_quick_bush_leafdecay("acacia")

    unilib.register_bush_sapling({
        -- From default:acacia_bush_sapling. Creates unilib:bush_acacia_sapling
        part_name = "acacia",
        orig_name = "default:acacia_bush_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Acacia Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 1, z = 1},
        minp_table = {x = -1, y = 0, z = -1},
        offset_list = {1, 1, 1},
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 2 / 16, 3 / 16},
    })
    unilib.register_craft({
        -- From default:acacia_bush_sapling
        type = "fuel",
        recipe = "unilib:bush_acacia_sapling",
        burntime = unilib.global.bush_burn_table.sapling[burnlevel],
    })

    unilib.register_decoration_generic("default_bush_acacia", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_bush_acacia.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.01,
            seed = 90155,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
