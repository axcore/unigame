---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_lattice_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_lattice_wood.init()

    return {
        description = "Wooden lattice",
    }

end

function unilib.pkg.pane_lattice_wood.exec()

    unilib.register_pane({
        -- From xdecor, xpanes:wood_frame_flat. Creates unilib:pane_lattice_wood_flat,
        --      unilib:pane_lattice_wood_crossed
        part_name = "lattice_wood",
        orig_name = {"xpanes:wood_frame", "xpanes:wood_frame_flat"},
        def_table = {
            description = S("Wooden Lattice"),
            textures = {"unilib_pane_lattice_wood.png", "", "unilib_pane_lattice_wood.png"},
            -- N.B. pane = 1 in original code, omitted here
            groups = {choppy = 2, flammable = 2},
            sounds = unilib.sound_table.wood,

            drawtype = "airlike",
            inventory_image = "unilib_pane_lattice_wood.png",
            paramtype = "light",
            recipe = {
                {"group:wood", "group:stick", "group:wood"},
                {"group:stick", "group:stick", "group:stick"},
                {"group:wood", "group:stick", "group:wood"},
            },
            wield_image = "unilib_pane_lattice_wood.png",
        },

        replace_mode = mode,
    })

end
