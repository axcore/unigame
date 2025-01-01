---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools_hoe.lua
--      Register hoes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_use_hoe(itemstack, user, pointed_thing, uses)

    -- Adapted from farming/api.lua

    local pt = pointed_thing

    -- Check if pointing at a node
    if not pt then
        return
    end
    if pt.type ~= "node" then
        return
    end

    local under = core.get_node(pt.under)
    local p = {x = pt.under.x, y = pt.under.y+1, z = pt.under.z}
    local above = core.get_node(p)

    -- Return if any of the nodes is not registered
    if not core.registered_nodes[under.name] then
        return
    end
    if not core.registered_nodes[above.name] then
        return
    end

    -- Check if the node above the pointed thing is air
    if above.name ~= "air" then
        return
    end

    -- Check if pointing at soil
    if core.get_item_group(under.name, "soil") ~= 1 then
        return
    end

    -- Check if (wet) soil defined
    local regN = core.registered_nodes
    if regN[under.name].soil == nil or regN[under.name].soil.wet == nil or
            regN[under.name].soil.dry == nil then
        return
    end

    local player_name = user and user:get_player_name() or ""

    if core.is_protected(pt.under, player_name) then

        core.record_protection_violation(pt.under, player_name)
        return

    end
    if core.is_protected(pt.above, player_name) then

        core.record_protection_violation(pt.above, player_name)
        return

    end

    -- Turn the node into soil and play sound
    core.set_node(pt.under, {name = regN[under.name].soil.dry})
    core.sound_play(
        "unilib_dig_crumbly",
        {pos = pt.under, gain = 0.3},
        true
    )

    if not unilib.utils.is_creative(player_name) then

        -- Wear tool
        local wdef = itemstack:get_definition()
        itemstack:add_wear_by_uses(uses)
        -- Tool break sound
        if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
            core.sound_play(wdef.sound.breaks, {pos = pt.above, gain = 0.5}, true)
        end
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Register hoes
---------------------------------------------------------------------------------------------------

function unilib.tools._register_hoe(data_table)

    -- Adapted from farming/api.lua
    -- Function to register a hoe
    -- Unlike the original minetest_game code, this function can also produce the mirror image
    --      craft recipe
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "diamond"
    --      full_name (str): e.g. "unilib:tool_hoe_diamond"
    --      orig_name (str): e.g. "farming:hoe_diamond"
    --      def_table (table): The partial definition table for the hoe
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      damage_group_table (table): e.g. damage_groups = {fleshy = 2}
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local full_name = data_table.full_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local damage_group_table = data_table.damage_group_table or nil

    local ingredient = def_table.ingredient

    -- Check def_table
    if def_table.description == nil then
        def_table.description = S("Hoe")
    end

    if def_table.inventory_image == nil then
        def_table.inventory_image = "unilib_unknown.png"
    end

    if def_table.max_uses == nil then
        def_table.max_uses = 30
    end

    -- Register the tool
    unilib.register_tool(full_name, orig_name, replace_mode, {
        description = def_table.description,
        inventory_image = def_table.inventory_image,
        groups = def_table.groups,
        sound = {breaks = "unilib_tool_breaks"},

        damage_groups = damage_group_table,

        on_use = function(itemstack, user, pointed_thing)
            return on_use_hoe(itemstack, user, pointed_thing, def_table.max_uses)
        end,
    })

    -- Register its recipe
    if def_table.recipe then

        unilib.register_craft({
            output = full_name,
            recipe = def_table.recipe
        })

    elseif ingredient ~= nil then

        unilib.register_craft({
            output = full_name,
            recipe = {
                {ingredient, ingredient},
                {"", "group:stick"},
                {"", "group:stick"},
            },
        })

        if unilib.setting.mtgame_tweak_flag then

            -- (Mirror image craft recipe)
            unilib.register_craft({
                output = full_name,
                recipe = {
                    {"", ingredient, ingredient},
                    {"", "group:stick", ""},
                    {"", "group:stick", ""},
                },
            })

        end

    end

    return full_name

end
