---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_nsspf = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

-- According to the MT forum, mushrooms should grow on the north side of a tree trunk, but (some)
--      fungus grows on the south side. Here, mushrooms and fungi always grow just above the
--      surface, mushrooms on the north side, fungi on the south side
-- Table in the form
--      plant_table[wall_node_name] = list_of_mini_lists
-- Each mini-list is in the form [
--      direction, plant_node_name, optional_surface_table, optional_dust_table
-- ], e.g. [
--      1,
--      "unilib:plant_fungus_beefsteak",
--      { "unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf" },
--      { "unilib:snow_ordinary" }
-- ]
-- ...where 1 represents a north-facing mushroom, but -1 represents a south-facing fungus. Note that
--      if no surface nodes are specified, the mushroom can grow at any height on the trunk (not
--      just immediately above the surface)
local plant_table = {}
-- 1 in 100 suitable tree trunk nodes spawn a mushroom/fungus
local plant_scarcity = math.floor(100 * unilib.setting.nsspf_scarcity_factor)
local plant_min_light = 10

-- Corresponding table for truffles. The surface node (which must be a dirt), which is next to a
--      wall node (e.g. a pine tree trunk) is replaced by a similar-looking dirt node which, when
--      dug, produces an edible truffle
-- Table in the form
--      truffle_table[wall_node_name] = list_of_mini_lists
-- Each mini-list is in the form [part_name, optional_surface_table],
--      e.g. ["white", { "unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf" } ]
-- ...where "white" corresponds to "unilib:plant_tuber_truffle_white", produced when the player digs
--      "unilib:dirt_ordinary_with_mycelium_white"
local truffle_table = {}
-- Truffles are much rarer than mushroom/fungi, but can grow in very dim light
-- N.B. unilib.setting.nsspf_scarcity_factor does not apply to truffles
local truffle_scarcity = 1000
local truffle_min_light = 3
-- Table of positions, relative to the wall node, at which the truffle can occur; one position is
--      chosen randomly
local random_list = {
    {x = -1, y = -1, z = 0},
    {x = 1, y = -1, z = 0},
    {x = 0, y = -1, z = -1},
    {x = 0, y = -1, z = 1},
}

-- Special mushrooms/fungi, which typically grow on the top surface of a tree trunk. Unlike the
--      mushroom/fungi above, these items can grow anywhere, even far above ground
-- Table in the form
--      special_table[surface_node_name] = [list_of_plant_node_names]
local special_table = {}
-- 1 in 500 suitable tree trunk nodes spawn a special mushroom/fungus; this approximates to the
--      same spawn rate as "plant_scarcity" above
local special_scarcity = math.floor(500 * unilib.setting.nsspf_scarcity_factor)
local special_min_light = 10

-- List of glowing mushrooms and fungi. An ABM switches the non-glowing node for the glowing node
--      at night
local glowing_list = {}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_nsspf.register_mushroom(data_table)

    -- Original to unilib
    -- Register a mushroom to be grown on the north side of a tree trunk. This function should be
    --      called from the package's .exec() function
    --
    -- data_table compulsory fields:
    --      wall_name (str): e.g. "unilib:tree_pine_trunk", but can be any node (e.g. ordinary
    --          dirt)
    --      plant_name (str): e.g. "unilib:plant_fungus_beefsteak"
    --
    -- data_table optional fields:
    --      surface_list (list or nil): Optional list of surface node names (usually dirts)
    --      dust_list (list or nil): Optional list of dust node names

    local wall_name = data_table.wall_name
    local plant_name = data_table.plant_name

    local surface_list = data_table.surface_list or {}
    local dust_list = data_table.dust_list or {}

    local surface_table = {}
    for _, full_name in pairs(surface_list) do
        surface_table[full_name] = true
    end

    local dust_table = {}
    for _, full_name in pairs(dust_list) do
        dust_table[full_name] = true
    end

    local mini_list = {1, plant_name, surface_table, dust_table}

    if plant_table[wall_name] == nil then
        plant_table[wall_name] = {}
    end

    table.insert(plant_table[wall_name], mini_list)

end

function unilib.pkg.shared_nsspf.register_fungus(data_table)

    -- Original to unilib
    -- Register a fungus to be grown on the south side of a tree trunk. This function should be
    --      called from the package's .exec() function
    --
    -- data_table compulsory fields:
    --      wall_name (str): e.g. "unilib:tree_pine_trunk", but can be any node (e.g. ordinary
    --          dirt)
    --      plant_name (str): e.g. "unilib:plant_fungus_beefsteak"
    --
    -- data_table optional fields:
    --      surface_list (list or nil): Optional list of surface node names (usually dirts)
    --      dust_list (list or nil): Optional list of dust node names

    local wall_name = data_table.wall_name
    local plant_name = data_table.plant_name

    local surface_list = data_table.surface_list or {}
    local dust_list = data_table.dust_list or {}

    local surface_table = {}
    for _, full_name in pairs(surface_list) do
        surface_table[full_name] = true
    end

    local dust_table = {}
    for _, full_name in pairs(dust_list) do
        dust_table[full_name] = true
    end

    local mini_list = {-1, plant_name, surface_table, dust_table}

    if plant_table[wall_name] == nil then
        plant_table[wall_name] = {}
    end

    table.insert(plant_table[wall_name], mini_list)

end

function unilib.pkg.shared_nsspf.register_special(plant_name, surface_name)

    -- Original to unilib
    -- Registers a special mushroom/fungus which typically grows on the top surface of a tree trunk.
    --      This function should be called from the package's .exec() function
    --
    -- Args:
    --      plant_name (str): e.g. "unilib:mushroom_hairy"
    --      surface_name (str): e.g. "unilib:tree_jungle_trunk", should be a node placed by a
    --          decoration (e.g. a jungle tree)

    if special_table[surface_name] == nil then
        special_table[surface_name] = {}
    end

    table.insert(special_table[surface_name], plant_name)

end

function unilib.pkg.shared_nsspf.register_truffle(data_table)

    -- Original to unilib
    -- Register a truffle to be grown adjacent to a tree trunk tree trunk. This function should be
    --      called from the package's .exec() function
    --
    -- data_table compulsory fields:
    --      wall_name (str): e.g. "unilib:tree_pine_trunk", but can be any suitable node (e.g.
    --          ordinary dirt)
    --      part_name (str): e.g. "white"
    --      orig_name (str): e.g. "nsspf:tuber_magnatum_pico", the original truffle craftitem
    --      surface_list (list or nil): (Compuslory) list of surface node names (usually dirts)
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "White Truffle"
    --      eat (int): e.g. 10
    --      sci_name (str): e.g. "Tuber magnatum pico"

    local wall_name = data_table.wall_name
    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local surface_list = data_table.surface_list

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Truffle")
    local eat = data_table.eat or 10
    local sci_name = data_table.sci_name or nil

    local surface_table = {}
    for _, surface_name in pairs(surface_list) do
        surface_table[surface_name] = true
    end

    local mini_list = {part_name, surface_table, {}}

    if truffle_table[wall_name] == nil then
        truffle_table[wall_name] = {}
    end

    table.insert(truffle_table[wall_name], mini_list)

    -- Create the truffle itself
    local truffle_name = "unilib:plant_tuber_truffle_" .. part_name
    unilib.register_craftitem(truffle_name, orig_name, replace_mode, {
        description = unilib.utils.annotate(description, sci_name),
        image = "unilib_plant_tuber_truffle_" .. part_name .. ".png",

        on_use = unilib.cuisine.eat_on_use(truffle_name, eat),
    })

    -- Create a mycelium dirt node which drop the truffle when dug
    unilib.register_node("unilib:dirt_ordinary_with_mycelium_" .. part_name, nil, replace_mode, {
        description = S("Ordinary Dirt with Mycelium"),
        -- N.B. In unilib code, I have randomly assigned one of the mycelium textures to each
        --      truffle type
        tiles = {
            "unilib_dirt_ordinary_with_mycelium_" .. part_name .. ".png",
            "unilib_dirt_ordinary.png",
        },
        groups = {crumbly = 3, not_in_creative_inventory = 1},
        -- (no sounds)

        drop = truffle_name,
        -- N.B. is_ground_content = false not in original code; added to match other dirts
        is_ground_content = false,
    })

end

function unilib.pkg.shared_nsspf.register_glowing(plant_name)

    -- Original to unilib
    -- Register a mushroom/fungus to glow at night. The calling package must provide at least
    --      two nodes, called X and X_glowing
    --
    -- Args:
    --      plant_name (str): e.g. "unilib:plant_fungus_nightlight"

    table.insert(glowing_list, plant_name)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_nsspf.init()

    return {
        description = "Shared functions for mushrooms and fungi (from nsspf)",
    }

end

function unilib.pkg.shared_nsspf.post()

    -- Code original to unilib
    -- N.B. The mechanism for placing mushrooms/fungi/truffles adjacent to tree trunks is probably
    --      not very efficient, but it is still much less laggy than the original code which used a
    --      billion ABMs

    for wall_name, main_list in pairs(plant_table) do

        core.register_on_generated(function(minp, maxp)

            -- The mapgen is not likely to generate trees below sea level
            if maxp.y < 1 then
                return
            end

            local pos_list = core.find_nodes_in_area(minp, maxp, wall_name)
            for n = 1, #pos_list do

                local pos = pos_list[n]

                -- By default, 1 in 100 suitable tree trunk nodes spawn a mushroom/fungus
                if math.random(plant_scarcity) == 1 then

                    -- Choose one of the mushrooms/fungi at random
                    local mini_list = main_list[math.random(#main_list)]
                    local target_pos = {x = pos.x, y = pos.y, z = pos.z + mini_list[1]}
                    -- "target_name" is the name of the node currently occupying the place, where
                    --      the mushroom/fungus will spawn. We require that place to be occupied by
                    --      air, or one of the dusts specified by "plant_table" (such as snow)
                    local target_name = core.get_node(target_pos).name
                    if (target_name == "air" or mini_list[4][target_name] ~= nil) and
                            core.get_node_light(target_pos) > plant_min_light then

                        -- If no surface is specified, then the mushroom/fungus can grow above any
                        --      surface
                        local surface_pos = {x = pos.x, y = pos.y - 1, z = pos.z + mini_list[1]}
                        local surface_name = core.get_node(surface_pos).name
                        if mini_list[3][surface_name] ~= nil then
                            core.set_node(target_pos, {name = mini_list[2]})
                        end

                    end

                end

            end

        end)

    end

    for wall_name, main_list in pairs(special_table) do

        core.register_on_generated(function(minp, maxp)

            -- The mapgen is not likely to generate trees below sea level
            if maxp.y < 1 then
                return
            end

            local pos_list = core.find_nodes_in_area(minp, maxp, wall_name)
            for n = 1, #pos_list do

                local pos = pos_list[n]

                -- By default, 1 in 500 suitable tree trunk nodes spawn a "special" mushroom/fungus
                if math.random(special_scarcity) == 1 then

                    -- Choose one of the mushrooms/fungi at random
                    local plant_name = main_list[math.random(#main_list)]

                    local target_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
                    if core.get_node(target_pos).name == "air" and
                            core.get_node_light(target_pos) > special_min_light then
                        core.set_node(target_pos, {name = plant_name})
                    end

                end

            end

        end)

    end

    for wall_name, main_list in pairs(truffle_table) do

        core.register_on_generated(function(minp, maxp)

            -- The mapgen is not likely to generate trees below sea level
            if maxp.y < 1 then
                return
            end

            local pos_list = core.find_nodes_in_area(minp, maxp, wall_name)
            for n = 1, #pos_list do

                local pos = pos_list[n]

                -- By default, 1 in 1000 suitable tree trunk nodes spawn a truffle
                if math.random(truffle_scarcity) == 1 then

                    -- Choose one of the truffles at random
                    local mini_list = main_list[math.random(#main_list)]
                    -- Choose one of the four surface nodes that are adjacent to the wall node at
                    --      random
                    local random_pos = random_list[math.random(#random_list)]
                    local surface_pos = {
                        x = pos.x + random_pos.x,
                        y = pos.y + random_pos.y,
                        z = pos.z + random_pos.z,
                    }

                    if mini_list[2][core.get_node(surface_pos).name] ~= nil then

                        if not unilib.setting.nsspf_exposed_truffle_flag then
                            surface_pos.y = surface_pos.y - 1
                        end

                        core.set_node(
                            surface_pos,
                            {name = "unilib:dirt_ordinary_with_mycelium_" .. mini_list[1]}
                        )

                    end

                end

            end

        end)

    end

    -- Set up glowing mushroom/fungi
    if #glowing_list > 0 then

        local complete_list = {}
        for _, full_name in pairs(glowing_list) do

            table.insert(complete_list, full_name)
            table.insert(complete_list, full_name .. "_glowing")

        end

        unilib.register_abm({
            label = "Glowing mushrooms/fungi [shared_nsspf]",
            nodenames = complete_list,

            interval = 10,
            chance = 1,

            action = function(pos, node, active_object_count, active_object_count_wider)

                -- Work out which mushroom/fungus we have
                local full_name = string.gsub(node.name, "_glowing$", "")

                -- Place the glowing or non-glowing node, depending on the time of day
                if core.get_node_light(pos, nil) < 10 and (
                    (core.get_timeofday() < 19500) or (core.get_timeofday() > 5000)
                ) then
                    core.set_node(pos, {name = full_name .. "_glowing"})
                else
                    core.set_node(pos, {name = full_name})
                end

            end
        })

    end

end
