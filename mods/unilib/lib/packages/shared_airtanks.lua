---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    airtanks
-- Code:    MIT
-- Media:   MIT/CC0/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_airtanks = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.airtanks.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_airtanks.register_tank(data_table)

    -- Adapted from register_air_tank(), register_air_tank_2(), register_air_tank_3()
    -- Registers air tanks
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "steel"
    --      description (str): e.g. "Steel Air Tank"
    --      ingredient (str): e.g. "unilib:metal_ingot_steel"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      capacity (int): 1 for single-capacity tanks, 2 for double-capacity tanks, 3 for triple-
    --          capacity tanks (default 1)
    --      rgb (str): e.g. "#d6d6d6"
    --      use_count (int): e.g. 10

    local part_name = data_table.part_name
    local description = data_table.description
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local capacity = data_table.capacity or 1
    local rgb = data_table.rgb or "#d6d6d6"
    local use_count = data_table.use_count or 10

    local category, extra
    if capacity == 1 then

        category = "single"
        extra = ""

    elseif capacity == 2 then

        category = "double"
        extra = "_2"

    elseif capacity == 3 then

        category = "triple"
        extra = "_3"

    end

    local filled_name = "unilib:device_airtank_" .. part_name .. "_" .. category
    local empty_name = filled_name .. "_empty"
    local filled_img = "unilib_device_airtank_" .. category .. ".png^[colorize:" .. rgb ..
                "^[mask:unilib_device_airtank_" .. category .. ".png"
    local empty_img = filled_img .. "^unilib_device_airtank_empty_overlay.png"
    local orig_filled_name = "airtanks:" .. part_name .. "_tank" .. extra
    local orig_empty_name = "airtanks:empty_" .. part_name .. "_tank" .. extra

    unilib.register_craftitem(empty_name, orig_empty_name, mode, {
        description = unilib.utils.hint(
            unilib.utils.brackets(description, S("Empty")),
            S("Refill in an air compressor. Uses when full: @1", use_count)
        ),
        inventory_image = empty_img,
        groups = {airtank = 1},

        filled_name = filled_name,
        use_count = use_count,
        wield_image = empty_img,
    })
    if capacity == 1 then

        local c_compressor = "unilib:device_compressor_air"

        unilib.register_craft({
            output = empty_name,
            recipe = {
                {"", ingredient, ""},
                {ingredient, c_compressor, ingredient},
                {"", ingredient, ""},
            },
            replacements = {
                {c_compressor, c_compressor},
            },
        })

    end

    unilib.register_tool(filled_name, orig_filled_name, mode, {
        description = unilib.utils.hint(description, S("Uses when full: @1", use_count)),
        inventory_image = filled_img,
        -- N.B. not_repaired_by_anvil = 1 omitted from original code
        groups = {airtank = 2},
        -- (no sounds)

        empty_name = empty_name,
        stack_max = 1,
        use_count = use_count,
        wield_image = filled_img,

        on_place = function(itemstack, user, pointed_thing)
            return unilib.pkg.shared_airtanks.use_tank(itemstack, user)
        end,

        on_use = function(itemstack, user, pointed_thing)
            return unilib.pkg.shared_airtanks.use_tank(itemstack, user)
        end,
    })
    if capacity == 2 then

        local single_filled_name = "unilib:device_airtank_" .. part_name .. "_single"
        local single_empty_name = single_filled_name .. "_empty"

        unilib.register_craft({
            output = empty_name,
            recipe = {
                {single_empty_name, single_empty_name},
            },
        })
        unilib.register_craft({
            output = filled_name,
            recipe = {
                {single_filled_name, single_filled_name},
            },
        })

    elseif capacity == 3 then

        local single_filled_name = "unilib:device_airtank_" .. part_name .. "_single"
        local single_empty_name = single_filled_name .. "_empty"
        local double_filled_name = "unilib:device_airtank_" .. part_name .. "_double"
        local double_empty_name = double_filled_name .. "_empty"

        unilib.register_craft({
            output = empty_name,
            recipe = {
                {single_empty_name, single_empty_name, single_empty_name},
            },
        })
        unilib.register_craft({
            output = empty_name,
            recipe = {
                {single_empty_name, double_empty_name, ""},
            },
        })
        unilib.register_craft({
            output = filled_name,
            recipe = {
                {single_filled_name, single_filled_name, single_filled_name},
            },
        })
        unilib.register_craft({
            output = filled_name,
            recipe = {
                {single_filled_name, double_filled_name, ""},
            },
        })

    end
    unilib.tools.register_no_repair(filled_name, S("This air tank cannot be repaired"))

end

function unilib.pkg.shared_airtanks.use_tank(itemstack, user)

    -- Was use_airtank()

    local breath = user:get_breath()
    if breath > 9 then
        return itemstack
    end

    breath = math.min(10, (breath + 5))
    user:set_breath(breath)
    core.sound_play("unilib_device_airtank_hiss", {pos = user:get_pos(), gain = 0.5})

    if not unilib.utils.is_creative(user:get_player_name()) then

        local def_table = itemstack:get_definition()
        itemstack:add_wear(unilib.constant.max_tool_wear / (def_table.use_count - 1))
        if itemstack:get_count() == 0 then

            if def_table.sound and def_table.sound.breaks then
                core.sound_play(def_table.sound.breaks, {pos = user:get_pos(), gain = 0.5})
            end

            local inv = user:get_inventory()
            itemstack = inv:add_item("main", def_table.empty_name)

        end

    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_airtanks.init()

    return {
        description = "Shared functions for air tanks (from airtanks)",
    }

end
