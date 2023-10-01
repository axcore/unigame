---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_secret = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_secret.init()

    return {
        description = "Secret glass nodes",
        notes = "One face of the node looks like bricks, the other faces are transparent, which" ..
                " creates one-way glass. Secret glasses are available with the full set of" ..
                " super stone facades, as well as some sandstones from minetest_game",
        depends = {"glass_artisanal_clear", "mineral_mese"},
        at_least_one = {
            "decor_wall_clay_dark",
            "decor_wall_clay_pale",
            "stone_desert",
            "stone_ordinary",
            "stone_sandstone_desert",
            "stone_sandstone_ordinary",
            "stone_sandstone_silver",
        },
    }

end

function unilib.pkg.glass_secret.exec()

    local secret_list = {}
    if unilib.pkg_executed_table["decor_wall_clay_dark"] ~= nil then

        table.insert(
            secret_list,
            {
                "decor_wall_clay_dark",
                "abriglass:oneway_glass_dark",
                S("Decorative Dark Clay Wall"),
                "unilib_glass_secret_face.png",
                "unilib_decor_wall_clay_dark.png",
            }
        )

    end

    if unilib.pkg_executed_table["decor_wall_clay_pale"] ~= nil then

        table.insert(
            secret_list,
            {
                "decor_wall_clay_pale",
                "abriglass:oneway_glass_pale",
                S("Decorative Pale Clay Wall"),
                "unilib_glass_secret_face.png^[colorize:#F8F8FF:200",
                "unilib_decor_wall_clay_dark.png^[colorize:#E6E6FA:200",
            }
        )

    end

    if unilib.pkg_executed_table["stone_desert"] ~= nil then

        table.insert(
            secret_list,
            {
                "stone_desert_brick",
                "abriglass:oneway_glass_desert_brick",
                S("Desert Stone Bricks"),
                "unilib_glass_secret_face.png^[colorize:#814F3C:200",
                "unilib_stone_desert_brick.png",
            }
        )

    end

    if unilib.pkg_executed_table["stone_ordinary"] ~= nil then

        table.insert(
            secret_list,
            {
                "stone_ordinary_brick",
                "abriglass:oneway_glass_stone_brick",
                S("Ordinary Stone Bricks"),
                "unilib_glass_secret_face.png^[colorize:#615E5D:200",
                "unilib_stone_ordinary_brick.png",
            }
        )

    end

    if unilib.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        table.insert(
            secret_list,
            {
                "stone_sandstone_ordinary_brick",
                "abriglass:oneway_glass_sandstone_brick",
                S("Ordinary Sandstone Bricks"),
                "unilib_glass_secret_face.png^[colorize:#FFF9C5:200",
                "unilib_stone_sandstone_ordinary_brick.png",
            }
        )

    end

    -- N.B. Not found in the original code
    if unilib.pkg_executed_table["stone_sandstone_desert"] ~= nil then

        table.insert(
            secret_list,
            {
                "stone_sandstone_desert_brick",
                nil,
                S("Desert Sandstone Bricks"),
                "unilib_glass_secret_face.png^[colorize:#BC955E:200",
                "unilib_stone_sandstone_desert_brick.png",
            }
        )

    end

    -- N.B. Not found in the original code
    if unilib.pkg_executed_table["stone_sandstone_silver"] ~= nil then

        table.insert(
            secret_list,
            {
                "stone_sandstone_silver_brick",
                nil,
                S("Silver Sandstone Bricks"),
                "unilib_glass_secret_face.png^[colorize:#C4C2B7:200",
                "unilib_stone_sandstone_silver_brick.png",
            }
        )

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
            description = unilib.brackets(S("One-Way Glass"), description),
            -- N.B. tweaked the tile list from the original code for realism, as some faces were
            --      invisible
            tiles = {glass_img, glass_img, glass_img, glass_img, glass_img, other_img},
            groups = {cracky = 3},
            -- (no sounds)

            drawtype = "nodebox",
            inventory_image = minetest.inventorycube(glass_img),
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
