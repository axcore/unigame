---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/cavestuff
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pebble_large = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cavestuff.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(data_table)

    -- Adapted from plantlife/cavestuff/nodes.lua
    -- Creates a large pebble based on a stone type
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary", a key in unilib.stone_table
    --      orig_name (str or list): e.g. "cavestuff:pebble_1"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Ordinary stone"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.base_img or "unilib_stone_" .. part_name

    local cbox = {
        type = "fixed",
        fixed = {-5/16, -8/16, -6/16, 5/16, -1/32, 5/16},
    }

    local img = "unilib_stone_" .. part_name .. ".png"
    if part_name == "desert" then
        img = "unilib_pebble_large_stone_desert.png"
    elseif part_name == "ordinary" then
        img = "unilib_pebble_large_stone_ordinary.png"
    end

    unilib.register_node("unilib:pebble_large_stone_" .. part_name, orig_name, replace_mode, {
        description = S("Large Desert Stone Pebble"),
        tiles = {img},
        groups = {attached_node = 1, cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

        collision_box = cbox,
        drawtype = "mesh",
        mesh = "unilib_pebble_large.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = cbox,
    })

    -- N.B. There are only two decoration packages completing this decoration; one for ordinary
    --      stone, and one for desert stone (as in the original code)
    unilib.register_decoration("cavestuff_pebble_large_stone_" .. part_name, {
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
        description = "Large desert stone pebble",
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
    for stone_type, _ in pairs(unilib.super_stone_table) do

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

        local data_table = unilib.stone_table[mini_table.part_name]

        if unilib.pkg_executed_table["stone_" .. stone_type] ~= nil then

            do_register({
                part_name = mini_table.part_name,
                orig_name = mini_table.orig_name,

                replace_mode = mode,
                description = data_table.description,
            })

        end

    end

end
