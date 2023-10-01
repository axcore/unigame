---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    chunkkeeper
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("chunkkeeper:keeper_off", {
    short_description = "Chunk Keeper (Off)",
    description = "Chunk Keeper (Off)\nKeeps the mapblock it's located in active\nConsumes burnable items to add time",
    tiles = {
        chunkkeeper.img("top_off"), -- Top
        chunkkeeper.img("sides_bottom"),
        chunkkeeper.img("sides_bottom"),
        chunkkeeper.img("sides_bottom"),
        chunkkeeper.img("sides_bottom"),
        chunkkeeper.img("sides_bottom")
    },
    is_ground_content = false,
    groups = {handy = 1, oddly_breakable_by_hand = 3},
    drop = "chunkkeeper:keeper_off",
    on_construct = function (pos, node)
        local meta = minetest.get_meta(pos)
        meta:set_int("super_user", 0) -- not inf
        meta:set_int("time_left", 0) -- no time
        meta:set_int("running", 0) -- off
        meta:set_int("hide_owner", 0) -- off
        meta:set_string("owner", "") -- no playername (not yet)
        local inv = meta:get_inventory()
        inv:set_size("main", 1) -- input burnables here (all burn times increased by at least x2)
    end,
    after_place_node = function (pos, placer)
        if placer and placer:is_player() then -- Only update the owner when we have an owner
            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name())
            minetest.get_node_timer(pos):start(1)
            chunkkeeper.update_formspec(pos)
        end
    end,
    allow_metadata_inventory_put = function (pos, listname, index, stack, player) -- Add fuel!
        local meta = minetest.get_meta(pos)
        local count = stack:get_count()
        chunkkeeper.log({pos=pos, listname=listname, index=index, stack=stack:to_table(), player=player:get_player_name()})
        local inv = meta:get_inventory()
        if player:get_player_name() ~= meta:get_string("owner") or meta:get_string("owner") == "" then
            if not minetest.check_player_privs(player, {protection_bypass=true}) then
                return count -- No inventory allowed, bad player, bad.
            end
        end
        if listname ~= "main" then
            chunkkeeper.log({listname=listname, errmsg = "Invalid inventory, expected 'main'"})
            return count -- Invalid inventory name
        end
        local recipe = minetest.get_craft_result({
            method = "fuel",
            items = {stack}
        })
        if not recipe then
            chunkkeeper.log({stack=stack:to_table(), errmsg = "Failed getting recipes for stack"})
            return count
        end
        if recipe.time == 0 then
            chunkkeeper.log({stack=stack:to_table(), errmsg = "Didn't get a burnable item?"})
            return count
        end
        local timer = meta:get_int("time_left")
        timer = timer + ((recipe.time * count) * chunkkeeper.settings.fuel_multiplier)
        meta:set_int("time_left", timer)
        chunkkeeper.update_formspec(pos)
        stack:clear()
        inv:set_list("main", {})
        return -1 -- Eat all fuel, this will make things vanish but the time will increase (intended stuff)
    end,
    on_receive_fields = function (pos, formname, fields, player)
        local meta = minetest.get_meta(pos)
        chunkkeeper.log({pos=pos, formname=formname, fields=fields, player=player:get_player_name()})
        local run = meta:get_int("running") == 1
        local hide_owner = meta:get_int("hide_owner") == 1
        local super = meta:get_int("super_user") == 1
        local owner = meta:get_string("owner")
        if owner ~= "" and player:get_player_name() ~= owner then
            if not minetest.check_player_privs(player, {protection_bypass=true}) then
                return -- Invalid user, non-owner access
            end
        end
        local dirty = false
        if fields.toggle_running then
            if run then
                meta:set_int("running", 0)
                if not super then
                    minetest.swap_node(pos, {name = "chunkkeeper:keeper_off"})
                else
                    minetest.swap_node(pos, {name = "chunkkeeper:keeper_inf_off"})
                end
                minetest.forceload_free_block(pos)
            else
                meta:set_int("running", 1)
                if not super then
                    minetest.swap_node(pos, {name = "chunkkeeper:keeper_on"})
                else
                    minetest.swap_node(pos, {name = "chunkkeeper:keeper_inf_on"})
                end
                minetest.forceload_block(pos)
            end
            dirty = true
        elseif fields.toggle_hide_owner then
            if hide_owner then
                meta:set_int("hide_owner", 0)
            else
                meta:set_int("hide_owner", 1)
            end
            dirty = true
        end
        if dirty then
            chunkkeeper.update_formspec(pos)
        end
    end,
    on_timer = function (pos, elapsed)
        return chunkkeeper.processFuel(pos)
    end
})
local iron = "default:steel_ingot"
local gold = "defualt:gold_ingot"
local diamond = "default:diamond"
minetest.register_craft({
    output = "chunkkeeper:keeper_off",
    recipe = {
        {"", diamond, ""},
        {iron, diamond, iron},
        {iron, gold, iron}
    }
})

minetest.register_node("chunkkeeper:keeper_on", {
    short_description = "Chunk Keeper (On)",
    description = "Chunk Keeper (On)\nKeeps the mapblock it's located in active\nConsumes burnable items to add time",
    tiles = {
        { -- Top
            name = chunkkeeper.img("top_on_animated"),
            animation={
                type = "vertical_frames",
                aspect_w = 32,
                aspect_h = 32,
                length = 2.0
            }
        },
        --chunkkeeper.img("top_off"), -- Top
        chunkkeeper.img("sides_bottom"),
        chunkkeeper.img("sides_bottom"),
        chunkkeeper.img("sides_bottom"),
        chunkkeeper.img("sides_bottom"),
        chunkkeeper.img("sides_bottom")
    },
    is_ground_content = false,
    groups = {handy = 1, oddly_breakable_by_hand = 3},
    drop = "chunkkeeper:keeper_off",
    on_construct = function (pos, node)
        local meta = minetest.get_meta(pos)
        meta:set_int("super_user", 0) -- not inf
        meta:set_int("time_left", 0) -- no time
        meta:set_int("running", 0) -- off
        meta:set_int("hide_owner", 0) -- off
        meta:set_string("owner", "") -- no playername (not yet)
        local inv = meta:get_inventory()
        inv:set_size("main", 1) -- input burnables here (all burn times increased by at least x2)
    end,
    after_place_node = function (pos, placer)
        if placer and placer:is_player() then -- Only update the owner when we have an owner
            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name())
            minetest.get_node_timer(pos):start(1)
            chunkkeeper.update_formspec(pos)
        end
    end,
    allow_metadata_inventory_put = function (pos, listname, index, stack, player) -- Add fuel!
        local meta = minetest.get_meta(pos)
        local count = stack:get_count()
        --chunkkeeper.log({pos=pos, listname=listname, index=index, stack=stack:to_table(), player=player:get_player_name()})
        local inv = meta:get_inventory()
        if player:get_player_name() ~= meta:get_string("owner") or meta:get_string("owner") == "" then
            if not minetest.check_player_privs(player, {protection_bypass=true}) then
                return count -- No inventory allowed, bad player, bad.
            end
        end
        if listname ~= "main" then
            chunkkeeper.log({listname=listname, errmsg = "Invalid inventory, expected 'main'"})
            return count -- Invalid inventory name
        end
        local recipe = minetest.get_craft_result({
            method = "fuel",
            items = {stack}
        })
        if not recipe then
            chunkkeeper.log({stack=stack:to_table(), errmsg = "Failed getting recipes for stack"})
            return count
        end
        if recipe.time == 0 then
            chunkkeeper.log({stack=stack:to_table(), errmsg = "Didn't get a burnable item?"})
            return count
        end
        local timer = meta:get_int("time_left")
        timer = timer + ((recipe.time * count) * chunkkeeper.settings.fuel_multiplier)
        meta:set_int("time_left", timer)
        chunkkeeper.update_formspec(pos)
        stack:clear()
        inv:set_list("main", {})
        return -1 -- Eat all fuel, this will make things vanish but the time will increase (intended stuff)
    end,
    on_receive_fields = function (pos, formname, fields, player)
        local meta = minetest.get_meta(pos)
        --chunkkeeper.log({pos=pos, formname=formname, fields=fields, player=player:get_player_name()})
        local run = meta:get_int("running") == 1
        local hide_owner = meta:get_int("hide_owner") == 1
        local super = meta:get_int("super_user") == 1
        local owner = meta:get_string("owner")
        if owner ~= "" and player:get_player_name() ~= owner then
            if not minetest.check_player_privs(player, {protection_bypass=true}) then
                return -- Invalid user, non-owner access
            end
        end
        local dirty = false
        if fields.toggle_running then
            if run then
                meta:set_int("running", 0)
                if not super then
                    minetest.swap_node(pos, {name = "chunkkeeper:keeper_off"})
                else
                    minetest.swap_node(pos, {name = "chunkkeeper:keeper_inf_off"})
                end
                minetest.forceload_free_block(pos)
            else
                meta:set_int("running", 1)
                if not super then
                    minetest.swap_node(pos, {name = "chunkkeeper:keeper_on"})
                else
                    minetest.swap_node(pos, {name = "chunkkeeper:keeper_inf_on"})
                end
                minetest.forceload_block(pos)
            end
            dirty = true
        elseif fields.toggle_hide_owner then
            if hide_owner then
                meta:set_int("hide_owner", 0)
            else
                meta:set_int("hide_owner", 1)
            end
            dirty = true
        end
        if dirty then
            chunkkeeper.update_formspec(pos)
        end
    end,
    on_timer = function (pos, elapsed)
        return chunkkeeper.processFuel(pos)
    end
})
]]--
