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
minetest.register_node("chunkkeeper:keeper_inf_off", {
    short_description = "Chunk Keeper (Off)",
    description = "Chunk Keeper (Off)\nKeeps the mapblock it's located in active\nThis one has unlimited time",
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
    drop = "chunkkeeper:keeper_inf_off",
    on_construct = function (pos, node)
        local meta = minetest.get_meta(pos)
        meta:set_int("super_user", 1) -- inf
        meta:set_int("time_left", 0) -- no time
        meta:set_int("running", 0) -- off
        meta:set_int("hide_owner", 0) -- off
        meta:set_string("owner", "") -- no playername (not yet)
        local inv = meta:get_inventory() -- Un-needed as infinite keeper's don't need time
        inv:set_size("main", 1) -- input burnables here (all burn times increased by at least x2)
    end,
    after_place_node = function (pos, placer)
        if placer and placer:is_player() then -- Only update the owner when we have an owner
            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name())
            minetest.get_node_timer(pos):start(1)
            chunkkeeper.update_formspec_inf(pos)
        end
    end,
    allow_metadata_inventory_put = function (pos, listname, index, stack, player) -- Add fuel!
        local count = stack:get_count()
        return count -- Invalid for infinite time
    end,
    on_receive_fields = function (pos, formname, fields, player)
        local meta = minetest.get_meta(pos)
        local run = meta:get_int("running") == 1
        local hide_owner = meta:get_int("hide_owner") == 1
        local super = meta:get_int("super_user") == 1
        local owner = meta:get_string("owner")
        --chunkkeeper.log({pos=pos, formname=formname, fields=fields, player=player:get_player_name(), owner=owner, super=super, run=run, hide_owner=hide_owner})
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
        end
        if dirty then
            chunkkeeper.update_formspec_inf(pos)
        end
    end,
    on_timer = function (pos, elapsed)
        return chunkkeeper.processFuel(pos) -- Needs to run for changing persistance
    end
})

minetest.register_node("chunkkeeper:keeper_inf_on", {
    short_description = "Chunk Keeper (On)",
    description = "Chunk Keeper (On)\nKeeps the mapblock it's located in active\nThis one has unlimited time",
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
    drop = "chunkkeeper:keeper_inf_off",
    on_construct = function (pos, node)
        local meta = minetest.get_meta(pos)
        meta:set_int("super_user", 1) -- inf
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
            chunkkeeper.update_formspec_inf(pos)
        end
    end,
    allow_metadata_inventory_put = function (pos, listname, index, stack, player) -- Add fuel!
        local count = stack:get_count()
        return count -- Invalid there is no need to add time for a infinite time
    end,
    on_receive_fields = function (pos, formname, fields, player)
        local meta = minetest.get_meta(pos)
        local run = meta:get_int("running") == 1
        local hide_owner = meta:get_int("hide_owner") == 1
        local super = meta:get_int("super_user") == 1
        local owner = meta:get_string("owner")
        --chunkkeeper.log({pos=pos, formname=formname, fields=fields, player=player:get_player_name(), owner=owner, super=super, run=run, hide_owner=hide_owner})
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
            chunkkeeper.update_formspec_inf(pos)
        end
    end,
    on_timer = function (pos, elapsed)
        return chunkkeeper.processFuel(pos) -- Needs to run for persistance
    end
})
]]--
