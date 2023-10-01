---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_lattice_papyrus_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_lattice_papyrus_simple.init()

    return {
        description = "Simple papyrus lattice",
        depends = {"crop_cotton", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.pane_lattice_papyrus_simple.exec()

    local c_papyrus = "unilib:plant_papyrus_ordinary"

    unilib.register_pane({
        -- From xdecor, xpanes:bamboo_frame_flat. Creates unilib:pane_lattice_papyrus_simple_flat,
        --      unilib:pane_lattice_papyrus_simple_crossed
        part_name = "lattice_papyrus_simple",
        orig_name = {"xpanes:bamboo_frame", "xpanes:bamboo_frame_flat"},
        def_table = {
            description = S("Simple Papyrus Lattice"),
            textures = {
                "unilib_pane_lattice_papyrus_simple.png",
                "",
                "unilib_pane_lattice_papyrus_simple.png",
            },
            -- N.B. pane = 1 in original code, omitted here
            groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.node,

            drawtype = "airlike",
            inventory_image = "unilib_pane_lattice_papyrus_simple.png",
            paramtype = "light",
            recipe = {
                {c_papyrus, c_papyrus, c_papyrus},
                {c_papyrus, "unilib:crop_cotton_harvest",  c_papyrus},
                {c_papyrus, c_papyrus, c_papyrus},
            },
            wield_image = "unilib_pane_lattice_papyrus_simple.png",
        },

        replace_mode = mode,
    })

end
