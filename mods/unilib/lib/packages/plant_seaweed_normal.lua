---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_seaweed
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seaweed_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pl_seaweed.add_mode

local seaweed_list = {
    {"flowers:seaweed", "thick"},
    {"flowers:seaweed_2", "medium"},
    {"flowers:seaweed_3", "thin"},
    {"flowers:seaweed_4", "sparse"},
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function place_func(pos)

    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}
    local full_name = "unilib:plant_seaweed_normal_" .. seaweed_list[math.random(1, 4)][2]
    -- N.B. math.random(1, 3) in the original code, for consistency with code in the
    --      "flower_waterlily_ordinary_alt" package
    minetest.swap_node(right_here, {name = full_name, param2 = math.random(0, 3)})

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seaweed_normal.init()

    return {
        description = "Four varities of seaweed in different thicknesses",
        depends = {"liquid_water_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.plant_seaweed_normal.exec()

    for _, mini_list in ipairs(seaweed_list) do

        local orig_name = mini_list[1]
        local part_name = mini_list[2]
        local group_table = {flammable = 2, flower = 1, snappy = 3}
        if part_name ~= "thick" then
            group_table.not_in_creative_inventory = 1
        end

        unilib.register_node("unilib:plant_seaweed_normal_" .. part_name, orig_name, mode, {
            -- From pl_seaweed, flowers:seaweed etc
            description = S("Seaweed"),
            tiles = {
                "unilib_plant_seaweed_normal_" .. part_name .. ".png",
                "unilib_plant_seaweed_normal_" .. part_name .. ".png^[transformFY",
            },
            groups = group_table,
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "nodebox",
            drop = "unilib:plant_seaweed_normal_thick",
            inventory_image = "unilib_plant_seaweed_normal_medium.png",
            liquids_pointable = true,
            node_box = {
                type = "fixed",
                fixed = {-0.5, -0.49, -0.5, 0.5, -0.49, 0.5},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.4, -0.5, -0.4, 0.4, -0.45, 0.4},
            },
            sunlight_propagates = true,
            use_texture_alpha = "clip",
            walkable = false,
            wield_image = "unilib_plant_seaweed_normal_medium.png",

            on_place = function(itemstack, placer, pointed_thing)

                local keys = placer:get_player_control()
                local pt = pointed_thing

                local place_pos = nil
                local top_pos = {x = pt.under.x, y = pt.under.y + 1, z = pt.under.z}
                local under_node = minetest.get_node(pt.under)
                local above_node = minetest.get_node(pt.above)
                local top_node = minetest.get_node(top_pos)

                if unilib.get_node_field(under_node.name, "buildable_to") then

                    if under_node.name ~= "unilib:liquid_water_ordinary_source" then
                        place_pos = pt.under
                    elseif top_node.name ~= "unilib:liquid_water_ordinary_source" and
                            unilib.get_node_field(top_node.name, "buildable_to") then
                        place_pos = top_pos
                    else
                        return
                    end

                elseif unilib.get_node_field(above_node.name, "buildable_to") then

                    place_pos = pt.above

                end

                if not place_pos then

                    -- Something went wrong
                    return

                end

                local player_name = placer:get_player_name()
                if not minetest.is_protected(place_pos, player_name) then

                    -- Notes from corresponding code in pl_waterlilies:
                    -- If this block appears in the world, something went wrong
                    local nodename = "unilib:stone_ordinary_cobble"

                    if not keys["sneak"] then

                        nodename = "unilib:plant_seaweed_normal_" ..
                                seaweed_list[math.random(1, 4)][2]
                        minetest.swap_node(place_pos, {name = nodename, param2 = math.random(0, 3)})

                    else

                        local fdir = minetest.dir_to_facedir(placer:get_look_dir())
                        minetest.swap_node(
                            place_pos,
                            {name = "unilib:plant_seaweed_normal_thick", param2 = fdir}
                        )

                    end

                    if not unilib.is_creative(player_name) then
                        itemstack:take_item()
                    end

                    return itemstack

                end

            end,
        })
        -- (not compatible with flowerpots)

    end

    -- N.B. biome_lib decorations from the original code are difficult to translate into
    --      minetest.register_decoration() calls, because the latter doesn't work when the .place_on
    --      node is a liquid
    -- The "plant_seaweed_normal_on_sand" decoration is not affected); the other two are more
    --      closely related to minetest_game's waterlily decoration, than to the plantlife versions
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_plant_seaweed_normal_above_dirt"
        part_name = "plant_seaweed_normal_above_dirt",
        convert_func = place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 33,
                plantlife_limit = -0.9,
            }),
            place_offset_y = 1,
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_plant_seaweed_normal_above_sand"
        part_name = "plant_seaweed_normal_above_sand",
        convert_func = place_func,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.convert_biome_lib_temp(-0.64),
            temp_min = unilib.convert_biome_lib_temp(-0.22),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 33,
                plantlife_limit = -0.9,
            }),
            place_offset_y = 1,
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_plant_seaweed_normal_on_sand"
        part_name = "plant_seaweed_normal_on_sand",
        convert_func = place_func,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.convert_biome_lib_temp(-0.64),
            temp_min = unilib.convert_biome_lib_temp(-0.22),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 33 / 2,
                plantlife_limit = -0.9,
            }),
        },
    })

end
