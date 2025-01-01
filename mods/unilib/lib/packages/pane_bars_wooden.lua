---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_bars_wooden = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_bars_wooden.init()

    return {
        description = "Wooden bars",
        depends = "item_stick_ordinary",
    }

end

function unilib.pkg.pane_bars_wooden.exec()

    unilib.register_pane({
        -- From mtg_plus mod, xpanes:wood_flat. Creates unilib:pane_bars_wooden_flat,
        --      unilib:pane_bars_wooden_crossed
        part_name = "bars_wooden",
        orig_name = {"xpanes:wood", "xpanes:wood_flat"},
        def_table = {
            description = S("Wooden Bars"),
            textures = {
                "unilib_pane_bars_wooden.png",
                "unilib_pane_bars_wooden_side.png",
                "unilib_pane_bars_wooden_top.png",
            },
            groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.global.sound_table.wood,

            inventory_image = "unilib_pane_bars_wooden.png",
            -- N.B. Original craft recipe conflicts with recipe in "shared_castle_gates_slots"
            --      package
            --[[
            recipe = {
                {"group:wood", "", "group:wood"},
                {"group:wood", "", "group:wood"},
                {"group:wood", "", "group:wood"},
            },
            ]]--
            recipe = {
                {"unilib:item_stick_ordinary", "", "unilib:item_stick_ordinary"},
                {"unilib:item_stick_ordinary", "", "unilib:item_stick_ordinary"},
                {"unilib:item_stick_ordinary", "", "unilib:item_stick_ordinary"},
            },
            wield_image = "unilib_pane_bars_wooden.png",
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From mtg_plus mod, xpanes:wood_flat
        type = "fuel",
        recipe = "unilib:pane_bars_wooden_flat",
        burntime = 2,
    })

end
