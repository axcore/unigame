---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_farlands_disintegrate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

-- Table to convert compatible nodes into matching textures for the particle spawner
local convert_table = {}
convert_table["unilib:decor_disintegrating_stone_desert"] = "unilib_stone_desert.png"
convert_table["unilib:decor_disintegrating_stone_ordinary"] = "unilib_stone_ordinary.png"
convert_table["unilib:decor_disintegrating_stone_sandstone_desert"] =
    "unilib_stone_sandstone_desert.png"
convert_table["unilib:decor_disintegrating_stone_sandstone_ordinary"] =
    "unilib_stone_sandstone_ordinary.png"
convert_table["unilib:decor_disintegrating_stone_sandstone_silver"] =
    "unilib_stone_sandstone_silver.png"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_farlands_disintegrate.init()

    return {
        description = "ABM to convert disintegrating stones to air (from farlands)",
        notes = "This ABM acts when a player stands on a disintegrating stone",
    }

end

function unilib.pkg.abm_farlands_disintegrate.post()

    unilib.register_abm({
        -- From farlands, decoblocks:crumblestone
        label = "Disintegrating stone particles [abm_farlands_disintegrate]",
        nodenames = {
            "unilib:decor_disintegrating_stone_desert",
            "unilib:decor_disintegrating_stone_ordinary",
            "unilib:decor_disintegrating_stone_sandstone_desert",
            "unilib:decor_disintegrating_stone_sandstone_ordinary",
            "unilib:decor_disintegrating_stone_sandstone_silver",
        },

        chance = 1,
        interval = 1,

        action = function(pos, node)

            local objs = core.get_objects_inside_radius(
                {x = pos.x, y = pos.y + 0.5, z = pos.z},
                0.5
            )

            for _, obj in ipairs(objs) do

                if obj:is_player() then

                    core.add_particlespawner({
                        amount = 13,
                        time = 1,
                        texture = convert_table[node.name] or "unilib_stone_ordinary.png",

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

                        collisiondetection = true,
                    })

                    core.set_node(pos, {name = "air"})

                end

            end

        end,
    })

end
