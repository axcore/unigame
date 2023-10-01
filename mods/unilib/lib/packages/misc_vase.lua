---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_vase = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_vase.init()

    return {
        description = "Set of ornamental vases",
        at_least_one = {"brick_ordinary", "stone_desert", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.misc_vase.exec()

    local vase_list = {
        {
            "ancient",
            "decoblocks:ancient_vase",
            S("Ancient Ornamental Vase"),
            "stone_desert",
        },
        {
            "clay",
            "decoblocks:vase",
            S("Ornamental Clay Vase"),
            "brick_ordinary"
        },
        {
            "sandstone",
            "decoblocks:ancient_vase_sand",
            S("Ornamental Sandstone Vase"),
            "stone_sandstone_ordinary",
        },
    }

    for _, mini_list in pairs(vase_list) do

        local part_name = mini_list[1]
        local orig_name = mini_list[2]
        local description = mini_list[3]
        local item_name = mini_list[4]

        local ingredient = "unilib:" .. item_name

        if unilib.pkg_executed_table[item_name] ~= nil then

            unilib.register_node("unilib:misc_vase_" .. part_name, orig_name, mode, {
                description = description,
                tiles = {"unilib_misc_vase_" .. part_name .. ".png"},
                groups = {cracky = 2, stone = 1},
                sounds = unilib.sound_table.stone,

                collision_box = {
                    type = "fixed",
                    fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
                },
                drawtype = "mesh",
                mesh = "unilib_misc_vase.obj",
                paramtype = "light",
                selection_box = {
                    type = "fixed",
                    fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
                },
                use_texture_alpha = "clip",
                visual_scale = 0.5,
                wield_scale = {x = 0.5, y = 0.5, z = 0.5},
            })
            unilib.register_craft({
                output = "unilib:misc_vase_" .. part_name,
                recipe = {
                    {ingredient, "", ingredient},
                    {ingredient, "", ingredient},
                    {"", ingredient, ""},
                },
            })

        end

    end

end
