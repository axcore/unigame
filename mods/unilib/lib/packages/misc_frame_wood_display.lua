---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_wood_display = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

local facedir = {
    [0] = {x = 0,  y = 0, z = 1},
          {x = 1,  y = 0, z = 0},
          {x = 0,  y = 0, z = -1},
          {x = -1, y = 0, z = 0},
}
local tmp = {}

---------------------------------------------------------------------------------------------------
-- Local functions (general)
---------------------------------------------------------------------------------------------------

local function remove_item(pos, node)

    local objs = core.get_objects_inside_radius(pos, 0.5)
    if not objs then
        return
    end

    for _, obj in pairs(objs) do

        local ent = obj:get_luaentity()
        if obj and ent and ent.name == "unilib:entity_misc_frame_wood_display" then

            obj:remove()
            break

        end

    end

end

local function drop_item(pos, node)

    local meta = core.get_meta(pos)
    local item = meta:get_string("item")
    if item == "" then
        return
    end

    core.add_item(pos, item)
    meta:set_string("item", "")
    remove_item(pos, node)

    local timer = core.get_node_timer(pos)
    timer:stop()

end

local function update_item(pos, node)

    remove_item(pos, node)
    local meta = core.get_meta(pos)
    local itemstring = meta:get_string("item")
    local posad = facedir[node.param2]
    if not posad or itemstring == "" then
        return
    end

    -- Some items (e.g. the door lever in the "device_lever" package) are not centred, so they are
    --      not displayed in the frame correctly
    -- Any such items should add a .display_offset property to correct this problem (for example,
    --      the actual display frame below uses it, in case a frame is displayed inside another
    --      frame)
    -- Code adapted from xdecor-libre
    local def_table = ItemStack(itemstring):get_definition()
    local added_offset = 0
    if def_table then

        -- (For compatibility, the original xdecor field, ._xdecor_itemframe_offset, is recognised
        --      too)
        if def_table.display_offset then
            added_offset = def_table.display_offset
        elseif def_table._xdecor_itemframe_offset then
            added_offset = def_table._xdecor_itemframe_offset
        end

        if added_offset ~= 0 then
            added_offset = math.min(6, math.max(-6, added_offset))
        end

    end

    pos = vector.add(pos, vector.multiply(posad, (6.5 + added_offset) / 16))
    tmp.nodename = node.name
    tmp.texture = ItemStack(itemstring):get_name()

    local entity = core.add_entity(pos, "unilib:entity_misc_frame_wood_display")
    local yaw = (math.pi * 2) - node.param2 * (math.pi / 2)
    entity:set_yaw(yaw)

    local timer = core.get_node_timer(pos)
    timer:start(15.0)

end

---------------------------------------------------------------------------------------------------
-- Local functions (callbacks)
---------------------------------------------------------------------------------------------------

local function after_place_node(pos, placer, itemstack)

    local meta = core.get_meta(pos)
    local name = placer:get_player_name()
    meta:set_string("owner", name)
    meta:set_string("infotext", S("@1 (owned by @2)", S("Wooden Display Frame"), name))

end

local function can_dig(pos, player)

    if not player then
        return
    end

    local meta = core.get_meta(pos)
    local player_name = player and player:get_player_name()
    local owner = meta:get_string("owner")
    local admin = core.check_player_privs(player_name, "protection_bypass")

    return admin or player_name == owner

end

local function update_infotext(meta, itemstring, owner)

    -- Original to unilib, because the xdecor code doesn't reliably restore the frame's infotext
    --      after the displayed item is removed

    -- itemstring and owner are optional arguments
    if itemstring == nil then
        itemstring = meta:get_string("item")
    end

    if owner == nil then
        owner = meta:get_string("owner")
    end

    if itemstring == "" then

        if owner == "" then
            meta:set_string("infotext", S("Wooden Display Frame"))
        else
            meta:set_string("infotext", S("@1 (owned by @2)", S("Wooden Display Frame"), owner))
        end

    else

        -- Display the displayed item's description, not its full_name, as in xdecor
--      meta:set_string("infotext", S("@1 (owned by @2)", itemstring, owner))
        local itemstack = ItemStack(itemstring)
        local msg = itemstack:get_short_description()
        if msg == "" then
            msg = itemstack:get_name()
        end

        if owner == "" then
            meta:set_string("infotext", msg)
        else
            meta:set_string("infotext", S("@1 (owned by @2)", msg, owner))
        end

    end

end

local function on_punch(pos, node, puncher)

    local meta = core.get_meta(pos)
    local player_name = puncher:get_player_name()
    local owner = meta:get_string("owner")
    local admin = core.check_player_privs(player_name, "protection_bypass")

    if admin and player_name == owner then

        drop_item(pos, node)
        update_infotext(meta)

    end

end

local function on_rightclick(pos, node, clicker, itemstack)

    local meta = core.get_meta(pos)
    local player_name = clicker:get_player_name()
    local owner = meta:get_string("owner")
    local admin = core.check_player_privs(player_name, "protection_bypass")

    if not admin and (player_name ~= owner or not itemstack) then
        return itemstack
    end

    drop_item(pos, node)
    local itemstring = itemstack:take_item():to_string()
    meta:set_string("item", itemstring)
    update_item(pos, node)
    update_infotext(meta, itemstring, owner)

    return itemstack

end

local function on_timer(pos)

    local node = core.get_node(pos)
    local meta = core.get_meta(pos)
    local num = #core.get_objects_inside_radius(pos, 0.5)

    if num == 0 and meta:get_string("item") ~= "" then
        update_item(pos, node)
    end

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_wood_display.init()

    return {
        description = "Wooden display frame",
        notes = "Right-click the frame with an item to display that item inside the frame, left-" ..
                "click to remove it. Some items that are not centred may not be displayed" ..
                " correctly; see the comments in the package for the necessary code" ..
                " adjustments",
        depends = "item_paper_ordinary",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.misc_frame_wood_display.exec()

    unilib.register_node("unilib:misc_frame_wood_display", "xdecor:itemframe", mode, {
        -- From xdecor:itemframe
        description = S("Wooden Display Frame"),
        tiles = {
            "unilib_misc_wood_simple.png",
            "unilib_misc_wood_simple.png",
            "unilib_misc_wood_simple.png",
            "unilib_misc_wood_simple.png",
            "unilib_misc_wood_simple.png",
            "unilib_misc_frame_wood_display.png"
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        -- N.B. display_offset added for compatibility with (other) display frames
        display_offset = -3.5,
        drawtype = "nodebox",
        inventory_image = "unilib_misc_frame_wood_display.png",
        -- N.B. is_ground_content = false not in original code; added to match other frames
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        after_destruct = remove_item,
        after_place_node = after_place_node,
        can_dig = can_dig,
        on_punch = on_punch,
        on_rightclick = on_rightclick,
        on_timer = on_timer,
    })
    unilib.register_craft({
        -- From xdecor:itemframe
        output = "unilib:misc_frame_wood_display",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {"group:stick", "unilib:item_paper_ordinary", "group:stick"},
            {"group:stick", "group:stick", "group:stick"},
        },
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:misc_frame_wood_display", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.register_entity("unilib:entity_misc_frame_wood_display", {
        -- From xdecor:f_item
        initial_properties = {
            collisionbox = {0},
            physical = false,
            textures = {"air"},
            visual = "wielditem",
            visual_size = {x = 0.33, y = 0.33},
        },

        get_staticdata = function(self)

            if self.nodename and self.texture then
                return self.nodename .. ";" .. self.texture
            end

            return ""

        end,

        on_activate = function(self, staticdata)

            local pos = self.object:get_pos()
            if core.get_node(pos).name ~= "unilib:misc_frame_wood_display" then
                self.object:remove()
            end

            if tmp.nodename and tmp.texture then

                self.nodename = tmp.nodename
                tmp.nodename = nil
                self.texture = tmp.texture
                tmp.texture = nil

            elseif staticdata and staticdata ~= "" then

                local data = staticdata:split(";")
                if data and data[1] and data[2] then

                    self.nodename = data[1]
                    self.texture = data[2]

                end

            end

            if self.texture then
                self.object:set_properties({textures = {self.texture}})
            end

        end,
    })

end
