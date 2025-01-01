---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- armour_base.lua
--      Base API functions for armour
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end

---------------------------------------------------------------------------------------------------
-- Local variables (original to unilib)
---------------------------------------------------------------------------------------------------

-- Flag set to true, if warnings should be displayed
local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Local variables (3d_armor/3d_armor/init.lua)
---------------------------------------------------------------------------------------------------

-- (Was last_punch_time)
local last_punch_time_table = {}
-- (Was timer)
local main_timer = 0

---------------------------------------------------------------------------------------------------
-- Local variables (3d_armor/3d_armor/api.lua)
---------------------------------------------------------------------------------------------------

-- (Was skin_previews)
local skin_preview_table = {}
-- (Was use_player_monoids)
local use_player_monoids_flag = core.global_exists("player_monoids")
-- (Was use_armor_monoid)
local use_armor_monoid_flag = core.global_exists("armor_monoid")
-- (Was use_pova_mod)
local use_pova_mod_flag = core.get_modpath("pova")

-- (Was armor_def)
local player_data_table = setmetatable({}, {

    __index = function()

        return setmetatable(
            {
                groups = setmetatable(
                    {},
                    {
                        __index = function()
                            return 0
                        end
                    }
                )
            },
            {
                __index = function()
                    return 0
                end
            }
        )

    end,
})

-- (Was armor_textures)
local player_texture_table = setmetatable({}, {

    __index = function()

        return setmetatable(
            {},
            {
                __index = function()
                    return "blank.png"
                end
            }
        )

    end

})

-- (Was armor)
local main_table = {
    -- (Was armor.default_skin. The value corresponds to the usual character.png skin)
    default_skin = "character",
    -- (Was armor.fire_nodes. This list is updated in the code below)
    fire_node_list = {
        {"nether:lava_source",                      5, 8},
        {"unilib:liquid_lava_ordinary_source",      5, 8},
        {"default:lava_source",                     5, 8},
        {"unilib:liquid_lava_ordinary_flowing",     5, 8},
        {"default:lava_flowing",                    5, 8},
        {"unilib:fire_ordinary",                    3, 4},
        {"fire:basic_flame",                        3, 4},
        {"unilib:fire_permanent",                   3, 4},
        {"fire:permanent_flame",                    3, 4},
        {"unilib:mineral_crystallite_spike",        2, 1},
        {"ethereal:crystal_spike",                  2, 1},
        {"unilib:flower_fire",                      2, 1},
        {"ethereal:fire_flower",                    2, 1},
        {"nether:lava_crust",                       2, 1},
        {"unilib:torch_ordinary",                   1, 1},
        {"default:torch",                           1, 1},
        {"unilib:torch_ordinary_ceiling",           1, 1},
        {"default:torch_ceiling",                   1, 1},
        {"unilib:torch_ordinary_wall",              1, 1},
        {"default:torch_wall",                      1, 1},
    },
    -- (Was armor.formspec)
    -- This formspec is updated in calls to unilib.armour.get_formspec(), and again in the setup
    --      code below (if the "technic" mod is available)
    -- The components "armour_preview", "armour_level", "armour_attr_X" and "armour_group_X" are
    --      substituted by unilib.armour.get_formspec()
    formspec = "image[2.5,0;2,4;armour_preview]" ..
        unilib.misc.get_hotbar_bg(0, 4.7) ..
        "list[current_player;main;0,4.7;8,1;]" ..
        "list[current_player;main;0,5.85;8,3;8]",
    -- (Was armor.def)
    player_data_table = player_data_table,
    -- (Was armor.textures)
    player_texture_table = player_texture_table,
    -- (Was armor.registered_callbacks. Each value is a list of functions called run_callbacks() )
    registered_callback_table = {
        on_damage = {},
        on_destroy = {},
        on_equip = {},
        on_unequip = {},
        on_update = {},
    },
    -- (Was armor.registered_groups)
    registered_group_table = { ["fleshy"] = 100 },
    -- (Was armor.attributes)
    standard_attribute_list = {"heal", "fire", "water", "feather"},
    -- (Was armor.elements)
    standard_bodypart_list = {"head", "torso", "hands", "legs", "feet", "shield"},
    -- (Was armor.physics)
    standard_physics_list = {"jump", "speed", "gravity"},

    -- (Original code fields, unused in the unilib version)
--  get_translator = S,
--  materials = {
--      wood = "group:wood",
--      cactus = "default:cactus",
--      steel = "default:steel_ingot",
--      bronze = "default:bronze_ingot",
--      diamond = "default:diamond",
--      gold = "default:gold_ingot",
--      mithril = "moreores:mithril_ingot",
--      crystal = "ethereal:crystal_ingot",
--      nether = "nether:nether_ingot",
--  },
--  migrate_old_inventory = true,
--  timer = 0,
--  version = "0.4.13",
}

-- (Was armor.config)
local main_config_table = {
    bones_delay = unilib.setting.armour_bones_delay,
    -- (Was armor.config.destroy)
    destroy_flag = unilib.setting.armour_destroy_flag,
    -- (Was armor.config.drop)
    drop_flag = unilib.setting.armour_drop_flag,
    -- (Was armor.config.feather_fall)
    feather_fall_flag = true,
    -- (Was armor.config.fire_protect)
    fire_protect_flag = unilib.setting.armour_fire_protect_flag,
    -- (Was armor.config.fire_protect_torch)
    fire_protect_torch_flag = unilib.setting.armour_fire_protect_torch_flag,
    heal_multiplier = unilib.setting.armour_heal_multiplier,
    init_delay = unilib.setting.armour_init_delay,
    level_multiplier = unilib.setting.armour_level_multiplier,
    -- (Was armor.config.punch_damage)
    punch_damage_flag = unilib.setting.armour_punch_damage_flag,
    -- (Was armor.config.set_elements)
    set_bodypart_list =
            unilib.utils.split_string_by_whitespace(unilib.setting.armour_set_bodyparts),
    set_multiplier = unilib.setting.armour_set_multiplier,
    update_time = unilib.setting.armour_update_timearmour_update_time,
    -- (Was armor.config.water_protect)
    water_protect_flag = unilib.setting.armour_water_protect_flag,

    -- (Original code fields, unused in the unilib version)
--  material_wood = true,
--  material_cactus = true,
--  material_steel = true,
--  material_bronze = true,
--  material_diamond = true,
--  material_gold = true,
--  material_mithril = true,
--  material_crystal = true,
--  material_nether = true,
}

-- The skin mod in use, if any (set below)
-- (Was skin_mod)
local skin_mod

---------------------------------------------------------------------------------------------------
-- Local functions (3d_armor/3d_armor/api.lua, called directly or indirectly from
--      unilib.register_armour() )
---------------------------------------------------------------------------------------------------

local function get_valid_player(player, msg)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.get_valid_player() / armor:get_valid_player()
    --
    -- Checks that the specified player can use armour
    --
    -- Args:
    --      player (ObjectRef): The player to check
    --
    -- Optional args:
    --      msg (str): Additional info for log messages
    --
    -- Return values:
    --      On success, a list in the form {player_name, detached_armour_inventory}

    msg = msg or ""

    if not player then

        if debug_warning_flag then

            unilib.utils.show_warning(
                "../lib/shared/armour/armour_base.lua: null player reference", msg
            )

        end

        return

    elseif type(player) ~= "userdata" then

        -- Fake player, fail silently
        return

    end

    local pname = player:get_player_name()
    if not pname then

        if debug_warning_flag then
            unilib.utils.show_warning("../lib/shared/armour/armour_base.lua: null player name", msg)
        end

        return

    end

    local armour_inv = core.get_inventory({type = "detached", name = pname .. "_armour"})
    if not armour_inv then

        -- This check may fail when called inside "on_joinplayer"; in that case, the armour will be
        --      initalised/updated later on
        if debug_warning_flag then

            unilib.utils.show_warning(
                "../lib/shared/armour/armour_base.lua: null detached armour inventory", msg
            )

        end

        return

    end

    return pname, armour_inv

end

local function get_bodypart(full_name)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.get_element() / armor:get_element()
    --
    -- Retrieves the body part ("head", "torso", "hands", "legs", "feet", "shield") on which the
    --      armour "full_name" is worn, and returns it

    for _, bodypart in pairs(main_table.standard_bodypart_list) do

        if core.get_item_group(full_name, "armour_" .. bodypart) > 0 then
            return bodypart
        end

    end

end

local function run_callbacks(callback_name, player, index, stack)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.run_callbacks() / armor:run_callbacks()
    --
    -- Runs various callbacks
    --
    -- Args:
    --      callback_name (str): The name of the callback function to execute
    --      player (ObjectRef): First parameter passed to callback
    --
    -- Optional args:
    --      index (int): Second parameter passed to callback
    --      stack (ItemStack): The callback owner

    if stack then

        local def_table = stack:get_definition() or {}
        if type(def_table[callback_name]) == "function" then
            def_table[callback_name](player, index, stack)
        end

    end

    local callback_list = main_table.registered_callback_table[callback_name]
    if callback_list then

        for _, func in pairs(callback_list) do
            func(player, index, stack)
        end

    end

end

local function get_player_skin(pname)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.get_player_skin() / armor:get_player_skin()
    --
    -- Retrieves the player's current skin
    --
    -- Args:
    --      pname (str): The player name
    --
    -- Return values:
    --      The path to the skin file

    if (skin_mod == "skins" or skin_mod == "simple_skins") and skins.skins[pname] then

        return skins.skins[pname] .. ".png"

    elseif skin_mod == "u_skins" and u_skins.u_skins[pname] then

        return u_skins.u_skins[pname] .. ".png"

    elseif skin_mod == "wardrobe_ad" and
            wardrobe.playerSkins and
            wardrobe.playerSkins[pname] then

        return wardrobe.playerSkins[pname]

    elseif skin_mod == "skinsdb" then

        local skin = skins.get_player_skin(core.get_player_by_name(pname))
        return skin:get_texture()

    else

        return main_table.default_skin .. ".png"

    end

end

local function get_preview(pname)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.get_preview() / armor:get_preview()
    --
    -- Some skins mods provide pairs of textures, one for the player model (e.g. "character.png")
    --      and one for formspecs such as ours (e.g. "character_preview.png")
    -- Retrieve the preview for the character's skin, if it exists; otherwise use unilib's fallback
    --      preview
    --
    -- Args:
    --      pname (str): The player name

    -- skinsdb
    if skin_mod == "skinsdb" then

        local skin = skins.get_player_skin(core.get_player_by_name(pname))
        return skin:get_preview()

    end

    -- All other compatible skin mods
    local preview = string.gsub(get_player_skin(pname), ".png", "_preview.png")
    local alt_preview = string.gsub(get_player_skin(pname), ".png", "-preview.png")

    if skin_preview_table[preview] then
        return preview
    elseif skin_preview_table[alt_preview] then
        return alt_preview
    else
        return "unilib_inventory_armour_preview.png"
    end

end

local function get_bodyparts_of_worn_armour(player)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.get_weared_armor_elements() / armor:get_weared_armor_elements()
    --
    -- Get bodyparts of equipped armour
    --
    -- Args:
    --      player (ObjectRef): The equipped player to check
    --
    -- Return values:
    --      A table of equipped armour items, in the form
    --          worn_armour_table[bodypart] = full_name_of_armour

    local pname, armour_inv = get_valid_player(player, "get_bodyparts_of_worn_armour()")
    if not pname then
        return
    end

    local worn_armour_table = {}
    for i = 1, armour_inv:get_size("armour") do

        local full_name = armour_inv:get_stack("armour", i):get_name()
        local bodypart = get_bodypart(full_name)
        if bodypart ~= nil then
            worn_armour_table[bodypart] = full_name
        end

    end

    return worn_armour_table

end

local function set_player_armour(player)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.set_player_armor() / armor:set_player_armor()
    --
    -- Sets the player's armour attributes
    --
    -- Args:
    --      player (ObjectRef): The player whose armour is being handled

    local pname, armour_inv = get_valid_player(player, "set_player_armour()")
    if not pname then
        return
    end

    local state = 0
    local count = 0
    local preview = get_preview(pname)
    local texture = "blank.png"
    local physics_table = {}
    local attribute_table = {}
    local level_table = {}
    local group_table = {}
    local change_table = {}
    local set_worn_table = {}
    local armour_multiplier = 0
    local worn_armour_table = get_bodyparts_of_worn_armour(player)

    for _, phys in pairs(main_table.standard_physics_list) do
        physics_table[phys] = 1
    end

    for _, attr in pairs(main_table.standard_attribute_list) do
        attribute_table[attr] = 0
    end

    for group, _ in pairs(main_table.registered_group_table) do

        change_table[group] = 1
        level_table[group] = 0

    end

    local armour_stack_list = armour_inv:get_list("armour")
    if type(armour_stack_list) ~= "table" then
        return
    end

    for i, stack in pairs(armour_stack_list) do

        if stack:get_count() == 1 then

            local def_table = stack:get_definition()
            for _, bodypart in pairs(main_table.standard_bodypart_list) do

                if def_table.groups["armour_" .. bodypart] then

                    if def_table.armour_groups then

                        for group, level in pairs(def_table.armour_groups) do

                            if level_table[group] then
                                level_table[group] = level_table[group] + level
                            end

                        end

                    else

                        local level = def_table.groups["armour_" .. bodypart]
                        level_table["fleshy"] = level_table["fleshy"] + level

                    end

                    break

                end

            end

            local full_name = stack:get_name()
            local img = def_table.texture or full_name:gsub("%:", "_")
            img = img:gsub(".png$", "")

            local prev = def_table.preview or img .. "_preview"
            prev = prev:gsub(".png$", "")
            if not unilib.setting.armour_transparent_flag then
                texture = texture .. "^" .. img .. ".png"
            end

            preview = preview .. "^" .. prev .. ".png"
            state = state + stack:get_wear()
            count = count + 1

            for _, phys in pairs(main_table.standard_physics_list) do

                local value = def_table.groups["physics_" .. phys] or 0
                physics_table[phys] = physics_table[phys] + value

            end

            for _, attr in pairs(main_table.standard_attribute_list) do

                local value = def_table.groups["armour_" .. attr] or 0
                attribute_table[attr] = attribute_table[attr] + value

            end

        end

    end

    -- Compare player-worn armour items against requiremements, in order to find out which armour
    --      items must be worn to set bonus requirements
    for bodypart, full_name in pairs(worn_armour_table) do

        -- (e.g. "steel" from "unilib:armour_boots_steel")
        local part_name = string.match(full_name, "%:.+_(.+)$")
        local worn_key = part_name or "unknown"

        -- Perform location checks to ensure the armour is worn correctly
        for _, set_bodypart in pairs(main_config_table.set_bodypart_list) do

            if set_bodypart == bodypart then

                if set_worn_table[worn_key] == nil then

                    set_worn_table[worn_key] = 0
                    set_worn_table[worn_key] = set_worn_table[worn_key] + 1

                else

                    set_worn_table[worn_key] = set_worn_table[worn_key] + 1

                end

            end

        end

    end

    -- The armour multiplier is only applied when the player is wearing a full set of armour
    for _, arm_piece_num in pairs(set_worn_table) do

        if arm_piece_num == #main_config_table.set_bodypart_list then
            armour_multiplier = main_config_table.set_multiplier
        end

    end

    for group, level in pairs(level_table) do

        if level > 0 then

            level = level * main_config_table.level_multiplier
            if armour_multiplier ~= 0 then
                level = level * main_config_table.set_multiplier
            end

        end

        local base = main_table.registered_group_table[group]
        main_table.player_data_table[pname].groups[group] = level
        if level > base then
            level = base
        end

        group_table[group] = base - level
        change_table[group] = group_table[group] / base

    end

    for _, attr in pairs(main_table.standard_attribute_list) do

        local mult = attr == "heal" and main_config_table.heal_multiplier or 1
        main_table.player_data_table[pname][attr] = attribute_table[attr] * mult

    end

    for _, phys in pairs(main_table.standard_physics_list) do
        main_table.player_data_table[pname][phys] = physics_table[phys]
    end

    if use_armor_monoid_flag then

        -- ("unilib:armour" is an ID used by the "player_monoids" mod)
        armor_monoid.monoid:add_change(player, change_table, "unilib:armour")

    else

        -- Preserve immortal group (damage disabled for player)
        local player_armour_group_table = player:get_armor_groups()
        local immortal = player_armour_group_table.immortal
        if immortal and immortal ~= 0 then
            group_table.immortal = 1
        end

        -- Preserve fall_damage_add_percent group (fall damage modifier)
        group_table.fall_damage_add_percent = player_armour_group_table.fall_damage_add_percent
        player:set_armor_groups(group_table)

    end

    if use_player_monoids_flag then

        -- ("unilib:physics" is an ID used by the "player_monoids" mod)
        player_monoids.speed:add_change(player, physics_table.speed, "unilib:physics")
        player_monoids.jump:add_change(player, physics_table.jump, "unilib:physics")
        player_monoids.gravity:add_change(player, physics_table.gravity, "unilib:physics")

    elseif use_pova_mod_flag then

        -- Only add the changes, not the default value (1.0) for each physics setting

        -- ("unilib_armour" is an ID used by the "pova" mod)
        pova.add_override(pname, "unilib_armour", {
            speed = physics_table.speed - 1,
            jump = physics_table.jump - 1,
            gravity = physics_table.gravity - 1,
        })

        pova.do_override(player)

    else

        local player_physics_locked = player:get_meta():get_int("player_physics_locked")
        if player_physics_locked == nil or player_physics_locked == 0 then
            player:set_physics_override(physics_table)
        end

    end

    main_table.player_texture_table[pname].armour = texture
    main_table.player_texture_table[pname].preview = preview
    main_table.player_data_table[pname].level =
            main_table.player_data_table[pname].groups.fleshy or 0
    main_table.player_data_table[pname].state = state
    main_table.player_data_table[pname].count = count

    unilib.armour.update_player_visuals(player)

end

local function serialise_inventory_list(inv_list)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.serialize_inventory_list() / armor:serialize_inventory_list()
    --
    -- Serialises armour inventory
    --
    -- Args:
    --      inv_list (list): Inventory list

    local list_table = {}
    for _, stack in ipairs(inv_list) do
        table.insert(list_table, stack:to_string())
    end

    return core.serialize(list_table)

end

local function deserialise_inventory_list(list_str)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.deserialize_inventory_list() / armor:deserialize_inventory_list()
    --
    -- De-serialises armour inventory
    --
    -- Args:
    --      list_str (str): Serialised inventory contents

    local list_table = core.deserialize(list_str)
    local inv_list = {}
    for _, stack in ipairs(list_table or {}) do
        table.insert(inv_list, ItemStack(stack))
    end

    return inv_list

end

local function save_armour_inventory(player)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.save_armor_inventory() / armor:save_armor_inventory()
    --
    -- The (detached) armour inventory is stored as a player attribute, "unilib_armour_inventory"

    local _, armour_inv = get_valid_player(player, "save_armour_inventory()")
    if armour_inv then

        local meta = player:get_meta()
        meta:set_string(
            "unilib_armour_inventory",
            serialise_inventory_list(armour_inv:get_list("armour"))
        )

    end

end

local function unequip_armour(player, bodypart)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.unequip() / armor:unequip()
    --
    -- Unequips a piece of armour from a player
    --
    -- Args:
    --      player (ObjectRef): The player to be equipped
    --      bodypart (str): One of the items in "main_table.standard_bodypart_list", e.g. "head"

    local pname, armour_inv = get_valid_player(player, "unequip_armour()")
    if not pname then
        return
    end

    for i = 1, armour_inv:get_size("armour") do

        local stack = armour_inv:get_stack("armour", i)
        if get_bodypart(stack:get_name()) == bodypart then

            armour_inv:set_stack("armour", i, "")

            core.after(0, function()

                local this_player = core.get_player_by_name(pname)

                -- If the player is still online, add the armour item to their inventory
                if this_player then

                    local this_inv = this_player:get_inventory()
                    if this_inv:room_for_item("main", stack) then
                        this_inv:add_item("main", stack)
                    else
                        core.add_item(this_player:get_pos(), stack)
                    end

                end

            end)

            run_callbacks("on_unequip", player, i, stack)
            set_player_armour(player)
            save_armour_inventory(player)

            return

        end

    end

end

local function equip_armour(player, itemstack)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.equip() / armor:equip()
    --
    -- Equips a player with a piece of armour
    --
    -- Args:
    --      player (ObjectRef): The player to be equipped
    --      itemstack (ItemStack): The armour item to be equipped
    --
    -- Return values:
    --      The lefttover ItemStack

    local pname, armour_inv = get_valid_player(player, "equip_armour()")
    local bodypart = get_bodypart(itemstack:get_name())
    if pname and bodypart then

        local index
        for i = 1, armour_inv:get_size("armour") do

            local stack = armour_inv:get_stack("armour", i)
            if get_bodypart(stack:get_name()) == bodypart then

                -- Prevent equipping an armour that would unequip a cursed armour
                if core.get_item_group(stack:get_name(), "cursed") ~= 0 then
                    return itemstack
                end

                index = i
                unequip_armour(player, bodypart)
                break

            elseif not index and stack:is_empty() then

                index = i

            end

        end

        local stack = itemstack:take_item()
        armour_inv:set_stack("armour", index, stack)

        run_callbacks("on_equip", player, index, stack)
        set_player_armour(player)
        save_armour_inventory(player)

    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Local functions (3d_armor/3d_armor/api.lua, called from code adapted from
--      3d_armor/3d_armor/init.lua)
---------------------------------------------------------------------------------------------------

local function register_armour_group(group, base)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.register_armor_group() / armor:register_armor_group()
    --
    -- Registers a new armour group
    --
    -- Args:
    --      group (str): Group ID, e.g. "radiation"
    --
    -- Optional args:
    --      base (int): Base armour value, e.g. 100

    base = base or 100
    main_table.registered_group_table[group] = base
    if use_armor_monoid_flag then
        armor_monoid.register_armour_group(group, base)
    end

end

local function add_preview(preview)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.add_preview() / armor:add_preview()

    skin_preview_table[preview] = true

end

local function set_skin_mod()

    -- Adapted from code in 3d_armor/3d_armor/init.lua and 3d_armor/3d_armor/api.lua
    -- This function replaces the original API function, since the exterior mods won't be looking
    --      for unilib
    --
    -- Sets which skin mod is available, if any

    for _, mod_name in ipairs({
        "skins", "u_skins", "simple_skins", "wardrobe_ad", "wardrobe_outfits", "skinsdb",
    }) do

        local path = core.get_modpath(mod_name)
        if path then

            local dir_list = core.get_dir_list(path .. "/textures")
            for _, folder in pairs(dir_list) do

                -- "wardrobe_ad" mod uses textures in the form "X-preview.png"
                if folder:find("_preview.png$") or folder:find("-preview.png$") then
                    add_preview(folder)
                end

            end

            if mod_name ~= "wardrobe_outfits" then
                skin_mod = mod_name
            end

        end

    end

end

local function update_skin(pname)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.update_skin() / armor:update_skin()

    core.after(0, function()

        local player = core.get_player_by_name(pname)
        if player then

            player_texture_table[pname].skin = get_player_skin(pname)
            set_player_armour(player)

        end

    end)

end

local function load_armour_inventory(player)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.load_armor_inventory() / armor:load_armor_inventory()
    --
    -- Loads the armour inventory
    --
    -- Args:
    --      player (ObjectRef): The player whose armour inventory is being handled

    local _, armour_inv = get_valid_player(player, "load_armour_inventory()")
    if armour_inv then

        local meta = player:get_meta()
        local armour_list_str = meta:get_string("unilib_armour_inventory")
        if armour_list_str then

            armour_inv:set_list("armour", deserialise_inventory_list(armour_list_str))
            return true

        end

    end

end

local function set_inventory_stack(player, i, stack)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.set_inventory_stack() / armor:set_inventory_stack()
    --
    -- Updates the inventory
    --
    -- Args:
    --      player (ObjectRef): The player whose armour inventory is being handled
    --      i (int): Armour inventory index
    --      stack (ItemStack): The armour item

    local _, armour_inv = get_valid_player(player, "set_inventory_stack()")
    if armour_inv then

        armour_inv:set_stack("armour", i, stack)
        save_armour_inventory(player)

    end

end

local function do_damage(player, index, stack, use)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.damage() / armor:damage()
    --
    -- The action of the armour being punched
    --
    -- Args:
    --      player (ObjectRef): The player whose armour is punched
    --      index (int): Inventory index where the armour is equipped
    --      stack (ItemStack): Armour item receiving damage
    --      use (int): Amount of wear to add to the armour item

    local old_stack = ItemStack(stack)
    local worn_armour_table = get_bodyparts_of_worn_armour(player)
    if not worn_armour_table then
        return
    end

    local armour_worn_count = 0
    for k, v in pairs(worn_armour_table) do
        armour_worn_count = armour_worn_count + 1
    end

    use = math.ceil(use / armour_worn_count)
    stack:add_wear(use)

    run_callbacks("on_damage", player, index, stack)
    set_inventory_stack(player, index, stack)
    if stack:get_count() == 0 then

        run_callbacks("on_unequip", player, index, old_stack)
        run_callbacks("on_destroy", player, index, old_stack)
        set_player_armour(player)

    end

end

local function do_punch(player, hitter, time_from_last_punch, tool_capabilities)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.punch() / armor:punch()
    --
    -- The action of punching armour
    --
    -- Args:
    --      player (ObjectRef): The player wearing the armour
    --
    -- Optional args:
    --      hitter (ObjectRef): The entity attacking the player
    --      time_from_last_punch (int): Time in seconds since the last punch action
    --      tool_capabilities (table):  See "Entity damage mechanism" in Minetest API

    local pname, armour_inv = get_valid_player(player, "do_punch()")
    if not pname then
        return
    end

    local set_state
    local state = 0
    local set_count
    local count = 0
    local reciprocate_damage_flag = true
    local default_group_table = {choppy = 3, cracky = 3, crumbly = 3, level = 1, snappy = 3}
    local inv_list = armour_inv:get_list("armour")

    for i, stack in pairs(inv_list) do

        if stack:get_count() == 1 then

            local full_name = stack:get_name()
            local armour_use = core.get_item_group(full_name, "armour_use") or 0
            local damage_flag = armour_use > 0
            local def_table = stack:get_definition() or {}

            if type(def_table.on_punched) == "function" then

                damage_flag = def_table.on_punched(
                    player, hitter, time_from_last_punch, tool_capabilities
                ) ~= false and damage_flag == true

            end

            if damage_flag == true and tool_capabilities then

                local damage_group_table = def_table.damage_groups or default_group_table
                local level = damage_group_table.level or 0
                local groupcaps = tool_capabilities.groupcaps or {}
                local uses = 0

                damage_flag = false
                if next(groupcaps) == nil then
                    damage_flag = true
                end

                for group, caps in pairs(groupcaps) do

                    local maxlevel = caps.maxlevel or 0
                    local diff = maxlevel - level
                    if diff == 0 then
                        diff = 1
                    end

                    if diff > 0 and caps.times then

                        local group_level = damage_group_table[group]
                        if group_level then

                            local time = caps.times[group_level]
                            if time then

                                local dt = time_from_last_punch or 0
                                if dt > time / diff then

                                    if caps.uses then
                                        uses = caps.uses * math.pow(3, diff)
                                    end

                                    damage_flag = true
                                    break

                                end

                            end

                        end

                    end

                end

                if damage_flag == true and
                        reciprocate_damage_flag == true and
                        hitter and
                        def_table.reciprocate_damage == true and
                        uses > 0 then

                    local item = hitter:get_wielded_item()
                    if item and item:get_name() ~= "" then

                        item:add_wear(65535 / uses)
                        hitter:set_wielded_item(item)

                    end

                    -- Reciprocate tool damage only once
                    reciprocate_damage_flag = false

                end

            end

            if damage_flag == true and hitter == "fire" then
                damage_flag = core.get_item_group(full_name, "flammable") > 0
            end

            if damage_flag == true then

                do_damage(player, i, stack, armour_use)
                set_state = main_table.player_data_table[pname].state
                set_count = main_table.player_data_table[pname].count

            end

            state = state + stack:get_wear()
            count = count + 1

        end

    end

    if set_count and set_count ~= count then

        state = set_state or state
        count = set_count or count

    end

    main_table.player_data_table[pname].state = state
    main_table.player_data_table[pname].count = count

end

---------------------------------------------------------------------------------------------------
-- Local functions (3d_armor/3d_armor/init.lua)
---------------------------------------------------------------------------------------------------

local function validate_armour_inventory(player)

    -- Adapted from 3d_armor/3d_armor/init.lua
    -- Was validate_armor_inventory()
    --
    -- Workaround for the detached inventory swap exploit

    local _, armour_inv = get_valid_player(player, "validate_armour_inventory()")
    if not armour_inv then
        return
    end

    local pos = player:get_pos()
    local armour_prev_table = {}
    local attribute_meta = player:get_meta()
    local armour_list_str = attribute_meta:get_string("unilib_armour_inventory")
    if armour_list_str then

        local armour_list = deserialise_inventory_list(armour_list_str)
        for i, stack in ipairs(armour_list) do

            if stack:get_count() > 0 then
                armour_prev_table[stack:get_name()] = i
            end

        end

    end

    local bodypart_table = {}
    local player_inv = player:get_inventory()
    for i = 1, 6 do

        local stack = armour_inv:get_stack("armour", i)
        if stack:get_count() > 0 then

            local item = stack:get_name()
            local bodypart = get_bodypart(item)
            if bodypart and not bodypart_table[bodypart] then

                if armour_prev_table[item] then

                    armour_prev_table[item] = nil

                else

                    -- Item was not in previous inventory
                    run_callbacks("on_equip", player, i, stack)

                end

                bodypart_table[bodypart] = true

            else

                armour_inv:remove_item("armour", stack)
                core.item_drop(stack, player, pos)
                -- Notes from original mod:
                -- The following code returns invalid items to the player's main inventory but could
                --      open up the possibity for a hacked client to receive items back they never
                --      really had. I am not certain so remove the is_singleplayer check at your own
                --      risk :]
                if core.is_singleplayer() and
                        player_inv and
                        player_inv:room_for_item("main", stack) then
                    player_inv:add_item("main", stack)
                end

            end

        end

    end

    for item, i in pairs(armour_prev_table) do

        local stack = ItemStack(item)
        -- Previous item is not in current inventory
        run_callbacks("on_unequip", player, i, stack)

    end

end

local function init_player_armour(initplayer)

    -- Adapted from 3d_armor/3d_armor/init.lua
    -- Was init_player_armor()

    local pname = assert(initplayer:get_player_name())
    local armour_inv = core.create_detached_inventory(pname .. "_armour", {

        allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)

            if player:get_player_name() ~= pname then
                return 0
            end

            return count

        end,

        allow_put = function(inv, listname, index, put_stack, player)

            if player:get_player_name() ~= pname then
                return 0
            end

            local bodypart = get_bodypart(put_stack:get_name())
            if not bodypart then
                return 0
            end

            for i = 1, 6 do

                local stack = inv:get_stack("armour", i)
                local def_table = stack:get_definition() or {}
                if def_table.groups and def_table.groups["armour_" .. bodypart] and i ~= index then
                    return 0
                end

            end

            return 1

        end,

        allow_take = function(inv, listname, index, stack, player)

            if player:get_player_name() ~= pname then
                return 0
            end

            --Cursed items cannot be unequipped by the player
            local is_cursed = core.get_item_group(stack:get_name(), "cursed") ~= 0
            if not core.is_creative_enabled(player) and is_cursed then
                return 0
            end

            return stack:get_count()

        end,

        on_move = function(inv, from_list, from_index, to_list, to_index, count, player)

            validate_armour_inventory(player)
            save_armour_inventory(player)
            set_player_armour(player)

        end,

        on_put = function(inv, listname, index, stack, player)

            validate_armour_inventory(player)
            save_armour_inventory(player)
            set_player_armour(player)

        end,

        on_take = function(inv, listname, index, stack, player)
            validate_armour_inventory(player)
            save_armour_inventory(player)
            set_player_armour(player)

        end,

    }, pname)

    armour_inv:set_size("armour", 6)

    if not load_armour_inventory(initplayer) then

        local player_inv = initplayer:get_inventory()
        player_inv:set_size("armour", 6)
        for i = 1, 6 do

            local stack = player_inv:get_stack("armour", i)
            armour_inv:set_stack("armour", i, stack)

        end

        save_armour_inventory(initplayer)
        player_inv:set_size("armour", 0)

    end

    for i = 1, 6 do

        local stack = armour_inv:get_stack("armour", i)
        if stack:get_count() > 0 then
            run_callbacks("on_equip", initplayer, i, stack)
        end

    end

    main_table.player_data_table[pname] = {
        level = 0,
        state = 0,
        count = 0,
        groups = {},
    }

    for _, phys in pairs(main_table.standard_physics_list) do
        main_table.player_data_table[pname][phys] = 1
    end

    for _, attr in pairs(main_table.standard_attribute_list) do
        main_table.player_data_table[pname][attr] = 0
    end

    for group, _ in pairs(main_table.registered_group_table) do
        main_table.player_data_table[pname].groups[group] = 0
    end

    local skin = get_player_skin(pname)
    main_table.player_texture_table[pname] = {
        skin = skin,
        armour = "blank.png",
        wielditem = "blank.png",
        preview = main_table.default_skin .. "_preview.png",
    }

    local texture_path = core.get_modpath("player_textures")
    if texture_path then

        local dir_list = core.get_dir_list(texture_path .. "/textures")
        for _, folder in pairs(dir_list) do

            if folder == "player_" .. pname .. ".png" then

                main_table.player_texture_table[pname].skin = folder
                break

            end

        end

    end

    set_player_armour(initplayer)

end

---------------------------------------------------------------------------------------------------
-- Register armour
---------------------------------------------------------------------------------------------------

function unilib.armour._register_armour(full_name, orig_name, replace_mode, def_table)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.register_armor() / armor:register_armor()
    --
    -- Registers an armour item
    --
    -- Args:
    --      full_name (str): e.g. "unilib:armour_helmet_bronze"
    --      orig_name (nil, str or list): e.g. "3d_armor:helmet_bronze"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --      def_table (table): Usual definition table for the armour item, specifiying a
    --          .description, .inventory_image and .groups, as well as the tables .armour_groups and
    --          .damage_groups
    --
    -- N.B. All unilib code uses the spelling "armour", but group names normally exist with both
    --      British and American spellings. Thus, this function will add the group "armour_torso" if
    --      "armor_torso" is specified, and vice-versa
    --
    -- Return values:
    --      The specified full_name

    -- Compatibility with obscure dialects
    if def_table.groups ~= nil then

        local group_table = {}
        for k, v in pairs(def_table.groups) do

            group_table[k] = v

            if string.sub(k, 1, 6) == "armor_" then

                local alt_group = "armour_" .. string.sub(k, 7)
                if group_table[alt_group] == nil then
                    group_table[alt_group] = v
                end

            elseif string.sub(k, 1, 7) == "armour_" then

                local alt_group = "armor_" .. string.sub(k, 8)
                if group_table[alt_group] == nil then
                    group_table[alt_group] = v
                end

            end

        end

        def_table.groups = group_table

    end

    if def_table.armor_groups ~= nil then

        def_table.armour_groups = def_table.armor_groups
        def_table.armor_groups = nil

    end

    -- Apply standard functionality to the definition
    def_table.on_secondary_use = function(itemstack, player)
        return equip_armour(player, itemstack)
    end

    def_table.on_place = function(itemstack, player, pointed_thing)

        if pointed_thing.type == "node" and player and not player:get_player_control().sneak then

            local node = core.get_node(pointed_thing.under)
            local node_def_table = core.registered_nodes[node.name]
            if node_def_table and node_def_table.on_rightclick then

                return node_def_table.on_rightclick(
                    pointed_thing.under, node, player, itemstack, pointed_thing
                )

            end

        end

        return equip_armour(player, itemstack)

    end

    -- Register the armour item
    unilib.register_tool(full_name, orig_name, replace_mode, def_table)

    -- (The original calling function might need this for its craft recipes)
    return full_name

end

---------------------------------------------------------------------------------------------------
-- Register armour callbacks
---------------------------------------------------------------------------------------------------

function unilib.armour._register_callback_on_damage(func)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.register_on_damage() / armor:register_on_damage()
    --
    -- Registers a callback for when armour is damaged
    --
    -- Args:
    --      func (func): Function to be executed

    if type(func) == "function" then
        table.insert(main_table.registered_callback_table.on_damage, func)
    end

end

function unilib.armour._register_callback_on_destroy(func)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.register_on_destroy() / armor:register_on_destroy()
    --
    -- Registers a callback for when armour is destroyed
    --
    -- Args:
    --      func (func): Function to be executed

    if type(func) == "function" then
        table.insert(main_table.registered_callback_table.on_destroy, func)
    end

end

function unilib.armour._register_callback_on_equip(func)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.register_on_equip() / armor:register_on_equip()
    --
    -- Registers a callback for when armour is equipped
    --
    -- Args:
    --      func (func): Function to be executed

    if type(func) == "function" then
        table.insert(main_table.registered_callback_table.on_equip, func)
    end

end

function unilib.armour._register_callback_on_unequip(func)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.register_on_unequip() / armor:register_on_unequip()
    --
    -- Registers a callback for when armour is unequipped
    --
    -- Args:
    --      func (func): Function to be executed

    if type(func) == "function" then
        table.insert(main_table.registered_callback_table.on_unequip, func)
    end

end

function unilib.armour._register_callback_on_update(func)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.register_on_update() / armor:register_on_update()
    --
    -- Registers a callback for when player visuals are updated
    --
    -- Args:
    --      func (func): Function to be executed

    if type(func) == "function" then
        table.insert(main_table.registered_callback_table.on_update, func)
    end

end

---------------------------------------------------------------------------------------------------
-- Register armour craft recipes
---------------------------------------------------------------------------------------------------

function unilib.armour._register_craft_boots(data_table)

    -- Adapted from 3d_armor
    -- Function to create a standard craft recipe for the specified boots
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:armour_boots_" .. part_name,
        recipe = {
            {ingredient, "", ingredient},
            {ingredient, "", ingredient},
        },
    })

end

function unilib.armour._register_craft_chestplate(data_table)

    -- Adapted from 3d_armor
    -- Function to create a standard craft recipe for the specified chestplate
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:armour_chestplate_" .. part_name,
        recipe = {
            {ingredient, "", ingredient},
            {ingredient, ingredient, ingredient},
            {ingredient, ingredient, ingredient},
        },
    })

end

function unilib.armour._register_craft_helmet(data_table)

    -- Adapted from 3d_armor
    -- Function to create a standard craft recipe for the specified helmet
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:armour_helmet_" .. part_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {ingredient, "", ingredient},
            {"", "", ""},
        },
    })

end

function unilib.armour._register_craft_leggings(data_table)

    -- Adapted from 3d_armor
    -- Function to create a standard craft recipe for the specified leggings
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:armour_leggings_" .. part_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {ingredient, "", ingredient},
            {ingredient, "", ingredient},
        },
    })

end

function unilib.armour._register_craft_gauntlets(data_table)

    -- Adapted from 3d_armor_gloves
    -- Function to create a standard craft recipe for the specified gauntlets
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"
    --      minor_ingredient (str): e.g. "unilib:item_string_ordinary"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient
    local minor_ingredient = data_table.minor_ingredient

    unilib.register_craft({
        output = "unilib:armour_gauntlets_" .. part_name,
        recipe = {
            {ingredient, "", ingredient},
            {minor_ingredient, "", minor_ingredient},
        },
    })

end

function unilib.armour._register_craft_shield(data_table)

    -- Adapted from 3d_armor
    -- Function to create a standard craft recipe for the specified shield
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:armour_shield_" .. part_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {ingredient, ingredient, ingredient},
            {"", ingredient, ""},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions (called by code in 3d_armor)
---------------------------------------------------------------------------------------------------

function unilib.armour._drop_armour(pos, stack)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.drop_armor() / armor:drop_armor()
    --
    -- Drops armour at the specified position
    --
    -- Args:
    --      pos (table): Position at which the armour is dropped, e.g. {x = 1, y = 1, z = 1}
    --      stack (ItemStack): The armour item to be dropped

    local node = core.get_node_or_nil(pos)
    if node then

        local obj = core.add_item(pos, stack)
        if obj then
            obj:set_velocity({x = math.random(-1, 1), y = 5, z = math.random(-1, 1)})
        end

    end

end

function unilib.armour._update_player_visuals(player)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.update_player_visuals() / armor:update_player_visuals()
    --
    -- Updates visuals
    --
    -- Args:
    --      player (ObjectRef): The player whose visuals are being handled

    if not player then
        return
    end

    if skin_mod == "skinsdb" then

        local skin = skins.get_player_skin(player)
        skin:apply_skin_to_player(player)

    else

        local pname = player:get_player_name()
        if main_table.player_texture_table[pname] then

            unilib.player_api.set_textures(player, {
                main_table.player_texture_table[pname].skin,
                main_table.player_texture_table[pname].armour,
                main_table.player_texture_table[pname].wielditem,
            })

        end

    end

    run_callbacks("on_update", player)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (not called by anything in 3d_armor, but available to other code)
---------------------------------------------------------------------------------------------------

function unilib.armour._get_formspec(pname, listring_flag)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.get_armor_formspec() / armor:get_armor_formspec()
    --
    -- Generates the armour formspec
    --
    -- Args:
    --      pname (str): The player name
    --
    -- Optional args:
    --      listring (bool): Use the "listring" formspec element (default is false)

    local formspec = main_table.formspec .. "list[detached:" .. pname ..
            "_armour;armour;0,0.5;2,3;]"

    if listring_flag == true then

        formspec = formspec .. "listring[current_player;main]" .. "listring[detached:" ..
                pname .. "_armour;armour]"

    end

    formspec = formspec:gsub("armour_preview", main_table.player_texture_table[pname].preview)
    formspec = formspec:gsub("armour_level", main_table.player_data_table[pname].level)

    for _, attr in pairs(main_table.standard_attribute_list) do
        formspec = formspec:gsub("armour_attr_" .. attr, main_table.player_data_table[pname][attr])
    end

    for group, _ in pairs(main_table.registered_group_table) do

        formspec = formspec:gsub(
            "armour_group_" .. group,
            main_table.player_data_table[pname].groups[group]
        )

    end

    return formspec

end

function unilib.armour._remove_all(player)

    -- Adapted from 3d_armor/3d_armor/api.lua
    -- Was armor.remove_all() / armor:remove_all()
    --
    -- Removes all armour worn by the player
    --
    -- Args:
    --      player (ObjectRef): The player whose armour is being removed

    local pname, armour_inv = get_valid_player(player, "unilib.armour.remove_all()")
    if not pname then
        return
    end

    armour_inv:set_list("armour", {})
    set_player_armour(player)
    save_armour_inventory(player)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (original to unilib)
---------------------------------------------------------------------------------------------------

function unilib.armour._get_config(key)

    -- Original to unilib
    -- Returns the value (which may be nil) for the specified key in main_config_table

    return main_config_table[key]

end

function unilib.armour._get_default_formspec()

    -- Original to unilib
    -- Returns the basic formspec (as a string); note that the actual formpsec used by an inventory
    --      mod, might be the one returned by unilib.armour.get_formspec()

    return main_table.formspec

end

function unilib.armour._get_player_data(pname)

    -- Original to unilib
    -- Returns the value of main_table.player_data_table[pname], which may be nil
    -- (For simplicity, we write some getter functions for packages that need them (e.g.
    --      "inventory_armour_ui"), rather than making "main_table" a shared variable. Note that
    --      there are no corresponding setter functions)

    return main_table.player_data_table[pname]

end

function unilib.armour._get_player_texture(pname)

    -- Original to unilib
    -- Returns the value of main_table.player_texture_table[pname], which may be nil

    return main_table.player_texture_table[pname]

end

function unilib.armour._set_player_texture(pname, k, v)

    -- Original to unilib
    -- Updates a player's texture table (if a table for the specified player exists)

    if main_table.player_texture_table[pname] ~= nil then
        main_table.player_texture_table[pname][k] = v
    end

end

function unilib.armour._set_default_formspec(str)

    -- Original to unilib
    -- Updates the basic formspec

    main_table.formspec = str

end

---------------------------------------------------------------------------------------------------
-- Setup code (override other mods)
---------------------------------------------------------------------------------------------------

core.after(0, function()

    if core.get_modpath("wardrobe_ad") then

        -- The "wardrobe_ad" mod calls 3d_armor functions; override its code, so that unilib
        --      functions are called instead
        function wardrobe.updatePlayerSkin(player)
            unilib.armour.update_player_visuals(player)
        end

        function wardrobe.changePlayerSkin(pname, skin)

            local player = core.get_player_by_name(pname)
            if not player then
                return
            end

            wardrobe.playerSkins[pname] = skin
            wardrobe.savePlayerSkins()

--          main_table.player_texture_table[playerName].skin = skin
--          main_table.player_texture_table[playerName].preview = get_preview(playerName)

            update_skin(pname)
--          unilib.armour.update_player_visuals(player)

        end

    end

    if core.get_modpath("skinsdb") then

        -- The "skinsdb" mod calls 3d_armor functions; override its code, so that unilib functions
        --      are called instead

        -- (This is required to make skin_class:apply_skin_to_player() work; an ugly hack, but it
        --      works)
        if armor == nil then
            armor = {}
        end

        armor.textures = main_table.player_texture_table

        -- (This replaces code in init.lua)
        skins.armor_loaded = true
        function skins.update_player_skin(player)
            set_player_armour(player)
        end

    end

end)

---------------------------------------------------------------------------------------------------
-- Setup code (from 3d_armor/3d_armor/init.lua)
---------------------------------------------------------------------------------------------------

-- Remove torch damage if the Minetest setting is disabled
if main_config_table.fire_protect_torch_flag == false and
        main_config_table.fire_protect_flag == true then

    for k, v in pairs(main_table.fire_node_list) do

        for k2, v2 in pairs(v) do

            if string.find(v2, "torch") then
                main_table.fire_node_list[k] = nil
            end

        end

    end

end

-- If technic is loaded, update the formspec to show radiation
if core.get_modpath("technic") then

    main_table.formspec = main_table.formspec ..
        "label[5,2.5;" .. FS("Radiation") .. ": armour_group_radiation]"

    register_armour_group("radiation")

end

-- unilib is compatible with several skin mods (but only one at a time)
set_skin_mod()

-- Update the formspec
main_table.formspec = main_table.formspec ..
    "label[5,1;" .. FS("Level") .. ": armour_level]" ..
    "label[5,1.5;" .. FS("Heal") .. ": armour_attr_heal]"

if main_config_table.fire_protect_flag then
    main_table.formspec = main_table.formspec .. "label[5,2;" .. FS("Fire") .. ": armour_attr_fire]"
end

-- Armour initialisation
unilib.armour.register_callback_on_damage(function(player, index, stack)

    local pname = player:get_player_name()
    local def_table = stack:get_definition()
    if pname and def_table and def_table.description and stack:get_wear() > 60100 then

        core.chat_send_player(pname, S("Your @1 is almost broken!", def_table.description))
        core.sound_play("unilib_tool_breaks", {to_player = pname, gain = 2.0})

    end

end)

unilib.armour.register_callback_on_destroy(function(player, index, stack)

    local pname = player:get_player_name()
    local def_table = stack:get_definition()
    if pname and def_table and def_table.description then

        core.chat_send_player(pname, S("Your @1 has been destroyed!", def_table.description))
        core.sound_play("unilib_tool_breaks", {to_player = pname, gain = 2.0})

    end

end)

-- Set up the armour player model

-- N.B. Original 3darmor code does not specify fields like .eye_height, so they are written using
--      default values, so the player does not (for example) lie down. Solution is to reformat this
--      table to look like the ones in ../libshared/player_api/
--[[
unilib.player_api.register_model("unilib_armour_character.b3d", {
    animation_speed = 30,
    textures = {
        main_table.default_skin .. ".png",
        "blank.png",
        "blank.png",
    },
    animations = {
        lay = {x = 162, y = 166},
        mine = {x = 189, y = 198},
        sit = {x = 81, y = 160},
        stand = {x = 0, y = 79},
        walk = {x = 168, y = 187},
        walk_mine = {x = 200, y = 219},
        -- Compatibility with the "emote" mod
        freeze = {x = 205, y = 205, override_local = true},
        point = {x = 196, y = 196, override_local = true},
        wave = {x = 192, y = 196, override_local = true},
    },
})
]]--
unilib.player_api.register_model("unilib_armour_character.b3d", {
    animation_speed = 30,
    textures = {
        main_table.default_skin .. ".png",
        "blank.png",
        "blank.png",
    },
    animations = {
        -- Standard animations
        lay       = {
            x = 162,
            y = 166,
            eye_height = 0.3,
            override_local = true,
            collisionbox = {-0.6, 0.0, -0.6, 0.6, 0.3, 0.6},
        },
        mine      = {x = 189, y = 198},
        sit       = {
            x = 81,
            y = 160,
            eye_height = 0.8,
            override_local = true,
            collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.0, 0.3},
        },
        stand     = {x = 0, y = 79},
        walk      = {x = 168, y = 187},
        walk_mine = {x = 200, y = 219},
        -- Compatibility with the "emote" mod
        freeze    = {x = 205, y = 205, override_local = true},
        point     = {x = 196, y = 196, override_local = true},
        wave      = {x = 192, y = 196, override_local = true},
    },
})

core.register_on_player_receive_fields(function(player, formname, fields)

    -- This function is called when the player changes skin using the "skins" or "u_skins" mods;
    --      both of them provide a fields.X matching "skins_set"

    local pname, _ = get_valid_player(player, "core.register_on_player_receive_fields()")
    if not pname then
        return
    end

    for field, _ in pairs(fields) do

        if string.find(field, "skins_set") then
            update_skin(pname)
        end

    end

end)

core.register_on_joinplayer(function(player)

    unilib.player_api.set_model(player, "unilib_armour_character.b3d")
    init_player_armour(player)

end)

core.register_on_leaveplayer(function(player)

    local pname = player:get_player_name()
    if pname then

        main_table.player_data_table[pname] = nil
        main_table.player_texture_table[pname] = nil

    end

end)

if main_config_table.drop_flag == true or main_config_table.destroy_flag == true then

    core.register_on_dieplayer(function(player)

        local pname, armour_inv = get_valid_player(player, "core.register_on_dieplayer()")
        if not pname then
            return
        end

        local drop_list = {}
        for i = 1, armour_inv:get_size("armour") do

            local stack = armour_inv:get_stack("armour", i)
            if stack:get_count() > 0 then

                -- Soulbound armours remain equipped after death
                if core.get_item_group(stack:get_name(), "soulbound") == 0 then

                    table.insert(drop_list, stack)
                    run_callbacks("on_unequip", player, i, stack)
                    armour_inv:set_stack("armour", i, nil)

                end

            end

        end

        save_armour_inventory(player)
        set_player_armour(player)

        local pos = player:get_pos()
        if pos and main_config_table.destroy_flag == false then

            core.after(main_config_table.bones_delay, function()

                local meta = nil
                local maxp = vector.add(pos, 16)
                local minp = vector.subtract(pos, 16)
                local bones_list = core.find_nodes_in_area(minp, maxp, {"bones:bones"})

                for _, this_pos in pairs(bones_list) do

                    local this_meta = core.get_meta(this_pos)
                    if this_meta:get_string("owner") == pname then

                        meta = this_meta
                        break

                    end

                end

                if meta then

                    local inv = meta:get_inventory()
                    for _, stack in ipairs(drop_list) do

                        if inv:room_for_item("main", stack) then
                            inv:add_item("main", stack)
                        else
                            unilib.armour.drop_armour(pos, stack)
                        end

                    end

                else

                    for _,stack in ipairs(drop_list) do
                        unilib.armour.drop_armour(pos, stack)
                    end

                end

            end)

        end

    end)

    core.register_on_respawnplayer(function(player)

        -- Reset un-dropped armour and its effects
        set_player_armour(player)

    end)

end

if main_config_table.punch_damage_flag == true then

    core.register_on_punchplayer(
        function(player, hitter, time_from_last_punch, tool_capabilities)

            local pname = player:get_player_name()
            if hitter then

                local hit_ip = hitter:is_player()
                if pname and hit_ip and core.is_protected(player:get_pos(), "") then
                    return
                end

            end

            if pname then

                do_punch(player, hitter, time_from_last_punch, tool_capabilities)
                last_punch_time_table[pname] = core.get_gametime()

            end

        end
    )

end

core.register_on_player_hpchange(function(player, hp_change, reason)

    if not core.is_player(player) then
        return hp_change
    end

    if reason.type == "drown" or reason.hunger or hp_change >= 0 then
        return hp_change
    end

    local pname = player:get_player_name()
    local properties = player:get_properties()
    local hp = player:get_hp()
    if hp + hp_change < properties.hp_max then

        local heal = main_table.player_data_table[pname].heal
        if heal >= math.random(100) then
            hp_change = 0
        end

        -- Check if armour damage was handled by fire, or by on_punchplayer
        local time = last_punch_time_table[pname] or 0
        if time == 0 or time + 1 < core.get_gametime() then
            do_punch(player)
        end

    end

    return hp_change

end, true)

core.register_globalstep(function(dtime)

    main_timer = main_timer + dtime

    if main_config_table.feather_fall_flag == true then

        for _, player in pairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            if main_table.player_data_table[pname].feather > 0 then

                local vel_y = player:get_velocity().y
                if vel_y < 0 and vel_y < 3 then

                    vel_y = -(vel_y * 0.05)
                    player:add_velocity({x = 0, y = vel_y, z = 0})

                end

            end

        end

    end

    if main_timer <= main_config_table.init_delay then
        return
    else
        main_timer = 0
    end

    -- Notes from original mod:
    -- Water breathing protection, added by TenPlus1
    if main_config_table.water_protect_flag == true then

        for _, player in pairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            if main_table.player_data_table[pname].water > 0 and player:get_breath() < 10 then
                player:set_breath(10)
            end

        end

    end

end)

if main_config_table.fire_protect_flag == true then

    -- Make torches hurt
    -- (No packages loaded yet, so unlike the original code, we must use core.after() )
    core.after(0, function()

        for _, full_name in pairs({
            "unilib:torch_ordinary", "unilib:torch_ordinary_wall", "unilib:torch_ordinary_ceiling",
            "default:torch", "default:torch_wall", "default:torch_ceiling",
        }) do

            if core.registered_items[full_name] ~= nil then
                core.override_item(full_name, {damage_per_second = 1})
            end

        end

    end)

    -- Check player damage for any hot nodes, against which they may be protected
    core.register_on_player_hpchange(function(player, hp_change, reason)

        if reason.type == "node_damage" and reason.node then

            -- Fire protection
            if main_config_table.fire_protect_flag == true and hp_change < 0 then

                local pname = player:get_player_name()
                for _, igniter_list in pairs(main_table.fire_node_list) do

                    if reason.node == igniter_list[1] then

                        if main_table.player_data_table[pname].fire >= igniter_list[2] then
                            hp_change = 0
                        end

                    end

                end

            end

        end

        return hp_change

    end, true)

end
