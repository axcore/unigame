---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_jute = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_jute.init()

    return {
        description = "Jute crate",
        notes = "This container is decorative; it cannot contain things",
        depends = {"item_string_ordinary", "produce_jute"},
    }

end

function unilib.pkg.container_crate_jute.exec()

    local c_harvest = "unilib:produce_jute_harvest"

    unilib.register_node("unilib:container_crate_jute", "better_farming:jute_crate", mode, {
        -- From better_farming:jute_crate
        description = S("Jute Crate"),
        tiles = {
            "unilib_container_crate_jute_top.png",
            "unilib_container_crate_harvest_bottom.png",
            "unilib_container_crate_jute_side.png",
            "unilib_container_crate_jute_side.png",
            "unilib_container_crate_jute_side.png",
            "unilib_container_crate_jute_side.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From better_farming:jute_crate
        output = "unilib:container_crate_jute",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", "unilib:item_string_ordinary"},
            {c_harvest, c_harvest, c_harvest},
        }
    })

end
