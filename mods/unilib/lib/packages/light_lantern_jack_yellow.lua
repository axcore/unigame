---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_jack_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_jack_yellow.init()

    return {
        description = "Yellow Jack 'O Lantern",
        depends = {"produce_pumpkin_yellow", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_jack_yellow.exec()

    unilib.register_node("unilib:light_lantern_jack_yellow_off", "farming:jackolantern", mode, {
        -- From farming:jackolantern
        description = unilib.hint(S("Yellow Jack 'O Lantern"), S("punch to turn on and off")),
        tiles = {
            "unilib_produce_pumpkin_yellow_grow_top.png",
            "unilib_produce_pumpkin_yellow_grow_top.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_light_lantern_jack_yellow_off.png"
        },
        groups = {choppy = 1, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",

        on_punch = function(pos, node, puncher)

            local name = puncher:get_player_name() or ""
            if minetest.is_protected(pos, name) then
                return
            end

            node.name = "unilib:light_lantern_jack_yellow_on"
            minetest.swap_node(pos, node)

        end
    })
    unilib.register_craft({
        -- From farming:jackolantern
        output = "unilib:light_lantern_jack_yellow_off",
        recipe = {
            {"unilib:torch_ordinary"},
            {"unilib:produce_pumpkin_yellow_harvest"}
        }
    })

    unilib.register_node("unilib:light_lantern_jack_yellow_on", "farming:jackolantern_on", mode, {
        -- From farming:jackolantern_on
        -- N.B. description missing in original code
        description = unilib.hint(S("Yellow Jack 'O Lantern"), S("punch to turn on and off")),
        tiles = {
            "unilib_produce_pumpkin_yellow_grow_top.png",
            "unilib_produce_pumpkin_yellow_grow_top.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_light_lantern_jack_yellow_on.png"
        },
        groups = {
            choppy = 1, flammable = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 1,
        },
        sounds = unilib.sound_table.wood,

        drop = "unilib:light_lantern_jack_yellow_off",
        light_source = unilib.light_max - 1,
        paramtype2 = "facedir",

        on_punch = function(pos, node, puncher)

            local name = puncher:get_player_name() or ""
            if minetest.is_protected(pos, name) then
                return
            end

            node.name = "unilib:light_lantern_jack_yellow_off"
            minetest.swap_node(pos, node)

        end
    })

end
