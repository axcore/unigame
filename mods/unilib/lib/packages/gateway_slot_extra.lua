---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gateway_slot_extra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_gates.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gateway_slot_extra.init()

    return {
        description = "Extra gateway slot set",
        notes = "The \"gateway_slot_basic\" package creates gateway slots for super stones and" ..
                " super trees; this package creates gateway slots from a few other ingredients" ..
                " (some of which were not used in the original code)",
        depends = "shared_castle_gates_slots",
        optional = {
            "brick_ordinary",
            "decor_stone_castle_wall",
            "ice_ordinary",
            "snow_ordinary",
            "stone_obsidian",
        },
    }

end

function unilib.pkg.gateway_slot_extra.exec()

    local material_list = {}

    if unilib.global.pkg_executed_table["brick_ordinary"] ~= nil then

        -- Creates unilib:brick_ordinary_block_slot, unilib:brick_ordinary_block_reverse
        table.insert(material_list, {
            part_name = "brick_ordinary",
            orig_slot_name = nil,
            orig_reverse_slot_name = nil,
            ingredient = "unilib:brick_ordinary_block",

            replace_mode = mode,
--          description = S("Ordinary Brick Block"),
--          img_list = {
--              "unilib_brick_ordinary_block.png^[transformFX",
--              "unilib_brick_ordinary_block.png",
--          },
            -- (no override_ingredient)
        })

    end

    if unilib.global.pkg_executed_table["decor_stone_castle_wall"] ~= nil then

        -- Creates unilib:decor_stone_castle_wall_slot, unilib:decor_stone_castle_wall_slot_reverse
        table.insert(material_list, {
            part_name = "decor_stone_castle_wall",
            orig_slot_name = "castle_gates:stonewall_gate_slot",
            orig_reverse_slot_name = "castle_gates:stonewall_gate_slot_reverse",
            ingredient = "unilib:decor_stone_castle_wall",

            replace_mode = mode,
--          description = S("Castle Wall"),
--          img_list = {"unilib_decor_stone_castle_wall.png"},
            -- (no override_ingredient)
        })

    end

    if unilib.global.pkg_executed_table["ice_ordinary"] ~= nil then

        -- Creates unilib:ice_ordinary_slot, unilib:ice_ordinary_slot_reverse
        table.insert(material_list, {
            part_name = "ice_ordinary",
            orig_slot_name = nil,
            orig_reverse_slot_name = nil,
            ingredient = "unilib:ice_ordinary",

            replace_mode = mode,
--          description = S("Ordinary Ice"),
--          img_list = {"unilib_ice_ordinary.png"},
            -- (no override_ingredient)
        })

    end

    if unilib.global.pkg_executed_table["snow_ordinary"] ~= nil then

        -- Creates unilib:snow_ordinary_slot, unilib:snow_ordinary_slot_reverse
        table.insert(material_list, {
            part_name = "snow_ordinary",
            orig_slot_name = nil,
            orig_reverse_slot_name = nil,
            ingredient = "unilib:snow_ordinary",

            replace_mode = mode,
--          description = S("Ordinary Snow"),
--          img_list = {"unilib_snow_ordinary.png"},
            -- (no override_ingredient)
        })

    end

    -- (An extra check, because the "gateway_slot_basic" may already create an obsidian slot, if
    --      it's listed as a super stone)
    if unilib.global.pkg_executed_table["stone_obsidian"] ~= nil and
            unilib.global.super_stone_table["obsidian"] == nil then

        -- Creates unilib:stone_obsidian_brick_slot, unilib:stone_obsidian_brick_slot_reverse
        table.insert(material_list, {
            part_name = "stone_obsidian_brick",
            orig_slot_name = nil,
            orig_reverse_slot_name = nil,
            ingredient = "unilib:stone_obsidian_brick",

            replace_mode = mode,
--          description = S("Obsidian Stone Bricks"),
--          img_list = {"unilib_stone_obsidian_brick.png"},
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

end
