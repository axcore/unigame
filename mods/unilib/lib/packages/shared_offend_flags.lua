---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    offend_flags
-- Code:    LGPL-3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_offend_flags = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.offend_flags.add_mode

---------------------------------------------------------------------------------------------------
-- Local variables (from the original mod)
---------------------------------------------------------------------------------------------------

local wind_noise = PerlinNoise(204, 1, 0, 500)

-- Check whether the new .get_2d() Perlin function is available, otherwise use .get2d(). Needed to
--      suppress deprecation warning in newer Minetest versions
local old_get2d = true
if wind_noise.get_2d then
    old_get2d = false
end

-- List of active flags, used to handle the animations
local active_flag_table = {}

local pi = math.pi
local rad_180 = pi
local rad_90 = pi / 2

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_offend_flags.default_flag_type = "blank"
unilib.pkg.shared_offend_flags.default_flag_description = S("Blank Flag")
unilib.pkg.shared_offend_flags.default_flag_img = "unilib_flag_blank.png"

unilib.pkg.shared_offend_flags.pole_name = "unilib:flag_mast_upper"

unilib.pkg.shared_offend_flags.flag_type_list = {unilib.pkg.shared_offend_flags.default_flag_type}
unilib.pkg.shared_offend_flags.description_table = {
    blank = unilib.pkg.shared_offend_flags.default_flag_description,
}
unilib.pkg.shared_offend_flags.img_table = {
    blank = unilib.pkg.shared_offend_flags.default_flag_img,
}

unilib.pkg.shared_offend_flags.flag_count = 1

-- Used by the "machine_printer_flag" package
unilib.pkg.shared_offend_flags.cartridge_max = 60000
unilib.pkg.shared_offend_flags.cartridge_min = 1000

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function flag_exists(flag_type)

    -- (Preserve function from original code, even though we could just check the table directly)

    return unilib.pkg.shared_offend_flags.description_table[flag_type] ~= nil

end

local function is_upper_mast(full_name)

    return string.sub(full_name, 1, string.len(unilib.pkg.shared_offend_flags.pole_name)) ==
            unilib.pkg.shared_offend_flags.pole_name

end

local function delete_entity_if_orphan(self)

    -- Delete entity if there is no flag mast node

    local pos = self.object:get_pos()
    local node = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
    if not is_upper_mast(node.name) and node.name ~= "ignore" then

        self.object:remove()
        return true

    end

    return false

end

local function get_flag_pos(pos, param2)

    local facedir_to_pos = {
        [0] = {x = 0, y = 0.6, z = -0.1},
        [1] = {x = -0.1, y = 0.6, z = 0},
        [2] = {x = 0, y = 0.6, z = 0.1},
        [3] = {x = 0.1, y = 0.6, z = 0},
    }

    return vector.add(pos, vector.multiply(facedir_to_pos[param2], 1))

end

local function rotate_flag_by_param2(flag, param2)

    local facedir_to_yaw = {
        [0] = rad_90,
        [1] = 0,
        [2] = -rad_90,
        [3] = rad_180,
    }

    local baseyaw = facedir_to_yaw[param2]
    if not baseyaw then
        return
    end

    flag:set_yaw(baseyaw - rad_180)

end

local function spawn_flag(pos, flag_type)

    local node_idx = minetest.hash_node_position(pos)
    local param2 = minetest.get_node(pos).param2

    local flag_pos = get_flag_pos(pos, param2)
    local obj = minetest.add_entity(flag_pos, "unilib:entity_flag_waving")
    if not obj or not obj:get_luaentity() then
        return
    end

    obj:get_luaentity().flag_type = flag_type
    obj:get_luaentity():reset_texture(flag_type)
    obj:get_luaentity().node_idx = node_idx
    rotate_flag_by_param2(obj, param2)

    active_flag_table[node_idx] = obj

    return obj

end

local function spawn_flag_and_set_texture(pos, flag_type)

    local flag = spawn_flag(pos, flag_type)
    if flag and flag:get_luaentity() then

        local meta = minetest.get_meta(pos)
        if flag_type == "" then
            flag_type = meta:get_string("flag_type")
        end

        if flag_type == "" then

            flag_type = unilib.pkg.shared_offend_flags.default_flag_type
            meta:set_string("flag_type", flag_type)

        end

        flag:get_luaentity():reset_texture(flag_type)

    end

    return flag

end

---------------------------------------------------------------------------------------------------
-- Shared functions (API for other packages)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_offend_flags.add_flag(flag_type)

    if flag_exists(flag_type) then
        return false
    end

    table.insert(unilib.pkg.shared_offend_flags.flag_type_list, flag_type)
    return true

end

function unilib.pkg.shared_offend_flags.get_flags()

    return table.copy(unilib.pkg.shared_offend_flags.flag_type_list)

end

function unilib.pkg.shared_offend_flags.set_flag_at(pos, flag_type)

    local node = minetest.get_node(pos)
    if not is_upper_mast(node.name) then
        return false
    end

    if not flag_exists(flag_type) then
        return false
    end

    local node_idx = minetest.hash_node_position(pos)
    local aflag = active_flag_table[node_idx]
    local flag
    if aflag then
        flag = aflag:get_luaentity()
    end

    if flag then

        local set_flag_type = flag:reset_texture(flag_type)
        if set_flag_type == flag_type then

            local meta = minetest.get_meta(pos)
            meta:set_string("flag_type", flag_type)
            return true

        end

    end

    return false

end

function unilib.pkg.shared_offend_flags.get_flag_at(pos)

    local node = minetest.get_node(pos)
    if not flag_exists(flag_type) then
        return nil
    end

    local meta = minetest.get_meta(pos)
    local flag_type = meta:get_string("flag_type")
    if flag_type ~= "" then
        return flag_type
    end

end

function unilib.pkg.shared_offend_flags.get_wind(pos)

    -- Returns the wind strength at pos

    -- The default wind function ignores pos
    -- Returns a wind between ca. 0 and 55
    local coords = {x = os.time() % 65535, y = 0}
    local cur_wind
    if old_get2d then
        cur_wind = wind_noise:get2d(coords)
    else
        cur_wind = wind_noise:get_2d(coords)
    end

    cur_wind = cur_wind * 30 + 30
    return cur_wind

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_offend_flags.init()

    return {
        description = "Shared functions for animated flags (from offend_flags)",
        notes = "Flags can be created using a flag printer, a blank flag and some ink" ..
                " cartridges. Although unilib provides a set of original flags, any texture" ..
                " can be used as the basis of a flag. See the comments in the package",
        depends = "metal_steel",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.shared_offend_flags.exec()

    -- Read a list of flags from the .csv in the "offend_flags" remix
    --
    -- Any textures can be used as the basis of a flag; just add a line to the .csv
    -- Each line in the .csv consists of three components:
    --      - A short, unique flag name, e.g. "uk". Any name containing only alphanumeric/underline
    --          characters is acceptable, but the name "blank" is reserved
    --      - The name of the texture. If the texture's file name is in a standard format (e.g.
    --              "unilib_flag_uk.png"), then this value can be omitted. Otherwise, specify the
    --              whole texture. Any texture can be used as the basis of a flag, e.g.
    --              "unilib_stone_ordinary.png"
    --      - A capitalised description, e.g. "United Kingdom". If it is omitted, a generic
    --              description is used

    local csv_path = unilib.path_mod .. "/csv/remixes/offend_flags/flags.csv"
    if unilib.is_file(csv_path) then

        local check_table = {}

        for i, csv_table in ipairs(unilib.read_csv(csv_path)) do

            -- "key" is expected to contain at least one letter, "value" at least one digit
            local flag_type, flag_img, flag_description = unpack(csv_table)
            if flag_type ~= nil then

                if string.find(flag_type, "^%s*$") or
                        string.find(flag_type, "[^%w_]+") or
                        flag_type == "blank" then

                    unilib.show_warning(
                        "shared_offend_flags package: Invalid flag name",
                        csv_path,
                        i
                    )

                elseif check_table[flag_type] ~= nil then

                    unilib.show_warning(
                        "shared_offend_flags package: Duplicate flag name",
                        csv_path,
                        i
                    )

                else

                    if flag_img == nil or flag_img == "" then
                        flag_img = "unilib_flag_" .. flag_type .. ".png"
                    end

                    if flag_description == nil or flag_description == "" then

                        flag_description = S("Flag Pole")

                    else

                        flag_description =
                                unilib.brackets(S("Flag Pole with Flag"), S(flag_description))

                    end

                    table.insert(unilib.pkg.shared_offend_flags.flag_type_list, flag_type)
                    unilib.pkg.shared_offend_flags.description_table[flag_type] = flag_description
                    unilib.pkg.shared_offend_flags.img_table[flag_type] = flag_img
                    check_table[flag_type] = true

                    unilib.pkg.shared_offend_flags.flag_count =
                            unilib.pkg.shared_offend_flags.flag_count + 1

                end

            end

        end

    end

    -- Register entities

    unilib.register_entity("unilib:entity_flag_waving", {
        -- From offend_flags:waving_flag
        initial_properties = {
            backface_culling = false,
            collisionbox = {0, 0, 0, 0, 0, 0},
            mesh = "unilib_flag_waving.b3d",
            physical = false,
            pointable = false,
            textures = {unilib.pkg.shared_offend_flags.default_flag_img},
            use_texture_alpha = false,
            visual = "mesh",
            visual_size = {x = 8.5, y = 8.5},
        },

        on_activate = function(self, staticdata, dtime)

            if delete_entity_if_orphan(self) then
                return
            end

            -- Init stuff
            self:reset_animation(true)
            self.object:set_armor_groups({immortal = 1})

            if staticdata ~= "" then

                local data = minetest.deserialize(staticdata)
                if data.flag_type then
                    self.flag_type = data.flag_type
                else
                    self.flag_type = unilib.pkg.shared_offend_flags.default_flag_type
                end

                self.node_idx = data.node_idx

                if not self.flag_type or not self.node_idx then

                    self.object:remove()
                    return

                end

                self:reset_texture(self.flag_type)

                active_flag_table[self.node_idx] = self.object

            else

                self.flag_type = unilib.pkg.shared_offend_flags.default_flag_type

            end

            -- Delete entity if there is already one for this pos
            local objs = minetest.get_objects_inside_radius(self.object:get_pos(), 0.5)
            for o = 1, #objs do

                local obj = objs[o]
                local lua = obj:get_luaentity()
                if lua and self ~= lua and lua.name == "unilib:entity_flag_waving" then

                    if lua.node_idx == self.node_idx then

                        self.object:remove()
                        return

                    end

                end

            end

        end,

        on_deactivate = function(self)

            if self.sound_id then
                minetest.sound_stop(self.sound_id)
            end

        end,

        on_step = function(self, dtime)

            if self.anim_timer == nil then
                self.anim_timer = 0
            else
                self.anim_timer = self.anim_timer - dtime
            end

            if self.anim_timer <= 0 then

                if delete_entity_if_orphan(self) then
                    return
                end

                self:reset_animation()

            end

        end,

        reset_animation = function(self, initial)

            local pos = self.object:get_pos()
            local cur_wind = unilib.pkg.shared_offend_flags.get_wind(pos)

            local anim_speed
            local wave_sound

            if cur_wind < 10 then

                anim_speed = 10 -- 2 cycles
                wave_sound = "unilib_flag_flap_1"

            elseif cur_wind < 20 then

                anim_speed = 20  -- 4 cycles
                wave_sound = "unilib_flag_flap_1"

            elseif cur_wind < 40 then

                anim_speed = 40  -- 8 cycles
                wave_sound = "unilib_flag_flap_2"

            else

                anim_speed = 80  -- 16 cycles
                wave_sound = "unilib_flag_flap_3"

            end

            -- Slight anim_speed change to desyncronize flag waving
            anim_speed = anim_speed + math.random(0, 200) * 0.01

            if self.object then

                if initial or (not self.object.set_animation_frame_speed) then
                    self.object:set_animation({x = 1, y = 575}, anim_speed, 0, true)
                else
                    self.object:set_animation_frame_speed(anim_speed)
                end

            end

            if not self.sound_id then

                self.sound_id = minetest.sound_play(
                    wave_sound,
                    {object = self.object, gain = 1.0, loop = true}
                )

            end

            -- Time to reset animation
            self.anim_timer = 115 + math.random(-10, 10)

        end,

        reset_texture = function(self, flag_type, nextprev)

            self.flag_type = flag_type
            local texture = unilib.pkg.shared_offend_flags.img_table[self.flag_type]
            self.object:set_properties({textures = {texture}})
            return self.flag_type

        end,

        get_staticdata = function(self)

            return minetest.serialize({
                node_idx = self.node_idx,
                flag_type = self.flag_type,
            })

        end,
    })

    -- Register nodes

    unilib.register_node("unilib:flag_mast_lower", "offend_flags:lower_mast", mode, {
        -- From offend_flags:lower_mast
        description = S("Flag Pole"),
        tiles = {"unilib_flag_metal.png", "unilib_flag_metal.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.metal,

        collision_box = {
            type = "fixed",
            fixed = {
                {-3/32, -1/2, -3/32, 3/32, 1/2, 3/32},
            },
        },
        drawtype = "mesh",
        mesh = "unilib_flag_mast_lower.obj",
        inventory_image = "unilib_flag_pole_bottom_inv.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {{-3/32, -1/2, -3/32, 3/32, 1/2, 3/32}},
        },
        wield_image = "unilib_flag_pole_bottom_inv.png",

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil and
                    mode == unilib.pkg.shared_screwdriver.rotate_axis  then
                return false
            end

        end,
    })
    unilib.register_craft({
        -- From offend_flags:lower_mast
        output = "unilib:flag_mast_lower 6",
        recipe = {
            {"unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot"},
        },
    })

    for _, flag_type in pairs(unilib.pkg.shared_offend_flags.flag_type_list) do

        local img
        if flag_type == "blank" then
            img = "unilib_flag_pole_top_inv.png"
        else
            img = unilib.pkg.shared_offend_flags.img_table[flag_type]
        end

        unilib.register_node(
            -- From offend_flags:upper_mast_XXX
            unilib.pkg.shared_offend_flags.pole_name .. "_" .. flag_type,
            nil,
            mode,
            {
                description = unilib.pkg.shared_offend_flags.description_table[flag_type],
                tiles = {"unilib_flag_metal.png", "unilib_flag_metal.png"},
                groups = {cracky = 2},
                sounds = unilib.sound_table.metal,

                drawtype = "mesh",
                inventory_image = img,
                is_ground_content = false,
                mesh = "unilib_flag_mast_upper.obj",
                node_placement_prediction = "",
                paramtype = "light",
                paramtype2 = "facedir",
                collision_box = {
                    type = "fixed",
                    fixed = {{-3/32, -1/2, -3/32, 3/32, 1/2, 3/32}},
                },
                selection_box = {
                    type = "fixed",
                    fixed = {{-3/32, -1/2, -3/32, 3/32, 27/16, 3/32}},
                },
                wield_image = img,

                on_place = function(itemstack, placer, pointed_thing)

                    if not pointed_thing.type == "node" then
                        return itemstack
                    end

                    local node = minetest.get_node(pointed_thing.under)
                    local pdef = minetest.registered_nodes[node.name]
                    if pdef and
                            pdef.on_rightclick and
                            not placer:get_player_control().sneak then

                        return pdef.on_rightclick(
                            pointed_thing.under, node, placer, itemstack, pointed_thing
                        )

                    end

                    local pos
                    if pdef and pdef.buildable_to then

                        pos = pointed_thing.under

                    else

                        pos = pointed_thing.above
                        node = minetest.get_node(pos)
                        pdef = minetest.registered_nodes[node.name]
                        if not pdef or not pdef.buildable_to then
                            return itemstack
                        end

                    end

                    local above1 = {x = pos.x, y = pos.y + 1, z = pos.z}
                    local above2 = {x = pos.x, y = pos.y + 2, z = pos.z}
                    local anode1 = minetest.get_node_or_nil(above1)
                    local anode2 = minetest.get_node_or_nil(above2)
                    local adef1 = anode1 and minetest.registered_nodes[anode1.name]
                    local adef2 = anode2 and minetest.registered_nodes[anode2.name]

                    -- Don't build if upper nodes are blocked, unless it's a hidden node
                    if not adef1 or (
                        not adef1.buildable_to and
                        anode1.name ~= "unilib:flag_mast_hidden_1"
                    ) then
                        return itemstack
                    end

                    if not adef2 or (
                        not adef2.buildable_to and
                        anode2.name ~= "unilib:flag_mast_hidden_2"
                    ) then
                        return itemstack
                    end

                    local pn = placer:get_player_name()
                    if minetest.is_protected(pos, pn) then

                        minetest.record_protection_violation(pos, pn)
                        return itemstack

                    elseif minetest.is_protected(above1, pn) then

                        minetest.record_protection_violation(above1, pn)
                        return itemstack

                    elseif minetest.is_protected(above2, pn) then

                        minetest.record_protection_violation(above2, pn)
                        return itemstack

                    end

                    local yaw = placer:get_look_horizontal()
                    local dir = minetest.yaw_to_dir(yaw)
                    local param2 = (minetest.dir_to_facedir(dir) + 3) % 4
                    minetest.set_node(pos, {name = itemstack:get_name(), param2 = param2})
                    minetest.set_node(above1, {name = "unilib:flag_mast_hidden_1"})
                    minetest.set_node(above2, {name = "unilib:flag_mast_hidden_2"})

                    if not unilib.is_creative(pn) then
                        itemstack:take_item()
                    end

                    local def = minetest.registered_nodes[itemstack:get_name()]
                    if def and def.sounds then
                        minetest.sound_play(def.sounds.place, {pos = pos}, true)
                    end

                    return itemstack

                end,

                on_construct = function(pos)

                    local flag = spawn_flag(pos, flag_type)
                    if flag and flag:get_luaentity() then

                        local meta = minetest.get_meta(pos)
                        meta:set_string("flag_type", flag:get_luaentity().flag_type)

                    end

                end,

                on_destruct = function(pos)

                    local node_idx = minetest.hash_node_position(pos)
                    if active_flag_table[node_idx] then
                        active_flag_table[node_idx]:remove()
                    end

                end,

                after_destruct = function(pos)

                    local above1 = {x = pos.x, y = pos.y + 1, z = pos.z}
                    local above2 = {x = pos.x, y = pos.y + 2, z = pos.z}
                    if minetest.get_node(above1).name == "unilib:flag_mast_hidden_1" then
                        minetest.remove_node(above1)
                    end
                    if minetest.get_node(above2).name == "unilib:flag_mast_hidden_2" then
                        minetest.remove_node(above2)
                    end

                end,

                on_rotate = function(pos, node, user, mode, new_param2)

                    if unilib.pkg_executed_table["shared_screwdriver"] ~= nil and
                            mode == unilib.pkg.shared_screwdriver.rotate_axis then
                        return false
                    end

                    local node_idx = minetest.hash_node_position(pos)
                    local aflag = active_flag_table[node_idx]
                    if aflag then

                        local lua = aflag:get_luaentity()
                        if not lua then

                            aflag = spawn_flag_and_set_texture(pos, flag_type)
                            if aflag then

                                lua = aflag:get_luaentity()
                                if not lua then
                                    return
                                end

                             end
                        end

                        local flag_pos_idx = lua.node_idx
                        local flag_pos = minetest.get_position_from_hash(flag_pos_idx)
                        flag_pos = get_flag_pos(flag_pos, new_param2)
                        rotate_flag_by_param2(aflag, new_param2)
                        aflag:set_pos(flag_pos)

                    end

                end,
            }
        )
        if flag_type == unilib.pkg.shared_offend_flags.default_flag_type then

            -- (The printer uses the blank flag to print other types of flag)
            unilib.register_craft({
                -- From offend_flags:upper_mast_blank
                output = unilib.pkg.shared_offend_flags.pole_name .. "_" .. flag_type,
                recipe = {
                    {"unilib:flag_mast_lower", "group:wool", "group:wool"},
                    {"unilib:flag_mast_lower", "group:wool", "group:wool"},
                },
            })

        end

    end

    -- Register hidden nodes
    -- Add 2 hidden upper mast segments to block all the nodes the upper mast occupies. This is also
    --      needed to prevent collision issues with over-high nodes
    -- These nodes will be automatically added/removed when the upper mast is constructed or
    --      destroyed

    unilib.register_node("unilib:flag_mast_hidden_1", "offend_flags:hidden_mast_1", mode, {
        -- From offend_flags:hidden_mast_1
        -- (no description)
        -- (no tiles)
        groups = {not_in_creative_inventory = 1},
        sounds = unilib.sound_table.metal,

        collision_box = {
            type = "fixed",
            fixed = {
                {-3/32, -1/2, -3/32, 3/32, 1/5, 3/32},
            },
        },
        diggable = false,
        drawtype = "airlike",
        drop = "",
        floodable = false,
        inventory_image = "unilib_flag_pole_hidden1_inv.png",
        is_ground_content = false,
        paramtype = "light",
        pointable = false,
        sunlight_propagates = true,
        wield_image = "unilib_flag_pole_hidden1_inv.png",

        can_dig = function() return false end,

        on_blast = function() end,
    })

    unilib.register_node("unilib:flag_mast_hidden_2", "offend_flags:hidden_mast_2", mode, {
        -- From offend_flags:hidden_mast_2
        -- (no description)
        -- (no tiles)
        groups = {not_in_creative_inventory = 1},
        sounds = unilib.sound_table.metal,

        collision_box = {
            type = "fixed",
            fixed = {
                {-3/32, -1/2, -3/32, 3/32, -5/16, 3/32},
            },
        },
        diggable = false,
        drawtype = "airlike",
        drop = "",
        floodable = false,
        inventory_image = "unilib_flag_pole_hidden2_inv.png",
        is_ground_content = false,
        paramtype = "light",
        pointable = false,
        sunlight_propagates = true,
        wield_image = "unilib_flag_pole_hidden2_inv.png",

        can_dig = function() return false end,

        on_blast = function() end,
    })

    -- Register LBMs

    unilib.register_lbm({
        label = "Respawn flags [shared_offend_flags]",
        name = "unilib:lbm_shared_offend_flags",
        nodenames = {unilib.pkg.shared_offend_flags.pole_name},

        run_at_every_load = true,

        action = function(pos, node)

            local node_idx = minetest.hash_node_position(pos)
            local aflag = active_flag_table[node_idx]
            if aflag then
                return
            end

            spawn_flag_and_set_texture(pos)

        end
    })

end
