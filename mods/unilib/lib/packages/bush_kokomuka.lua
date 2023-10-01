---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_kokomuka = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_kokomuka.init()

    return {
        description = "Kokomuka bush",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.bush_kokomuka.exec()

    -- (no burnlevel)
    local sci_name = "Veronica elliptica"

    unilib.register_bush_stem({
        -- From aotearoa:kokomuka_stem. Creates unilib:bush_kokomuka_stem
        part_name = "kokomuka",
        orig_name = "aotearoa:kokomuka_stem",

        replace_mode = mode,
        common_group = 2,
        description = S("Kokomuka Bush Stem"),
        sci_name = sci_name,
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16}
    })
    if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:kokomuka_stem
            output = "unilib:item_stick_ordinary",
            recipe = {
                {"unilib:bush_kokomuka_stem"},
            }
        })

    end
    unilib.register_craft({
        -- From aotearoa:kokomuka_stem
        type = "fuel",
        recipe = "unilib:bush_kokomuka_stem",
        burntime = 2,
    })

    local inv_img = unilib.filter_leaves_img("unilib_bush_kokomuka_leaves.png")
    unilib.register_node("unilib:bush_kokomuka_leaves", "aotearoa:kokomuka", mode, {
        -- From aotearoa:kokomuka
        description = unilib.annotate(S("Kokomuka Bush Leaves"), sci_name),
        tiles = {"unilib_bush_kokomuka_leaves.png"},
        groups = {flammable = 2, flower = 1, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:bush_kokomuka_sapling"}, rarity = 5},
                {items = {"unilib:bush_kokomuka_leaves"}}
            }
        },
        inventory_image = inv_img,
        is_ground_content = false,
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
    unilib.register_quick_bush_leafdecay("kokomuka")

    unilib.register_bush_sapling({
        -- From aotearoa:kokomuka_sapling. Creates unilib:bush_kokomuka_sapling
        part_name = "kokomuka",
        orig_name = "aotearoa:kokomuka_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Kokomuka Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_bush_kokomuka_1", 1, 1, 1},
            {"unilib_bush_kokomuka_2", 1, 1, 1},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_bush_kokomuka_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_bush_kokomuka_" .. i .. ".mts",

            fill_ratio = 0.0025,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
