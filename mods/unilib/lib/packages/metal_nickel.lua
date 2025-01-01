---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_nickel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_nickel.init()

    return {
        description = "Nickel",
        depends = "mineral_garnierite",
    }

end

function unilib.pkg.metal_nickel.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "nickel",
        description = S("Nickel"),

        hardness = 2,
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_nickel_powder
        orig_name = nil,
        metal_part_name = "nickel",
        mineral_part_name = "garnierite",

        replace_mode = mode,
        description = S("Nickel Powder"),
    })

    unilib.register_craftitem("unilib:metal_nickel_ingot", "real_minerals:nickel_ingot", mode, {
        -- From real_minerals:nickel_ingot
        description = S("Nickel Ingot"),
        inventory_image = "unilib_metal_nickel_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:nickel_ingot
        type = "cooking",
        output = "unilib:metal_nickel_ingot",
        recipe = "unilib:mineral_garnierite_lump",

        cooktime = 5,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_nickel_ingot 9",
        recipe = {
            {"unilib:metal_nickel_block"},
        },
    })

    unilib.register_node("unilib:metal_nickel_block", "real_minerals:nickel_block", mode, {
        -- From real_minerals:nickel_block
        description = S("Nickel Block"),
        tiles = {"unilib_metal_nickel_block.png"},
        -- N.B. level = 4 in original code; reduced to 3 because only admin-restricted unilib tools
        --      can dig level = 4
        groups = {bendy = 2, cracky = 2, level = 3, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:nickel_block
        output = "unilib:metal_nickel_block",
        ingredient = "unilib:metal_nickel_ingot",
    })
    unilib.register_stairs("unilib:metal_nickel_block")
    unilib.register_carvings("unilib:metal_nickel_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_nickel_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Nickel Block"),
            tiles = {"unilib_metal_nickel_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("nickel")

    end

end
