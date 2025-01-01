---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_iron_pig = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_iron_pig.init()

    return {
        description = "Pig iron",
        optional = {"mineral_haematite", "mineral_limonite", "mineral_magnetite"},
    }

end

function unilib.pkg.metal_iron_pig.exec()

    local mineral_part_name_list = {}

    unilib.register_metal({
        -- Original to unilib
        part_name = "iron_pig",
        description = S("Pig Iron"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_iron_pig_ingot", "real_minerals:pig_iron_ingot", mode, {
        -- From real_minerals:pig_iron_ingot
        description = S("Pig Iron Ingot"),
        inventory_image = "unilib_metal_iron_pig_ingot.png",
        -- N.B. alloy = 1 not in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    if unilib.global.pkg_executed_table["mineral_haematite"] ~= nil then

        unilib.register_craft({
            -- From real_minerals:pig_iron_ingot
            type = "cooking",
            output = "unilib:metal_iron_pig_ingot",
            recipe = "unilib:mineral_haematite_lump",

            cooktime = 5,
        })

        table.insert(mineral_part_name_list, "haematite")

    end
    if unilib.global.pkg_executed_table["mineral_limonite"] ~= nil then

        unilib.register_craft({
            -- From real_minerals:pig_iron_ingot
            type = "cooking",
            output = "unilib:metal_iron_pig_ingot",
            recipe = "unilib:mineral_limonite_lump",

            cooktime = 5,
        })

        table.insert(mineral_part_name_list, "limonite")

    end
    if unilib.global.pkg_executed_table["mineral_magnetite"] ~= nil then

        unilib.register_craft({
            -- From real_minerals:pig_iron_ingot
            type = "cooking",
            output = "unilib:metal_iron_pig_ingot",
            recipe = "unilib:mineral_magnetite_lump",

            cooktime = 5,
        })

        table.insert(mineral_part_name_list, "magnetite")

    end
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_iron_pig_ingot 9",
        recipe = {
            {"unilib:metal_iron_pig_block"},
        },
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_iron_pig_powder
        orig_name = nil,
        metal_part_name = "iron_pig",
        mineral_part_name = mineral_part_name_list,

        replace_mode = mode,
        description = S("Pig Iron Powder"),
    })

    unilib.register_node("unilib:metal_iron_pig_block", "real_minerals:pig_iron_block", mode, {
        -- From real_minerals:pig_iron_block
        description = S("Pig Iron Block"),
        tiles = {"unilib_metal_iron_pig_block.png"},
        groups = {bendy = 2, cracky = 2, level = 3, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:pig_iron_block
        output = "unilib:metal_iron_pig_block",
        ingredient = "unilib:metal_iron_pig_ingot",
    })
    unilib.register_stairs("unilib:metal_iron_pig_block")
    unilib.register_carvings("unilib:metal_iron_pig_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_iron_pig_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Pig Iron Block"),
            tiles = {"unilib_metal_iron_pig_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("iron_pig")

    end

end
