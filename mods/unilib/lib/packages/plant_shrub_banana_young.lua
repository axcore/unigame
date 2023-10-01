---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_banana_young = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_banana_young.init()

    return {
        description = "Young banana plant",
        notes = "Grows into a (normal) banana plant. Does not produce bananas",
        depends = "plant_shrub_banana",
    }

end

function unilib.pkg.plant_shrub_banana_young.exec()

    unilib.register_node("unilib:plant_shrub_banana_young", "lib_ecology:plant_banana_1", mode, {
        -- From GLEMr11, lib_ecology:plant_banana_1
        description = unilib.annotate(S("Young Banana Plant"), "Musa"),
        tiles = {"unilib_plant_shrub_banana.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 2, flora = 1, growing = 1, plant = 1, snappy = 3},
        -- N.B. No sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_plant_shrub_banana.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,

        on_construct = function(pos)

            -- N.B. In original code, 60-120
            minetest.get_node_timer(pos):start(
                math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)
            )

        end,

        on_timer = function(pos)
            minetest.set_node(pos, {name = "unilib:plant_shrub_banana"})
        end,
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_banana_young", "lib_ecology:plant_banana_1")

end
