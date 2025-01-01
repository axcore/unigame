---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_bars_iron_rusty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_bars_iron_rusty.init()

    return {
        description = "Rusty iron bars",
        depends = {"dirt_ordinary", "metal_steel"},
    }

end

function unilib.pkg.pane_bars_iron_rusty.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_pane({
        -- From xdecor, xpanes:rusty_bar_flat. Creates unilib:pane_bars_iron_rusty_flat,
        --      unilib:pane_bars_iron_rusty_crossed
        part_name = "bars_iron_rusty",
        orig_name = {"xpanes:rusty_bar", "xpanes:rusty_bar_flat"},
        def_table = {
            description = S("Rusty Iron Bars"),
            textures = {"unilib_pane_bars_iron_rusty.png", "", "unilib_pane_bars_iron_rusty.png"},
            -- N.B. pane = 1 in original code, omitted here
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.stone,

            drawtype = "airlike",
            inventory_image = "unilib_pane_bars_iron_rusty.png",
            paramtype = "light",
            recipe = {
                {"", "unilib:dirt_ordinary", ""},
                {c_ingot, c_ingot, c_ingot},
                {c_ingot, c_ingot, c_ingot},
            },
            wield_image = "unilib_pane_bars_iron_rusty.png",
        },

        replace_mode = mode,
    })

end
