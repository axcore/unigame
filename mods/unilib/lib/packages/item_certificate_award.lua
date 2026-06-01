---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_certificate_award = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Trophy types for which certificates exist
local trophy_table = {
    gold = S("Gold Award Certificate"),
    silver = S("Silver Award Certificate"),
    bronze = S("Bronze Award Certificate"),
}

---------------------------------------------------------------------------------------------------
-- local functions
---------------------------------------------------------------------------------------------------

local function register_certificate(trophy_type, basic_description)

    local full_name = "unilib:item_certificate_award_" .. trophy_type
    local img = "unilib_item_certificate_award_" .. trophy_type .. "_inv.png"

    unilib.register_node(full_name, nil, mode, {
        -- Original to unilib
        description = basic_description,
        tiles = {"unilib_item_certificate_award_" .. trophy_type .. ".png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.node,

        drawtype = "nodebox",
        inventory_image = img,
        is_ground_content = false,
        -- N.B. node_box adapted from the one used in "shared_default_sign"
        node_box = {
            type = "wallmounted",
            wall_top = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
            wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
            wall_side = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        walkable = false,
        wield_image = img,

        on_dig = function(pos, node, digger)

            if not unilib.utils.is_player(digger) then
                core.node_dig(pos, node, digger)
            end

            local meta = core.get_meta(pos)
            local owner = meta:get_string("owner")
            local description = meta:get_string("description")

            -- Remove the old node
            core.remove_node(pos)

            -- Create replacement item, preserving metadata
            local new_stack = ItemStack(full_name)
            local new_meta = new_stack:get_meta()
            new_meta:set_string("owner", owner)
            if owner ~= "" then

                new_meta:set_string("description", description)
                new_meta:set_string("infotext", description)

            end

            -- Give the replacement item to the player
            local inv = digger:get_inventory()
            if inv then

                local leftover = inv:add_item("main", new_stack)
                if not leftover:is_empty() then
                    core.add_item(digger:get_pos(), leftover)
                end

            else

                core.add_item(pos, new_stack)

            end

        end,

        on_place = function(itemstack, placer, pointed_thing)

            if not unilib.utils.is_player(placer) or pointed_thing.type ~= "node" then
                return itemstack
            end

            local new_stack = core.item_place(itemstack, placer, pointed_thing)
            if new_stack == nil then
                new_stack = itemstack
            end

            local pos = vector.new(pointed_thing.above)
            local node = core.get_node_or_nil(pos)
            if node and node.name == full_name then

                local old_meta = itemstack:get_meta()
                local owner = old_meta:get_string("owner")
                local description = old_meta:get_string("description")

                local new_meta = core.get_meta(pos)
                new_meta:set_string("owner", owner)
                new_meta:set_string("description", description)
                new_meta:set_string("infotext", description)

            end

        end,
    })

    return full_name

end

local function grant_certificate(player, trophy_type, vocation_title)

    if not unilib.utils.is_player(player) then
        return
    end

    local pname = player:get_player_name()
    local inv = player:get_inventory()
    if not inv then
        return
    end

    local description = unilib.utils.brackets(
        trophy_table[trophy_type] .. " - " .. vocation_title, S("awarded to @1", pname)
    )

    local stack = ItemStack("unilib:item_certificate_award_" .. trophy_type)

    local meta = stack:get_meta()
    meta:set_string("owner", pname)
    meta:set_string("description", description)
    meta:set_string("infotext", description)

    local leftover = inv:add_item("main", stack)
    if not leftover:is_empty() then
        core.add_item(player:get_pos(), leftover)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_certificate_award.init()

    return {
        description = "Certificates for player awards",
        notes = "These awards are granted to the player automatically, when they unlock the" ..
                " higher levels of vocations. Note that certificates will not be awarded" ..
                " automatically for vocations that specify their own callbacks",
    }

end

function unilib.pkg.item_certificate_award.exec()

    -- Sanity check - no need for certificates, if awards are disabled
    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Create the certificates in gold, silver and bronze
    for k, v in pairs(trophy_table) do
        register_certificate(k, v)
    end

    -- Insert a callback, to be called whenever the player unlocks a level in a vocation
    unilib.awards.add_standard_level_callback(

        function(player, vocation_name, new_level, max_levels)

            local vocation_table = unilib.global.awards_vocation_table[vocation_name]

            if new_level == max_levels then
                grant_certificate(player, "gold", vocation_table.title)
            elseif new_level == (max_levels - 1) then
                grant_certificate(player, "silver", vocation_table.title)
            elseif new_level == (max_levels - 2) then
                grant_certificate(player, "bronze", vocation_table.title)
            end

        end
    )

end
