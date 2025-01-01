---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_pohuehue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_pohuehue.init()

    return {
        description = "Pohuehue",
    }

end

function unilib.pkg.plant_pohuehue.exec()

    unilib.register_node("unilib:plant_pohuehue", "aotearoa:pohuehue", mode, {
        -- From aotearoa:pohuehue
        description = unilib.utils.annotate(S("Pohuehue"), "Muehlenbeckia complexa"),
        tiles = {"unilib_plant_pohuehue.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.47, -0.5, -0.47, 0.47, 0.37, 0.47},
            },
        },
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("aotearoa_plant_pohuehue", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_pohuehue",

        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.95,
            seed = 337121,
            spread = {x = 6, y = 6, z = 6},
        },
        sidelen = 16,
    })

end
