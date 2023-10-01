---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chain_metal_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chain_metal_dark.init()

    return {
        description = "Dark metal chain",
        depends = {"dye_basic", "metal_steel", "shared_morelights"},
    }

end

function unilib.pkg.chain_metal_dark.exec()

    unilib.register_node("unilib:chain_metal_dark", "morelights:chain_d", mode, {
        -- From morelights:chain_d
        description = S("Hanging Dark Metal Chain"),
        tiles = {"unilib_pole_metal_dark.png"},
        groups = {cracky = 3, handy = 1, mounted_ceiling = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.metal,

        collision_box = {
            type = "fixed",
            fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
        },
        drawtype = "mesh",
        inventory_image = "unilib_chain_metal_dark_inv.png",
        mesh = "unilib_chain_metal.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
        },
        sunlight_propagates = true,
        wield_image = "unilib_chain_metal_dark_inv.png",

        on_place = function(itemstack, placer, pointed_thing)

            return unilib.pkg.shared_morelights.on_place_hanging(
                itemstack,
                placer,
                pointed_thing,
                "unilib:chain_metal_dark_ceiling"
            )

        end,
    })
    unilib.register_craft({
        -- From morelights:chain_d
        output = "unilib:chain_metal_dark",
        recipe = {
            {"unilib:dye_grey_dark", "unilib:metal_steel_ingot", ""},
            {"", "", ""},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })

    -- (When attached to a ceiling, add a square bracket)
    unilib.register_node("unilib:chain_metal_dark_ceiling", "morelights:chain_ceiling_d", mode, {
        -- From morelights:chain_ceiling_d
        -- (no description)
        tiles = {"unilib_pole_metal_dark.png"},
        groups = {
            cracky = 3, handy = 1, mounted_ceiling = 1, not_in_creative_inventory = 1,
            oddly_breakable_by_hand = 3,
        },
        sounds = unilib.sound_table.metal,

        collision_box = {
            type = "fixed",
            fixed = {
                {-3/16, 7/16, -3/16, 3/16, 1/2, 3/16},
                {-1/16, -1/2, -1/16, 1/16, 7/16, 1/16},
            }
        },
        drawtype = "mesh",
        drop = "unilib:chain_metal_dark",
        mesh = "unilib_chain_metal_ceiling.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-3/16, 7/16, -3/16, 3/16, 1/2, 3/16},
                {-1/16, -1/2, -1/16, 1/16, 7/16, 1/16},
            }
        },
        sunlight_propagates = true,
    })

end
