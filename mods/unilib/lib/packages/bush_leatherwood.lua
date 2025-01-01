---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_leatherwood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_leatherwood.init()

    return {
        description = "Leatherwood bush",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.bush_leatherwood.exec()

    local burnlevel = 2
    local sci_name = "Olearia colensoi"

    unilib.register_bush_stem({
        -- From aotearoa:leatherwood_stem. Creates unilib:bush_leatherwood_stem
        part_name = "leatherwood",
        orig_name = "aotearoa:leatherwood_stem",

        replace_mode = mode,
        common_group = 2,
        description = S("Leatherwood Bush Stem"),
        sci_name = sci_name,
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16}
    })
    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:leatherwood_stem
            output = "unilib:item_stick_ordinary",
            recipe = {
                {"unilib:bush_leatherwood_stem"},
            },
        })

    end
    unilib.register_craft({
        -- From aotearoa:leatherwood_stem
        type = "fuel",
        recipe = "unilib:bush_leatherwood_stem",
        burntime = 2,
    })

    local inv_img = unilib.flora.filter_leaves_img("unilib_bush_leatherwood_leaves.png")
    unilib.register_node("unilib:bush_leatherwood_leaves", "aotearoa:leatherwood", mode, {
        -- From aotearoa:leatherwood
        description = unilib.utils.annotate(S("Leatherwood Bush Leaves"), sci_name),
        tiles = {"unilib_bush_leatherwood_leaves.png"},
        groups = {flammable = 2, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:bush_leatherwood_sapling"}, rarity = 5},
                {items = {"unilib:bush_leatherwood_leaves"}},
            },
        },
        inventory_image = inv_img,
        -- N.B. removed .is_ground_content = false to match other bush leaves
--      is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_img = inv_img,
    })
    unilib.register_quick_bush_leafdecay("leatherwood")

    unilib.register_bush_sapling({
        -- From aotearoa:leatherwood_sapling. Creates unilib:bush_leatherwood_sapling
        part_name = "leatherwood",
        orig_name = "aotearoa:leatherwood_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Leatherwood Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_bush_leatherwood_1", 1, 1, 1},
            {"unilib_bush_leatherwood_2", 1, 1, 1},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_bush_leatherwood_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_bush_leatherwood_" .. i .. ".mts",

            fill_ratio = 0.1,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration_generic("aotearoa_bush_leatherwood_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_bush_leatherwood_" .. i .. ".mts",

            fill_ratio = 0.02,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
