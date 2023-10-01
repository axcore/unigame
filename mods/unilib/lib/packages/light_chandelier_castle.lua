---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_lighting
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_chandelier_castle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_lighting.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_chandelier_castle.init()

    return {
        description = "Castle chandelier",
        depends = {"metal_steel", "torch_ordinary"},
    }

end

function unilib.pkg.light_chandelier_castle.exec()

    unilib.register_node("unilib:light_chandelier_castle", "castle_lighting:chandelier", mode, {
        -- From castle_lighting:chandelier
        description = S("Castle Chandelier"),
        tiles = {
            {
                name = "unilib_light_chandelier_castle.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.0
                },
            },
        },
        groups = {cracky = 2},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_light_chandelier_castle_inv.png",
        light_source = 14,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {0.35, -0.375, 0.35, -0.35, 0.5, -0.35},
            },
        },
        sunlight_propagates = true,
        wield_image = "unilib_light_chandelier_castle_inv.png",
    })
    unilib.register_craft({
        -- From castle_lighting:chandelier
        output = "unilib:light_chandelier_castle",
        recipe = {
            {"", "", ""},
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:torch_ordinary", "unilib:torch_ordinary", "unilib:torch_ordinary"},
        },
    })

    unilib.register_node(
        -- From castle_lighting:chandelier_chain
        "unilib:light_chandelier_castle_chain",
        "castle_lighting:chandelier_chain",
        mode,
        {
            description = S("Castle Chandelier Chain"),
            tiles = {"unilib_light_chandelier_castle_chain.png"},
            groups = {cracky = 2},
            -- N.B. glass in the original code
            sounds = unilib.sound_table.metal,

            drawtype = "plantlike",
            inventory_image = "unilib_light_chandelier_castle_chain.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {0.1, -0.5, 0.1, -0.1, 0.5, -0.1},
                },
            },
            sunlight_propagates = true,
            wield_image = "unilib_light_chandelier_castle_chain.png",
        }
    )
    unilib.register_craft({
        -- From castle_lighting:chandelier_chain
        output = "unilib:light_chandelier_castle_chain 4",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"", "", ""},
            {"","unilib:metal_steel_ingot",""},
        }
    })

end
