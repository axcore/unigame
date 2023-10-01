---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_lattice_chainlink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_lattice_chainlink.init()

    return {
        description = "Chainlink lattice",
        depends = "metal_steel",
    }

end

function unilib.pkg.pane_lattice_chainlink.exec()

    unilib.register_pane({
        -- From xdecor, xpanes:chainlink_flat. Creates unilib:pane_lattice_chainlink_flat,
        --      unilib:pane_lattice_chainlink_crossed
        part_name = "lattice_chainlink",
        orig_name = {"xpanes:chainlink", "xpanes:chainlink_flat"},
        def_table = {
            description = S("Chainlink Lattice"),
            textures = {
                "unilib_pane_lattice_chainlink.png",
                "",
                "unilib_pane_lattice_chainlink.png",
            },
            -- N.B. pane = 1 in original code, omitted here
            groups = {cracky = 3, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.node,

            drawtype = "airlike",
            inventory_image = "unilib_pane_lattice_chainlink.png",
            paramtype = "light",
            recipe = {
                {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
                {"", "unilib:metal_steel_ingot", ""},
                {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            },
            wield_image = "unilib_pane_lattice_chainlink.png",
        },

        replace_mode = mode,
    })

end
