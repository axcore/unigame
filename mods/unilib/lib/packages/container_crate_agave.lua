---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_agave = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_agave.init()

    return {
        description = "Agave crate",
        notes = "This container is decorative; it cannot contain things",
        depends = "produce_agave",
    }

end

function unilib.pkg.container_crate_agave.exec()

    local c_harvest = "unilib:produce_agave_harvest"

    unilib.register_node("unilib:container_crate_agave", "better_farming:agave_crate", mode, {
        -- From better_farming:agave_crate
        description = S("Agave Crate"),
        tiles = {
            "unilib_container_crate_agave_top.png",
            "unilib_container_crate_harvest_bottom.png",
            "unilib_container_crate_agave_side.png",
            "unilib_container_crate_agave_side.png",
            "unilib_container_crate_agave_side.png",
            "unilib_container_crate_agave_side.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From better_farming:agave_crate
        output = "unilib:container_crate_agave",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", c_harvest},
            {c_harvest, c_harvest, c_harvest},
        }
    })

end
