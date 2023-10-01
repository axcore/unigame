---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_dirty = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_dirty.init()

    return {
        description = "Dirty water",
    }

end

function unilib.pkg.liquid_water_dirty.exec()

    -- (Creates unilib:bucket_steel_with_water_dirty, etc)
    unilib.register_liquid({
        part_name = "water_dirty",
        source_name = "unilib:liquid_water_dirty_source",
        flowing_name = "unilib:liquid_water_dirty_flowing",

        burntime = 0,
        -- N.B. The packages "material_stucco" and "metal_steel_rusty" use this for non-ingestable
        --      crafting
        craftable_flag = true,
        description = S("Dirty Water"),
        force_renew_flag = false,
        water_flag = true,
    })

    unilib.register_node("unilib:liquid_water_dirty_source", "mapgen:dirty_water_source", mode, {
        -- From farlands, mapgen:dirty_water_source
        description = S("Dirty Water Source"),
        tiles = {
            {
                name = "unilib_liquid_water_dirty_source_animated.png^[opacity:200",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            },
        },
        groups = {cools_lava = 1, liquid = 3, puts_out_fire = 1, water = 3},
        sounds = unilib.sound_table.water,

        buildable_to = true,
        diggable = false,
        drawtype = "liquid",
        drop = "",
        drowning = 1,
        is_ground_content = false,
        liquidtype = "source",
        liquid_alternative_flowing = "unilib:liquid_water_dirty_flowing",
        liquid_alternative_source = "unilib:liquid_water_dirty_source",
        liquid_range = 2,
        liquid_renewable = false,
        liquid_viscosity = 2,
        paramtype = "light",
        pointable = false,
        post_effect_color = {r = 30, g = 76, b = 90, a = 103},
        use_texture_alpha = "blend",
        walkable = false,
    })

    unilib.register_node("unilib:liquid_water_dirty_flowing", "mapgen:dirty_water_flowing", mode, {
        -- From farlands, mapgen:dirty_water_flowing
        description = S("Flowing Dirty Water"),
        -- (no tiles)
        groups = {
            cools_lava = 1, liquid = 3, not_in_creative_inventory = 1, puts_out_fire = 1, water = 3,
        },
        sounds = unilib.sound_table.water,

        buildable_to = true,
        diggable = false,
        drawtype = "flowingliquid",
        drop = "",
        drowning = 1,
        is_ground_content = false,
        liquidtype = "flowing",
        liquid_alternative_flowing = "unilib:liquid_water_dirty_flowing",
        liquid_alternative_source = "unilib:liquid_water_dirty_source",
        liquid_range = 2,
        liquid_renewable = false,
        liquid_viscosity = 1,
        paramtype = "light",
        paramtype2 = "flowingliquid",
        pointable = false,
        post_effect_color = {r = 30, g = 76, b = 90, a = 103},
        special_tiles = {
            {
                name = "unilib_liquid_water_dirty_flowing_animated.png^[opacity:200",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            },
            {
                name = "unilib_liquid_water_dirty_flowing_animated.png^[opacity:200",
                backface_culling = true,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            },
        },
        use_texture_alpha = "blend",
        walkable = false,
    })

end
