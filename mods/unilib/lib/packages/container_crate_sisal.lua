---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_sisal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_sisal.init()

    return {
        description = "Sisal crate",
        notes = "This container is decorative; it cannot contain things",
        depends = "produce_sisal",
    }

end

function unilib.pkg.container_crate_sisal.exec()

    local c_harvest = "unilib:produce_sisal_harvest"

    unilib.register_node("unilib:container_crate_sisal", "better_farming:sisal_crate", mode, {
        -- From better_farming:sisal_crate
        description = S("Sisal Crate"),
        tiles = {
            "unilib_container_crate_sisal_top.png",
            "unilib_container_crate_harvest_bottom.png",
            "unilib_container_crate_sisal_side.png",
            "unilib_container_crate_sisal_side.png",
            "unilib_container_crate_sisal_side.png",
            "unilib_container_crate_sisal_side.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From better_farming:sisal_crate
        output = "unilib:container_crate_sisal",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", c_harvest},
            {c_harvest, c_harvest, c_harvest},
        },
    })

end
