---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/3d_armor_stand
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stand_armour = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_stand"].add_mode

local formspec = "size[8,7]" ..
    unilib.misc.get_hotbar_bg(0,3) ..
    "list[current_name;armour_head;3,0.5;1,1;]" ..
    "list[current_name;armour_torso;4,0.5;1,1;]" ..
    "list[current_name;armour_legs;3,1.5;1,1;]" ..
    "list[current_name;armour_feet;4,1.5;1,1;]" ..
    "image[3,0.5;1,1;unilib_misc_stand_armour_head.png]" ..
    "image[4,0.5;1,1;unilib_misc_stand_armour_torso.png]" ..
    "image[3,1.5;1,1;unilib_misc_stand_armour_legs.png]" ..
    "image[4,1.5;1,1;unilib_misc_stand_armour_feet.png]" ..
    "list[current_player;main;0,3;8,1;]" ..
    "list[current_player;main;0,4.25;8,3;8]"

-- (A subset of bodyparts used in ../lib/shared/armour/armour_base.lua)
local bodypart_list = {"head", "torso", "legs", "feet"}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function drop_armour(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    for _, bodypart in pairs(bodypart_list) do

        local stack = inv:get_stack("armour_" .. bodypart, 1)
        if stack and stack:get_count() > 0 then

            unilib.armour.drop_armour(pos, stack)
            inv:set_stack("armour_" .. bodypart, 1, nil)

        end

    end

end

local function get_stand_object(pos)

    local main_obj = nil
    local obj_list = core.get_objects_inside_radius(pos, 0.5) or {}

    for _, this_obj in pairs(obj_list) do

        local ent = this_obj:get_luaentity()
        if ent then

            if ent.name == "unilib:entity_misc_stand_armour" then

                -- Remove duplicates
                if main_obj then
                    this_obj:remove()
                else
                    main_obj = this_obj
                end

            end

        end

    end

    return main_obj

end

local function update_entity(pos)

    local node = core.get_node(pos)
    local obj = get_stand_object(pos)

    if obj then

        if not string.find(node.name, "unilib:misc_stand_armour") then

            obj:remove()
            return

        end

    else

        obj = core.add_entity(pos, "unilib:entity_misc_stand_armour")

    end

    if obj then

        local blank_img = "blank.png"
        local img_list = {}
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local yaw = 0

        if inv then

            for _, bodypart in pairs(bodypart_list) do

                local stack = inv:get_stack("armour_" .. bodypart, 1)
                if stack:get_count() == 1 then

                    local item = stack:get_name() or ""
                    local def_table = stack:get_definition() or {}
                    local group_table = def_table.groups or {}
                    if group_table["armour_" .. bodypart] then

                        if def_table.texture then
                            table.insert(img_list, def_table.texture)
                        else
                            table.insert(img_list, item:gsub("%:", "_") .. ".png")
                        end

                    end

                end

            end

        end

        if #img_list > 0 then
            blank_img = table.concat(img_list, "^")
        end

        if node.param2 then

            local rot = node.param2 % 4
            if rot == 1 then
                yaw = 3 * math.pi / 2
            elseif rot == 2 then
                yaw = math.pi
            elseif rot == 3 then
                yaw = math.pi / 2
            end

        end

        obj:set_yaw(yaw)
        obj:set_properties({textures = {blank_img}})

    end

end

local function has_locked_armour_stand_privilege(meta, player)

    local pname = ""
    if player then

        if core.check_player_privs(player, "protection_bypass") then
            return true
        end

        pname = player:get_player_name()

    end

    if pname ~= meta:get_string("owner") then
        return false
    else
        return true
    end

end

local function add_hidden_node(pos, player)

    local this_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
    local pname = player:get_player_name()
    local node = core.get_node(this_pos)
    if node.name == "air" and not core.is_protected(pos, pname) then
        core.set_node(this_pos, {name = "unilib:misc_stand_armour_top"})
    end

end

local function remove_hidden_node(pos)

    local this_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
    local node = core.get_node(this_pos)
    if node.name == "unilib:misc_stand_armour_top" then
        core.remove_node(this_pos)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stand_armour.init()

    return {
        description = "Armour stand",
        depends = {"metal_copper", "metal_steel"},
    }

end

function unilib.pkg.misc_stand_armour.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_stand_armour_top", "3d_armor_stand:top", mode, {
        -- From 3d_armor_stand:top
        description = S("Top of Armour Stand"),
        tiles = {"blank.png"},
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        buildable_to = false,
        diggable = false,
        drawtype = "plantlike",
        drop = "",
        is_ground_content = false,
        paramtype = "light",
        pointable = false,
        sunlight_propagates = true,
        walkable = true,

        -- Not affected by TNT
        on_blast = function() end,
    })

    unilib.register_node("unilib:misc_stand_armour", "3d_armor_stand:armor_stand", mode, {
        -- From 3d_armor_stand:armor_stand
        description = S("Armour Stand"),
        tiles = {"unilib_misc_stand_armour.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "mesh",
        is_ground_content = false,
        mesh = "unilib_misc_stand_armour.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.4375, -0.25, 0.25, 1.4, 0.25},
                {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
            },
        },
        use_texture_alpha = "clip",
        walkable = false,

        after_destruct = function(pos)

            update_entity(pos)
            remove_hidden_node(pos)

        end,

        after_place_node = function(pos, placer)

            core.add_entity(pos, "unilib:entity_misc_stand_armour")
            add_hidden_node(pos, placer)

        end,

        allow_metadata_inventory_move = function(pos)
            return 0
        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack)

            local def_table = stack:get_definition() or {}
            local group_table = def_table.groups or {}
            if group_table[listname] then
                return 1
            else
                return 0
            end

        end,

        can_dig = function(pos, player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            for _, bodypart in pairs(bodypart_list) do

                if not inv:is_empty("armour_" .. bodypart) then
                    return false
                end

            end

            return true

        end,

        on_blast = function(pos)

            drop_armour(pos)
            -- N.B. Not an ItemStack in original code. The original armor.drop_armor() and the
            --      unilib equivalent expect an ItemStack as a second argument
            unilib.armour.drop_armour(pos, ItemStack("unilib:misc_stand_armour"))
            core.remove_node(pos)

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", formspec)
            meta:set_string("infotext", S("Armour Stand"))

            local inv = meta:get_inventory()
            for _, bodypart in pairs(bodypart_list) do
                inv:set_size("armour_" .. bodypart, 1)
            end

        end,

        on_metadata_inventory_put = function(pos)
            update_entity(pos)
        end,

        on_metadata_inventory_take = function(pos)
            update_entity(pos)
        end,
    })
    unilib.register_craft({
        -- From 3d_armor_stand:armor_stand
        output = "unilib:misc_stand_armour",
        recipe = {
            {"", "group:fence", ""},
            {"", "group:fence", ""},
            {c_ingot, c_ingot, c_ingot},
        },
    })

    unilib.register_node(
        -- From 3d_armor_stand:locked_armor_stand
        "unilib:misc_stand_armour_locked",
        "3d_armor_stand:locked_armor_stand",
        mode,
        {
            description = S("Locked Armour Stand"),
            tiles = {"unilib_misc_stand_armour_locked.png"},
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.global.sound_table.wood,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_misc_stand_armour.obj",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.25, -0.4375, -0.25, 0.25, 1.4, 0.25},
                    {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
                },
            },
            use_texture_alpha = "clip",
            walkable = false,

            after_destruct = function(pos)

                update_entity(pos)
                remove_hidden_node(pos)

            end,

            after_place_node = function(pos, placer)

                core.add_entity(pos, "unilib:entity_misc_stand_armour")

                local meta = core.get_meta(pos)
                meta:set_string("owner", placer:get_player_name() or "")
                meta:set_string(
                    "infotext", S("Armour Stand (owned by @1)", meta:get_string("owner"))
                )

                add_hidden_node(pos, placer)

            end,

            allow_metadata_inventory_move = function(pos)
                return 0
            end,

            allow_metadata_inventory_put = function(pos, listname, index, stack, player)

                local meta = core.get_meta(pos)
                if not has_locked_armour_stand_privilege(meta, player) then
                    return 0
                end

                local def_table = stack:get_definition() or {}
                local group_table = def_table.groups or {}
                if group_table[listname] then
                    return 1
                else
                    return 0
                end

            end,

            allow_metadata_inventory_take = function(pos, listname, index, stack, player)

                local meta = core.get_meta(pos)
                if not has_locked_armour_stand_privilege(meta, player) then
                    return 0
                end

                return stack:get_count()

            end,

            can_dig = function(pos, player)

                local meta = core.get_meta(pos)
                local inv = meta:get_inventory()
                for _, bodypart in pairs(bodypart_list) do

                    if not inv:is_empty("armour_" .. bodypart) then
                        return false
                    end

                end

                return true

            end,

            -- Not affected by TNT
            on_blast = function(pos) end,

            on_construct = function(pos)

                local meta = core.get_meta(pos)
                meta:set_string("formspec", formspec)
                meta:set_string("infotext", S("Armour Stand"))
                meta:set_string("owner", "")

                local inv = meta:get_inventory()
                for _, bodypart in pairs(bodypart_list) do
                    inv:set_size("armour_" .. bodypart, 1)
                end

            end,

            on_metadata_inventory_put = function(pos)
                update_entity(pos)
            end,

            on_metadata_inventory_take = function(pos)
                update_entity(pos)
            end,
        }
    )
    unilib.register_craft({
        -- From 3d_armor_stand:locked_armor_stand
        output = "unilib:misc_stand_armour_locked",
        recipe = {
            {"unilib:misc_stand_armour", c_ingot},
        },
    })

    unilib.register_node(
        -- From 3d_armor_stand:shared_armor_stand
        "unilib:misc_stand_armour_shared",
        "3d_armor_stand:shared_armor_stand",
        mode,
        {
            description = S("Shared Armour Stand"),
            tiles = {"unilib_misc_stand_armour_shared.png"},
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.global.sound_table.wood,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_misc_stand_armour.obj",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.25, -0.4375, -0.25, 0.25, 1.4, 0.25},
                    {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
                },
            },
            use_texture_alpha = "clip",
            walkable = false,

            after_destruct = function(pos)

                update_entity(pos)
                remove_hidden_node(pos)

            end,

            after_place_node = function(pos, placer)

                core.add_entity(pos, "unilib:entity_misc_stand_armour")

                local meta = core.get_meta(pos)
                meta:set_string("infotext", S("Shared Armour Stand"))
                add_hidden_node(pos, placer)

            end,

            allow_metadata_inventory_move = function(pos)
                return 0
            end,

            allow_metadata_inventory_put = function(pos, listname, index, stack, player)

                if not core.is_player(player) or
                        core.is_protected(pos, player:get_player_name()) then
                    return 0
                end

                local def_table = stack:get_definition() or {}
                local group_table = def_table.groups or {}
                if group_table[listname] then
                    return 1
                else
                    return 0
                end

            end,

            allow_metadata_inventory_take = function(pos, listname, index, stack, player)

                if not core.is_player(player) or
                        core.is_protected(pos, player:get_player_name()) then
                    return 0
                end

                return stack:get_count()

            end,

            can_dig = function(pos, player)

                local meta = core.get_meta(pos)
                local inv = meta:get_inventory()
                for _, bodypart in pairs(bodypart_list) do

                    if not inv:is_empty("armour_" .. bodypart) then
                        return false
                    end

                end

                return true

            end,

            -- Not affected by TNT
            on_blast = function(pos) end,

            on_construct = function(pos)

                local meta = core.get_meta(pos)
                meta:set_string("formspec", formspec)
                meta:set_string("infotext", S("Shared Armour Stand"))

                local inv = meta:get_inventory()
                for _, bodypart in pairs(bodypart_list) do
                    inv:set_size("armour_" .. bodypart, 1)
                end

            end,

            on_metadata_inventory_put = function(pos)
                update_entity(pos)
            end,

            on_metadata_inventory_take = function(pos)
                update_entity(pos)
            end,
        }
    )
    unilib.register_craft({
        -- From 3d_armor_stand:shared_armor_stand
        output = "unilib:misc_stand_armour_shared",
        recipe = {
            {"unilib:misc_stand_armour", "unilib:metal_copper_ingot"},
        },
    })

    unilib.register_entity("unilib:entity_misc_stand_armour", {
        -- From 3d_armor_stand:armor_entity
        initial_properties = {
            collisionbox = {0, 0, 0, 0, 0, 0},
            mesh = "unilib_misc_stand_armour_entity.obj",
            physical = true,
            textures = {"blank.png"},
            visual = "mesh",
            visual_size = {x = 1, y = 1},
        },

        _pos = nil,

        on_activate = function(self)

            local pos = self.object:get_pos()
            if pos then

                self._pos = vector.round(pos)
                update_entity(pos)

            end

        end,

        on_blast = function(self, damage)

            local empty_list = {}
            local node = core.get_node(self._pos)
            if node.name == "unilib:misc_stand_armour" then

                drop_armour(self._pos)
                self.object:remove()

            end

            return false, false, empty_list

        end,
    })

    unilib.register_abm({
        label = "Handle armour stands [misc_stand_armour]",
        nodenames = {
            "unilib:misc_stand_armour_locked",
            "unilib:misc_stand_armour_shared",
            "unilib:misc_stand_armour",
        },

        chance = 1,
        interval = 15,

        action = function(pos, node, active_object_count, active_object_count_wider)

            local num = #core.get_objects_inside_radius(pos, 0.5)
            if num > 0 then
                return
            end

            update_entity(pos)

        end
    })

end
