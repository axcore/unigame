---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_fern = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_fern.init()

    return {
        description = "Fern tree as decoration",
        depends = {"dirt_ordinary", "tree_fern"},
        at_least_one = {
            "biome_australia_great_dividing_range",
            "biome_australia_far_north_queensland",
            "biome_australia_tasmania",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.deco_australia_tree_fern.exec()

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_in_range"
        part_name = "tree_fern_in_range",
        convert_func = unilib.pkg.tree_fern.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = 0.004,
            sidelen = 80,
        },
        space_table = {
            height = 5,
            width = 1,
            sub_name = "unilib:tree_fern_sapling",
        },
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_in_queensland"
        part_name = "tree_fern_in_queensland",
        convert_func = unilib.pkg.tree_fern.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = 0.01,
            sidelen = 80,
        },
        space_table = {
            height = 5,
            width = 1,
            sub_name = "unilib:tree_fern_sapling",
        },
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_in_tasmania"
        part_name = "tree_fern_in_tasmania",
        convert_func = unilib.pkg.tree_fern.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = 0.01,
            sidelen = 80,
        },
        space_table = {
            height = 5,
            width = 1,
            sub_name = "unilib:tree_fern_sapling",
        },
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_in_victoria"
        part_name = "tree_fern_in_victoria",
        convert_func = unilib.pkg.tree_fern.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = 0.008,
            sidelen = 80,
        },
        space_table = {
            height = 5,
            width = 1,
            sub_name = "unilib:tree_fern_sapling",
        },
    })

end

function unilib.pkg.deco_australia_tree_fern.post()

    if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        unilib.register_decoration_now("convert_tree_fern_in_range", nil, {
            -- From australia/biome_great_dividing_range.lua
            biomes = "australia_great_dividing_range",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 80,
            y_min = 36,
        })

    end

    if unilib.pkg_executed_table["biome_australia_far_north_queensland"] ~= nil then

        unilib.register_decoration_now("convert_tree_fern_in_queensland", nil, {
            -- From australia/biome_far_north_queensland.lua
            biomes = "australia_far_north_queensland",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 21,
            y_min = 6,
        })

    end

    if unilib.pkg_executed_table["biome_australia_tasmania"] ~= nil then

        unilib.register_decoration_now("convert_tree_fern_in_tasmania", nil, {
            -- From australia/biome_tasmania.lua
            biomes = "australia_tasmania",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 80,
            y_min = 36,
        })

    end

    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_decoration_now("convert_tree_fern_in_victoria", nil, {
            -- From australia/biome_victorian_forests.lua
            biomes = "australia_victorian_forests",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 80,
            y_min = 36,
        })

    end

end
