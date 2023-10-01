---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/molehills
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_molehill = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.molehills.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function place_func(pos)

    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}

    if minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}).name ~= "air" and
            minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}).name ~= "air" and
            minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}).name ~= "air" and
            minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}).name ~= "air" and
            minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z + 1}).name ~= "air" and
            minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z - 1}).name ~= "air" and
            minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z + 1}).name ~= "air" and
            minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z - 1}).name ~= "air" then
        minetest.swap_node(right_here, {name = "unilib:misc_molehill"})
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_molehill.init()

    return {
        description = "Molehill",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.misc_molehill.exec()

    unilib.register_node("unilib:misc_molehill", "molehills:molehill", mode, {
        -- From molehills:molehill
        description = S("Molehill"),
        tiles = {"unilib_misc_molehill.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,

        collision_box = {
            type = "fixed",
            fixed = { -0.5, -0.5, -0.5, 0.5, -0.125, 0.5}
        },
        drawtype = "mesh",
        inventory_image = "unilib_misc_molehill_inv.png",
        mesh = "unilib_misc_molehill.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = { -0.5, -0.5, -0.5, 0.5, -0.125, 0.5}
        },
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From molehills:molehill
        output = "unilib:dirt_ordinary",
        recipe = {
            {"unilib:misc_molehill", "unilib:misc_molehill"},
            {"unilib:misc_molehill", "unilib:misc_molehill"},
        }
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_misc_molehill"
        part_name = "misc_molehill",
        convert_func = place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 99.5,
                rarity_fertility = 1,
            }),
        },
    })

end
