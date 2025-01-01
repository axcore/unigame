---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_jack_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_jack_red.init()

    return {
        description = "Red Jack 'O Lantern",
        depends = {"plant_pumpkin_red_wild", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_jack_red.exec()

    unilib.register_node("unilib:light_lantern_jack_red_off", "cropocalypse:carved_pumpkin", mode, {
        -- From cropocalypse:carved_pumpkin
        description = unilib.utils.hint(S("Red Jack 'O Lantern"), S("punch to turn on and off")),
        tiles = {
            "unilib_plant_pumpkin_red_wild_top.png",
            "unilib_plant_pumpkin_red_wild_bottom.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_light_lantern_jack_red_off.png",
        },
        groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2, pumpkin = 1},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype2 = "facedir",

        -- N.B. .on_punch() not in original code
        on_punch = function(pos, node, puncher)

            local name = puncher:get_player_name() or ""
            if core.is_protected(pos, name) then
                return
            end

            node.name = "unilib:light_lantern_jack_red_on"
            core.swap_node(pos, node)

        end,
    })
    unilib.register_craft({
        -- Original to unilib, replacing the original recipe to match the one in the
        --      "light_lantern_jack_yellow" pacakage
        output = "unilib:light_lantern_jack_red_off",
        recipe = {
            {"unilib:torch_ordinary"},
            {"unilib:plant_pumpkin_red_wild"},
        },
    })

    unilib.register_node("unilib:light_lantern_jack_red_on", "cropocalypse:jack_olantern", mode, {
        -- From cropocalypse:jack_olantern
        description = S("Red Jack O'Lantern"),
        tiles = {
            "unilib_plant_pumpkin_red_wild_top.png",
            "unilib_plant_pumpkin_red_wild_bottom.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_light_lantern_jack_red_on.png",
        },
        -- N.B. not_in_creative_inventory = 1 not in original code
        groups = {
            choppy = 2, flammable = 1, not_in_creative_inventory = 1, oddly_breakable_by_hand = 2,
            pumpkin = 1,
        },
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        light_source = 11,
        paramtype2 = "facedir",

        -- N.B. .on_punch() not in original code
        on_punch = function(pos, node, puncher)

            local name = puncher:get_player_name() or ""
            if core.is_protected(pos, name) then
                return
            end

            node.name = "unilib:light_lantern_jack_red_off"
            core.swap_node(pos, node)

        end,
    })

end
