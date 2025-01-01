---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriflame
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fire_permanent_tinted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.abriflame.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_smoke(pos, node, clicker, enable)

    local meta = core.get_meta(pos)
    local handler = meta:get_int("sound")
    local particle = meta:get_int("smoke")

    if particle ~= 0 or enable ~= true then

        if handler then
            core.sound_stop(handler)
        end

        core.delete_particlespawner(particle)
        meta:set_int("smoke", 0)
        meta:set_int("sound", 0)

        return

    end

    if core.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name ~= "air" or particle ~= 0 then
        return
    end

    particle = core.add_particlespawner({
        amount = 4,
        time = 0,
        texture = "unilib_fire_permanent_tinted_smoke.png",

        maxacc = {x = 0, y = 0.5, z = 0},
        minacc = {x = 0, y = 0, z = 0},
        maxexptime = 3,
        minexptime = 1,
        maxpos = {x = pos.x + 0.25, y = pos.y + 5, z = pos.z + 0.25},
        minpos = {x = pos.x - 0.25, y = pos.y + 0.4, z = pos.z-0.25},
        maxsize = 8,
        minsize = 4,
        maxvel = {x = 0.2, y = 1, z = 0.2},
        minvel = {x = -0.2, y = 0.3, z = -0.2},

        collisiondetection = true,
    })

    handler = core.sound_play("fire_small", {
        pos = pos,
        max_hear_distance = 5,
        loop = true
    })

    meta:set_int("smoke", particle)
    meta:set_int("sound", handler)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fire_permanent_tinted.init()

    return {
        description = "Tinted permanent flame set (15 colours)",
        notes = "In order to ignite a tinted flame, place any dyed artisanal glass, and then" ..
                " punch it with flint and steel",
        depends = "glass_artisanal_basic",
    }

end

function unilib.pkg.fire_permanent_tinted.exec()

    local spark_img = "unilib_fire_permanent_tinted_spark.png"

    local flame_list = {
        {"black",       "black",    S("Black-Tinted Permanent Flame")},
        {"blue",        "blue",     S("Blue-Tinted Permanent Flame")},
        {"cyan",        "cyan",     S("Cyan-Tinted Permanent Flame")},
        {"green",       "green",    S("Green-Tinted Permanent Flame")},
        {"magenta",     "magenta",  S("Magenta-Tinted Permanent Flame")},
        {"orange",      "orange",   S("Orange-Tinted Permanent Flame")},
        {"violet",      "purple",   S("Purple-Tinted Permanent Flame")},
        {"red",         "red",      S("Red-Tinted Permanent Flame")},
        {"white",       "frosted",  S("White-Tinted Permanent Flame")},
        {"yellow",      "yellow",   S("Yellow-Tinted Permanent Flame")},
        -- Extra colours not included in the original code, to complete the standard 15-dye set
        {"brown",       nil,        S("Brown-Tinted Permanent Flame")},
        {"green_dark",  nil,        S("Dark-Green-Tinted Permanent Flame")},
        {"grey",        nil,        S("Grey-Tinted Permanent Flame")},
        {"grey_dark",   nil,        S("Dark-Grey-Tinted Permanent Flame")},
        {"pink",        nil,        S("Pink-Tinted Permanent Flame")},
    }

    for _, row_list in pairs(flame_list) do

        local part_name = row_list[1]
        local orig_part_name = row_list[2]
        local description = row_list[3]

        local orig_name = nil
        if orig_part_name ~= nil then
            orig_name = "abriflame:" .. orig_part_name .. "_fire"
        end

        local img = "unilib_fire_permanent_tinted_" .. part_name .. "_inv.png"

        unilib.register_node("unilib:fire_permanent_tinted_" .. part_name, orig_name, mode, {
            -- From abriflame:black_fire, etc. Creates unilib:fire_permanent_tinted_black, etc
            description = description,
            tiles = {{
                name = "unilib_fire_permanent_tinted_" .. part_name .. "_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            }},
            groups = {dig_immediate = 3, not_in_creative_inventory = 1, tinted_fire = 1},
            -- (no sounds)

            buildable_to = true,
            drawtype = "firelike",
            drop = "",
            inventory_image = img,
            light_source = 14,
            paramtype = "light",
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = img,

            on_rightclick = function(pos, node, clicker)
                do_smoke(pos, node, clicker, true)
            end,

            on_destruct = function(pos)

                do_smoke(pos, nil, nil, false)
                core.sound_play("unilib_extinguish_flame", {
                    pos = pos,
                    max_hear_distance = 5,
                    gain = 0.25,
                })

            end,
        })

    end

    if core.features.particlespawner_tweenable then

        unilib.register_abm({
            label = "Permanent fire particles [fire_permanent_tinted]",
            nodenames = {"group:tinted_fire"},

            catch_up = false,
            chance = 1,
            interval = 1,

            action = function(pos, node)

                -- The colour of the particles must match the flame (more or less)
                -- (Assuming "unilib:fire_permanent_tinted_X")
                local colour = string.sub(node.name, 30)
                -- (Ugly but effective)
                if colour == "green_dark" then
                    colour = "green"
                elseif colour == "grey_dark" then
                    colour = "grey"
                end

                core.add_particlespawner({
                    amount = 100,
                    time = 1,

                    acc = vector.new(0, 0.1, 0),
                    collision_removal = true,
                    collisiondetection = true,
                    exptime = 1,
                    glow = 14,
                    pos = {
                        min = vector.add(pos, vector.new(-0.5, -0.5, -0.5)),
                        max = vector.add(pos, vector.new(0.5, 0.5, 0.5)),
                    },
                    texpool = {
                        {
                            name = spark_img .. "^[multiply:" .. colour,
                            alpha_tween = {1, 0},
                            scale_tween = {0.5, 0},
                            blend = "screen",
                        },
                        {
                            name = spark_img .. "^[multiply:#c00",
                            alpha_tween = {1, 0},
                            scale_tween = {0.5, 0},
                            blend = "screen",
                        },
                        {
                            name = spark_img .. "^[multiply:#800",
                            alpha_tween = {1, 0},
                            scale_tween = {0.5, 0},
                            blend = "screen",
                        },
                        {
                            name = spark_img .. "^[multiply:#ff0",
                            alpha_tween = {1, 0},
                            scale_tween = {0.5, 0},
                            blend = "screen",
                        },
                        {
                            name = spark_img .. "^[multiply:#fc0",
                            alpha_tween = {1, 0},
                            scale_tween = {0.5, 0},
                            blend = "screen",
                        },
                        {
                            name = spark_img .. "^[multiply:#cc0",
                            alpha_tween = {1, 0},
                            scale_tween = {0.5, 0},
                            blend = "screen",
                        },
                        {
                            name = spark_img .. "^[multiply:#f80",
                            alpha_tween = {1, 0},
                            scale_tween = {0.5, 0},
                            blend = "screen",
                        },
                    },
                    vel = {
                        min = vector.new(-0.5, 0.5, -0.5),
                        max = vector.new( 0.5, 0.5, 0.5),
                    },
                })

            end,
        })

    end

end
