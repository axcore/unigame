---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_corn_flint = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_corn_flint.init()

    return {
        description = "Flint corn crate",
        notes = "This container is decorative; it cannot contain things",
        depends = "produce_corn_flint",
    }

end

function unilib.pkg.container_crate_corn_flint.exec()

    local c_harvest = "unilib:produce_corn_flint_harvest"

    unilib.register_node("unilib:container_crate_corn_flint", "better_farming:corn_crate", mode, {
        -- From better_farming:corn_crate
        description = S("Flint Corn Crate"),
        tiles = {
            "unilib_container_crate_corn_flint_top.png",
            "unilib_container_crate_harvest_bottom.png",
            "unilib_container_crate_corn_flint_side.png",
            "unilib_container_crate_corn_flint_side.png",
            "unilib_container_crate_corn_flint_side.png",
            "unilib_container_crate_corn_flint_side.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From better_farming:corn_crate
        output = "unilib:container_crate_corn_flint",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", c_harvest},
            {c_harvest, c_harvest, c_harvest},
        },
    })

end
