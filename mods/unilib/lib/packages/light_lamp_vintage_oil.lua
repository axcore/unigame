---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_vintage_oil = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_vintage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_vintage_oil.init()

    return {
        description = "Vintage oil lamp",
        depends = {"glass_ordinary", "item_string_ordinary", "metal_brass"},
    }

end

function unilib.pkg.light_lamp_vintage_oil.exec()

    unilib.register_node("unilib:light_lamp_vintage_oil", "morelights_vintage:oillamp", mode, {
        -- From morelights_vintage:oillamp
        description = S("Vintage Oil Lamp"),
        tiles = {
            {
                name = "unilib_light_lamp_vintage_oil_flame.png",
                animation = {
                    type = "sheet_2d",
                    frames_w = 16,
                    frames_h = 1,
                    frame_length = 0.3,
                }
            },
            "unilib_light_lamp_vintage_oil.png",
            "unilib_chain_brass_vintage.png",
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        collision_box = {
            type = "fixed",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/4, 1/8},
        },
        drawtype = "mesh",
        light_source = 8,
        mesh = "unilib_light_lamp_vintage_oil.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/4, 1/8},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From morelights_vintage:oillamp
        output = "unilib:light_lamp_vintage_oil",
        recipe = {
            {"", "unilib:glass_ordinary", ""},
            {"", "unilib:item_string_ordinary", ""},
            {"", "unilib:metal_brass_ingot", ""}
        }
    })

end
