---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_lava_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_lava_ordinary.init()

    return {
        description = "Ordinary lava",
        notes = "When cooled, source lava produce obsidian, flowing lava produces ordinary stone",
        depends = "stone_ordinary",
        optional = "stone_obsidian",
    }

end

function unilib.pkg.liquid_lava_ordinary.exec()

    -- (Creates unilib:bucket_steel_with_lava_ordinary, etc)
    unilib.register_liquid({
        part_name = "lava_ordinary",
        source_name = "unilib:liquid_lava_ordinary_source",
        flowing_name = "unilib:liquid_lava_ordinary_flowing",

        burntime = 60,
        description = S("Ordinary Lava"),
        force_renew_flag = false,
    })

    unilib.register_node(
        -- From default:lava_source
        "unilib:liquid_lava_ordinary_source",
        "default:lava_source",
        mode,
        {
            description = S("Ordinary Lava Source"),
            tiles = {
                {
                    name = "unilib_liquid_lava_ordinary_source_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 3.0,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_lava_ordinary_source_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 3.0,
                    },
                    backface_culling = true,
                },
            },
            groups = {igniter = 1, lava = 3, liquid = 2},
            -- (no sounds)

            buildable_to = true,
            damage_per_second = 4 * 2,
            diggable = false,
            drawtype = "liquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            light_source = unilib.light_max - 1,
            liquid_alternative_flowing = "unilib:liquid_lava_ordinary_flowing",
            liquid_alternative_source = "unilib:liquid_lava_ordinary_source",
            liquid_renewable = false,
            liquid_viscosity = 7,
            liquidtype = "source",
            paramtype = "light",
            pointable = false,
            post_effect_color = {r = 255, g = 64, b = 0, a = 191},
            walkable = false,
        }
    )
    unilib.register_craft({
        -- From default:lava_source
        type = "fuel",
        recipe = "unilib:liquid_lava_ordinary_source",
        burntime = 60,
    })
    if unilib.pkg_executed_table["stone_obsidian"] ~= nil then

        unilib.register_lava({
            cooled_name = "unilib:stone_obsidian",
            lava_name = "unilib:liquid_lava_ordinary_source",
        })

    end

    unilib.register_node(
        -- From default:lava_flowing
        "unilib:liquid_lava_ordinary_flowing",
        "default:lava_flowing",
        mode,
        {
            description = S("Flowing Ordinary Lava"),
            tiles = {"unilib_liquid_lava_ordinary.png"},
            groups = {igniter = 1, lava = 3, liquid = 2, not_in_creative_inventory = 1},
            -- (no sounds)

            buildable_to = true,
            damage_per_second = 4 * 2,
            diggable = false,
            drawtype = "flowingliquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            light_source = unilib.light_max - 1,
            liquid_alternative_flowing = "unilib:liquid_lava_ordinary_flowing",
            liquid_alternative_source = "unilib:liquid_lava_ordinary_source",
            liquid_renewable = false,
            liquid_viscosity = 7,
            liquidtype = "flowing",
            paramtype = "light",
            paramtype2 = "flowingliquid",
            pointable = false,
            post_effect_color = {r = 255, g = 64, b = 0, a = 191},
            special_tiles = {
                {
                    name = "unilib_liquid_lava_ordinary_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 3.3,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_lava_ordinary_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 3.3,
                    },
                    backface_culling = true,
                },
            },
            walkable = false,
        }
    )
    unilib.register_lava({
        cooled_name = "unilib:stone_ordinary",
        lava_name = "unilib:liquid_lava_ordinary_flowing",
    })

end
