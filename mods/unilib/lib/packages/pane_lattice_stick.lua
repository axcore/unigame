---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_lattice_stick = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_lattice_stick.init()

    return {
        description = "Stick lattice",
        depends = "item_stick_ordinary",
    }

end

function unilib.pkg.pane_lattice_stick.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_pane({
        -- From xpanes:lattice_flat. Creates unilib:pane_lattice_stick_flat,
        --      unilib:pane_lattice_stick_crossed
        part_name = "lattice_stick",
        orig_name = {nil, nil},
        def_table = {
            description = S("Stick Lattice"),
            textures = {
                "unilib_pane_lattice_stick.png",
                "blank.png",
                "blank.png",
            },
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            -- N.B. glass in original code
            sounds = unilib.global.sound_table.wood,

            inventory_image = "unilib_pane_lattice_stick.png",
            recipe = {
                {c_stick, "", c_stick},
                {"", c_stick, ""},
                {c_stick, "", c_stick},
            },
            wield_image = "unilib_pane_lattice_stick.png",
        },

        replace_mode = mode,
    })

end
