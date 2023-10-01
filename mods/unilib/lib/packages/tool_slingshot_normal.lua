---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hook
-- Code:    LGPL-2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_slingshot_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.hook.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_use_slingshot(itemstack, user)

    local veloc = 15
    local pos = user:get_pos()
    local upos = {x = pos.x, y = pos.y + 2, z = pos.z}
    local dir = user:get_look_dir()
    local item = itemstack:to_table()

    local mode = minetest.deserialize(item["metadata"])
    if mode == nil then
        mode = 1
    else
        mode = mode.mode
    end

    local item = user:get_inventory():get_stack("main", user:get_wield_index() + mode):get_name()
    if item == "" then
        return itemstack
    end

    local e = minetest.add_item({x = pos.x, y = pos.y + 2, z = pos.z}, item)
    e:set_velocity({x = dir.x * veloc, y = dir.y * veloc, z = dir.z * veloc})
    e:set_acceleration({x = dir.x * -3, y = -5, z = dir.z * -3})
    e:get_luaentity().age = unilib.pkg.shared_hook.hook_table.tmp_time
    table.insert(
        unilib.pkg.shared_hook.hook_table.tmp_throw,
        {ob = e, timer = 2, user = user:get_player_name()}
    )

    if item == "unilib:tool_slingshot_normal" then
        itemstack:set_wear(9999999)
    end

    user:get_inventory():remove_item("main", item)
    minetest.sound_play("hook_throw", {pos = pos, gain = 1.0, max_hear_distance = 5})
    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_slingshot_normal.init()

    return {
        description = "Normal slingshot",
        notes = "Throws the item on the left in your inventory far away. Place the slingshot" ..
                " to make it throw the item on the right instead",
        depends = {"metal_steel", "shared_hook"},
    }

end

function unilib.pkg.tool_slingshot_normal.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_tool("unilib:tool_slingshot_normal", "hook:slingshot", mode, {
        -- From hook:slingshot
        description = S("Normal Slingshot"),
        inventory_image = "unilib_tool_slingshot_normal.png",

        range = 4,

        on_place = function(itemstack, user, pointed_thing)

            local item = itemstack:to_table()
            local meta = minetest.deserialize(item["metadata"])
            local mode = 0
            if meta == nil then

                meta = {}
                mode = 1

            end

            if meta.mode == nil then
                meta.mode = 1
            end

            mode = meta.mode
            if mode == 1 then

                mode = -1
                minetest.chat_send_player(user:get_player_name(), S("Using stack on the left"))

            else

                mode = 1
                minetest.chat_send_player(user:get_player_name(), S("Using stack on the right"))

            end

            meta.mode = mode
            item.metadata = minetest.serialize(meta)
            item.meta = minetest.serialize(meta)
            itemstack:replace(item)

            return itemstack

        end,

        on_use = function(itemstack, user, pointed_thing)

            local ref = pointed_thing.ref
            if ref and not (
                ref:get_luaentity() and ref:get_luaentity().name == "__builtin:item"
            ) then

                unilib.pkg.shared_hook.punch(user, ref, 4)
                return itemstack

            end

            on_use_slingshot(itemstack, user)
            return itemstack

        end,
    })
    unilib.register_craft({
        -- From hook:slingshot
        output = "unilib:tool_slingshot_normal",
        recipe = {
            {c_ingot, "", c_ingot},
            {"", "unilib:metal_steel_block", ""},
            {"", c_ingot, ""},
        }
    })

end
