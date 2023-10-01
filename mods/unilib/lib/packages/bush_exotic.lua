---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_exotic.init()

    return {
        description = "Exotic bush",
        -- (Allow crafting bush stem into exotic tree wood)
        optional = "tree_exotic",
    }

end

function unilib.pkg.bush_exotic.exec()

    -- (Using same level as the equivalent bush in default)
    local burnlevel = 2
    -- (no sci_name)

    unilib.register_bush_stem({
        -- From farlands, default:bush_stem. Creates unilib:bush_exotic_stem
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Bush Stem"),
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    if unilib.pkg_executed_table["tree_exotic"] ~= nil then

        unilib.register_craft({
            -- From farlands, default:bush_stem
            output = "unilib:tree_exotic_wood",
            recipe = {
                {"unilib:bush_exotic_stem"},
            }
        })

    end
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_exotic_stem",
        burntime = unilib.bush_burn_table.stem[burnlevel],
    })

    unilib.register_bush_leaves({
        -- From farlands, default:bush_leaves. Creates unilib:bush_exotic_leaves
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Exotic Bush Leaves"),
        img_list = {"unilib_tree_exotic_leaves_simple.png"},
    })
    unilib.register_quick_bush_leafdecay("exotic")

    unilib.register_bush_sapling({
        -- From farlands, default:bush_sapling. Creates unilib:bush_exotic_sapling
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 1, z = 1},
        minp_table = {x = -1, y = 0, z = -1},
        offset_list = {1, 1, 1},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_exotic_sapling",
        burntime = unilib.bush_burn_table.sapling[burnlevel],
    })

    unilib.register_decoration("farlands_bush_exotic_1", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_bush_exotic.mts",

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

    unilib.register_decoration("farlands_bush_exotic_2", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_bush_exotic.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.01,
            persist = 0.7,
            scale = 0.015,
            seed = 137,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
