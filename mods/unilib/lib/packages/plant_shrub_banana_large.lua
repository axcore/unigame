---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_banana_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_banana_large.init()

    return {
        description = "Large banana plant",
        notes = "Does not produce bananas",
    }

end

function unilib.pkg.plant_shrub_banana_large.exec()

    unilib.register_node(
        -- From GLEMr4, lib_ecology:plant_bananaplant2
        "unilib:plant_shrub_banana_large",
        "lib_ecology:plant_bananaplant2",
        mode,
        {
            description = unilib.utils.annotate(S("Large Banana Plant"), "Musa"),
            tiles = {"unilib_plant_shrub_banana.png"},
            groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            buildable_to = true,
            drawtype = "mesh",
            -- N.B. floodable no longer required, because of unilib's flooding effects
--          floodable = true,
            mesh = "unilib_plant_shrub_banana_large.b3d",
            paramtype = "light",
            paramtype2 = "degrotate",
            -- N.B. Adjusted selection box from original code, which was identical (and more suited
            --      to) the plant in the "plant_shrub_banana" package
            --[[
            selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3},
            },
            ]]--
            selection_box = {
                type = "fixed",
                fixed = {-0.4, -0.5, -0.4, 0.4, 0.8, 0.4},
            },
            sunlight_propagates = true,
            use_texture_alpha = "clip",
            visual_scale = 1.2,
            walkable = false,
            waving = 1,
        }
    )
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("farlands_plant_shrub_banana_large", {
        -- Original to unilib
        deco_type = "simple",
        decoration = "unilib:plant_shrub_banana_large",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end
