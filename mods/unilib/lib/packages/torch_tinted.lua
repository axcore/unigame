---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abritorch
-- Code:    MIT
-- Media:   CC-BY 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.torch_tinted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.abritorch.add_mode

local enable_ceiling_flag = true

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.torch_tinted.init()

    return {
        description = "Tinted torch set (15 colours)",
        depends = {"dye_basic", "torch_ordinary"},
    }

end

function unilib.pkg.torch_tinted.exec()

    local c_torch = "unilib:torch_ordinary"

    local torch_list = {
        {"black",       "black",    S("Black-Tinted Torch")},
        {"blue",        "blue",     S("Blue-Tinted Torch")},
        {"cyan",        "cyan",     S("Cyan-Tinted Torch")},
        {"green",       "green",    S("Green-Tinted Torch")},
        {"magenta",     "magenta",  S("Magenta-Tinted Torch")},
        {"orange",      "orange",   S("Orange-Tinted Torch")},
        {"violet",      "purple",   S("Purple-Tinted Torch")},
        {"red",         "red",      S("Red-Tinted Torch")},
        {"white",       "frosted",  S("White-Tinted Torch")},
        {"yellow",      "yellow",   S("Yellow-Tinted Torch")},
        -- Extra colours not included in the original code, to complete the standard 15-dye set
        {"brown",       nil,        S("Brown-Tinted Torch")},
        {"green_dark",  nil,        S("Dark Green-Tinted Torch")},
        {"grey",        nil,        S("Grey-Tinted Torch")},
        {"grey_dark",   nil,        S("Dark Grey-Tinted Torch")},
        {"pink",        nil,        S("Pink-Tinted Torch")},
    }

    for _, row_list in pairs(torch_list) do

        local part_name = row_list[1]
        local orig_part_name = row_list[2]
        local description = row_list[3]

        local orig_hand_name = nil
        local orig_floor_name = nil
        local orig_wall_name = nil
        if orig_part_name ~= nil then

            orig_hand_name = "abritorch:torch_" .. orig_part_name
            orig_floor_name = "abritorch:floor_" .. orig_part_name
            orig_wall_name = "abritorch:wall_" .. orig_part_name

        end

        local inv_img = "unilib_torch_tinted_" .. part_name .. "_inv.png"
        local animated_img = "unilib_torch_tinted_" .. part_name .. "_animated.png"

        unilib.register_craftitem("unilib:torch_tinted_" .. part_name, orig_hand_name, mode, {
            -- From abritorch:torch_black, etc. Creates unilib:torch_tinted_black, etc
            description = description,
            -- (no tiles)
            groups = {tinted_torch_craftitem = 1},
            -- (no sounds)

            inventory_image = inv_img,
            liquids_pointable = false,
            wield_image = inv_img,
            wield_scale = {x = 1, y = 1, z = 1 + 1/16},

            on_place = function(itemstack, placer, pointed_thing)

                local above = pointed_thing.above
                local under = pointed_thing.under
                local wdir = core.dir_to_wallmounted(
                    {x = under.x - above.x, y = under.y - above.y, z = under.z - above.z}
                )

                if wdir < 1 and not enable_ceiling_flag then
                    return itemstack
                end

                local fakestack = itemstack
                local retval
                if wdir <= 1 then
                    retval = fakestack:set_name("unilib:torch_tinted_" .. part_name .. "_floor")
                else
                    retval = fakestack:set_name("unilib:torch_tinted_" .. part_name .. "_wall")
                end

                if not retval then
                    return itemstack
                end

                itemstack = core.item_place(fakestack, placer, pointed_thing)
                itemstack:set_name("unilib:torch_tinted_" .. part_name)

                return itemstack

            end,
        })
        unilib.register_craft({
            -- From abritorch:torch_black, etc
            output = "unilib:torch_tinted_" .. part_name .. " 4",
            recipe = {
                {c_torch, "", c_torch},
                {"", "unilib:dye_" .. part_name, ""},
                {c_torch, "", c_torch},
            },
        })

        unilib.register_node(
            -- From abritorch:floor_black, etc. Creates unilib:torch_tinted_black_floor, etc
            "unilib:torch_tinted_" .. part_name .. "_floor",
            orig_floor_name,
            mode,
            {
                description = description,
                tiles = {
                    {
                        name = animated_img,
                        animation = {
                            type = "vertical_frames",
                            aspect_w = 16,
                            aspect_h = 16,
                            length = 3.3,
                        },
                    },
                },
                groups = {
                    attached_node = 1, choppy = 2, dig_immediate = 3, flammable = 1,
                    not_in_creative_inventory = 1, tinted_torch = 1, torch = 1,
                },
                -- (no sounds)

                drawtype = "mesh",
                drop = "unilib:torch_tinted_" .. part_name,
                inventory_image = inv_img,
                light_source = 13,
                mesh = "unilib_torch_tinted_floor.obj",
                paramtype = "light",
                paramtype2 = "wallmounted",
                selection_box = {
                    type = "wallmounted",
                    wall_top = {-1/16, -2/16, -1/16, 1/16, 0.5, 1/16},
                    wall_bottom = {-1/16, -0.5, -1/16, 1/16, 2/16, 1/16},
                },
                sunlight_propagates = true,
                walkable = false,
                wield_image = inv_img,
                wield_scale = {x = 1, y = 1, z = 1 + 1/16},
                use_texture_alpha = "clip",
            }
        )

        unilib.register_node("unilib:torch_tinted_" .. part_name .. "_wall", orig_wall_name, mode, {
            -- From abritorch:wall_black, etc. Creates unilib:torch_tinted_black_wall, etc
            -- N.B. description missing in original code
            description = description,
            tiles = {
                {
                    name = animated_img,
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 3.3,
                    },
                },
            },
            groups = {
                attached_node = 1, choppy = 2, dig_immediate = 3, flammable = 1,
                not_in_creative_inventory = 1, tinted_torch = 1, torch = 1,
            },
            -- (no sounds)

            drawtype = "mesh",
            drop = "unilib:torch_tinted_" .. part_name,
            inventory_image = inv_img,
            light_source = 13,
            mesh = "unilib_torch_tinted_wall.obj",
            paramtype = "light",
            paramtype2 = "wallmounted",
            selection_box = {
                type = "wallmounted",
                wall_top = {-0.1, -0.1, -0.1, 0.1, 0.5, 0.1},
                wall_bottom = {-0.1, -0.5, -0.1, 0.1, 0.1, 0.1},
                wall_side = {-0.5, -0.3, -0.1, -0.2, 0.3, 0.1},
            },
            sunlight_propagates = true,
            walkable = false,
            wield_image = inv_img,
            wield_scale = {x = 1, y = 1, z = 1 + 1/16},
            use_texture_alpha = "clip",
        })

    end

    -- (LBM to replace the 10 separate ABMs in the original code)
    unilib.register_lbm({
        lbm = "Place tinted torches [torch_tinted]",
        name = "unilib:lbm_torch_tinted",
        nodenames = {"group:tinted_torch_craftitem"},

        action = function(pos, node)

            local colour = node.name:match("unilib:torch_tinted_(%w+)")
            local wall_name = "unilib:torch_tinted_" .. colour .. "_wall"

            if node.param2 == 0 and not enable_ceiling_flag then

                core.remove_node(pos)
                return

            elseif node.param2 == 1 then

                wall_name = "unilib:torch_tinted_" .. part_name .. "_floor"

            end

            core.set_node(pos, {name = wall_name, param2 = node.param2})

        end
    })

    if core.features.particlespawner_tweenable then

        local spark_img = "unilib_torch_tinted_spark.png"

        unilib.register_abm({
            label = "Add torch particles [torch_tinted]",
            nodenames = {"group:tinted_torch"},

            catch_up = false,
            chance = 1,
            interval = 1,

            action = function(pos, node)

                local colour = node.name:match("unilib:torch_tinted_(%w+)")

                core.add_particlespawner({
                    amount = 2,
                    time = 1,

                    acc = {
                        min = vector.new(0, 0.1, 0),
                        max = vector.new(0, 0.3, 0),
                    },
                    collision_removal = true,
                    collisiondetection = true,
                    exptime = 1,
                    glow = 14,
                    pos = {
                        min = vector.add(pos, vector.new(-0.1, 0.45, -0.1)),
                        max = vector.add(pos, vector.new(0.1, 0.5, 0.1)),
                    },
                    texpool = {
                        {
                            name = spark_img,
                            alpha_tween = {1, 0},
                            scale = 0.3,
                        },
                        {
                            name = spark_img .. "^[multiply:" .. colour,
                            alpha_tween = {1, 0},
                            scale = 0.5,
                        },
                    },
                    vel = {
                        min = vector.new(0, 0, 0),
                        max = vector.new(0, 0.15, 0),
                    },
                })

            end,
        })

    end

end
