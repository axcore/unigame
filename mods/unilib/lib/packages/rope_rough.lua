---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_rough = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_remove(pos, oldnode, digger, rope_name)

    local num = 0
    local below = {x = pos.x, y = pos.y, z = pos.z}
    local digger_inv = digger:get_inventory()

    while core.get_node(below).name == rope_name do

        core.remove_node(below)
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

    if pointed_thing.type ~= "node" then
        return itemstack
    end

    -- (Compatibility with wooden display frames, etc)
    if unilib.misc.pointed_has_rightclick(itemstack, placer, pointed_thing) then
        return unilib.misc.pointed_use_rightclick(itemstack, placer, pointed_thing)
    end

    local pos = pointed_thing.above
    local oldnode = core.get_node(pos)
    local stackname = itemstack:get_name()
    local protection_bypass = core.check_player_privs(placer, "protection_bypass")
    local pname = placer:get_player_name()
    local is_creative = unilib.utils.is_creative(pname)

    if core.is_protected(pos, pname) and not protection_bypass then

        core.record_protection_violation(pos, pname)
        return itemstack

    end

    -- N.B. "count" prevents infinitely-long ropes in creative mode, limiting them to the maximum
    --      stack size; in survival the rope length is limited to the actual stack size
    local count = 0
    while oldnode.name == "air" and
            (is_creative or not itemstack:is_empty()) and
            count < itemstack:get_stack_max() do

        if core.is_protected(pos, pname) and not protection_bypass then
            break
        end

        local newnode = {name = stackname, param1 = 0}
        core.set_node(pos, newnode)
        itemstack:take_item()
        pos.y = pos.y - 1
        oldnode = core.get_node(pos)

        count = count + 1

    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_rough.init()

    return {
        description = "Rough rope. Place a single node; other rough rope nodes in your" ..
                " inventory are automatically added beneath it",
        depends = "item_string_ordinary",
    }

end

function unilib.pkg.rope_rough.exec()

    unilib.register_node("unilib:rope_rough", "xdecor:rope", mode, {
        -- From xdecor:rope
        description = S("Rough Rope"),
        tiles = {"unilib_rope_rough.png"},
        groups = {flammable = 3, snappy = 3},
        sounds = unilib.global.sound_table.node,

        climbable = true,
        drawtype = "plantlike",
        inventory_image = "unilib_rope_rough_inv.png",
        -- N.B. is_ground_content = false not in original code; added to match other ropes
        is_ground_content = false,
        -- N.B. node_placement_prediction not in original code
        node_placement_prediction = "",
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

            if not core.is_protected(pos, player_name) or
                    core.get_player_privs(player_name).protection_bypass then
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
