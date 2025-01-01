---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dyes_callback.lua
--      Callback functions for dyed items
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Callback functions for dyed items
---------------------------------------------------------------------------------------------------

function unilib.dyes._item_after_place_node(pos, placer, itemstack, pointed_thing)

    -- From unifieddyes/api.lua, unifieddyes.fix_rotation_nsew()
    local node = core.get_node(pos)
    local colour_bits = node.param2 - (node.param2 % 8)
    local yaw = placer:get_look_horizontal()
    local dir = core.yaw_to_dir(yaw + 1.5)
    local fdir = core.dir_to_wallmounted(dir)

    core.swap_node(pos, {name = node.name, param2 = fdir + colour_bits})

end

function unilib.dyes._item_on_punch(pos, node, puncher)

    -- Original to unilib
    -- Converts a suitable node into a dyed variant of itself, when punched with a basic dye

    local wielded = puncher:get_wielded_item()
    local wielded_name = wielded:get_name()
    local pname = puncher:get_player_name()
    local inv = puncher:get_inventory()

    local palette_index = unilib.global.dye_palette_table[wielded_name]
    if palette_index == nil or core.is_protected(pos, pname) then
        return
    end

    local dir = node.param2 % 8
    core.swap_node(pos, {name = node.name, param2 = (palette_index * 8) + dir})

    if not unilib.utils.is_creative(pname) then
        inv:remove_item("main", wielded_name)
    end

end

function unilib.dyes._item_on_rotate(pos, node, user, mode, new_param2)

    -- From unifieddyes/api.lua, unifieddyes.fix_after_screwdriver_nsew()
    local new_fdir = new_param2 % 8
    local colour = new_param2 - new_fdir
    if new_fdir < 2 then

        new_fdir = 2
        core.swap_node(pos, {name = node.name, param2 = new_fdir + colour})
        return true

    end

end
