---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_lighting
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_brazier_pillar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_lighting.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_brazier_pillar.init()

    return {
        description = "Pillar braziers made from common materials",
        depends = "shared_castle_lighting",
        optional = {
            "decor_stone_castle_wall",
            "stone_desert",
            "stone_obsidian",
            "stone_ordinary",
            "stone_sandstone_ordinary",
        },
    }

end

function unilib.pkg.light_brazier_pillar.exec()

    -- The original code creates braziers using some basic ingredients
    -- Create unilib equivalents. In addition, other packages can call the same shared function to
    --      create additional braziers
    -- N.B. This code allows a few more basic ingredients than the original did

    local material_list = {}

    if unilib.pkg_executed_table["decor_stone_castle_wall"] ~= nil then

        -- Creates unilib:light_pillar_brazier_decor_stone_castle_wall
        table.insert(material_list, {
            part_name = "decor_stone_castle_wall",
            orig_name = "castle_lighting:stonewall_pillar_brasier",
            ingredient = "unilib:decor_stone_castle_wall",

            replace_mode = mode,
            description = S("Castle Wall"),
            img_list = {"unilib_decor_stone_castle_wall.png"},
            -- (no override_ingredient)
        })

    end

    if unilib.pkg_executed_table["stone_desert"] ~= nil then

        -- Creates unilib:light_pillar_brazier_stone_desert
        table.insert(material_list, {
            part_name = "stone_desert",
            orig_name = "castle_lighting:desertstone_pillar_brasier",
            ingredient = "unilib:stone_desert",

            replace_mode = mode,
            description = S("Desert Stone"),
            img_list = {"unilib_stone_desert.png"},
            -- (no override_ingredient)
        })

        -- Creates unilib:light_pillar_brazier_stone_desert_brick
        table.insert(material_list, {
            part_name = "stone_desert_brick",
            orig_name = "castle_lighting:desertstonebrick_pillar_brasier",
            ingredient = "unilib:stone_desert_brick",

            replace_mode = mode,
            description = S("Desert Stone Bricks"),
            img_list = {"unilib_stone_desert_brick.png"},
            -- (no override_ingredient)
        })

    end

    if unilib.pkg_executed_table["stone_obsidian"] ~= nil then

        -- Creates unilib:light_pillar_brazier_stone_obsidian_brick
        table.insert(material_list, {
            part_name = "stone_obsidian_brick",
            orig_name = nil,
            ingredient = "unilib:stone_obsidian_brick",

            replace_mode = mode,
            description = S("Obsidian Stone Bricks"),
            img_list = {"unilib_stone_obsidian_brick.png"},
            -- (no override_ingredient)
        })

    end

    if unilib.pkg_executed_table["stone_ordinary"] ~= nil then

        -- Creates unilib:light_pillar_brazier_stone_ordinary
        table.insert(material_list, {
            part_name = "stone_ordinary",
            orig_name = "castle_lighting:stone_pillar_brasier",
            ingredient = "unilib:stone_ordinary",

            replace_mode = mode,
            description = S("Ordinary Stone"),
            img_list = {"unilib_stone_ordinary.png"},
            -- (no override_ingredient)
        })

        -- Creates unilib:light_pillar_brazier_stone_ordinary_brick
        table.insert(material_list, {
            part_name = "stone_ordinary_brick",
            orig_name = "castle_lighting:stonebrick_pillar_brasier",
            ingredient = "unilib:stone_ordinary_brick",

            replace_mode = mode,
            description = S("Ordinary Stone Bricks"),
            img_list = {"unilib_stone_ordinary_brick.png"},
            -- (no override_ingredient)
        })

        -- Creates unilib:light_pillar_brazier_stone_ordinary_cobble
        table.insert(material_list, {
            part_name = "stone_ordinary_cobble",
            orig_name = "castle_lighting:cobble_pillar_brasier",
            ingredient = "unilib:stone_ordinary_cobble",

            replace_mode = mode,
            description = S("Ordinary Cobblestone"),
            img_list = {"unilib_stone_ordinary_cobble.png"},
            -- (no override_ingredient)
        })

    end

    if unilib.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        -- Creates unilib:light_pillar_brazier_stone_sandstone
        table.insert(material_list, {
            part_name = "stone_sandstone",
            orig_name = "castle_lighting:sandstone_pillar_brasier",
            ingredient = "unilib:stone_sandstone_ordinary",

            replace_mode = mode,
            description = S("Sandstone"),
            img_list = {"unilib_stone_sandstone_ordinary.png"},
            -- (no override_ingredient)
        })

        -- Creates unilib:light_pillar_brazier_stone_sandstone_brick
        table.insert(material_list, {
            part_name = "stone_sandstone_brick",
            orig_name = "castle_lighting:sandstonebrick_pillar_brasier",
            ingredient = "unilib:stone_sandstone_ordinary_brick",

            replace_mode = mode,
            description = S("Sandstone Bricks"),
            img_list = {"unilib_stone_sandstone_ordinary_brick.png"},
            -- (no override_ingredient)
        })

    end

    for _, data_table in pairs(material_list) do
        unilib.pkg.shared_castle_lighting.register_pillar_brazier(data_table)
    end

end
