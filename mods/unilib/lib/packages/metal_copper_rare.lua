---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_copper_rare = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_copper_rare.init()

    return {
        description = "Rare copper",
        at_least_one = {"mineral_copper_native", "mineral_malachite", "mineral_tetrahedrite"},
    }

end

function unilib.pkg.metal_copper_rare.exec()

    local mineral_part_name_list = {}

    unilib.register_metal({
        -- Original to unilib
        part_name = "copper_rare",
        description = S("Rare Copper"),

        hardness = 2,
    })

    unilib.register_craftitem(
        -- From real_minerals:copper_ingot
        "unilib:metal_copper_rare_ingot",
        "real_minerals:copper_ingot",
        mode,
        {
            description = S("Rare Copper Ingot"),
            inventory_image = "unilib_metal_copper_rare_ingot.png",
            groups = {metal_ingot = 1},
        }
    )
    if unilib.global.pkg_executed_table["mineral_copper_native"] ~= nil then

        unilib.register_craft({
            -- From real_minerals:copper_ingot
            type = "cooking",
            output = "unilib:metal_copper_rare_ingot",
            recipe = "unilib:mineral_copper_native_lump",

            cooktime = 5,
        })

        table.insert(mineral_part_name_list, "copper_native")

    end
    if unilib.global.pkg_executed_table["mineral_malachite"] ~= nil then

        unilib.register_craft({
            -- From real_minerals:copper_ingot
            type = "cooking",
            output = "unilib:metal_copper_rare_ingot",
            recipe = "unilib:mineral_malachite_lump",

            cooktime = 5,
        })

        table.insert(mineral_part_name_list, "malachite")

    end
    if unilib.global.pkg_executed_table["mineral_tetrahedrite"] ~= nil then

        unilib.register_craft({
            -- From real_minerals:copper_ingot
            type = "cooking",
            output = "unilib:metal_copper_rare_ingot",
            recipe = "unilib:mineral_tetrahedrite_lump",

            cooktime = 5,
        })

        table.insert(mineral_part_name_list, "tetrahedrite")

    end
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_copper_rare_ingot 9",
        recipe = {
            {"unilib:metal_copper_rare_block"},
        }
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_copper_rare_powder
        orig_name = nil,
        metal_part_name = "copper_rare",
        mineral_part_name = mineral_part_name_list,

        replace_mode = mode,
        description = S("Rare Copper Powder"),
    })

    unilib.register_node("unilib:metal_copper_rare_block", "real_minerals:copper_block", mode, {
        -- From real_minerals:copper_block
        description = S("Rare Copper Block"),
        tiles = {"unilib_metal_copper_rare_block.png"},
        groups = {bendy = 2, cracky = 2, level = 1, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:copper_block
        output = "unilib:metal_copper_rare_block",
        ingredient = "unilib:metal_copper_rare_ingot",
    })
    unilib.register_stairs("unilib:metal_copper_rare_block")
    unilib.register_carvings("unilib:metal_copper_rare_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_copper_rare_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Rare Copper Block"),
            tiles = {"unilib_metal_copper_rare_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("copper_rare")

    end

end
