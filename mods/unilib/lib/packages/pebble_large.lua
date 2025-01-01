---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/cavestuff
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pebble_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cavestuff.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.pebble_large.register_pebble(data_table)

    -- Adapted from plantlife/cavestuff/nodes.lua
    -- Creates a large pebble based on a stone type
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary", a key in unilib.global.stone_table
    --      orig_name (str or list): e.g. "cavestuff:pebble_1"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local def_table = core.registered_nodes["unilib:stone_" .. part_name]
    if def_table == nil then
        return
    end

    local cbox = {
        type = "fixed",
        fixed = {-5/16, -8/16, -6/16, 5/16, -1/32, 5/16},
    }

    local img = def_table.tiles[1]
    if part_name == "desert" then
        img = "unilib_pebble_large_stone_desert.png"
    elseif part_name == "ordinary" then
        img = "unilib_pebble_large_stone_ordinary.png"
    end

    local inv_img = img .. "^[mask:unilib_mask_pebble_large.png"

    unilib.register_node("unilib:pebble_large_stone_" .. part_name, orig_name, replace_mode, {
        description = unilib.utils.brackets(S("Large Stone Pebble"), def_table.description),
        tiles = {img},
        -- N.B. replaced attached_node = 1 in the original code with falling_node = 1, for
        --      consistency with small pebbles
--      groups = {attached_node = 1, cracky = 3, stone = 1},
        groups = {cracky = 3, falling_node = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        collision_box = cbox,
        drawtype = "mesh",
        -- N.B. No .inventory_image in original code
        inventory_image = inv_img,
        mesh = "unilib_pebble_large.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = cbox,
        -- N.B. No .wield_image in original code
        wield_image = inv_img,
    })

    -- N.B. There are only two decoration packages completing this decoration; one for ordinary
    --      stone, and one for desert stone (as in the original code)
    unilib.register_decoration_generic("cavestuff_pebble_large_stone_" .. part_name, {
        deco_type = "simple",
        decoration = "unilib:pebble_large_stone_" .. part_name,

        fill_ratio = 0.001,
        -- N.B. param2 and param2_max not used in the original code for desert stone pebbles
        param2 = 0,
        param2_max = 3,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pebble_large.init()

    return {
        description = "Large stone pebbles",
        notes = "This package creates large pebbles from the full range of super stones",
    }

end

function unilib.pkg.pebble_large.post()

    -- N.B. The original code created two numbered variants, which were virtually identical. This
    --      package combines them into a single node

    local default_list = {
        -- minetest_game stones
        {
            part_name = "desert",
            orig_name = {"cavestuff:desert_pebble_1", "cavestuff:desert_pebble_2"},
        },
        {
            part_name = "ordinary",
            orig_name = {"cavestuff:pebble_1", "cavestuff:pebble_2"},
        },
    }

    local pebble_table = {}
    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        pebble_table[stone_type] = {
            part_name = stone_type,
            orig_name = nil,
        }

    end

    for _, mini_table in pairs(default_list) do

        if pebble_table[mini_table.part_name] ~= nil then
            pebble_table[mini_table.part_name] = mini_table
        end

    end

    for stone_type, mini_table in pairs(pebble_table) do

        local data_table = unilib.global.stone_table[mini_table.part_name]

        if unilib.global.pkg_executed_table["stone_" .. stone_type] ~= nil then

            unilib.pkg.pebble_large.register_pebble({
                part_name = mini_table.part_name,
                orig_name = mini_table.orig_name,

                replace_mode = mode,
            })

        end

    end

end
