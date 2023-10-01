---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    forest
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_oil_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.forest.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_oil_normal.init()

    return {
        description = "Normal oil",
    }

end

function unilib.pkg.liquid_oil_normal.exec()

    -- (Creates unilib:bucket_steel_with_oil_normal, etc)
    unilib.register_liquid({
        part_name = "oil_normal",
        source_name = "unilib:liquid_oil_normal_source",
        flowing_name = "unilib:liquid_oil_normal_flowing",

        -- (No burntime in original code, so use half the burntime of lava)
        burntime = 30,
        description = S("Normal Oil"),
        force_renew_flag = false,
    })

    unilib.register_node("unilib:liquid_oil_normal_source", "forest:oil_source", mode, {
        -- From forest:oil_source
        description = S("Normal Oil Source"),
        tiles = {
            {
                name = "unilib_liquid_oil_normal_source_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 22,
                },
            },
        },
        groups = {flammable = 2, liquid = 3, oil = 1},
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 1,
        diggable = false,
        drawtype = "liquid",
        drop = "",
        drowning = 1,
        inventory_image = minetest.inventorycube("unilib_liquid_oil_normal.png"),
        liquid_alternative_flowing = "unilib:liquid_oil_normal_flowing",
        liquid_alternative_source = "unilib:liquid_oil_normal_source",
        liquid_viscosity = 4,
        liquidtype = "source",
        paramtype = "light",
        pointable = false,
        post_effect_color = {r = 32, g = 20, b = 12, a = 255},
        special_tiles = {
            {
                name = "unilib_liquid_oil_normal_source_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 22,
                },
                backface_culling = false,
            }
        },
        walkable = false,
    })

    unilib.register_node("unilib:liquid_oil_normal_flowing", "forest:oil_flowing", mode, {
        -- From forest:oil_flowing
        description = S("Flowing Normal Oil"),
        tiles = {"unilib_liquid_oil_normal.png"},
        groups = {flammable = 2, liquid = 3, not_in_creative_inventory = 1, oil = 1},
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 1,
        diggable = false,
        drawtype = "flowingliquid",
        drop = "",
        drowning = 1,
        inventory_image = minetest.inventorycube("unilib_liquid_oil_normal.png"),
        liquid_alternative_flowing = "unilib:liquid_oil_normal_flowing",
        liquid_alternative_source = "unilib:liquid_oil_normal_source",
        liquid_viscosity = 4,
        liquidtype = "flowing",
        paramtype = "light",
        paramtype2 = "flowingliquid",
        pointable = false,
        post_effect_color = {r = 32, g = 20, b = 12, a = 255},
        special_tiles = {
            {
                image = "unilib_liquid_oil_normal_flowing_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 10,
                },
                backface_culling = false,
            },
            {
                image = "unilib_liquid_oil_normal_flowing_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 10,
                },
                backface_culling = true,
            },
        },
        walkable = false,
    })

end
