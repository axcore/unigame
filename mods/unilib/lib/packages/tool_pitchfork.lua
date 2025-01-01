---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pitchfork = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_protected(pos, name)
    return core.is_protected(pos, name) and not core.check_player_privs(name, "protection_bypass")
end

local function modify_turf(turf_name, dirt_name)

    -- Handle digging turf with the pitchfork (incorporating Git #12 fix for duplicate dirts)
    local old_on_dig = core.registered_items[turf_name].on_dig

    unilib.override_item(turf_name, {
        -- Adapted from cottages/ndoes_hay.lua
        on_dig = function(pos, node, digger)

            if not(pos) or not(digger) then
                return old_on_dig(pos, node, digger)
            end

            local diggername = digger:get_player_name()
            local wielded = digger:get_wielded_item()
            if not(wielded) or
                    not(wielded:get_name()) or
                    wielded:get_name() ~= "unilib:tool_pitchfork" then
                return old_on_dig(pos, node, digger)
            end

            local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
            local node_above = core.get_node_or_nil(pos_above)
            if not(node_above) or not(node_above.name) or node_above.name ~= "air" then
                return old_on_dig(pos, node, digger)
            end

            if is_protected(pos, diggername) or is_protected(pos_above, diggername) then
                return old_on_dig(pos, node, digger)
            end

            core.swap_node(pos, {name = dirt_name})
            core.add_node(
                pos_above,
                {name = "unilib:misc_hay_ordinary_pile", param2 = math.random(2, 25)}
            )

            -- Start a node timer so that the hay will decay after a while
            local timer = core.get_node_timer(pos_above)
            if not timer:is_started() then
                timer:start(math.random(60, 300))
            end

            return

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pitchfork.init()

    return {
        description = "Pitchfork",
        nodes = "Tool for digging nodes with the group \"hay\". Creates hay when digging" ..
                " dirt with turf. Can also be placed as a node",
        depends = {"dirt_ordinary", "misc_hay_ordinary", "item_stick_ordinary"},
    }

end

function unilib.pkg.tool_pitchfork.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_tool("unilib:tool_pitchfork", "cottages:pitchfork", mode, {
        -- From cottages:pitchfork
        description = unilib.utils.hint(
            S("Pitchfork"), S("dig turf to get hay, place pitchfork with right click")
        ),
        inventory_image = "unilib_tool_pitchfork.png",
        groups = {},
        sound = {breaks = "unilib_tool_breaks"},

        liquids_pointable = false,
        stack_max = 1,
        wield_image = "unilib_tool_pitchfork.png^[transformFYR180",
        wield_scale = {x = 1.5, y = 1.5, z = 0.5},

        -- Notes from cottages:
        -- Very useful for digging hay, straw and bales of those materials. "damage_groups" makes it
        --      slightly stronger than a stone sword
        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 1.0,
            groupcaps = {
                fleshy = {times = {[2] = 0.80, [3] = 0.40}, maxlevel = 1, uses = 1 / 0.002},
                hay = {times = {[2] = 0.10, [3] = 0.10}, maxlevel = 1, uses = 1 / 0.002},
                snappy = {times = {[2] = 0.80, [3] = 0.40}, maxlevel = 1, uses = 1 / 0.002},
            },
            max_drop_level = 1,
        },

        on_place = function(itemstack, placer, pointed_thing)

            if placer == nil or pointed_thing == nil or pointed_thing.type ~= "node" then
                return nil
            end

            local pos = core.get_pointed_thing_position(pointed_thing, 1)
            local node = core.get_node_or_nil(pos)
            if node == nil or not(node.name) or node.name ~= "air" then
                return nil
            end

            if core.is_protected(pos, placer:get_player_name()) then
                return nil
            end

            core.rotate_and_place(
                ItemStack("unilib:tool_pitchfork_placed"),
                placer,
                pointed_thing
            )

            -- Did the placing succeed?
            local nnode = core.get_node(pos)
            if not(nnode) or not(nnode.name) or nnode.name ~= "unilib:tool_pitchfork_placed" then
                return nil
            end

            local meta = core.get_meta(pos)
            meta:set_int("wear", itemstack:get_wear())
            meta:set_string("infotext", S("Pitchfork (for hay and straw)"))

            -- The tool has been placed, so consume it
            return ItemStack("")

        end,
    })
    unilib.register_craft({
        -- From cottages:pitchfork
        output = "unilib:tool_pitchfork",
        recipe = {
            {c_stick, c_stick, c_stick},
            {"", c_stick, ""},
            {"", c_stick, ""},
        },
    })

    unilib.register_node("unilib:tool_pitchfork_placed", "cottages:pitchfork_placed", mode, {
        -- From cottages:pitchfork_placed
        description = unilib.utils.hint(S("Pitchfork"), S("for hay and straw")),
        tiles = {"unilib_tree_apple_wood.png^[transformR90"},
        groups = {
            attached_node = 1, dig_immediate = 3, falling_node = 1, not_in_creative_inventory = 1,
            snappy = 2,
        },
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        drop = "unilib:tool_pitchfork",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-(1/32), -(11/16), -(1/32), (1/32), 16/16, (1/32)},
                {-(7/32), -(4/16), -(1/32), (7/32), -(2/16), (1/32)},
                {-(7/32), -(11/16), -(1/32), -(5/32), -(4/16), (1/32)},
                { (5/32), -(11/16), -(1/32), (7/32), -(4/16), (1/32)},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.1, 0.3, 1.0, 0.1}
        },

        -- Notes from cottages:
        -- When dropped, preserve wear (the first item in "drops" is the pitchfork)
        preserve_metadata = function(pos, oldnode, oldmeta, drops)

            if oldmeta["wear"] then
                drops[1]:set_wear(oldmeta["wear"])
            end

        end,
    })

    -- Handle digging turf with the pitchfork
    if not unilib.setting.cottages_versatile_pitchfork_flag then

        -- Only one type of dirt-with-turf can be used to make hay
        modify_turf("unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary")

    else

        -- Any "fertile" dirt-with-turf can be used to make hay
        for turf_name, data_table in pairs(unilib.global.dirt_with_turf_table) do

            if unilib.global.fertile_dirt_table[data_table.dirt_part_name] ~= nil then
                modify_turf(turf_name, "unilib:" .. data_table.dirt_part_name)
            end

        end

    end

end
