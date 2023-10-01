---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dynamic.lua
--      Set up dynamic flooders and extenders
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Tables used to create the custom ore "blobs"
local all_sides_table = {
    {x = 1, y = 0, z = 0},
    {x = -1, y = 0, z = 0},
    {x = 0, y = 1, z = 0},
    {x = 0, y = -1, z = 0},
    {x = 0, y = 0, z = 1},
    {x = 0, y = 0, z = -1}
}

local all_corners_table = {
    {x = 1, y = 1, z = 1},
    {x = -1, y = 1, z = 1},
    {x = 1, y = -1, z = 1},
    {x = -1, y = -1, z = 1},
    {x = 1, y = 1, z = -1},
    {x = -1, y = 1, z = -1},
    {x = 1, y = -1, z = -1},
    {x = -1, y = -1, z = -1}
}

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- N.B. Code in this file is inadequately documented

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function convert_sides(sides)

    -- Original to unilib

    if sides == "sides" then
        return all_sides_table
    elseif sides == "corners" then
        return all_corners_table
    else
        return sides
    end

end

local function extend_me(pos, wherein, output, sides, chance)

    -- Adapted from underch/dynamic.lua
    -- Called from the LBM created by unilib.register_extender(), to convert a dynamic node (and
    --      optionally surrounding nodes matching "wherein") into the "output" node

    for _, p in pairs(sides) do

        local pp = {x = pos.x + p.x, y = pos.y + p.y, z = pos.z + p.z}
        if minetest.get_node(pp).name == wherein and math.random() < chance then
            extend_me(pp, wherein, output, sides, chance)
        end

    end

    minetest.set_node(pos, {name = output})

end

local function flood_me(pos, wherein, output, sides, size, ore_table, top_table)

    -- Adapted from underch/dynamic.lua
    -- Called from the LBM created by unilib.register_flooder(), to convert a dynamic node (and
    --      optionally surrounding nodes matching "wherein") into the "output" node

    local positions = {}

    local i = 1
    local pc = 0
    local blocks = 1

    local function add_pos(p)

        positions[pc+1] = p
        pc = pc + 1

    end

    for _, p in pairs(sides) do
        add_pos({x = pos.x + p.x, y = pos.y + p.y, z = pos.z + p.z})
    end

    while i <= pc do

        if minetest.get_node(positions[i]).name == wherein and math.random() < size/blocks then

            for _, p in pairs(sides) do

                add_pos({
                    x = positions[i].x + p.x,
                    y = positions[i].y + p.y,
                    z = positions[i].z + p.z,
                })

            end

            local blockset = false
            if ore_table ~= nil then

                for _, o in pairs(ore_table) do

                    if (math.random() < o.chance) then

                        blockset = true
                        minetest.set_node(positions[i], {name = o.block})
                        break

                    end

                end

            end

            if not blockset then
                minetest.set_node(positions[i], {name = output})
            end

            blocks = blocks + 1

            if top_table ~= nil then

                local above = {x = positions[i].x, y = positions[i].y+1, z = positions[i].z}
                if minetest.get_node(above).name == "air" then

                    for _, t in pairs(top_table) do

                        if (math.random() < t.chance) then

                            minetest.set_node(above, {name = t.block})
                            break

                        end

                    end

                end

            end
        end

        i = i + 1

    end

    minetest.set_node(pos, {name = output})

end

local function flood_me_jit(pos, wherein, output, sides, size, ore_table, top_table)

    -- Adapted from underch/dynamic.lua ("experimental" version)
    -- Called from the LBM created by unilib.register_flooder(), to convert a dynamic node (and
    --      optionally surrounding nodes matching "wherein") into the "output" node

    local positions = {}

    local i = 1
    local pc = 0
    local blocks = 1

    local function add_pos(p)

        positions[pc+1] = p
        pc = pc + 1

    end

    for _, p in pairs(sides) do
        add_pos({x = pos.x + p.x, y = pos.y + p.y, z = pos.z + p.z})
    end

    while i <= pc do

        local name = minetest.get_node(positions[i]).name
        local is_jit = name == "unilib:misc_matrix_bulk" or name == "unilib:misc_matrix_crust"

        if (is_jit or name == wherein) and math.random() < size/blocks then

            for _, p in pairs(sides) do
                add_pos({x = positions[i].x+p.x, y = positions[i].y+p.y, z = positions[i].z+p.z})
            end

            local blockset = false
            if ore_table ~= nil then

                for _, o in pairs(ore_table) do

                    if (math.random() < o.chance) then

                        blockset = true
                        minetest.set_node(positions[i], {name = o.block})
                        break

                    end

                end

            end

            if not blockset then
                minetest.set_node(positions[i], {name = output})
            end

            blocks = blocks + 1

            if top_table ~= nil then

                local above = {x = positions[i].x, y = positions[i].y+1, z = positions[i].z}
                if minetest.get_node(above).name == "air" then

                    for _, t in pairs(top_table) do

                        if (math.random() < t.chance) then

                            minetest.set_node(above, {name = t.block})
                            break

                        end

                    end

                end

            end

        elseif is_jit then

            unilib.jbiome_reveal(positions[i], true)

        end

        i = i + 1

    end

    minetest.set_node(pos, {name = output})

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.register_extender(data_table)

    -- Adapted from underch/dynamic.lua
    -- Creates a dynamic node, which is placed randomly in the map (from a package like
    --      "mapgen_underch", calling a function like unilib.pbiome_ore() )
    -- An LBM runs to convert the dynamic node into the "output" node. Surrounding "wherein" nodes
    --      are randomly converted to the "output" node as well, creating something like an ore
    --      "blob"
    -- (In case the dynamic node is visible in-game, punching it will apply the conversion)
    --
    -- data_table compulsory fields:
    --      label (str): A unique ID for this dynamic node. Usually the same as the item_name for
    --          the "output" node (e.g. "stone_ordinary" from "unilib:stone_ordinary"); but in case
    --          there are several dynamic nodes with the same "output" node, the label can end in
    --          a variant, e.g. "stone_ordinary_2"
    --      orig_name (str): The full_name of the dynamic node in the original mod (or an empty
    --          string if not applicable
    --      wherein (str): The wherein in which the "output" node is placed, e.g. "air"
    --      output (str): The "output" node, e.g. "unilib:liquid_lava_ordinary_flowing"
    --      replace_mode (str): Replace mode for the calling package's original mod (e.g. "defer")
    --      sides (str or table): If a string, the values "sides" or "corners", which are converted
    --          into one of the tables defined above. Otherwise, a table in the same general format
    --      chance (float): Probability (in range 0-1) that each successive "wherein" node will be
    --          converted into the "output" node

    local function my_lbm(pos)

        extend_me(
            pos,
            data_table.wherein,
            data_table.output,
            convert_sides(data_table.sides),
            data_table.chance
        )

    end

    unilib.register_node(
        "unilib:dynamic_" .. data_table.label,
        data_table.orig_name,
        data_table.replace_mode,
        {
            description = unilib.brackets(S("Dynamic extender node"), data_table.label),
            tiles = {"unilib_dynamic_node.png"},
            groups = {not_in_creative_inventory = 1},
            -- (no sounds)

            drop = "",

            on_punch = my_lbm
        }
    )

    unilib.register_lbm({
        label = "Handle underch dynamic nodes [unilib]",
        name = "unilib:lbm_system_dynamic_" .. data_table.label,
        nodenames = {"unilib:dynamic_" .. data_table.label},

        interval = 0.1,
        run_at_every_load = true,

        action = my_lbm,
    })

end

function unilib.register_flooder(data_table)

    -- Adapted from underch/dynamic.lua
    -- Creates a different dynamic node, which is placed randomly in the map (from a package like
    --      "mapgen_underch", calling a function like unilib.pbiome_ore() )
    --
    -- data_table compulsory fields:
    --      label (str): A unique ID for this dynamic node. Usually the same as the item_name for
    --          the "output" node (e.g. "stone_ordinary" from "unilib:stone_ordinary"); but in case
    --          there are several dynamic nodes with the same "output" node, the label can end in
    --          a variant, e.g. "stone_ordinary_2"
    --      orig_name (str): The full_name of the dynamic node in the original mod (or an empty
    --          string if not applicable
    --      wherein (str): The wherein in which the "output" node is placed, e.g. "air"
    --      output (str): The "output" node, e.g. "unilib:liquid_lava_ordinary_flowing"
    --      replace_mode (str): Replace mode for the calling package's original mod (e.g. "defer")
    --      sides (str or table): If a string, the values "sides" or "corners", which are converted
    --          into one of the tables defined above. Otherwise, a table in the same general format
    --      size (int): Typically 30 or 100
    --
    -- data_table optional fields:
    --      ore_table (table): e.g. {{block = "unilib:dirt_mossy", chance = 2/3}}
    --      top_table (table): e.g. {{block = "unilib:dynamic_underground_bush", chance = 1/5}}

    local function my_lbm(pos)

        flood_me(
            pos,
            data_table.wherein,
            data_table.output,
            convert_sides(data_table.sides),
            data_table.size,
            data_table.ore_table,
            data_table.top_table
        )

    end

    unilib.register_node(
        "unilib:dynamic_" .. data_table.label,
        data_table.orig_name,
        data_table.replace_mode,
        {
            description = unilib.brackets(S("Dynamic flooder node"), data_table.label),
            tiles = {"unilib_dynamic_node.png"},
             groups = {not_in_creative_inventory = 1},
            -- (no sounds)

            drop = "",

            on_punch = my_lbm,
        }
    )

    minetest.register_lbm({
        label = "Handle underch flooders [unilib]",
        name = "unilib:lbm_system_flooder_" .. data_table.label,
        -- N.B. Deliberately unilib:dynamic_X, not unilib:flooder_X
        nodenames = {"unilib:dynamic_" .. data_table.label},

        chance = 1,
        interval = 0.1,
        run_at_every_load = true,

        action = my_lbm
    })

end

function unilib.register_flooder_jit(data_table)

    -- Adapted from underch/dynamic.lua
    -- Creates a different dynamic node, which is placed randomly in the map (from a package like
    --      "mapgen_underch", calling a function like unilib.pbiome_ore() )
    --
    -- data_table compulsory fields:
    --      label (str): A unique ID for this dynamic node. Usually the same as the item_name for
    --          the "output" node (e.g. "stone_ordinary" from "unilib:stone_ordinary"); but in case
    --          there are several dynamic nodes with the same "output" node, the label can end in
    --          a variant, e.g. "stone_ordinary_2"
    --      orig_name (str): The full_name of the dynamic node in the original mod (or an empty
    --          string if not applicable
    --      wherein (str): The wherein in which the "output" node is placed, e.g. "air"
    --      output (str): The "output" node, e.g. "unilib:liquid_lava_ordinary_flowing"
    --      replace_mode (str): Replace mode for the calling package's original mod (e.g. "defer")
    --      sides (str or table): If a string, the values "sides" or "corners", which are converted
    --          into one of the tables defined above. Otherwise, a table in the same general format
    --      size (int): Typically 30 or 100
    --
    -- data_table optional fields:
    --      ore_table (table): e.g. {{block = "unilib:dirt_mossy", chance = 2/3}}
    --      top_table (table): e.g. {{block = "unilib:dynamic_underground_bush", chance = 1/5}}

    local function my_lbm(pos)

        flood_me_jit(
            pos,
            data_table.wherein,
            data_table.output,
            convert_sides(data_table.sides),
            data_table.size,
            data_table.ore_table,
            data_table.top_table
        )

    end

    unilib.register_node(
        "unilib:dynamic_" .. data_table.label,
        data_table.orig_name,
        data_table.replace_mode,
        {
            description = unilib.brackets(S("Dynamic flooder node"), data_table.label),
            tiles = {"unilib_dynamic_node.png"},
             groups = {not_in_creative_inventory = 1},
            -- (no sounds)

            drop = "",

            on_punch = my_lbm,
        }
    )

    minetest.register_lbm({
        label = "Handle underch flooders (JIT) [unilib]",
        name = "unilib:lbm_system_flooder_" .. data_table.label,
        -- N.B. Deliberately unilib:dynamic_X, not unilib:flooder_X
        nodenames = {"unilib:dynamic_" .. data_table.label},

        chance = 1,
        interval = 0.1,
        run_at_every_load = true,

        action = my_lbm
    })

end
