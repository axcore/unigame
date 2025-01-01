---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_rhododendron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_rhododendron.init()

    return {
        description = "Rhododendron bush",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.bush_rhododendron.exec()

    local burnlevel = 2
    local sci_name = "Rhododendron ferrugineum"

    unilib.register_bush_stem({
        -- Original to unilib. Creates unilib:bush_rhododendron_stem
        part_name = "rhododendron",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Rhododendron Bush Stem"),
        sci_name = sci_name,
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:item_stick_ordinary",
            recipe = {
                {"unilib:bush_rhododendron_stem"},
            },
        })

    end
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_rhododendron_stem",
        burntime = unilib.global.bush_burn_table.stem[burnlevel],
    })

    local inv_img = unilib.flora.filter_leaves_img("unilib_bush_rhododendron_leaves.png")
    unilib.register_node(
        -- Texture from GLEMr11, lib_ecology_bush_rhododendron_leaves_1.png. Original code
        "unilib:bush_rhododendron_leaves",
        "lib_ecology:bush_rhodedendron_leaves_1",
        mode,
        {
            description = unilib.utils.annotate(S("Rhododendron Bush Leaves"), sci_name),
            tiles = {"unilib_bush_rhododendron_leaves.png"},
            groups = {flammable = 2, leaves = 1, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:bush_rhododendron_sapling"}, rarity = 5},
                    {items = {"unilib:bush_rhododendron_leaves"}},
                },
            },
            inventory_image = inv_img,
            paramtype = "light",
            wield_img = inv_img,

            after_place_node = unilib.flora.after_place_leaves,

            -- N.B. .on_construct() and .on_timer() from original code, replaced with ABM below
            --[[
            on_construct = function(pos)

                -- N.B. In original code, 60-120
                core.get_node_timer(pos):start(
                    math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
                )

            end,

            on_timer = function(pos)
                core.set_node(pos, {name = "unilib:bush_rhododendron_leaves_flowering"})
            end,
            ]]--
        }
    )

    inv_img = unilib.flora.filter_leaves_img("unilib_bush_rhododendron_leaves_flowering.png")
    unilib.register_node(
        -- Texture from GLEMr11, lib_ecology_bush_rhododendron_leaves_2.png. Original code
        "unilib:bush_rhododendron_leaves_flowering",
        "lib_ecology:bush_rhodedendron_leaves_2",
        mode,
        {
            description = unilib.utils.annotate(S("Rhododendron Bush Leaves"), sci_name),
            tiles = {"unilib_bush_rhododendron_leaves_flowering.png"},
            groups = {flammable = 2, leaves = 1, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:bush_rhododendron_sapling"}, rarity = 5},
                    {items = {"unilib:bush_rhododendron_leaves_flowering"}},
                },
            },
            inventory_image = inv_img,
            paramtype = "light",
            wield_img = inv_img,

            after_place_node = unilib.flora.after_place_leaves,

            -- N.B. .on_construct() and .on_timer() from original code, replaced with ABM below
            --[[
            on_construct = function(pos)

                -- N.B. In original code, 60-120
                core.get_node_timer(pos):start(
                    math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
                )

            end,

            on_timer = function(pos)
                core.set_node(pos, {name = "unilib:bush_rhododendron_leaves_mature"})
            end,
            ]]--
        }
    )

    inv_img = unilib.flora.filter_leaves_img("unilib_bush_rhododendron_leaves_mature.png")
    unilib.register_node(
        -- Texture from GLEMr11, lib_ecology_bush_rhododendron_leaves_3.png. Original code
        "unilib:bush_rhododendron_leaves_mature",
        "lib_ecology:bush_rhodedendron_leaves_2",
        mode,
        {
            description = unilib.utils.annotate(S("Rhododendron Bush Leaves"), sci_name),
            tiles = {"unilib_bush_rhododendron_leaves_mature.png"},
            groups = {flammable = 2, leaves = 1, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:bush_rhododendron_sapling"}, rarity = 5},
                    {items = {"unilib:bush_rhododendron_leaves_mature"}},
                },
            },
            inventory_image = inv_img,
            paramtype = "light",
            wield_img = inv_img,

            after_place_node = unilib.flora.after_place_leaves,
        }
    )

    unilib.register_leafdecay({
        -- Original to unilib
        trunks = {"unilib:bush_rhododendron_stem"},
        leaves = {
            "unilib:bush_rhododendron_leaves",
            "unilib:bush_rhododendron_leaves_flowering",
            "unilib:bush_rhododendron_leaves_mature",
        },
        radius = 2,
    })

    unilib.register_bush_sapling({
        -- Original to unilib. Creates unilib:bush_rhododendron_sapling
        part_name = "rhododendron",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Rhododendron Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 2, z = 1},
        minp_table = {x = -1, y = 1, z = -1},
        schem_list = {
            {"unilib_glem_bush_rhododendron_1", 1, 1, 1},
            {"unilib_glem_bush_rhododendron_2", 1, 1, 1},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_rhododendron_sapling",
        burntime = unilib.global.bush_burn_table.sapling[burnlevel],
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("glem_bush_rhododendron_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_glem_bush_rhododendron_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

    -- N.B. This ABM replaces the original .on_construct() and .on_timer() callbacks, which did not
    --      work
    unilib.register_abm({
        -- Original to unilib. Convert ordinary leaves to flower leaves over time
        label = "Convert rhododendron bush leaves [bush_rhododendron]",
        nodenames = {
            "unilib:bush_rhododendron_leaves",
            "unilib:bush_rhododendron_leaves_flowering",
        },

--        chance = 1,
--        interval = math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max),
        chance = 10,
        interval = math.random(
            unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max
        ) / 10,

        action = function(pos, node, active_object_count, active_object_count_wider)

            -- Flowers only appear if the bush is still intact
            local stem_list = core.find_nodes_in_area(
                {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
                {x = pos.x + 1, y = pos.y, z = pos.z + 1},
                {"unilib:bush_rhododendron_stem"}
            )

            if #stem_list > 0 then

                if node.name == "unilib:bush_rhododendron_leaves" then
                    core.set_node(pos, {name = "unilib:bush_rhododendron_leaves_flowering"})
                else
                    core.set_node(pos, {name = "unilib:bush_rhododendron_leaves_mature"})
                end

            end

        end
    })

end
