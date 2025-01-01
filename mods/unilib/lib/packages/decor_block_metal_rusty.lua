---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    columnia
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_metal_rusty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.columnia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_metal_rusty.init()

    return {
        description = "Rusty metal block",
        depends = "metal_steel",
        optional = "misc_blueprint_column",
        at_least_one = {"liquid_water_ordinary", "liquid_water_river"},
    }

end

function unilib.pkg.decor_block_metal_rusty.exec()

    local c_blueprint = "unilib:misc_blueprint_column"
    local c_steel_ingot = "unilib:metal_steel_ingot"
    local c_water = "unilib:liquid_water_ordinary_source"

    unilib.register_node("unilib:decor_block_metal_rusty", "lib_materials:rusty", mode, {
        -- From GLEMr4, lib_materials:rusty
        description = S("Rusty Metal Block"),
        tiles = {"unilib_decor_block_metal_rusty.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_stairs("unilib:decor_block_metal_rusty")
    unilib.register_carvings("unilib:decor_block_metal_rusty", {
        column_flag = true,
    })

    if unilib.global.pkg_executed_table["misc_blueprint_column"] ~= nil then

        unilib.register_node(
            -- From columnia:rusty_block
            "unilib:decor_block_metal_rusty_etched",
            "columnia:rusty_block",
            mode,
            {
                description = S("Etched Rusty Metal Block"),
                tiles = {"unilib_decor_block_metal_rusty_etched.png"},
                groups = {cracky = 1, level = 2},
                sounds = unilib.global.sound_table.stone,

                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From columnia:rusty_block
            output = "unilib:decor_block_metal_rusty_etched 8",
            recipe = {
                {c_steel_ingot, c_steel_ingot, c_steel_ingot},
                {c_steel_ingot, c_blueprint, c_steel_ingot},
                {c_steel_ingot, c_steel_ingot, c_steel_ingot},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })
        unilib.register_stairs("unilib:decor_block_metal_rusty_etched", {
            img_rotate_flag = true,
        })
        unilib.register_carvings("unilib:decor_block_metal_rusty_etched", {
            column_flag = true,
        })

    end

end

function unilib.pkg.decor_block_metal_rusty.post()

    local c_steel_ingot = "unilib:metal_steel_ingot"

    -- N.B. original code used "default:water_source" instead of a bucket
    unilib.register_craft({
        -- From GLEMr4, lib_materials:rusty
        output = "unilib:decor_block_metal_rusty 8",
        recipe = {
            {c_steel_ingot, c_steel_ingot, c_steel_ingot},
            {c_steel_ingot, "group:craftable_bucket", c_steel_ingot},
            {c_steel_ingot, c_steel_ingot, c_steel_ingot},
        },
        replacements = unilib.global.craftable_bucket_list,
    })

end
