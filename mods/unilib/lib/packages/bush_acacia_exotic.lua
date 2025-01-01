---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_acacia_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_acacia_exotic.init()

    return {
        description = "Exotic acacia bush",
        -- If the "ore_farlands_bush_exotic" package is not loaded, then the shared package will use
        --      an ABM to place leaves-with-fruit nodes instead
        -- Also allow crafting bush stem into exotic tree wood
        optional = "tree_acacia_exotic",
    }

end

function unilib.pkg.bush_acacia_exotic.exec()

    -- (Using same level as the equivalent bush in default)
    local burnlevel = 3
    -- (no sci_name)

    unilib.register_bush_stem({
        -- From farlands, default:acacia_bush_stem. Creates unilib:bush_acacia_exotic_stem
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Acacia Bush Stem"),
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    if unilib.global.pkg_executed_table["tree_acacia_exotic"] ~= nil then

        unilib.register_craft({
            -- From farlands, default:acacia_bush_stem
            output = "unilib:tree_acacia_exotic_wood",
            recipe = {
                {"unilib:bush_acacia_exotic_stem"},
            },
        })

    end
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_acacia_exotic_stem",
        burntime = unilib.global.bush_burn_table.stem[burnlevel],
    })

    unilib.register_bush_leaves({
        -- From farlands, default:acacia_bush_leaves. Creates unilib:bush_acacia_exotic_leaves
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Exotic Acacia Bush Leaves"),
        img_list = {"unilib_tree_acacia_exotic_leaves_simple.png"},
    })
    unilib.register_quick_bush_leafdecay("acacia_exotic")

    unilib.register_bush_sapling({
        -- From farlands, default:acacia_bush_sapling. Creates unilib:bush_acacia_exotic_sapling
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Acacia Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 1, z = 1},
        minp_table = {x = -1, y = 0, z = -1},
        offset_list = {1, 1, 1},
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 2 / 16, 3 / 16},
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_acacia_exotic_sapling",
        burntime = unilib.global.bush_burn_table.sapling[burnlevel],
    })

    unilib.register_decoration_generic("farlands_bush_acacia_exotic", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_bush_acacia_exotic.mts",

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
