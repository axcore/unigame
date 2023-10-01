---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_chandelier_vintage = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_vintage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_chandelier_vintage.init()

    return {
        description = "Vintage chandelier",
        depends = {"light_bulb_normal", "metal_brass", "metal_steel"},
    }

end

function unilib.pkg.light_chandelier_vintage.exec()

    local c_brass = "unilib:metal_brass_ingot"
    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:light_chandelier_vintage", "morelights_vintage:chandelier", mode, {
        -- From morelights_vintage:chandelier
        description = S("Vintage Chandelier"),
        tiles = {
            "unilib_light_chandelier_vintage.png",
            "unilib_chain_brass_vintage.png^[multiply:#DFDFDF"
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        collision_box = {
            type = "fixed",
            fixed = {-3/8, -1/2, -3/8, 3/8, 1/2, 3/8},
        },
        drawtype = "mesh",
        light_source = 10,
        mesh = "unilib_light_chandelier_vintage.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3/8, -1/2, -3/8, 3/8, 1/2, 3/8},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From morelights_vintage:chandelier
        output = "unilib:light_chandelier_vintage",
        recipe = {
            {"", c_brass, ""},
            {"unilib:light_bulb_normal", c_brass, "unilib:light_bulb_normal"},
            {c_steel, c_brass, c_steel}
        }
    })

end
