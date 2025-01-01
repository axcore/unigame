---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_oil_crude = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_oil_crude.init()

    return {
        description = "Crude oil",
        notes = "Crude oil can be refined into normal oil using cobblestone",
        optional = {"bucket_steel", "liquid_oil_normal"},
    }

end

function unilib.pkg.liquid_oil_crude.exec()

    -- (Creates unilib:bucket_steel_with_oil_crude, etc)
    unilib.register_liquid({
        part_name = "oil_crude",
        source_name = "unilib:liquid_oil_crude_source",
        flowing_name = "unilib:liquid_oil_crude_flowing",

        -- (Slightly lower than the burntime of normal oil, which is 30)
        burntime = 25,
        description = S("Crude Oil"),
        force_renew_flag = false,
    })

    unilib.register_node("unilib:liquid_oil_crude_source", nil, mode, {
        -- Original to unilib, adapted from forest:oil_source
        description = S("Crude Oil Source"),
        tiles = {
            {
                name = "unilib_liquid_oil_crude_source_animated.png",
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
        inventory_image = core.inventorycube("unilib_liquid_oil_crude.png"),
        -- N.B. is_ground_content = false not in original code; added to match other liquids
        is_ground_content = false,
        liquid_alternative_flowing = "unilib:liquid_oil_crude_flowing",
        liquid_alternative_source = "unilib:liquid_oil_crude_source",
        liquid_viscosity = 5,
        liquidtype = "source",
        paramtype = "light",
        pointable = false,
        post_effect_color = {r = 32, g = 20, b = 12, a = 255},
        special_tiles = {
            {
                name = "unilib_liquid_oil_crude_source_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 22,
                },
                backface_culling = false,
            },
        },
        walkable = false,
    })

    unilib.register_node("unilib:liquid_oil_crude_flowing", "forest:oil_flowing", mode, {
        -- Original to unilib, adapted from  forest:oil_flowing
        description = S("Flowing Crude Oil"),
        tiles = {"unilib_liquid_oil_crude.png"},
        groups = {flammable = 2, liquid = 3, not_in_creative_inventory = 1, oil = 1},
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 1,
        diggable = false,
        drawtype = "flowingliquid",
        drop = "",
        drowning = 1,
        inventory_image = core.inventorycube("unilib_liquid_oil_crude.png"),
        -- N.B. is_ground_content = false not in original code; added to match other liquids
        is_ground_content = false,
        liquid_alternative_flowing = "unilib:liquid_oil_crude_flowing",
        liquid_alternative_source = "unilib:liquid_oil_crude_source",
        liquid_viscosity = 5,
        liquidtype = "flowing",
        paramtype = "light",
        paramtype2 = "flowingliquid",
        pointable = false,
        post_effect_color = {r = 32, g = 20, b = 12, a = 255},
        special_tiles = {
            {
                image = "unilib_liquid_oil_crude_flowing_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 10,
                },
                backface_culling = false,
            },
            {
                image = "unilib_liquid_oil_crude_flowing_animated.png",
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

function unilib.pkg.liquid_oil_crude.post()

    if unilib.global.pkg_executed_table["bucket_steel"] ~= nil and
            unilib.global.pkg_executed_table["liquid_oil_normal"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:bucket_steel_with_oil_normal",
            recipe = {
                {"group:cobble", "group:cobble", "group:cobble"},
                {"group:cobble", "unilib:bucket_steel_with_oil_crude", "group:cobble"},
                {"group:cobble", "group:cobble", "group:cobble"},
            },
        })

    end

end

