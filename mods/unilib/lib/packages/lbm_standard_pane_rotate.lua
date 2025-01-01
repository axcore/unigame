---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xpanes
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lbm_standard_pane_rotate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xpanes.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_pane(pos)

    -- Adapted from xpanes/init.lua

    if not unilib.global.use_unipanes_flag then
        return core.get_item_group(core.get_node(pos).name, "pane") > 0
    else
        return core.get_item_group(core.get_node(pos).name, "unipane") > 0
    end

end

local function connects_dir(pos, base_name, dir)

    -- Adapted from xpanes/init.lua

    local aside = vector.add(pos, core.facedir_to_dir(dir))
    if is_pane(aside) then
        return true
    end

    local connects_to = core.registered_nodes[base_name .. "_crossed"].connects_to
    if not connects_to then
        return false
    end

    local list = core.find_nodes_in_area(aside, aside, connects_to)
    if #list > 0 then
        return true
    end

    return false

end

local function swap(pos, node, name, param2)

    -- Adapted from xpanes/init.lua

    if node.name == name and node.param2 == param2 then
        return
    end

    core.swap_node(pos, {name = name, param2 = param2})

end

local function do_rotate(pos)

    -- Adapted from xpanes/init.lua
    -- Called by the LBM in lbms.lua to switch between flat and crossed panes, depending on the
    --      pane's neighbour(s)
    --
    -- Args:
    --      pos (table): e.g. {x = 1, y = 1, z = 1}

    if not is_pane(pos) then
        return
    end

    local node = core.get_node(pos)
    local full_name = node.name
    local base_name

    if full_name:sub(-5) == "_flat" then
        base_name = full_name:sub(1, -6)
    elseif full_name:sub(-8) == "_crossed" then
        base_name = full_name:sub(1, -9)
    end

    local any = node.param2
    local c = {}
    local count = 0
    for dir = 0, 3 do

        c[dir] = connects_dir(pos, base_name, dir)
        if c[dir] then

            any = dir
            count = count + 1

        end

    end

    if count == 0 then

        swap(pos, node, base_name .. "_flat", any)

    elseif count == 1 then

        swap(pos, node, base_name .. "_flat", (any + 1) % 4)

    elseif count == 2 then

        if (c[0] and c[2]) or (c[1] and c[3]) then
            swap(pos, node, base_name .. "_flat", (any + 1) % 4)
        else
            swap(pos, node, base_name .. "_crossed", 0)
        end

    else

        swap(pos, node, base_name .. "_crossed", 0)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lbm_standard_pane_rotate.init()

    return {
        description = "LBMs to handle pane rotation (from minetest_game/xpanes)",
    }

end

function unilib.pkg.lbm_standard_pane_rotate.post()

    -- Adapted from xpanes/init.lua
    -- When running on top of minetest_game, unilib panes use the group "unipane" instead of "pane".
    --      This prevents a clash between unilib's LBM and the equivalent LBM in minetest_game

    if not unilib.global.use_unipanes_flag then

        unilib.register_lbm({
            label = "Handle connected panes [lbm_standard_pane_rotate]",
            name = "unilib:lbm_system_pane",
            nodenames = {"group:pane"},

            action = function(pos, node)

                do_rotate(pos)
                for i = 0, 3 do

                    local dir = core.facedir_to_dir(i)
                    do_rotate(vector.add(pos, dir))

                end

            end,
        })

    else

        unilib.register_lbm({
            label = "Handle connected panes [lbm_standard_pane_rotate]",
            name = "unilib:lbm_system_unipane",
            nodenames = {"group:unipane"},

            action = function(pos, node)

                do_rotate(pos)
                for i = 0, 3 do

                    local dir = core.facedir_to_dir(i)
                    do_rotate(vector.add(pos, dir))

                end

            end,
        })

    end

    unilib.register_obsolete_lbm({
        mod_origin = "xpanes",
        name = "xpanes:gen2",
    })

    core.register_on_placenode(function(pos, node)

        if core.get_item_group(node, "pane") or core.get_item_group(node, "unipane") then
            do_rotate(pos)
        end

        for i = 0, 3 do

            local dir = core.facedir_to_dir(i)
            do_rotate(vector.add(pos, dir))

        end

    end)

    core.register_on_dignode(function(pos)

        for i = 0, 3 do

            local dir = core.facedir_to_dir(i)
            do_rotate(vector.add(pos, dir))

        end

    end)

end
