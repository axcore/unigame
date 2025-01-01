---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_reedmace = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function land_place_func(pos)

    -- Called by the ABM and the decorations defined below

    local size = math.random(1, 3)
    local spikes = math.random(1, 3)
    local pos_1 = {x = pos.x, y = pos.y + 1, z = pos.z}
    local pos_2 = {x = pos.x, y = pos.y + 2, z = pos.z}
    local pos_3 = {x = pos.x, y = pos.y + 3, z = pos.z}

    if core.get_node(pos_1).name == "air" or
            core.get_node(pos_1).name == "unilib:plant_reedmace_sapling" then

        if core.get_node(pos_2).name ~= "air" then
            core.swap_node(pos_1, {name = "unilib:plant_reedmace_small"})
        elseif core.get_node(pos_3).name ~= "air" then
            core.swap_node(pos_1, {name = "unilib:plant_reedmace_medium"})
        elseif size == 1 then
            core.swap_node(pos_1, {name = "unilib:plant_reedmace_small"})
        elseif size == 2 then
            core.swap_node(pos_1, {name = "unilib:plant_reedmace_medium"})
        elseif size == 3 then

            if spikes == 1 then
                core.swap_node(pos_1, {name = "unilib:plant_reedmace_mature"})
            else
                core.swap_node(pos_1, {name = "unilib:plant_reedmace_large"})
            end

        end

    end

end

local function water_place_func(pos)

    -- Called by the ABM and the decoration defined below

    local size = math.random(1, 3)
    local spikes = math.random(1, 3)
    local pos_1 = {x = pos.x, y = pos.y + 1, z = pos.z}
    local pos_2 = {x = pos.x, y = pos.y + 2, z = pos.z}
    local pos_3 = {x = pos.x, y = pos.y + 3, z = pos.z}
    local pos_4 = {x = pos.x, y = pos.y + 4, z = pos.z}

    core.add_entity(pos_1, "unilib:entity_plant_reedmace_water")

    if core.get_node(pos_2).name == "air" then

        if core.get_node(pos_3).name ~= "air" then
            core.swap_node(pos_2, {name = "unilib:plant_reedmace_small"})
        elseif core.get_node(pos_4).name ~= "air" then
            core.swap_node(pos_2, {name = "unilib:plant_reedmace_medium"})
        elseif size == 1 then
            core.swap_node(pos_2, {name = "unilib:plant_reedmace_small"})
        elseif size == 2 then
            core.swap_node(pos_2, {name = "unilib:plant_reedmace_medium"})
        elseif size == 3 then

            if spikes == 1 then
                core.swap_node(pos_2, {name = "unilib:plant_reedmace_mature"})
            else
                core.swap_node(pos_2, {name = "unilib:plant_reedmace_large"})
            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_reedmace.init()

    return {
        description = "Reedmace",
        notes = "Several nodes from the original mod have been renamed as bulrush, and moved" ..
                " to the \"plant_bulrush\" package",
        depends = "liquid_water_ordinary",
    }

end

function unilib.pkg.plant_reedmace.exec()

    -- An ABM causes the "sapling" to grow into one of the four growth stages (without any
    --      intermediate growth stages), when placed on land or one-block deep water
    -- When any growth stage is dug, the "sapling" is the item placed in the player's inventory

    unilib.register_node("unilib:plant_reedmace_sapling", "dryplants:reedmace_sapling", mode, {
        -- From dryplants:reedmace_sapling
        description = unilib.utils.annotate(S("Reedmace"), "Typha"),
        tiles = {"unilib_plant_reedmace_sapling.png"},
        groups = {attached_node = 1, flammable = 2, sapling = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_reedmace_sapling.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_plant_reedmace_near_water"
        part_name = "plant_reedmace_near_water",
        convert_func = land_place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 101 - 40,
                plantlife_limit = -0.9,
            }),
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_plant_reedmace_in_water"
        part_name = "plant_reedmace_in_water",
        convert_func = water_place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 101 - 65,
                plantlife_limit = -0.9,
            }),
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_plant_reedmace_on_sand"
        part_name = "plant_reedmace_on_sand",
        convert_func = land_place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 101 - 90,
                plantlife_limit = -0.9,
            }),
        },
    })
    unilib.register_abm({
        label = "Reedmace growth [plant_reedmace]",
        nodenames = "unilib:plant_reedmace_sapling",

        chance = 100 / 5,
        interval = 600,

        action = function(pos, node, _, _)

            -- Matches both "_source" and "_flowing"
            local c_water = "unilib:liquid_water_ordinary_"

            if string.find(
                core.get_node({x = pos.x + 1, y = pos.y, z = pos.z}).name, c_water
            ) or string.find(
                core.get_node({x = pos.x, y = pos.y, z = pos.z + 1}).name, c_water
            ) or string.find(
                core.get_node({x = pos.x - 1, y = pos.y, z = pos.z}).name, c_water
            ) or string.find(
                core.get_node({x = pos.x, y = pos.y, z = pos.z - 1}).name, c_water
            ) then

                if core.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then
                    water_place_func({x = pos.x, y = pos.y - 1, z = pos.z})
                end

                core.swap_node(
                    {x = pos.x, y = pos.y, z = pos.z},
                    {name = "unilib:liquid_water_ordinary_source"}
                )

            else

                land_place_func({x = pos.x, y = pos.y - 1, z = pos.z})

            end

        end,
    })

    unilib.register_node("unilib:plant_reedmace_small", "dryplants:reedmace_top", mode, {
        -- From dryplants:reedmace_top
        description = unilib.utils.annotate(S("Reedmace"), "Typha"),
        tiles = {"unilib_plant_reedmace_small.png"},
        -- N.B. attached_node = 1 not in original code; it's required for the GLEM schematics used
        --      with the "plant_bulrush" package
        groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_reedmace_small.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
    })

    unilib.register_node("unilib:plant_reedmace_medium", "dryplants:reedmace_height_2", mode, {
        -- From dryplants:reedmace_height_2
        description = unilib.utils.annotate(S("Reedmace"), "Typha"),
        tiles = {"unilib_plant_reedmace_medium.png"},
        -- N.B not_in_create_inventory = 1 not in original code
        groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_reedmace_small.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        visual_scale = math.sqrt(8),
        walkable = false,
    })

    unilib.register_node("unilib:plant_reedmace_large", "dryplants:reedmace_height_3", mode, {
        -- From dryplants:reedmace_height_3
        description = unilib.utils.annotate(S("Reedmace"), "Typha"),
        tiles = {"unilib_plant_reedmace_large.png"},
        -- N.B not_in_create_inventory = 1 not in original code
        groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_reedmace_small.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        visual_scale = math.sqrt(8),
        walkable = false,
    })

    unilib.register_node(
        -- From dryplants:reedmace_height_3_spikes
        "unilib:plant_reedmace_mature",
        "dryplants:reedmace_height_3_spikes",
        mode,
        {
            description = unilib.utils.annotate(S("Reedmace"), "Typha"),
            tiles = {"unilib_plant_reedmace_mature.png"},
            -- N.B not_in_create_inventory = 1 not in original code
            groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "plantlike",
            drop = "unilib:plant_reedmace_sapling",
            inventory_image = "unilib_plant_reedmace_small.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
            },
            visual_scale = math.sqrt(8),
            walkable = false,
        }
    )

    -- Growth on water is handled using an entity
    unilib.register_entity("unilib:entity_plant_reedmace_water", {
        initial_properties = {
            collisionbox = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
            mesh = "unilib_plant_reedmace.obj",
            textures = {"unilib_plant_reedmace_water.png"},
            visual = "mesh",
            visual_size = {x = 10, y = 10},
        },

        on_punch = function(self, puncher)

            if puncher:is_player() and puncher:get_inventory() then

                if not core.setting_getbool("creative_mode") then
                    puncher:get_inventory():add_item("main", "unilib:plant_reedmace_sapling")
                end

                self.object:remove()

            end

        end,
    })

    -- N.B. These nodes have been renamed as bulrush, and moved to the "plant_bulrush" package
    --[[
    unilib.register_node("unilib:plant_reedmace_water", "dryplants:reedmace_water", mode, {
        -- From dryplants:reedmace_water
        description = S("Reedmace"),
        tiles = {"unilib_plant_reedmace_water.png"},
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_plant_reedmace_water.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
    })

    unilib.register_node("unilib:plant_reedmace_spikes", "dryplants:reedmace_spikes", mode, {
        -- From dryplants:reedmace_spikes
        description = S("Reedmace"),
        tiles = {"unilib_plant_reedmace_spikes.png"},
        groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_reedmace_spikes.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
    })

    unilib.register_node("unilib:plant_reedmace_stem", "dryplants:reedmace", mode, {
        -- From dryplants:reedmace
        description = S("Reedmace"),
        tiles = {"unilib_plant_reedmace_stem.png"},
        groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_reedmace_stem.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,

        after_destruct = function(pos, oldnode)

            local node = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:plant_reedmace_small" or
                    node.name == "unilib:plant_reedmace_spikes" then

                core.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
                core.add_item(pos, "unilib:plant_reedmace_sapling")

            end

        end,
    })

    unilib.register_node("unilib:plant_reedmace_bottom", "dryplants:reedmace_bottom", mode, {
        -- From dryplants:reedmace_bottom
        description = S("Reedmace"),
        tiles = {"unilib_plant_reedmace_bottom.png"},
        groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_reedmace_bottom.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
        },
        walkable = false,

        after_destruct = function(pos, oldnode)

            local node = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:plant_reedmace_stem" or
                    node.name == "unilib:plant_reedmace_small" or
                    node.name == "unilib:plant_reedmace_spikes" then

                core.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
                core.add_item(pos, "unilib:plant_reedmace_sapling")

            end
        end,
    })
    ]]--

end
