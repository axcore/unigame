---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_workbench = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.xdecor.add_mode

-- List of formspecs, depending on which "tab" is open
local formspec_list = {
    -- main_fs
    "label[0.9,1.23;" .. FS("Cut") .. "]"
    .. "label[0.9,2.23;" .. FS("Repair") .. "]"
    .. [[
        box[-0.05,1;2.05,0.9;#555555]
        box[-0.05,2;2.05,0.9;#555555]
    ]]
    .. "button[0,0;2,1;craft;" .. FS("Crafting") .. "]"
    .. "button[2,0;2,1;storage;" .. FS("Storage") .. "]"
    .. [[
        image[3,1;1,1;unilib_gui_workbench_arrow.png]
        image[0,1;1,1;unilib_gui_workbench_saw.png]
        image[0,2;1,1;unilib_gui_workbench_anvil.png]
        image[3,2;1,1;unilib_gui_workbench_hammer_bg.png]
        list[context;input;2,1;1,1;]
        list[context;tool;2,2;1,1;]
        list[context;hammer;3,2;1,1;]
        list[context;forms;4,0;4,3;]
        listring[current_player;main]
        listring[context;tool]
        listring[current_player;main]
        listring[context;hammer]
        listring[current_player;main]
        listring[context;forms]
        listring[current_player;main]
        listring[context;input]
    ]],

    -- crafting_fs
    "image[5,1;1,1;gui_furnace_arrow_bg.png^[transformR270]"
    .. "button[0,0;1.5,1;back;< " .. FS("Back") .. "]"
    .. [[
        list[current_player;craft;2,0;3,3;]
        list[current_player;craftpreview;6,1;1,1;]
        listring[current_player;main]
        listring[current_player;craft]
    ]],

    -- storage_fs
    "list[context;storage;0,1;8,2;]"
    .. "button[0,0;1.5,1;back;< " .. FS("Back") .. "]"
    .. [[
        listring[context;storage]
        listring[current_player;main]
    ]],
}

-- List of stair types available from the workbench
-- This list is almost the same as the one in the original xdecor code
-- Note that costs of very small items (such as the nanoslab) will be higher, because
--      unilib.global.stair_cost_table measures a cost in node eighths (xdecor measures it in
--      sixteenths)
-- Noe also that some stairs will appear in different orientations than they do in xdecor
local stair_list = {
    "_stair_micro_bottom_cut_eighth",   -- nanoslab
    "_stair_panel_bottom_cut_eighth",   -- micropanel
    "_stair_slab_cut_eighth",           -- microslab
    "_stair_steps_sliced_eighth",       -- thinstair
    "_stair_micro_bottom",              -- cube
    "_stair_panel_bottom",              -- panel
    "_stair_slab",                      -- slab
    "_stair_steps",                     -- doublepanel
    "_stair_simple_half",               -- halfstair
    "_stair_outer",                     -- stair_outer
    "_stair_simple",                    -- stair
    "_stair_inner",                     -- stair_inner
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_repairable(full_name)

    -- Was workbench:repairable(), xdecor:is_repairable()

    if unilib.global.tool_no_repair_table[full_name] == nil then
        return true
    else
        return false
    end

end

local function get_output(inv, input, name)

    -- Was workbench:get_output()

    local output_table = {}
    for i = 1, #stair_list do

        if unilib.global.stair_cost_table[stair_list[i]] ~= nil then

            -- (As noted above, unilib's smallest cost is an eighth of a block, whereas in xdecor
            --      it's a sixteenth; so some costs will be higher in unilib, than in xdecor)
            local count = math.min(
                math.floor(input:get_count() * (8 / unilib.global.stair_cost_table[stair_list[i]])),
                input:get_stack_max()
            )

            output_table[i] = name .. stair_list[i] .. " " .. count

        end

    end

    inv:set_list("forms", output_table)

end

local function set_formspec(meta, id)

    -- Was workbench:set_formspec()

    meta:set_string(
        "formspec",
        "size[8,7;]list[current_player;main;0,3.25;8,4;]" .. formspec_list[id] ..
                unilib.misc.get_hotbar_bg(0,3.25))

end

local function on_construct(pos)

    -- Was workbench.construct()

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    inv:set_size("tool", 1)
    inv:set_size("input", 1)
    inv:set_size("hammer", 1)
    inv:set_size("forms", 4 * 3)
    inv:set_size("storage", 8 * 2)

    meta:set_string("infotext", S("Workbench"))
    set_formspec(meta, 1)

end

local function on_receive_fields(pos, _, fields)

    -- Was workbench.fields()

    if fields.quit then
        return
    end

    local meta = core.get_meta(pos)
    local id = fields.back and 1 or fields.craft and 2 or fields.storage and 3
    if not id then
        return
    end

    set_formspec(meta, id)

end

local function can_dig(pos)

    -- Was workbench.dig()

    local inv = core.get_meta(pos):get_inventory()
    return inv:is_empty("input") and
            inv:is_empty("hammer") and
            inv:is_empty("tool") and
            inv:is_empty("storage")

end

local function on_timer(pos)

    -- Was workbench.timer()

    local timer = core.get_node_timer(pos)
    local inv = core.get_meta(pos):get_inventory()
    local tool = inv:get_stack("tool", 1)
    local hammer = inv:get_stack("hammer", 1)

    if tool:is_empty() or hammer:is_empty() or tool:get_wear() == 0 then

        timer:stop()
        return

    end

    -- Tool's wearing range: 0-65535; 0 = new condition
    -- N.B. The original code destroys a hammer to semi-repair a tool; madness!
    -- These revised numbers allow a single hammer to repair 20 tools at 10 times the speed of the
    --      original
    --[[
    tool:add_wear(-500)
    hammer:add_wear(700)
    ]]--
    tool:add_wear(-5000)
    hammer:add_wear(250)

    inv:set_stack("tool", 1, tool)
    inv:set_stack("hammer", 1, hammer)

    return true

end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)

    -- Was workbench.allow_put()

    local stackname = stack:get_name()
    if (listname == "tool" and stack:get_wear() > 0 and is_repairable(stackname)) or
            (listname == "input" and unilib.global.stair_convert_table[stackname] ~= nil) or
            (listname == "hammer" and stackname == "unilib:tool_hammer_blacksmith") or
            listname == "storage" then
        return stack:get_count()
    end

    return 0

end

local function on_metadata_inventory_put(pos, listname, index, stack, player)

    -- Was workbench.on_put()

    local inv = core.get_meta(pos):get_inventory()
    if listname == "input" then

        local input = inv:get_stack("input", 1)
        get_output(inv, input, stack:get_name())

    elseif listname == "tool" or listname == "hammer" then

        local timer = core.get_node_timer(pos)
        timer:start(3.0)

    end

end

local function allow_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player
)
    -- Was workbench.allow_move()

    return (to_list == "storage" and from_list ~= "forms") and count or 0

end

local function on_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player
)
    -- Was workbench.on_move()

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local from_stack = inv:get_stack(from_list, from_index)
    local to_stack = inv:get_stack(to_list, to_index)

    workbench.on_take(pos, from_list, from_index, from_stack, player)
    on_metadata_inventory_put(pos, to_list, to_index, to_stack, player)

end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)

    -- Was workbench.allow_take()

    return stack:get_count()

end

local function on_metadata_inventory_take(pos, listname, index, stack, player)

    -- Was workbench.on_take()

    local inv = core.get_meta(pos):get_inventory()
    local input = inv:get_stack("input", 1)
    local inputname = input:get_name()
    local stackname = stack:get_name()

    if listname == "input" then

        if stackname == inputname and unilib.global.stair_convert_table[stackname] ~= nil then
            get_output(inv, input, stackname)
        else
            inv:set_list("forms", {})
        end

    elseif listname == "forms" then

        local fromstack = inv:get_stack(listname, index)
        if not fromstack:is_empty() and fromstack:get_name() ~= stackname then

            local player_inv = player:get_inventory()
            if player_inv:room_for_item("main", fromstack) then
                player_inv:add_item("main", fromstack)
            end

        end

        input:take_item(
            math.floor(input:get_count() * (8 / unilib.global.stair_cost_table[stair_list[index]]))
        )
        inv:set_stack("input", 1, input)
        get_output(inv, input, inputname)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_workbench.init()

    return {
        description = "Workbench, providing a 3x3 crafting grid (in case it's not available" ..
                " otherwise), additional storage, a node-cutting function and a tool repair" ..
                " function (add a tool and a hammer, and wait while the tool is repaired)",
        notes = "Prices for the node-cutting function may differ slightly from the corresponding" ..
                " items in the original code, because unilib measures prices in eighths of a" ..
                " block",
        depends = "tool_hammer_blacksmith",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.machine_workbench.exec()

    unilib.register_node("unilib:machine_workbench", "xdecor:workbench", mode, {
        -- From xdecor:workbench
        description = S("Workbench"),
        tiles = {
            "unilib_machine_workbench_top.png",
            "unilib_machine_workbench_top.png",
            "unilib_machine_workbench_side.png",
            "unilib_machine_workbench_side.png",
            "unilib_machine_workbench_front.png",
            "unilib_machine_workbench_front.png"
        },
        groups = {choppy = 2, cracky = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        allow_metadata_inventory_move = allow_metadata_inventory_move,

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        allow_metadata_inventory_take = allow_metadata_inventory_take,

        can_dig = can_dig,

        on_construct = on_construct,

        on_metadata_inventory_move = on_metadata_inventory_move,

        on_metadata_inventory_put = on_metadata_inventory_put,

        on_metadata_inventory_take = on_metadata_inventory_take,

        on_receive_fields = on_receive_fields,

        on_timer = on_timer,
    })
    unilib.register_craft({
        -- From xdecor:workbench
        output = "unilib:machine_workbench",
        recipe = {
            {"group:wood", "group:wood"},
            {"group:wood", "group:wood"},
        },
    })

    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:machine_workbench", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
