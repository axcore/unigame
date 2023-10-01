---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_disintegrating = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_disintegrating.init()

    return {
        description = "Disintegrating stone",
        notes = "Crumbles to dust when a player stands on it",
        depends = {"decor_stone_tiles", "stone_ordinary"},
    }

end

function unilib.pkg.decor_stone_disintegrating.exec()

    unilib.register_node("unilib:decor_stone_disintegrating", "decoblocks:crumblestone", mode, {
        -- From farlands, decoblocks:crumblestone
        description = S("Disintegrating Stone"),
        tiles = {"unilib_decor_stone_disintegrating.png"},
        groups = {crumbly = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft({
        -- From farlands, decoblocks:crumblestone
        type = "shapeless",
        output = "unilib:decor_stone_disintegrating 2",
        recipe = {
            "unilib:decor_stone_tiles",
            "unilib:stone_ordinary_cobble",
            "unilib:decor_stone_tiles",
        }
    })

    unilib.register_abm({
        -- From farlands, decoblocks:crumblestone
        label = "Disintegrating stone particles [decor_stone_disintegrating]",
        nodenames = {"unilib:decor_stone_disintegrating"},

        chance = 1,
        interval = 1,

        action = function(pos, node)

            local objs = minetest.get_objects_inside_radius(
                {x = pos.x, y = pos.y + 0.5, z = pos.z},
                0.5
            )

            for _, obj in ipairs(objs) do

                if obj:is_player() then

                    minetest.add_particlespawner({
                        amount = 13,
                        time = 1,

                        collisiondetection = true,
                        maxacc = {x = 0, y = -1, z = 0},
                        minacc = {x = 0, y = -0.5, z = 0},
                        maxexptime = 2,
                        minexptime = 1,
                        maxpos = {x = pos.x + 0.2, y = pos.y + 1, z = pos.z + 0.2},
                        minpos = {x = pos.x - 0.2, y = pos.y, z = pos.z - 0.2},
                        maxsize = 2,
                        minsize = 1,
                        maxvel = {x = 0.1, y = -2, z = 0.1},
                        minvel = {x = -0.1, y = -1, z = -0.1},
                        texture = "unilib_stone_ordinary.png",
                    })

                    minetest.set_node(pos, {name = "air"})

                end

            end

        end,
    })

end
