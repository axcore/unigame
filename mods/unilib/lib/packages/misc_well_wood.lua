---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_well_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

-- How many seconds it takes to fill a bucket
local fill_time = 10
-- Textures used in the formspec, set in the .post() function, once we know how many types of
--      bucket are available
local empty_bucket_name = ""
local full_bucket_name = ""

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_empty_bucket(full_name)

    -- Original to unilib
    -- "full_name" is something like "unilib:bucket_steel_empty"
    -- We check that against unilib's list of registered buckets and, if a match is found, return
    --      the bucket type (a key in unilib.generic_bucket_table, in this case "bucket_steel")
    -- If no match is found, we return nil

    for bucket_type, _ in pairs(unilib.generic_bucket_table) do

        if "unilib:" .. bucket_type .. "_empty" == full_name then
            return bucket_type
        end

    end

    return nil

end

local function is_water_bucket(full_name)

    -- Original to unilib
    -- "full_name" is something like "unilib:bucket_steel_with_water_ordinary" or
    --      "unilib:bucket_steel_with_water_river"
    -- We check that against unilib's list of registered buckets, looking for a bucket filled with
    --      either ordinary or river water (but not any other liquid, at the moment)
    -- Returns true or false

    for bucket_type, _ in pairs(unilib.generic_bucket_table) do

        if "unilib:" .. bucket_type .. "_water_ordinary" == full_name or
                "unilib:" .. bucket_type .. "_water_river" == full_name then
            return true
        else
            return false
        end

    end

end

local function fill_bucket(pos)

    -- Adapted from cottages/nodes_water.lua

    if not(pos) then
        return
    end

    local meta = minetest.get_meta(pos)
    local bucket = meta:get_string("bucket")
    if not(bucket) then
        return
    end

    local bucket_type = is_empty_bucket(bucket)
    if not(bucket_type) then
        return
    end

    -- Abort if the water has not been running long enough (the player may have removed a bucket
    --      before it was full)
    start = meta:get_string("fillstarttime")
    if ((minetest.get_us_time() / 1000000) - tonumber(start)) < (fill_time - 2) then
        return
    end

    -- The bucket has been filled
    local filled_name = "unilib:" .. bucket_type .. "_with_water_river"
    meta:set_string("bucket", filled_name)

    -- Change the texture of the bucket entity to that of one filled with river water
    local objs = nil
    objs = minetest.get_objects_inside_radius(pos, 0.5)
    if objs then

        for _, obj in ipairs(objs) do

            if obj and
                    obj:get_luaentity() and
                    obj:get_luaentity().name == "unilib:entity_misc_well_wood" then

                obj:set_properties({textures = {filled_name}})
                obj:get_luaentity().nodename = filled_name
                obj:get_luaentity().texture = filled_name

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_well_wood.init()

    return {
        description = "Wooden well",
        notes = "Punch the well with any empty bucket to fill it with river water (after waiting" ..
                " 10 seconds). Spare buckets can be stored by right-clicking the well",
        depends = {"item_stick_ordinary", "tree_apple"},
    }

end

function unilib.pkg.misc_well_wood.exec()

    -- (Contains .nodename and .texture fields)
    local tmp_def_table = {}

    unilib.register_entity("unilib:entity_misc_well_wood", {
        -- From cottages:bucket_entity
        collisionbox = {0, 0, 0, 0, 0, 0},
        hp_max = 1,
        physical = false,
        textures = {"air"},
        visual = "wielditem",
        visual_size = {x = 0.33, y = 0.33},

        on_activate = function(self, staticdata)

            if tmp_def_table.nodename ~= nil and tmp_def_table.texture ~= nil then

                self.nodename = tmp_def_table.nodename
                tmp_def_table.nodename = nil
                self.texture = tmp_def_table.texture
                tmp_def_table.texture = nil

            else

                if staticdata ~= nil and staticdata ~= "" then

                    local data = staticdata:split(";")
                    if data and data[1] and data[2] then

                        self.nodename = data[1]
                        self.texture = data[2]

                    end
                end

            end

            if self.texture ~= nil then
                self.object:set_properties({textures = {self.texture}})
            end

            self.object:set_properties({automatic_rotate = 1})
            if self.texture ~= nil and self.nodename ~= nil then

                local entity_pos = vector.round(self.object:get_pos())
                local objs = minetest.get_objects_inside_radius(entity_pos, 0.5)

                for _, obj in ipairs(objs) do

                    if obj ~= self.object and
                            obj:get_luaentity() and
                            obj:get_luaentity().name == "unilib:entity_misc_well_wood" and
                            obj:get_luaentity().nodename == self.nodename and
                            obj:get_properties() and
                            obj:get_properties().textures and
                            obj:get_properties().textures[1] == self.texture then

                        -- (Removed, as it looks like a debug message)
                        --[[
                        unilib.log("action","[cottages] Removing extra " ..
                            self.texture .. " found in " .. self.nodename .. " at " ..
                            minetest.pos_to_string(entity_pos))
                        ]]--
                        self.object:remove()
                        break

                    end

                end

            end

        end,

        get_staticdata = function(self)

            if self.nodename ~= nil and self.texture ~= nil then
                return self.nodename .. ";" .. self.texture
            end

            return ""

        end,
    })

    unilib.register_node("unilib:misc_well_wood", "cottages:water_gen", mode, {
        -- From cottages:water_gen
        description = S("Wooden Well"),
        tiles = {
            "unilib_tree_apple_trunk_top.png",
            "unilib_tree_apple_trunk.png^[transformR90",
            "unilib_tree_apple_trunk.png^[transformR90",
        },
        groups = {choppy = 2, cracky = 1, flammable = 2, tree = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                -- Floor of water bassin
                {-0.5, -0.5+(3/16), -0.5, 0.5, -0.5+(4/16), 0.5},
                -- Walls
                {-0.5, -0.5+(3/16), -0.5, 0.5, (4/16), -0.5+(2/16)},
                {-0.5, -0.5+(3/16), -0.5, -0.5+(2/16), (4/16), 0.5},
                { 0.5, -0.5+(3/16), 0.5, 0.5-(2/16), (4/16), -0.5},
                { 0.5, -0.5+(3/16), 0.5, -0.5+(2/16), (4/16), 0.5-(2/16)},
                -- Feet
                {-0.5+(3/16), -0.5, -0.5+(3/16), -0.5+(6/16), -0.5+(3/16), 0.5-(3/16)},
                { 0.5-(3/16), -0.5, -0.5+(3/16), 0.5-(6/16), -0.5+(3/16), 0.5-(3/16)},
                -- Real pump
                { 0.5-(4/16), -0.5, -(2/16), 0.5, 0.5+(4/16), (2/16)},
                -- Water pipe inside wooden stem
                { 0.5-(8/16), 0.5+(1/16), -(1/16), 0.5, 0.5+(3/16), (1/16)},
                -- Where the water comes out
                { 0.5-(15/32), 0.5, -(1/32), 0.5-(12/32), 0.5+(1/16), (1/32)},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0.5+(4/16), 0.5}
        },

        after_place_node = function(pos, placer)

            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name() or "")
            meta:set_string(
                "infotext",
                unilib.brackets(
                    S("Wooden Well"),
                    S("public, owned by %s"):format(meta:get_string("owner"))
                )
            )

            -- No bucket loaded
            meta:set_string("bucket", "")
            meta:set_string("public", "public")

        end,

        -- (No inventory move allowed)
        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            return 0
        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            if not(stack) or not unilib.pkg.shared_cottages.player_can_use(meta, player) then
                return 0
            end

            local inv = meta:get_inventory()
            -- Only for empty buckets and water buckets
            local sname = stack:get_name()
            if not(is_empty_bucket(sname)) and not(is_water_bucket(sname)) then
                return 0
            end

            return stack:get_count()

        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            if not(unilib.pkg.shared_cottages.player_can_use(meta, player)) then
                return 0
            end

            return stack:get_count()

        end,

        can_dig = function(pos,player)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local bucket = meta:get_string("bucket")
            local start = meta:get_string("fillstarttime")
            return inv:is_empty("main") and
                    unilib.can_interact_with_node(player, pos) and
                    (not(bucket) or bucket == "") and
                    (
                        (
                            not(start) or
                            start == "" or
                            (minetest.get_us_time() / 1000000) - tonumber(start) >= (fill_time - 2)
                        )
                    )

        end,

        on_blast = function() end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            local spos = pos.x .. "," .. pos.y .. "," .. pos.z
            -- N.B. The formspec provided by the cottages mod is untidy, so I have rearranged it
            --[[
            meta:set_string(
                "formspec",
                "size[8,9]" ..
                "label[3.0,0.0;Tree trunk well]" ..
                "label[1.5,0.7;Punch the well while wielding an empty bucket.]" ..
                "label[1.5,1.0;Your bucket will slowly be filled with river water.]" ..
                "label[1.5,1.3;Punch again to get the bucket back when it is full.]" ..
                "label[1.0,2.9;Internal bucket storage (passive storage only):]" ..
                "item_image[0.2,0.7;1.0,1.0;bucket:bucket_empty]" ..
                "item_image[0.2,1.7;1.0,1.0;bucket:bucket_river_water]" ..
                "label[1.5,1.9;Punch well with full water bucket in order to empty bucket.]" ..
                "button_exit[6.0,0.0;2,0.5;public;" .. S("Public?") .. "]" ..
                "list[nodemeta:" .. spos .. ";main;1,3.3;8,1;]" ..
                "list[current_player;main;0,4.85;8,1;]" ..
                "list[current_player;main;0,6.08;8,3;8]" ..
                "listring[nodemeta:" .. spos .. ";main]" ..
                "listring[current_player;main]"
            )
            ]]--
            meta:set_string(
                "formspec",
                "size[8,9]" ..
                "label[3.0,0.0;Wooden well]" ..
                "button_exit[6.0,0.0;2,0.5;public;" .. S("Public?") .. "]" ..
                "item_image[0.2,0.7;1.0,1.0;" .. empty_bucket_name .. "]" ..
                "label[1.5,0.7;" .. S("Punch the well with an empty bucket") .. "]" ..
                "label[1.5,1.0;" .. S("Your bucket will slowly fill with river water") .. "]" ..
                "label[1.5,1.3;" .. S("Punch again to get back a full bucket") .. "]" ..
                "item_image[0.2,1.7;1.0,1.0;" .. full_bucket_name .. "]" ..
                "label[1.5,1.9;" .. S("Fill the well by punching it with a water bucket") .. "]" ..
                "label[1.0,2.7;" .. S("Spare buckets can be stored here") .. ":]" ..
                "list[nodemeta:" .. spos .. ";main;1,3.3;8,1;]" ..
                "list[current_player;main;0,4.85;8,1;]" ..
                "list[current_player;main;0,6.08;8,3;8]" ..
                "listring[nodemeta:" .. spos .. ";main]" ..
                "listring[current_player;main]"
            )
            local inv = meta:get_inventory()
            inv:set_size("main", 6)
            meta:set_string("infotext", unilib.brackets(S("Wooden Well"), S("public")))

        end,

        -- Punch to place and retrieve bucket
        on_punch = function(pos, node, puncher, pointed_thing)

            if not(pos) or not(node) or not(puncher) then
                return
            end

            -- Only the owner can use the well
            local name = puncher:get_player_name()
            local meta = minetest.get_meta(pos)
            local owner = meta:get_string("owner")
            local public = meta:get_string("public")
            if name ~= owner and public ~= "public" then

                minetest.chat_send_player(
                    name,
                    S("This well is owned by %s. You can't use it!"):format(owner)
                )

                return

            end

            -- We will either add or take from the player's inventory
            local pinv = puncher:get_inventory()

            -- Is the well working on something? (either an empty or full bucket)
            local bucket = meta:get_string("bucket")

            -- There is a bucket loaded - either empty or full
            if bucket and bucket ~= "" and not(is_empty_bucket(bucket)) then

                if not(pinv:room_for_item("main", bucket)) then

                    minetest.chat_send_player(
                        puncher:get_player_name(),
                        S("Sorry, there is no room for the bucket because your inventory is full")
                    )

                    return

                end

            elseif bucket and is_empty_bucket(bucket) then

                minetest.chat_send_player(
                    puncher:get_player_name(),
                    S("Please wait until your bucket has been filled")
                )

                -- Do not give the empty bucket back immediately
                return

            end

            -- Remove the old entity (either a bucket will be placed now or a bucket taken)
            local objs = nil
            objs = minetest.get_objects_inside_radius(pos, 0.5)
            if objs then

                for _, obj in ipairs(objs) do

                    if obj and
                            obj:get_luaentity() and
                            obj:get_luaentity().name == "unilib:entity_misc_well_wood" then
                        obj:remove()
                    end

                end

            end

            -- The player gets the bucket (either empty or full) into their inventory
            if bucket and bucket ~= "" then

                pinv:add_item("main", bucket)
                meta:set_string("bucket", "")
                -- We are finished
                return

            end

            -- Punching with an empty bucket will put that bucket into the well (as an entity) and
            --      will slowly fill it
            local wielded = puncher:get_wielded_item()
            local bucket_name = nil
            if wielded and wielded:get_name() then

                bucket_name = wielded:get_name()
                if is_empty_bucket(bucket_name) then

                    -- Remember that a bucket is loaded
                    meta:set_string("bucket", bucket_name)
                    -- Create the entity
                    tmp_def_table.nodename = bucket_name
                    tmp_def_table.texture = bucket_name
                    local e = minetest.add_entity(
                        {x = pos.x, y = pos.y + (4/16), z = pos.z},
                        "unilib:entity_misc_well_wood"
                    )

                    -- Fill the bucket with water
                    minetest.after(fill_time, fill_bucket, pos)
                    -- The bucket will only be filled if the water has been running for long enough
                    meta:set_string("fillstarttime", tostring(minetest.get_us_time() / 1000000))
                    -- Remove the bucket from the player's inventory
                    pinv:remove_item("main", bucket_name)

                    return

                end

            end

            -- Buckets can also be emptied here
            if wielded and
                    wielded:get_name() and
                    is_water_bucket(wielded:get_name()) and
                    pinv:room_for_item("main", bucket_name) then

                -- Remove the full bucket from the player's inventory
                pinv:remove_item("main", wielded:get_name())
                -- Add an empty bucket
                pinv:add_item("main", bucket_name)

                return

            end

            -- Otherwise, check if there is a bucket that can be retrieved
            meta:set_string("bucket", "")

        end,

        on_receive_fields = function(pos, formname, fields, sender)

            unilib.pkg.shared_cottages.switch_public(
                pos, formname, fields, sender, S("Wooden Well")
            )

        end,
    })
    for bucket_type, _ in pairs(unilib.generic_bucket_table) do

        local bucket_name = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- From cottages:water_gen
            output = "unilib:misc_well_wood",
            recipe = {
                {"unilib:item_stick_ordinary", "", ""},
                {"unilib:tree_apple_trunk", bucket_name, bucket_name},
                {"unilib:tree_apple_trunk", "unilib:tree_apple_trunk", "unilib:tree_apple_trunk"},
            }
        })

    end

end

function unilib.pkg.misc_well_wood.post()

    -- Set the images used in the formspec
    if unilib.pkg_executed_table["bucket_steel"] then

        -- Prefer the minetest_game bucket textures, if available
        empty_bucket_name = "unilib:bucket_steel_empty"
        full_bucket_name = "unilib:bucket_steel_with_water_river"

    else

        -- Use any available textures
        for bucket_type, _ in pairs(unilib.generic_bucket_table) do

            empty_bucket_name = "unilib:" .. bucket_type .. "_empty"
            full_bucket_name = "unilib:" .. bucket_type .. "_with_water_river"
            return

        end

    end

end
