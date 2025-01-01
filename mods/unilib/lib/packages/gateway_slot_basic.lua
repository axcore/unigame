---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gateway_slot_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_gates.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gateway_slot_basic.init()

    return {
        description = "Gateway slot set",
        notes = "This package creates gateway slots for super stones and super trees. See also" ..
                " the \"gateway_slot_extra\" package, which creates gateway slots using some" ..
                " other ingredients",
        depends = "shared_castle_gates_slots",
    }

end

function unilib.pkg.gateway_slot_basic.post()

    -- First create the gateway slots using ingredients from the original code, then create the
    --      remaining super tree and super node items later
    -- (The approach used in other super stone and super tree packages, first creating a simple
    --      list or table, would be too complicated in this case)
    local material_list = {}

    if unilib.global.pkg_executed_table["stone_desert"] ~= nil and
            unilib.global.super_stone_table["desert"] ~= nil then

        -- Creates unilib:stone_desert_slot, unilib:stone_desert_slot_reverse
        table.insert(material_list, {
            part_name = "stone_desert",
            orig_slot_name = "castle_gates:desertstone_gate_slot",
            orig_reverse_slot_name = "castle_gates:desertstone_gate_slot_reverse",
            ingredient = "unilib:stone_desert",

            replace_mode = mode,
--          description = S("Desert Stone"),
--          img_list = {"unilib_stone_desert.png"},
            -- (no override_ingredient)
        })

        -- Creates unilib:stone_desert_brick_slot, unilib:stone_desert_brick_slot_reverse
        table.insert(material_list, {
            part_name = "stone_desert_brick",
            orig_slot_name = "castle_gates:desertstonebrick_gate_slot",
            orig_reverse_slot_name = "castle_gates:desertstonebrick_gate_slot_reverse",
            ingredient = "unilib:stone_desert_brick",

            replace_mode = mode,
--          description = S("Desert Stone Bricks"),
--          img_list = {"unilib_stone_desert_brick.png"},
            -- (no override_ingredient)
        })

    end

    if unilib.global.pkg_executed_table["stone_ordinary"] ~= nil and
            unilib.global.super_stone_table["ordinary"] ~= nil then

        -- Creates unilib:stone_ordinary_slot, unilib:stone_ordinary_slot_reverse
        table.insert(material_list, {
            part_name = "stone_ordinary",
            orig_slot_name = "castle_gates:stone_gate_slot",
            orig_reverse_slot_name = "castle_gates:stone_gate_slot_reverse",
            ingredient = "unilib:stone_ordinary",

            replace_mode = mode,
--          description = S("Ordinary Stone"),
--          img_list = {"unilib_stone_ordinary.png"},
            -- (no override_ingredient)
        })

        -- Creates unilib:stone_ordinary_brick_slot, unilib:stone_ordinary_brick_slot_reverse
        table.insert(material_list, {
            part_name = "stone_ordinary_brick",
            orig_slot_name = "castle_gates:stonebrick_gate_slot",
            orig_reverse_slot_name = "castle_gates:stonebrick_gate_slot_reverse",
            ingredient = "unilib:stone_ordinary_brick",

            replace_mode = mode,
--          description = S("Ordinary Stone Bricks"),
--          img_list = {"unilib_stone_ordinary_brick.png"},
            -- (no override_ingredient)
        })

        -- Creates unilib:stone_ordinary_cobble_slot, unilib:stone_ordinary_cobble_slot_reverse
        table.insert(material_list, {
            part_name = "stone_ordinary_cobble",
            orig_slot_name = "castle_gates:cobble_gate_slot",
            orig_reverse_slot_name = "castle_gates:cobble_gate_slot_reverse",
            ingredient = "unilib:stone_ordinary_cobble",

            replace_mode = mode,
--          description = S("Ordinary Cobblestone"),
--          img_list = {"unilib_stone_ordinary_cobble.png"},
            -- (no override_ingredient)
        })

    end

    if unilib.global.pkg_executed_table["stone_sandstone_ordinary"] ~= nil and
            unilib.global.super_stone_table["sandstone_ordinary"] ~= nil then

        -- Creates unilib:stone_sandstone_slot, unilib:stone_sandstone_slot_reverse
        table.insert(material_list, {
            part_name = "stone_sandstone",
            orig_slot_name = "castle_gates:sandstone_gate_slot",
            orig_reverse_slot_name = "castle_gates:sandstone_gate_slot_reverse",
            ingredient = "unilib:stone_sandstone_ordinary",

            replace_mode = mode,
--          description = S("Sandstone"),
--          img_list = {"unilib_stone_sandstone_ordinary.png"},
            -- (no override_ingredient)
        })

        -- Creates unilib:stone_sandstone_brick_slot, unilib:stone_sandstone_brick_slot_reverse
        table.insert(material_list, {
            part_name = "stone_sandstone_brick",
            orig_slot_name = "castle_gates:sandstonebrick_gate_slot",
            orig_reverse_slot_name = "castle_gates:sandstonebrick_gate_slot_reverse",
            ingredient = "unilib:stone_sandstone_ordinary_brick",

            replace_mode = mode,
--          description = S("Sandstone Bricks"),
--          img_list = {"unilib_stone_sandstone_ordinary_brick.png"},
            -- (no override_ingredient)
        })

    end

    for _, data_table in pairs(material_list) do

        local def_table = core.registered_nodes[data_table]
        if def_table ~= nil then

            data_table.description = def_table.description
            data_table.img_list = def_table.tiles
            unilib.pkg.shared_castle_gates_slots.register_gateway_slot(data_table)

        end

    end

    -- Now create gateway slots for super stones and super trees, being careful not to re-create
    --      anything already handled above
    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        if unilib.global.pkg_executed_table["stone_" .. stone_type] ~= nil then

            local smooth_ingredient = "unilib:stone_" .. stone_type
            local smooth_def_table = core.registered_nodes[smooth_ingredient]
            local smooth_output = "unilib:stone_" .. stone_type .. "_slot"

            if smooth_def_table ~= nil and core.registered_nodes[smooth_output] == nil then

                unilib.pkg.shared_castle_gates_slots.register_gateway_slot({
                    part_name = "stone_" .. stone_type,
                    orig_slot_name = nil,
                    orig_reverse_slot_name = nil,
                    ingredient = smooth_ingredient,

                    replace_mode = mode,
                    description = smooth_def_table.description,
                    img_list = smooth_def_table.tiles,
                    -- (no override_ingredient)
                })

            end

            local brick_ingredient = "unilib:stone_" .. stone_type .. "_brick"
            local brick_def_table = core.registered_nodes[brick_ingredient]
            local brick_output = "unilib:stone_" .. stone_type .. "_brick_slot"

            if brick_def_table ~= nil and core.registered_nodes[brick_output] == nil then

                unilib.pkg.shared_castle_gates_slots.register_gateway_slot({
                    part_name = "stone_" .. stone_type .. "_brick",
                    orig_slot_name = nil,
                    orig_reverse_slot_name = nil,
                    ingredient = brick_ingredient,

                    replace_mode = mode,
                    description = brick_def_table.description,
                    img_list = brick_def_table.tiles,
                    -- (no override_ingredient)
                })

            end

            local cobble_ingredient = "unilib:stone_" .. stone_type .. "_cobble"
            local cobble_def_table = core.registered_nodes[cobble_ingredient]
            local cobble_output = "unilib:stone_" .. stone_type .. "_cobble_slot"

            if cobble_def_table ~= nil and core.registered_nodes[cobble_output] == nil then

                unilib.pkg.shared_castle_gates_slots.register_gateway_slot({
                    part_name = "stone_" .. stone_type .. "_cobble",
                    orig_slot_name = nil,
                    orig_reverse_slot_name = nil,
                    ingredient = cobble_ingredient,

                    replace_mode = mode,
                    description = cobble_def_table.description,
                    img_list = cobble_def_table.tiles,
                    -- (no override_ingredient)
                })

            end

        end

    end

    -- (Fewer checks required for super trees)
    for tree_type, _ in pairs(unilib.global.super_tree_table) do

        if unilib.global.pkg_executed_table["tree_" .. tree_type] ~= nil then

            local ingredient = "unilib:tree_" .. tree_type .. "_wood"
            local def_table = core.registered_nodes[ingredient]

            if def_table ~= nil then

                unilib.pkg.shared_castle_gates_slots.register_gateway_slot({
                    part_name = "tree_" .. tree_type .. "_wood",
                    orig_slot_name = nil,
                    orig_reverse_slot_name = nil,
                    ingredient = ingredient,

                    replace_mode = mode,
                    description = def_table.description,
                    img_list = def_table.tiles,
                    -- (no override_ingredient)
                })

            end

        end

    end

end
