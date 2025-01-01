---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_secret = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_secret.init()

    return {
        description = "Secret glass nodes",
        notes = "One face of the node looks like a smoothstone, cobble or brick, but only when" ..
                " viewed from the outside; all other surfaces are transparent, which creates" ..
                " a one-way window. Secret glass nodes are available for all super stones, in" ..
                " addition to basic white and black variants",
        depends = {"glass_artisanal_clear", "mineral_mese"},
        optional = {"decor_wall_clay_dark", "decor_wall_clay_pale"},
    }

end

function unilib.pkg.glass_secret.post()

    local secret_list = {}

    -- N.B. "stone_sandstone_desert" and "stone_sandstone_silver" variants are not found in the
    --      original code
    local orig_name_table = {
        decor_wall_clay_dark = "abriglass:oneway_glass_dark",
        decor_wall_clay_pale = "abriglass:oneway_glass_pale",
        stone_desert_brick = "abriglass:oneway_glass_desert_brick",
        stone_ordinary_brick = "abriglass:oneway_glass_stone_brick",
        stone_sandstone_ordinary_brick = "abriglass:oneway_glass_sandstone_brick",
    }

    if unilib.global.pkg_executed_table["decor_wall_clay_dark"] ~= nil then

        table.insert(
            secret_list,
            {
                "decor_wall_clay_dark",
                orig_name_table["decor_wall_clay_dark"],
                S("Decorative Dark Clay Wall"),
                "unilib_glass_secret_face.png",
                "unilib_decor_wall_clay_dark.png",
            }
        )

    end

    if unilib.global.pkg_executed_table["decor_wall_clay_pale"] ~= nil then

        table.insert(
            secret_list,
            {
                "decor_wall_clay_pale",
                orig_name_table["decor_wall_clay_pale"],
                S("Decorative Pale Clay Wall"),
                "unilib_glass_secret_face.png^[colorize:#F8F8FF:200",
                "unilib_decor_wall_clay_dark.png^[colorize:#E6E6FA:200",
            }
        )

    end

    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        local data_table = unilib.global.stone_table[stone_type]

        if unilib.global.pkg_executed_table["stone_" .. stone_type] ~= nil then

            local smooth_item_name = "stone_" .. stone_type
            local smooth_def_table = core.registered_nodes["unilib:" .. smooth_item_name]
            if smooth_def_table then

                table.insert(
                    secret_list,
                    {
                        smooth_item_name,
                        orig_name_table[smooth_item_name],
                        smooth_def_table.description,
                        "unilib_glass_secret_face.png^[colorize:" .. data_table.colour .. ":200",
                        smooth_def_table.tiles[1],
                    }
                )

            end

            local block_item_name = "stone_" .. stone_type .. "_block"
            local block_def_table = core.registered_nodes["unilib:" .. block_item_name]
            if block_def_table then

                table.insert(
                    secret_list,
                    {
                        block_item_name,
                        orig_name_table[block_item_name],
                        block_def_table.description,
                        "unilib_glass_secret_face.png^[colorize:" .. data_table.colour .. ":200",
                        block_def_table.tiles[1],
                    }
                )

            end

            local brick_item_name = "stone_" .. stone_type .. "_brick"
            local brick_def_table = core.registered_nodes["unilib:" .. brick_item_name]
            if brick_def_table then

                table.insert(
                    secret_list,
                    {
                        brick_item_name,
                        orig_name_table[brick_item_name],
                        brick_def_table.description,
                        "unilib_glass_secret_face.png^[colorize:" .. data_table.colour .. ":200",
                        brick_def_table.tiles[1],
                    }
                )

            end

        end

    end

    for _, mini_list in pairs(secret_list) do

        local part_name = mini_list[1]
        local orig_name = mini_list[2]
        local description = mini_list[3]
        local glass_img = mini_list[4]
        local other_img = mini_list[5]

        local ingredient = "unilib:" .. part_name

        unilib.register_node("unilib:glass_secret_" .. part_name, orig_name, mode, {
            -- From abriglass:oneway_glass_desert_brick, etc. Creates
            --      unilib:glass_secret_stone_desert_brick, etc
            description = unilib.utils.brackets(S("One-Way Glass"), description),
            -- N.B. tweaked the tile list from the original code for realism, as some faces were
            --      invisible
            tiles = {glass_img, glass_img, glass_img, glass_img, glass_img, other_img},
            groups = {cracky = 3},
            -- (no sounds)

            drawtype = "nodebox",
            -- N.B. only "glass_img" used in the original code
            inventory_image = core.inventorycube(glass_img, other_img, glass_img),
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        })
        unilib.register_craft({
            -- From abriglass:oneway_glass_desert_brick, etc
            output = "unilib:glass_secret_" .. part_name .. " 2",
            recipe = {
                {
                    "unilib:glass_artisanal_clear",
                    "unilib:mineral_mese_crystal_fragment",
                    ingredient,
                },
            },
        })

    end

end
