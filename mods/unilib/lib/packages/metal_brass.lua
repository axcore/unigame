---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_brass = {}

local S = unilib.intllib
local basic_materials_add_mode = unilib.global.imported_mod_table.basic_materials.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_brass.init()

    return {
        description = "Brass",
        depends = {"metal_copper", "metal_silver"},
        optional = {"metal_gold", "metal_tin"},
    }

end

function unilib.pkg.metal_brass.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "brass",
        description = S("Brass"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- From technic:brass_dust. Creates unilib:metal_brass_powder
        part_name = "brass",
        orig_name = "technic:brass_dust",

        replace_mode = technic_add_mode,
        description = S("Brass Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From basic_materials:brass_ingot
        "unilib:metal_brass_ingot",
        {"basic_materials:brass_ingot", "homedecor:brass_ingot", "technic:brass_ingot"},
        basic_materials_add_mode,
        {
            description = S("Brass Ingot"),
            inventory_image = "unilib_metal_brass_ingot.png",
            -- N.B. no groups in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:brass_ingot
        type = "shapeless",
        output = "unilib:metal_brass_ingot 3",
        recipe = {
            "unilib:metal_copper_ingot",
            "unilib:metal_copper_ingot",
            "unilib:metal_silver_ingot",
        },
    })
    if unilib.global.pkg_executed_table["metal_gold"] ~= nil and
            unilib.global.pkg_executed_table["metal_tin"] ~= nil then

        -- (Recipe used in case moreores was not loaded; unilib preserves it)
        unilib.register_craft({
            -- From basic_materials:brass_ingot
            output = "unilib:metal_brass_ingot 9",
            recipe = {
                {
                    "unilib:metal_copper_ingot",
                    "unilib:metal_tin_ingot",
                    "unilib:metal_copper_ingot",
                },
                {
                    "unilib:metal_gold_ingot",
                    "unilib:metal_copper_ingot",
                    -- N.B. gold ingot becomes a tin ingot in more recent versions of
                    --      basic_materials
                    "unilib:metal_gold_ingot",
                },
                {
                    "unilib:metal_copper_ingot",
                    "unilib:metal_tin_ingot",
                    "unilib:metal_copper_ingot",
                },
            },
        })

    end
    unilib.register_craft({
        -- From basic_materials:brass_ingot
        output = "unilib:metal_brass_ingot 9",
        recipe = {
            {"unilib:metal_brass_block"},
        },
    })

    unilib.register_node(
        -- From basic_materials:brass_block
        "unilib:metal_brass_block",
        {"basic_materials:brass_block", "technic:brass_block"},
        basic_materials_add_mode,
        {
            description = S("Brass Block"),
            tiles = {"unilib_metal_brass_block.png"},
            groups = {cracky = 1, level = 2},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From basic_materials:brass_block
        output = "unilib:metal_brass_block",
        ingredient = "unilib:metal_brass_ingot",
    })
    unilib.register_stairs("unilib:metal_brass_block")
    unilib.register_carvings("unilib:metal_brass_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_brass_block_compressed", nil, basic_materials_add_mode, {
            -- Original to unilib
            description = S("Compressed Brass Block"),
            tiles = {"unilib_metal_brass_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("brass")

    end

end
