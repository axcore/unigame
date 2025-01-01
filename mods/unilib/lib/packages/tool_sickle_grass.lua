---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sickle_grass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function sickle_can_break(pos, node, player)

    local def = ItemStack({name = node.name}):get_definition()

    if not def.diggable or (def.can_dig and not def.can_dig(pos, player)) then

        --[[
        unilib.utils.log(
            "info",
            player:get_player_name() .. " tried to sickle " .. def.name ..
                    " which is not diggable " .. core.pos_to_string(pos)
        )
        ]]--
        unilib.utils.log_player_action(
            player, "tried to sickle", def.name, "which is not diggable at", pos
        )

        return

    end

    if core.is_protected(pos, player:get_player_name()) then

        --[[
        unilib.utils.log(
            "action",
            player:get_player_name() .. " tried to sickle " .. def.name ..
                    " at protected position " .. core.pos_to_string(pos)
        )
        ]]--
        unilib.utils.log_player_action(
            player, "tried to sickle", def.name, "at protected position", pos
        )

        core.record_protection_violation(pos, player:get_player_name())

        return

    end

    return true

end

local function sickle_on_use(itemstack, user, pointed_thing, uses)

    -- Turns nodes with group flora=1 & flower=0 into cut grass

    -- Check if pointing at a node
    local pt = pointed_thing
    if not pt then
        return
    end

    if pt.type ~= "node" then
        return
    end

    local under = core.get_node(pt.under)
    local above_pos = {x = pt.under.x, y = pt.under.y + 1, z = pt.under.z}
    local above = core.get_node(above_pos)

    -- Return if either node is not registered
    if not core.registered_nodes[under.name] then
        return
    end

    if not core.registered_nodes[above.name] then
        return
    end

    if not sickle_can_break(pt.under, under, user) then
        return
    end

    -- Check that it's something that can be cut using fine tools
    if core.get_item_group(under.name, "snappy") > 0 then

        -- Check if flora but no flower
        if core.get_item_group(under.name, "flora") == 1 and
                core.get_item_group(under.name, "flower") == 0 then

            -- Turn the node into cut grass, wear out item and play sound
            core.swap_node(pt.under, {name = "unilib:misc_patch_grass"})

        else

            -- Otherwise dig the node
            if not core.node_dig(pt.under, under, user) then
                return
            end

        end

        core.sound_play("unilib_dig_crumbly", {pos = pt.under, gain = 0.5,})
        itemstack:add_wear(unilib.constant.max_tool_wear / (uses - 1))
        return itemstack

    elseif string.find(under.name, "unilib:dirt_ordinary_with_turf") then

        if core.is_protected(above_pos, user:get_player_name()) or above.name ~= "air" then
            return
        end

        -- Place a patch of grass above, and short turf below (sounds confusing, but works in
        --      practice)
        core.swap_node(pt.under, {name = "unilib:dirt_ordinary_with_turf_short"})
        core.swap_node(above_pos, {name = "unilib:misc_patch_grass"})

        core.sound_play("unilib_dig_crumbly", {pos = pt.under, gain = 0.5})
        itemstack:add_wear(unilib.constant.max_tool_wear / (uses - 1))
        return itemstack

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sickle_grass.init()

    return {
        description = "Sickle for cutting grass",
        notes = "Turns nodes with group flora = 1 and flower = 0 into cut/short grass",
        depends = {"dirt_ordinary_with_turf_short", "item_stick_ordinary", "misc_patch_grass"},
        optional = "dirt_ordinary",
    }

end

function unilib.pkg.tool_sickle_grass.exec()

    unilib.register_tool("unilib:tool_sickle_grass", "dryplants:sickle", mode, {
        -- From dryplants:sickle
        description = S("Grass-Cutting Sickle"),
        inventory_image = "unilib_tool_sickle_grass.png",
        -- (no groups)
        -- (no sound)

        on_use = function(itemstack, user, pointed_thing)
            return sickle_on_use(itemstack, user, pointed_thing, 220)
        end,
    })
    unilib.register_craft({
        -- From dryplants:sickle
        output = "unilib:tool_sickle_grass",
        recipe = {
            {"group:stone", ""},
            {"", "unilib:item_stick_ordinary"},
            {"unilib:item_stick_ordinary", ""},
        },
    })

end
