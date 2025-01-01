---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_hog_peanut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_hog_peanut.init()

    return {
        description = "Hog peanut shrub",
    }

end

function unilib.pkg.plant_shrub_hog_peanut.exec()

    unilib.register_node("unilib:plant_shrub_hog_peanut", "mapgen:shrub", mode, {
        -- From farlands, mapgen:shrub
        description = unilib.utils.annotate(S("Hog Peanut Shrub"), "Amphicarpaea bracteata"),
        tiles = {"unilib_plant_shrub_hog_peanut.png"},
        groups = {flammable = 1, flora = 1, oddly_breakable_by_hand = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "mesh",
        -- N.B. inventory_image not added here, because the 3D-rendering actually looks better
        mesh = "unilib_plant_shrub_hog_peanut.obj",
        paramtype = "light",
        -- N.B. Remove .paramtype2 as the callback below doesn't work on modern Minetest
--      paramtype2 = "degrotate",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3},
        },
        use_texture_alpha = "clip",
        visual_scale = 0.5,
        walkable = false,

        -- N.B. This callback, from the original code, does not work on modern Minetest
        --[[
        on_construct = function(pos, node)

            local node = core.get_node(pos)
            node.param2 = math.random(0, 179)

        end,
        ]]--
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("farlands_plant_shrub_hog_peanut", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_hog_peanut",

        fill_ratio = 0.05,
        height = 1,
        sidelen = 16,
    })

end
