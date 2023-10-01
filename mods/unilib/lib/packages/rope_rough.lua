---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_rough = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_remove(pos, oldnode, digger, rope_name)

    local num = 0
    local below = {x = pos.x, y = pos.y, z = pos.z}
    local digger_inv = digger:get_inventory()

    while minetest.get_node(below).name == rope_name do

        minetest.remove_node(below)
        below.y = below.y - 1
        num = num + 1

    end

    if num == 0 then
        return
    end

    digger_inv:add_item("main", rope_name .. " " .. num)

    return true

end

local function on_place(itemstack, placer, pointed_thing)

    if pointed_thing.type == "node" then

        local pos = pointed_thing.above
        local oldnode = minetest.get_node(pos)
        local stackname = itemstack:get_name()

        if minetest.is_protected(pos, placer:get_player_name()) then
            return itemstack
        end

        while oldnode.name == "air" and not itemstack:is_empty() do

            local newnode = {name = stackname, param1 = 0}
            minetest.set_node(pos, newnode)
            itemstack:take_item()
            pos.y = pos.y - 1
            oldnode = minetest.get_node(pos)

        end

    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_rough.init()

    return {
        description = "Rough rope",
        depends = "item_string_ordinary",
    }

end

function unilib.pkg.rope_rough.exec()

    unilib.register_node("unilib:rope_rough", "xdecor:rope", mode, {
        -- From xdecor:rope
        description = S("Rough Rope"),
        tiles = {"unilib_rope_rough.png"},
        groups = {flammable = 3, snappy = 3},
        sounds = unilib.sound_table.node,

        climbable = true,
        drawtype = "plantlike",
        inventory_image = "unilib_rope_rough_inv.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
            },
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_rope_rough_inv.png",

        on_place = on_place,

        on_punch = function(pos, node, puncher, pointed_thing)

            local player_name = puncher:get_player_name()

            if not minetest.is_protected(pos, player_name) or
                    minetest.get_player_privs(player_name).protection_bypass then
                do_remove(pos, node, puncher, "unilib:rope_rough")
            end

        end,
    })
    unilib.register_craft({
        -- From xdecor:rope
        output = "unilib:rope_rough",
        recipe = {
            {"unilib:item_string_ordinary"},
            {"unilib:item_string_ordinary"},
            {"unilib:item_string_ordinary"},
        },
    })

end
