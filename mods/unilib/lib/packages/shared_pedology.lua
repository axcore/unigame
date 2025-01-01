---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_pedology = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

-- Descriptions for various states of permeable wetness
local wet_name_list = {[0] = S("Dry"),  S("Wet"), S("Watery"), S("Sludgy"), S("Muddy"), S("Slurry")}
-- Maximum wetness for any material, including liquid versions, e.g.
--      overall_max_wet_table["clay_permeable"] = 5
local overall_max_wet_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions (ABM actions)
---------------------------------------------------------------------------------------------------

local function do_ooze(pos, node, active_object_count, active_object_wider)

    -- Adapted from pedology/init.lua, was pedology.ooze()
    -- Performs the spread of wetness from a wetter node to an adjacent drier node

    local wet = core.get_item_group(node.name, "wet")
    if wet == 0 then
        return
    end

    -- This table contain the nodes which are either neighbours of "node", or which touch the "node"
    --      at an edge or corner, and which are not on a higher y-level than "node"
    local neighbour_list = {
        {
            -- Neighbour directly below
            {x = pos.x, y = pos.y - 1, z = pos.z},
            min_wet = 1,
        },
        {
            -- Touching the lower sides
            {x = pos.x, y = pos.y - 1, z = pos.z - 1},
            {x = pos.x, y = pos.y - 1, z = pos.z + 1},
            {x = pos.x - 1, y = pos.y - 1, z = pos.z},
            {x = pos.x + 1, y = pos.y - 1, z = pos.z},
            min_wet = 1,
        },
        {
            -- Touching the lower corners
            {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
            {x = pos.x - 1, y = pos.y - 1, z = pos.z + 1},
            {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
            {x = pos.x + 1, y = pos.y - 1, z = pos.z + 1},
            {x = pos.x + 1, y = pos.y - 1, z = pos.z + 1},
            min_wet = 1,
        },
        {
            -- Sides on the same level
            {x = pos.x - 1, y = pos.y, z = pos.z},
            {x = pos.x + 1, y = pos.y, z = pos.z},
            {x = pos.x, y = pos.y, z = pos.z - 1},
            {x = pos.x, y = pos.y, z = pos.z + 1},
            min_wet = 2,
        },
        {
            -- Touching at the side on the same level
            {x = pos.x - 1, y = pos.y, z = pos.z - 1},
            {x = pos.x - 1, y = pos.y, z = pos.z + 1},
            {x = pos.x + 1, y = pos.y, z = pos.z - 1},
            {x = pos.x + 1, y = pos.y, z = pos.z + 1},
            min_wet = 12
        },
    }

    for i = 1, #neighbour_list do

        for j = 1, #neighbour_list[i] do

            local node = core.get_node(neighbour_list[i][j])
            local name = node.name
            local dest_wet = core.get_item_group(name, "wet")
            if dest_wet < wet and
                    core.get_item_group(name, "sucky") >= 1 and
                    neighbour_list[i].min_wet <= (wet - dest_wet) then

                unilib.pkg.shared_pedology.do_wet(neighbour_list[i][j])
                unilib.pkg.shared_pedology.do_dry(pos)
                return

            end

        end

    end

end

local function do_suck(pos, node, active_object_count, active_object_wider)

    -- Adapted from pedology/init.lua, was pedology.suck()
    -- Wettens the node if many water nodes are neighbours, or are touching it at an edge or corner

    local wet = core.get_item_group(node.name, "wet")
    local score = 0

    -- These three tables contain the positions of all nodes around node
    local neighbour_list = {
        {
            -- Sides
            {x = pos.x, y = pos.y - 1, z = pos.z},
            {x = pos.x - 1, y = pos.y, z = pos.z},
            {x = pos.x + 1, y = pos.y, z = pos.z},
            {x = pos.x, y = pos.y + 1, z = pos.z},
            {x = pos.x, y = pos.y, z = pos.z - 1},
            {x = pos.x, y = pos.y, z = pos.z + 1},
            rating = 1,
        },
        {
            -- Edges
            {x = pos.x, y = pos.y - 1, z = pos.z - 1},
            {x = pos.x, y = pos.y - 1, z = pos.z + 1},
            {x = pos.x, y = pos.y + 1, z = pos.z - 1},
            {x = pos.x, y = pos.y + 1, z = pos.z + 1},
            {x = pos.x - 1, y = pos.y, z = pos.z - 1},
            {x = pos.x - 1, y = pos.y, z = pos.z + 1},
            {x = pos.x + 1, y = pos.y, z = pos.z - 1},
            {x = pos.x + 1, y = pos.y, z = pos.z + 1},
            {x = pos.x - 1, y = pos.y - 1, z = pos.z},
            {x = pos.x - 1, y = pos.y + 1, z = pos.z},
            {x = pos.x + 1, y = pos.y - 1, z = pos.z},
            {x = pos.x + 1, y = pos.y + 1, z = pos.z},
            rating = 0.5,
        },
        {
            -- Corners
            {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
            {x = pos.x - 1, y = pos.y - 1, z = pos.z + 1},
            {x = pos.x - 1, y = pos.y + 1, z = pos.z - 1},
            {x = pos.x - 1, y = pos.y + 1, z = pos.z + 1},
            {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
            {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
            {x = pos.x + 1, y = pos.y + 1, z = pos.z - 1},
            {x = pos.x + 1, y = pos.y - 1, z = pos.z + 1},
            {x = pos.x + 1, y = pos.y - 1, z = pos.z + 1},
            rating = 0.25,
        },
    }

    for i = 1, #neighbour_list do

        for j = 1, #neighbour_list[i] do

            local neighbor = core.get_node(neighbour_list[i][j])
            local name = neighbor.name
            local water = core.get_item_group(name, "water")
            if water >= 1 then
                score = score + neighbour_list[i].rating
            end

        end

    end

    local wetten_flag = false
    if wet == 0 and score >= 1 then
        wetten_flag = true
    elseif wet == 1 and score >= 2 then
        wetten_flag = true
    elseif wet == 2 and score >= 3 then
        wetten_flag = true
    elseif wet == 3 and score >= 5 then
        wetten_flag = true
    elseif wet == 4 and score >= 8 then
        wetten_flag = true
    elseif wet == 5 and score >= 11 then

        -- Erosion: turn node into water
        core.set_node(pos, {name = "unilib:liquid_water_fresh_source"})
        return

    end

    if wetten_flag == true then
        unilib.pkg.shared_pedology.do_wet(pos)
    end

end

local function do_sun_dry(pos, node, active_object_count, active_object_wider)

    -- Adapted from pedology/init.lua, was pedology.sun_dry()
    -- Dries out a node when it is in direct sunlight

    if core.get_item_group(node.name, "wet") < 6 then

        -- Don’t dry off the node, if there is water nearby
        if not core.find_node_near(pos, 1, {"group:water"}) then

            local light = core.get_node_light(pos, core.get_timeofday())
            if light >= unilib.setting.pedology_dry_light then
                unilib.pkg.shared_pedology.do_dry(pos)
            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (dripping water)
---------------------------------------------------------------------------------------------------

local function get_drip_particle(pos, wet)

    -- Adapted from pedology/init.lua, was pedology.drip_particle()
    -- Permeable nodes (whose wetness is at least 1) drip water, when they are directly above at
    --      least two "air" nodes (and when the MT setting permits it)
    -- This function creates particle-based dripping water

    if core.env:get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name == "air" and
            core.env:get_node({x = pos.x, y = pos.y - 2, z = pos.z}).name == "air" then

        return core.add_particlespawner({
            amount = wet,
            time = 0,
            texture = "unilib_liquid_water_fresh.png",

            maxexptime = 3,
            minexptime = 1,
            maxpos = {pos.x + (45 / 100), pos.y - 0.5, pos.z + (45 / 100)},
            minpos = {pos.x - (45 / 100), pos.y - 0.5, pos.z - (45 / 100)},
            maxvel = {0, 0, 0},
            minvel = {0, (unilib.constant.gravity * -1), 0},

            collisiondetection = true,
            vertical = true,
        })

    else

        return nil

    end
end

local function create_drip(pos)

    -- Adapted from pedology/drip.lua, was pedology.create_drip()
    -- Permeable nodes (whose wetness is at least 1) drip water, when they are directly above at
    --      least two "air" nodes (and when the MT setting permits it)
    -- This function creates entity-based dripping water

    if core.env:get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name == "air" and
            core.env:get_node({x = pos.x, y = pos.y - 2, z = pos.z}).name == "air" then

        local i = math.random(-45, 45) / 100
        core.env:add_entity(
            {x = pos.x + i, y = pos.y - 0.5, z = pos.z + i},
            "unilib:entity_water_drop"
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (register clays, dirts, gravels and liquids)
---------------------------------------------------------------------------------------------------

local function register_permeable_node(data_table)

    -- Adapted from pedology/init.lua, was pedology.register_sucky()
    -- Called by unilib.pkg.shared_pedology.register_permeable_set() to register a node of a
    --      specified material and wetness
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "clay_permeable"
    --      orig_part_name (st): e.g. "clay", the component used in the node names for the original
    --          code
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Permeable Clay (Dry)"
    --      wetness (int): e.g. 5
    --      oozing_group (int): e.g. 1
    --      sucky_group (int): e.g. 1
    --      melting_point (int): e.g. 1000. The value is used as the node's .melting_point group
    --      drop (str): "unilib:clay_permeable_lump_0"
    --      sound_table (table): Sound table for the material type. If nil, makes no sound
    --      additional_table (table): Table of additional groups (by now, a flat table)

    local part_name = data_table.part_name
    local orig_part_name = data_table.orig_part_name
    local replace_mode = data_table.replace_mode
    local additional_table = data_table.additional_table
    local description = data_table.description
    local drop = data_table.drop
    local melting_point = data_table.melting_point
    local oozing_group = data_table.oozing_group
    local sound_table = data_table.sound_table
    local sucky_group = data_table.sucky_group
    local wetness = data_table.wetness

    local item_name = part_name .. "_" .. tostring(wetness)
    local orig_full_name = "pedology:" .. orig_part_name .. "_" .. tostring(wetness)

    -- If the node is not dry, do not add it into the creative inventory
    local non_creative_group
    if wetness == 0 then
        non_creative_group = 0
    else
        non_creative_group = 1
    end

    local groups = {
        [part_name] = 1,
        melting_point = melting_point,
        not_in_creative_inventory = non_creative_group,
        oozing = oozing_group,
        sucky = sucky_group,
        wet = wetness,
    }

    if additional_table ~= nil then

        for k,v in pairs(additional_table) do
            groups[k] = v
        end

    end

    local on_construct, on_destruct

    if unilib.setting.pedology_drip_mode == "particle" then

        on_construct = function(pos)

            local dripper = get_drip_particle(pos, wetness)
            if dripper ~= nil then

                local meta = core.get_meta(pos)
                meta:set_int("dripper", dripper)

            end

        end

        on_destruct = function(pos)

            local meta = core.get_meta(pos)
            local dripper = meta:get_int("dripper")
            if dripper ~= nil then
                core.delete_particlespawner(dripper)
            end

        end

    else

        on_construct, on_destruct = nil

    end

    unilib.register_node("unilib:" .. item_name, orig_full_name, replace_mode, {
        description = description,
        tiles = {"unilib_" .. item_name .. ".png"},
        groups = groups,
        sounds = sound_table,

        drop = drop,
        inventory_image = core.inventorycube("unilib_" .. item_name .. ".png"),
        paramtype = "light",

        on_construct = on_construct,

        on_destruct = on_destruct,
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions (register clays, dirts, gravels and liquids)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pedology.register_permeable_set(data_table)

    -- Adapted from pedology/init.lua, was pedology.register_sucky_group()
    -- Registers a set of permeable node of a particular material (e.g. clay), with different
    --      wetnesses from dry to liquid; also register a lump, dropped by those nodes
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "clay_permeable"
    --      orig_part_name (st): e.g. "clay", the component used in the node names for the original
    --          code
    --      node_description (str): e.g. "Permeable Clay"
    --      lump_description (str); e.g. "Permeable Clay Lump"
    --      melt_list (list): List of values for the .melting_point group for each wetness level.
    --          Note that the original pedology code does nothing with the .melting_group, after
    --          creating it (besides an unfinished ABM); the values are retained in unilib code in
    --          case pedology is updated in the future
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      additional_table (table): Either a table of tables of strings, a table of strings or
    --          nil. If it is nil, no additional groups will be added to all nodes. If it is a
    --          table, the strings are interpreted as group names which will be added to each node.
    --          If it is a table of tables strings, you can specify the groups tables for each
    --          wetness level (start with index number 0 for dry)
    --      drop_count (int): The number of lumps dropped by the node. If 0, the node simply drops
    --          itself (not recommended)
    --      lump_max_wet(int): The maximum wetness level for this material (as a lump), minimum 0,
    --          recommended maximum 3
    --      node_max_wet(int): The maximum wetness level for this material (as a node), minimum 0,
    --          maximum 5. Does not take account of the clay/silt liquids, so the value for
    --          permeable clay is 3
    --      ooze_chance (float): The chance of oozing (used in ABM)
    --      ooze_interval (float): The interval in seconds in which the node may ooze (used in ABM)
    --      overall_max_wet(int): The maximum wetness level for this material (as a node or liquid),
    --          so the value for permeable clay is 5
    --      sound_table (table): Sound table for the material type. If nil, makes no sound

    local part_name = data_table.part_name
    local orig_part_name = data_table.orig_part_name
    local node_description = data_table.node_description
    local lump_description = data_table.lump_description
    local melt_list = data_table.melt_list

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local additional_table = data_table.additional_table or {}
    local drop_count = data_table.drop_count or 0
    local lump_max_wet = data_table.lump_max_wet or 3
    local node_max_wet = data_table.node_max_wet or 5
    local ooze_chance = data_table.ooze_chance or 1
    local ooze_interval = data_table.ooze_interval or 60
    local overall_max_wet = data_table.overall_max_wet or node_max_wet
    local sound_table = data_table.sound_table or nil

    local dripping_list = {}

    local nested_group_flag = false
    if type(additional_table) == "table" then

        if type(additional_table[0]) == "table" then
            nested_group_flag = true
        end

    end

    for wetness = 0, node_max_wet do

        local full_name, orig_full_name, drop, sucky_group, oozing_group, melting_point,
                mod_additional_table, this_lump_description

        if wetness == 0 then
            oozing_group = 0
        else
            oozing_group = 1
        end

        if wetness == node_max_wet and wetness ~= 5 then
            sucky_group = 0
        else
            sucky_group = 1
        end

        if melt_list == nil then
            melting_point = 0
        else
            melting_point = melt_list[wetness]
        end

        if lump_description ~= nil then
            this_lump_description = unilib.utils.brackets(lump_description, wet_name_list[wetness])
        end

        if lump_max_wet == -1 then

            drop = nil

        elseif wetness > lump_max_wet then

            full_name = "unilib:" .. part_name .. "_lump_" .. tostring(lump_max_wet)
            drop = full_name .. " " .. tostring(drop_count)

        else

            full_name = "unilib:" .. part_name .. "_lump_" .. tostring(wetness)
            drop = full_name .. " " .. tostring(drop_count)

            if orig_part_name then
                orig_full_name = "pedology:lump_" .. orig_part_name .. "_" .. tostring(wetness)
            end

            unilib.register_craftitem(full_name, orig_full_name, replace_mode, {
                description = this_lump_description,
                inventory_image = "unilib_" .. part_name .. "_lump_inv_" .. tostring(wetness) ..
                        ".png",

                wield_image = "unilib_" .. part_name .. "_lump_" .. tostring(wetness) .. ".png",
            })

        end

        if nested_group_flag then
            mod_additional_table = additional_table[wetness]
        else
            mod_additional_table = additional_table
        end

        if wetness == 3 then
            mod_additional_table["disable_jump"] = 1
        end

        register_permeable_node({
            part_name = part_name,
            orig_part_name = orig_part_name,
            replace_mode = replace_mode,
            additional_table = mod_additional_table,
            description = unilib.utils.brackets(node_description, wet_name_list[wetness]),
            drop = drop,
            melting_point = melting_point,
            oozing_group = oozing_group,
            sound_table = sound_table,
            sucky_group = sucky_group,
            wetness = wetness,
        })

        -- (Add dripping nodes to the ABM below)
        if wetness > 0 then
            table.insert(dripping_list, "unilib:" .. part_name .. "_" .. tostring(wetness))
        end

    end

    if unilib.setting.pedology_drip_mode == "entity" then

        unilib.register_abm({
            label = "Drip from permeable stone [shared_pedology]",
            nodenames = dripping_list,
            neighbors = {"air"},

            chance = math.max(ooze_chance, 22),
            interval = math.max(ooze_interval / 4, 2),

            action = create_drip,
        })

    end

    if node_max_wet > 0 then

        unilib.register_abm({
            label = "Wetness spreads to nearby permeable nodes [shared_pedology]",
            nodenames = {"group:" .. part_name},
            neighbors = {"group:sucky"},

            chance = ooze_chance,
            interval = ooze_interval,

            action = do_ooze,
        })

    end

    -- The maximum overall wetness (including liquids) is needed by
    --      unilib.pkg.shared_pedology.do_wet()
    overall_max_wet_table[part_name] = overall_max_wet

end

function unilib.pkg.shared_pedology.register_liquid(data_table)

    -- Adapted from pedology/init.lua, was pedology.register_liquid()
    -- Registers one of the unique liquids provided by the pedology mod

    -- data_table compulsory fields:
    --      part_name (str): e.g. "water_fresh", "clay_permeable_4"
    --      source_orig_name (str): e.g. "pedology:water_fresh_source", "pedology:clay_4_source"
    --      flowing_orig_name (str): e.g. e.g. "pedology:water_fresh_flowing",
    --          "pedology:clay_4_flowing"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      additional_table (str): e.g. Additional groups, e.g. {water = 1},
    --          {oozing = 1, sucky = 1, wet = 4}
    --      damage_per_second (str): e.g. 0
    --      drowning (str): e.g. 2
    --      flowing_description (str): e.g. "Flowing Fresh Water"
    --      rgb_table (str): e.g. {r = 100, b = 200, g = 100, a = 60}
    --      sludge_flag (str): True for clays/silts. The nodes are not registered as unilib liquids
    --          (though they have the same properties as other Minetest liquids), and their node
    --          names do not contain a "liquid" component. False for other liquids (in the original
    --          code, the two water variants). If false, the calling package should call
    --          unilib.register_liquid()
    --      source_description (str): e.g. "Fresh Water Source"
    --      viscosity (str): e.g. 1

    local part_name = data_table.part_name
    local source_orig_name = data_table.orig_name
    local flowing_orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local additional_table = data_table.additional_table or {water = 1}
    local damage_per_second = data_table.damage_per_second or 0
    local drowning = data_table.drowning or 2
    local flowing_description = data_table.flowing_description or S("Flowing Water")
    local rgb_table = data_table.rgb_table or {r = 100, b = 200, g = 100, a = 60}
    local sludge_flag = data_table.sludge_flag or false
    local source_description = data_table.source_description or S("Water Source")
    local viscosity = data_table.viscosity or 1

    local source_group_table = {liquid = 1, wet = 6}
    local flowing_group_table = {liquid = 1, not_in_creative_inventory = 1, wet = 6}
    for k, v in pairs(additional_table) do

        source_group_table[k] = v
        flowing_group_table[k] = v

    end

    local source_full_name, flowing_full_name, img
    if not sludge_flag then

        source_full_name = "unilib:liquid_" .. part_name .. "_source"
        flowing_full_name = "unilib:liquid_" .. part_name .. "_flowing"
        img = "unilib_liquid_" .. part_name .. ".png"

    else

        -- Not registered as a unilib liquid; but still has the properties of a Minetest liquid
        -- We don't add "_source" to the end of a node name, because other code in this package is
        --      expecting a node name ending with a numeral
        source_full_name = "unilib:" .. part_name
        flowing_full_name = "unilib:" .. part_name .. "_flowing"
        img = "unilib_" .. part_name .. ".png"

    end

    unilib.register_node(source_full_name, source_orig_name, replace_mode, {
        description = source_description,
        tiles = {img},
        groups = source_group_table,
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.water,

        buildable_to = true,
        damage_per_second = damage_per_second,
        diggable = false,
        drawtype = "liquid",
        drop = "",
        drowning = drowning,
        inventory_image = core.inventorycube(img),
        -- N.B. is_ground_content = false not in original code; added to match other liquids
        is_ground_content = false,
        liquid_alternative_flowing = flowing_full_name,
        liquid_alternative_source = source_full_name,
        liquid_viscosity = viscosity,
        liquidtype = "source",
        paramtype = "light",
        pointable = false,
        post_effect_color = rgb_table,
        special_tiles = {
            {name = img, backface_culling = false},
        },
        walkable = false,
    })

    unilib.register_node(flowing_full_name, flowing_orig_name, replace_mode, {
        description = flowing_description,
        tiles = {img},
        groups = flowing_group_table,
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.water,

        buildable_to = true,
        damage_per_second = damage_per_second,
        diggable = false,
        drawtype = "flowingliquid",
        drop = "",
        drowning = drowning,
        inventory_image = core.inventorycube(img),
        -- N.B. is_ground_content = false not in original code; added to match other liquids
        is_ground_content = false,
        liquid_alternative_flowing = flowing_full_name,
        liquid_alternative_source = source_full_name,
        liquid_viscosity = viscosity,
        liquidtype = "flowing",
        paramtype = "light",
        paramtype2 = "flowingliquid",
        pointable = false,
        post_effect_color = rgb_table,
        special_tiles = {
            {name = img, backface_culling = false},
            {name = img, backface_culling = true},
        },
        walkable = false,
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions (change wetness API)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pedology.do_dry(pos)

    -- Adapted from pedology/init.lua, was pedology.dry()
    -- Replace the node with a drier version of it, if available
    -- This is an API function available to any packages that want it

    local node = core.get_node(pos)
    local wet = core.get_item_group(node.name, "wet")
    local dried = tostring(wet - 1)
    if wet <= 0 then
        return
    end

    local new_name = string.sub(node.name, 1, #node.name - 1) .. dried
    core.set_node(pos, {name = new_name, param1 = 0, param2 = 0})

end

function unilib.pkg.shared_pedology.do_wet(pos)

    -- Adapted from pedology/init.lua, was pedology.wetten()
    -- Replace the node with a wetter version of it, if available
    -- This is an API function available to any packages that want it

    local node = core.get_node(pos)
    local wet = core.get_item_group(node.name, "wet")
    local item_name = unilib.utils.get_item_name(node.name)
    local part_name = string.sub(item_name, 1, #item_name - 2)

    if overall_max_wet_table[part_name] == nil then
        return
    elseif wet > overall_max_wet_table[part_name] then
        return
    end

    local newbasename = string.sub(node.name, 1, #node.name - 1) .. tostring(wet + 1)
    core.set_node(pos, {name = newbasename, param1 = 0, param2 = 0})

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pedology.init()

    return {
        description = "Shared functions for permeable dirts/clays/stones (from pedology)",
        notes = "Creates sets of permeable dirt/gravel/silt/sand nodes. Wetness are wettened by" ..
                " proximity to water and dried by direct sunlight, or when the wetness can" ..
                " travel slowly downwards",
    }

end

function unilib.pkg.shared_pedology.exec()

    -- Wetness ABMs
    unilib.register_abm({
        label = "Dryness spread [shared_pedology]",
        nodenames = {"group:sun_dry"},
        neighbors = {"air"},

        chance = 10,
        interval = 30,

        action = do_sun_dry,
    })

    unilib.register_abm({
        label = "Wetness spread [shared_pedology]",
        nodenames = {"group:sucky"},
        neighbors = {"group:water"},

        chance = 1,
        interval = 30,

        action = do_suck,
    })

    if unilib.setting.pedology_drip_mode == "entity" then

        -- Entity-based water drips
        unilib.register_entity("unilib:entity_water_drop", {
            initial_properties = {
                collisionbox = {0, 0, 0, 0, 0, 0},
                hp_max = 2000,
                initial_sprite_basepos = {x = 0, y = 0},
                physical = true,
                spritediv = {x = 1, y = 1},
                -- (Texture from the "liquid_water_fresh" package)
                textures = {
                    "unilib_liquid_water_fresh.png",
                    "unilib_liquid_water_fresh.png",
                    "unilib_liquid_water_fresh.png",
                    "unilib_liquid_water_fresh.png",
                    "unilib_liquid_water_fresh.png",
                    "unilib_liquid_water_fresh.png",
                },
                visual = "cube",
                visual_size = {x = 0.05, y = 0.1},
            },

            on_activate = function(self, staticdata)

                self.object:setsprite({x = 0, y = 0}, 1, 1, true)

            end,

            on_step = function(self, dtime)

                local k = math.random(1, 222)
                local ownpos = self.object:get_pos()

                if k == 1 then
                    self.object:setacceleration({x = 0, y = -5, z = 0})
                end

                if core.env:get_node(
                    {x = ownpos.x, y = ownpos.y + 0.5, z = ownpos.z}
                ).name == "air" then
                    self.object:setacceleration({x = 0, y = -5, z = 0})
                end

                if core.env:get_node(
                    {x = ownpos.x, y = ownpos.y - 0.5, z = ownpos.z}
                ).name ~= "air" then

                    self.object:remove()
                    core.sound_play(
                        {name = "unilib_wetness_drip"},
                        {pos = ownpos, gain = 0.5, max_hear_distance = 8}
                    )

                end

            end,
        })

    end

end
