---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_underch_slime = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_underch_slime.register_slime_eye(data_table)

    -- Adapted from underch/slime.lua
    -- Called from a package like "stone_slimestone_green_extra" to create related slimestone eye
    --      items
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "green"
    --      eye_desc (str): e.g. "Green Slimestone Eye"
    --      block_desc (str): e.g. "Green Slimestone Eye Block"
    --      ore_desc (str): e.g. "Green Slimestone Eye Ore"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local eye_desc = data_table.eye_desc
    local block_desc = data_table.block_desc
    local ore_desc = data_table.ore_desc

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:stone_slimestone_" .. part_name
    local part_img = "unilib_stone_slimestone_" .. part_name

    unilib.register_craftitem(
        full_name .. "_eye",
        "underch:" .. part_name .. "eye_item",
        replace_mode,
        {
            description = eye_desc,
            inventory_image = part_img .. "_eye.png",
        }
    )
    minetest.register_craft({
        type = "shapeless",
        output = full_name .. "_eye 9",
        recipe = {full_name .. "_eye_block"}
    })

    unilib.register_node(
        full_name .. "_eye_block",
        "underch:" .. part_name .. "eye_block",
        replace_mode,
        {
            description = block_desc,
            tiles = {part_img .. "_eye_block.png"},
            groups = {oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.dirt,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        output = full_name .. "_eye_block",
        ingredient = full_name .. "_eye",
    })

    unilib.register_node(
        full_name .. "_with_eye",
        "underch:" .. part_name .. "eye_ore",
        replace_mode,
        {
            description = ore_desc,
            tiles = {part_img .. "_with_eye.png"},
            groups = {cracky = 2, crumbly = 1},
            sounds = unilib.sound_table.dirt,

            drop = full_name .. "_eye",
        }
    )

end

function unilib.pkg.shared_underch_slime.register_block_slimy(data_table)

    -- Adapted from underch/slime.lua
    -- Called from a package like "stone_slimestone_green_extra" to create related slimy block items
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "green"
    --      block_desc (str): e.g. "Green Slimy Block"
    --      ingredient (str): e.g. "unilib:stone_slimestone_green"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local block_desc = data_table.block_desc
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:stone_slimestone_" .. part_name
    local part_img = "unilib_stone_slimestone_" .. part_name

    unilib.register_node(
        full_name .. "_block_slimy",
        "underch:" .. part_name .. "_slimy_block",
        replace_mode,
        {
            description = block_desc,
            tiles = {part_img .. "_block_slimy.png"},
            groups = {cracky = 2, crumbly = 1},
            sounds = unilib.sound_table.dirt,
        }
    )
    minetest.register_craft({
        type = "cooking",
        output = full_name,
        recipe = ingredient,
    })
    unilib.register_stairs(full_name .. "_block_slimy")

end

function unilib.pkg.shared_underch_slime.register_brick_slimy(data_table)

    -- Original to unilib (code), from underch (textures)
    -- Called from a package like "stone_slimestone_green_extra" to create related slimy brick items
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "green"
    --      brick_desc (str): e.g. "Green Slimy Bricks"
    --      ingredient (str): e.g. "unilib:stone_slimestone_green_block_slimy"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local brick_desc = data_table.brick_desc
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:stone_slimestone_" .. part_name .. "_brick_slimy"

    unilib.register_node(full_name, nil, replace_mode, {
        description = brick_desc,
        tiles = {"unilib_stone_slimestone_" .. part_name .. "_brick_slimy.png"},
        groups = {cracky = 2, crumbly = 1},
        sounds = unilib.sound_table.dirt,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        output = full_name,
        ingredient = ingredient,
    })
    unilib.register_stairs(full_name)
    unilib.set_auto_rotate(full_name, unilib.auto_rotate_brick_flag)

end

function unilib.pkg.shared_underch_slime.register_liquid_slime(data_table)

    -- Adapted from underch/slime.lua
    -- Called from a package like "stone_slimestone_green_extra" to create related liquid slime
    --      items
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "green"
    --      bucket_desc (str): e.g. "Green Slime"
    --      source_desc (str): e.g. "Green Slime Source"
    --      flowing_desc (str): e.g. "Flowing Green Slime"
    --      colour_table (table): Table used in the liquid slime's .post_effect_color field, e.g.
    --          {r = 20, g = 160, b = 0, a = 210}
    --      wherein (str): e.g. "unilib:stone_slimestone_green", an item defined by the calling
    --          package
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local bucket_desc = data_table.bucket_desc
    local source_desc = data_table.source_desc
    local flowing_desc = data_table.flowing_desc
    local colour_table = data_table.colour_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local source_name = "unilib:liquid_slime_" .. part_name .. "_source"
    local flowing_name = "unilib:liquid_slime_" .. part_name .. "_flowing"
    local source_img = "unilib_liquid_slime_" .. part_name .. "_source.png"
    local flowing_img = "unilib_liquid_slime_" .. part_name .. "_source.png"

    -- (Creates unilib:bucket_steel_with_slime_green, etc)
    unilib.register_liquid({
        part_name = "slime_" .. part_name,
        source_name = source_name,
        flowing_name = flowing_name,

        burntime = 0,
        description = bucket_desc,
    })

    unilib.register_node(source_name, "underch:" .. part_name .. "_slime_source", replace_mode, {
        description = source_desc,
        tiles = {source_img},
        groups = {
            cools_lava = 1, liquid = 3, not_in_creative_inventory = 1, puts_out_fire = 1, water = 3,
        },
        sounds = unilib.sound_table.sand,

        buildable_to = true,
        diggable = false,
        drawtype = "liquid",
        drop = "",
        drowning = 1,
        is_ground_content = false,
        liquid_alternative_flowing = flowing_name,
        liquid_alternative_source = source_name,
        liquid_renewable = false,
        liquid_viscosity = 12,
        liquidtype = "source",
        paramtype = "light",
        pointable = false,
        post_effect_color = colour_table,
        special_tiles = {source_img},
        walkable = false,
    })

    unilib.register_node(flowing_name, "underch:" .. part_name .. "_slime_flowing", replace_mode, {
        description = flowing_desc,
        tiles = {source_img},
        groups = {
            cools_lava = 1, liquid = 3, not_in_creative_inventory = 1, puts_out_fire = 1, water = 3,
        },
        sounds = default.node_sound_sand_defaults(),

        buildable_to = true,
        diggable = false,
        drawtype = "flowingliquid",
        drop = "",
        drowning = 12,
        is_ground_content = false,
        liquid_alternative_flowing = flowing_name,
        liquid_alternative_source = source_name,
        liquid_viscosity = 17,
        liquid_renewable = false,
        liquidtype = "flowing",
        paramtype = "light",
        paramtype2 = "flowingliquid",
        pointable = false,
        post_effect_color = colour_table,
        special_tiles = {
            {
                name = flowing_img,
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 6.0,
                },
            },
            {
                name = flowing_img,
                backface_culling = true,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 6.0,
                },
            },
        },
        walkable = false,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_underch_slime.init()

    return {
        description = "Shared functions for slime (from underch)",
    }

end
