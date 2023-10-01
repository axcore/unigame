---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    30biomes
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_fir = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table["30biomes"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fir.init()

    return {
        description = "Fir tree",
        optional = "mushroom_red",
    }

end

function unilib.pkg.tree_fir.exec()

    local burnlevel = 3
    local sci_name = "Abies nordmanniana"

    unilib.register_tree({
        -- Original to unilib
        part_name = "fir",
        description = S("Fir Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From 30biomes:fir_tree. Creates unilib:tree_fir_trunk
        part_name = "fir",
        orig_name = "30biomes:fir_tree",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Fir Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- Original to unilib. Creates unilib:tree_fir_wood
        part_name = "fir",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Fir Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From 30biomes:fir_needles. Creates unilib:tree_fir_leaves
        part_name = "fir",
        orig_name = "30biomes:fir_needles",

        replace_mode = mode,
        description = S("Fir Tree Needles"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("fir")

    unilib.register_tree_sapling({
        -- Original to unilib. Creates unilib:tree_fir_sapling
        part_name = "fir",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Fir Tree Sapling"),
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "fir",

        replace_mode = mode,
        burnlevel = burnlevel,
        fence_description = S("Fir Tree Wood Fence"),
        gate_description = S("Fir Tree Wood Fence Rail"),
        rail_description = S("Fir Tree Wood Fence Gate"),
    })

    unilib.register_decoration("30biomes_tree_fir", {
        -- From 30biomes/decorations.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_fir.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.036,
            persist = 0.66,
            scale = 0.022,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    if unilib.pkg_executed_table["mushroom_red"] ~= nil then

        unilib.register_decoration("30biomes_tree_fir_log", {
            -- From 30biomes/decorations.lua
            deco_type = "schematic",
            --[[
            schematic = {
                data = {
                    {name = "air", prob = 0},
                    {name = "air", prob = 0},
                    {name = "air", prob = 0},
                    {name = "unilib:tree_fir_trunk", param2 = 12, prob = 191},
                    {name = "unilib:tree_fir_trunk", param2 = 12},
                    {name = "unilib:tree_fir_trunk", param2 = 12, prob = 127},
                    {name = "air", prob = 0},
                    {name = "unilib:mushroom_red", prob = 63},
                    {name = "air", prob = 0},
                },
                size = {x = 3, y = 3, z = 1},
            },
            ]]--
            schematic = unilib.path_mod .. "/mts/unilib_tree_fir_log.mts",

            flags = "place_center_x",
            noise_params = {
                octaves = 3,
                offset = 0.0018,
                persist = 0.66,
                scale = 0.0011,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            rotation = "random",
            sidelen = 16,
        })

    end

end
