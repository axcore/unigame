---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_thorny = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_thorny.init()

    return {
        description = "Thorny cactus",
    }

end

function unilib.pkg.plant_cactus_thorny.exec()

    unilib.register_node("unilib:plant_cactus_thorny", "lib_ecology:plant_cactus_03", mode, {
        -- From GLEMr4, lib_ecology:plant_cactus_03
        description = S("Thorny Cactus"),
        tiles = {"unilib_plant_cactus_thorny.png"},
        groups = {choppy = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
        },
        drawtype = "mesh",
        mesh = "unilib_plant_cactus_exotic.b3d",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
        },
        use_texture_alpha = "clip",
        visual_scale = 0.5,
    })
    -- (not compatible with flowerpots)

end
