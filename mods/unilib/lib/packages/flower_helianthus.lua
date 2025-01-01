---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_sunflowers
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_helianthus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pl_sunflowers.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function place_func(pos)

    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}
    core.swap_node(right_here, {name = "unilib:flower_helianthus", param2 = math.random(0, 3)})

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_helianthus.init()

    return {
        description = "Helianthus",
        notes = "Original named as a sunflower; renamed to avoid confusion with the crop of the" ..
                " same name",
        depends = "crop_wheat",
    }

end

function unilib.pkg.flower_helianthus.exec()

    unilib.register_node("unilib:flower_helianthus", "flowers:sunflower", mode, {
        -- From pl_sunflowers, flowers:sunflower
        description = unilib.utils.annotate(S("Helianthus"), "Helianthus"),
        tiles = {"unilib_flower_helianthus.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, dig_immediate = 3, flammable = 3, flora = 1},
        groups = {
            attached_node = 1, color_yellow = 1, colour_yellow = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        collision_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        },
        drawtype = "mesh",
        drop = {
            max_items = 1,
            items = {
                {
                    items = {"unilib:crop_wheat_seed"},
                    rarity = 8,
                },
                {
                    items = {"unilib:flower_helianthus"},
                },
            },
        },
        inventory_image = "unilib_flower_helianthus_inv.png",
        mesh = "unilib_flower_helianthus.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        },
        use_texture_alpha = "clip",
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_flower_helianthus"
        part_name = "flower_helianthus",
        convert_func = place_func,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.utils.convert_biome_lib_temp(-0.1),
        },
        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 25,
                plantlife_limit = -0.9,
            }),
        },
    })

end
