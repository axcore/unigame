---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools_toolranks.lua
--      Toolranks support functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From sickles/api.lua)
local repair_warning = unilib.constant.max_tool_wear * 0.9   -- Original factor was 0.917...

-- (From toolranks/init.lua)
local colour_table = {
    grey = core.get_color_escape_sequence("#9d9d9d"),
    green = core.get_color_escape_sequence("#1eff00"),
    gold = core.get_color_escape_sequence("#ffdf00"),
    red = core.get_color_escape_sequence("#ff2b2b"),
    white = core.get_color_escape_sequence("#ffffff"),
}

local level_multiplier = 1 / unilib.setting.toolranks_max_levels

-- Progressive levelling table (when each level is 50% more expensive than the previous one)
local progressive_table = {}
local total = 0
local last = unilib.setting.toolranks_nodes_per_level
for i = 0, (unilib.setting.toolranks_max_levels - 1) do

    total = total + last
    progressive_table[i] = total
    last = math.floor((last * 0.5) + last)

end

-- (Force translation of the tool types typically used in calls to unilib.apply_toolranks() )
local tool_type_list = {
    S("axe"), S("chainsaw"), S("drill"), S("hoe"), S("pickaxe"), S("scythe"), S("shovel"),
    S("sickle"), S("spear"), S("sword"), S("tool"),
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_level(uses)

    -- Adapted from toolranks/init.lua

    if type(uses) == "number" and uses > 0 then

        if not unilib.setting.toolranks_progressive_flag then

            -- Simple levelling: all levels are equal
            local this_level = math.floor(uses / unilib.setting.toolranks_nodes_per_level)
            if this_level >= unilib.setting.toolranks_max_levels then
                return unilib.setting.toolranks_max_levels, 0
            else
                return this_level,
                        ((this_level + 1) * unilib.setting.toolranks_nodes_per_level) - uses
            end

        else

            -- Progressive level: each level is 50% harder than the previous one
            for i = 0, (unilib.setting.toolranks_max_levels - 1) do

                if uses < progressive_table[i] then
                    return i, progressive_table[i] - uses
                end

            end

            -- Tool is fully levelled-up
            return unilib.setting.toolranks_max_levels, 0

        end

    else

        return 0, 0

    end

end

local function toolranks_after_use(itemstack, user, node, digparams)

    local pname = user:get_player_name()
    if not pname or unilib.utils.is_creative(pname) then
        return itemstack
    end

    local itemmeta = itemstack:get_meta()
    local itemdef = itemstack:get_definition()
    local itemdesc = itemdef.original_description or ""
    local dugnodes = tonumber(itemmeta:get_string("dug")) or 0
    local lastlevel = tonumber(itemmeta:get_string("lastlevel")) or 0
--    local most_digs = mod_storage:get_int("most_digs") or 0
--    local most_digs_user = mod_storage:get_string("most_digs_user") or 0
    local most_digs_count = tonumber(unilib.utils.get_mod_attribute("tools_most_digs_count")) or 0
    local most_digs_player = unilib.utils.get_mod_attribute("tools_most_digs_player") or 0

    -- Only nodes that wear out the tool count towards levelling up
    if digparams.wear > 0 then

        dugnodes = dugnodes + 1
        itemmeta:set_string("dug", dugnodes)

    end

    if dugnodes > most_digs_count then

        if unilib.setting.toolranks_announce_flag and most_digs_player ~= pname then

            core.chat_send_all(S(
                "Most advanced tool is now a @1@2@3 owned by @4 with @5 uses.",
                colour_table.green,
                itemdesc,
                colour_table.white,
                pname,
                dugnodes
            ))

        end

        unilib.utils.set_mod_attribute("tools_most_digs_count", dugnodes)
        unilib.utils.set_mod_attribute("tools_most_digs_player", pname)

    end

    if itemstack:get_wear() > repair_warning then

        -- (This code replaces the code in the generic unilib.tool_after_use() function above)
        core.chat_send_player(
            user:get_player_name(),
            S("Your @1 is about to break!", itemdef.tool_type)
        )

        core.sound_play("unilib_tool_breaks", {to_player = pname, gain = 2.0})

    end

    local level, to_go = get_level(dugnodes)
    if lastlevel < level then

        if level >= unilib.setting.toolranks_max_levels then

            core.chat_send_player(
                user:get_player_name(),
                S(
                    "Your @1@2@3 just reached its maximum level!",
                    colour_table.green,
                    itemdef.tool_type,
                    colour_table.white
                )
            )

        else

            core.chat_send_player(
                user:get_player_name(),
                S(
                    "Your @1@2@3 just levelled up!",
                    colour_table.green,
                    itemdef.tool_type,
                    colour_table.white
                )
            )

        end

        core.sound_play("unilib_tool_level_up", {to_player = pname, gain = 2.0})

        -- Make tool better by modifying tool_capabilities (if defined)
        if itemdef.tool_capabilities then

            local speed_multiplier =
                1 + (level * level_multiplier * (unilib.setting.toolranks_speed_multiplier - 1))
            local use_multiplier =
                1 + (level * level_multiplier * (unilib.setting.toolranks_use_multiplier - 1))
            local caps = table.copy(itemdef.tool_capabilities)

            caps.full_punch_interval =
                caps.full_punch_interval and (caps.full_punch_interval / speed_multiplier)
            caps.punch_attack_uses =
                caps.punch_attack_uses and (caps.punch_attack_uses * use_multiplier)

            for _,c in pairs(caps.groupcaps) do

                c.uses = c.uses * use_multiplier
                for i,t in ipairs(c.times) do
                    c.times[i] = t / speed_multiplier
                end

            end

            itemmeta:set_tool_capabilities(caps)

        end

    end

    itemmeta:set_string("lastlevel", level)
    itemmeta:set_string(
        "description",
        unilib.tools.prepare_toolranks_description(
            itemdesc, itemdef.tool_type, dugnodes, itemmeta:get_string("max_repair")
        )
    )
    itemstack:add_wear(digparams.wear)

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Toolranks support functions
---------------------------------------------------------------------------------------------------

function unilib.tools._prepare_toolranks_description(old_description, tool_type, uses, max_repair)

    -- Adapted from toolranks/init.lua
    -- Modified to prevent colours bleeding into the subsequent lines (which is a problem, if any
    --      part of the code wants to use fewer lines)

    -- Toolranks don't level up in creative mode. We can't test the player's creative mode here, but
    --      we can at least test the overall one
    if unilib.utils.is_creative() then
        return old_description
    end

    -- Prepare description
    local description
    local level, to_go = get_level(uses)

    if not unilib.setting.toolranks_countdown_flag or to_go == 0 then

        description = S(
            "@1@2@3",
            colour_table.green,
            old_description,
            colour_table.white
        ) .. "\n" .. S(
            "@1Level @2 @3@4",
            colour_table.gold,
            level,
            S(tool_type),
            colour_table.white
        ) .. "\n" .. S(
            "@1@Nodes dug: @2@3",
            colour_table.grey,
            (type(uses) == "number" and uses or 0),
            colour_table.white
        )

    else

        description = S(
            "@1@2@3",
            colour_table.green,
            old_description,
            colour_table.white
        ) .. "\n" .. S(
            "@1Level @2 @3@4",
            colour_table.gold,
            level,
            S(tool_type),
            colour_table.white
        ) .. "\n" .. S(
            "@1@Nodes dug: @2, next level: @3@4",
            colour_table.grey,
            (type(uses) == "number" and uses or 0),
            to_go,
            colour_table.white
        )

    end

    if unilib.setting.tool_limit_repair_factor > 0 and max_repair ~= nil and max_repair ~= "" then

        description = description .. "\n" .. S(
            "@1Maximum repair: @2%@3",
            colour_table.red,
            math.floor(
                (unilib.constant.max_tool_wear - tonumber(max_repair)) * 100 /
                unilib.constant.max_tool_wear
            ),
            colour_table.white
        )

    end

    return description

end

function unilib.tools._apply_toolranks(full_name, tool_type)

    -- Adapted from toolranks/init.lua
    -- Applies toolranks to the specified tool (if toolranks are enabled in general)
    --
    -- Args:
    --      full_name (str): e.g. "unilib:tool_pick_stone"
    --      tool_type (str): a short, translatable description of the tool type; a string in lower-
    --          case and in English, e.g. "axe", "shovel", "pickaxe"

    if unilib.setting.toolranks_enable_flag then

        local old_description = ItemStack(full_name):get_definition().description
        if tool_type == nil or tool_type == "" then
            tool_type = "tool"
        end

        unilib.override_item(full_name, {
            description = unilib.tools.prepare_toolranks_description(old_description, tool_type),

            original_description = old_description,
            tool_type = tool_type,

            after_use = toolranks_after_use,
        })

    end

end

function unilib.tools._update_toolranks_description(itemstack)

    -- Original to unilib
    -- Resets an item's metadata description. This happens in every call to toolranks_after_use(),
    --      but if the tool hasn't actually been used (for example, if the item's
    --      .original_description has been changed), this function can be called instead

    local itemmeta = itemstack:get_meta()
    local itemdef = itemstack:get_definition()
    local itemdesc = itemdef.original_description or ""
    local dugnodes = tonumber(itemmeta:get_string("dug")) or 0

    itemmeta:set_string(
        "description",
        unilib.tools.prepare_toolranks_description(
            itemdesc, itemdef.tool_type, dugnodes, itemmeta:get_string("max_repair")
        )
    )

end

