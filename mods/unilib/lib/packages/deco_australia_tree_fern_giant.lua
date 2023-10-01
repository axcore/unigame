---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_fern_giant = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_fern_giant.init()

    return {
        description = "Giant fern tree as decoration",
        depends = {"dirt_ordinary", "tree_fern_giant"},
        at_least_one = {
            "biome_australia_great_dividing_range",
            "biome_australia_far_north_queensland",
            "biome_australia_tasmania",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.deco_australia_tree_fern_giant.exec()

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_giant_in_range"
        part_name = "tree_fern_giant_in_range",
        convert_func = unilib.pkg.tree_fern_giant.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = 0.002,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
        },
        space_table = {
            height = 17,
            width = 7,
            sub_name = "unilib:tree_fern_giant_sapling",
        },
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_giant_in_queensland"
        part_name = "tree_fern_giant_in_queensland",
        convert_func = unilib.pkg.tree_fern_giant.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = 0.003,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
        },
        space_table = {
            height = 17,
            width = 7,
            sub_name = "unilib:tree_fern_giant_sapling",
        },
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_giant_in_tasmania"
        part_name = "tree_fern_giant_in_tasmania",
        convert_func = unilib.pkg.tree_fern_giant.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = 0.006,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
        },
        space_table = {
            height = 17,
            width = 7,
            sub_name = "unilib:tree_fern_giant_sapling",
        },
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_giant_in_victoria"
        part_name = "tree_fern_giant_in_victoria",
        convert_func = unilib.pkg.tree_fern_giant.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = 0.004,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
        },
        space_table = {
            height = 17,
            width = 7,
            sub_name = "unilib:tree_fern_giant_sapling",
        },
    })

end

function unilib.pkg.deco_australia_tree_fern_giant.post()

    if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        unilib.register_decoration_now("convert_tree_fern_giant_in_range", nil, {
            -- From australia/biome_great_dividing_range.lua
            biomes = "australia_great_dividing_range",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 70,
            y_min = 36,
        })

    end

    if unilib.pkg_executed_table["biome_australia_far_north_queensland"] ~= nil then

        unilib.register_decoration_now("convert_tree_fern_giant_in_queensland", nil, {
            -- From australia/biome_far_north_queensland.lua
            biomes = "australia_far_north_queensland",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 20,
            y_min = 6,
        })

    end

    if unilib.pkg_executed_table["biome_australia_tasmania"] ~= nil then

        unilib.register_decoration_now("convert_tree_fern_giant_in_tasmania", nil, {
            -- From australia/biome_tasmania.lua
            biomes = "australia_tasmania",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 70,
            y_min = 36,
        })

    end

    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_decoration_now("convert_tree_fern_giant_in_victoria", nil, {
            -- From australia/biome_victorian_forests.lua
            biomes = "australia_victorian_forests",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 70,
            y_min = 36,
        })

    end

end
