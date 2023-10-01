---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_onion_spanish = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_onion_spanish.init()

    return {
        description = "Spanish onion crate",
        notes = "This container is decorative; it cannot contain things",
        depends = "produce_onion_spanish",
    }

end

function unilib.pkg.container_crate_onion_spanish.exec()

    local c_harvest = "unilib:produce_onion_spanish_harvest"

    unilib.register_node(
        -- From better_farming:onion_crate
        "unilib:container_crate_onion_spanish",
        "better_farming:onion_crate",
        mode,
        {
            description = S("Spanish Onion Crate"),
            tiles = {
                "unilib_container_crate_onion_spanish_top.png",
                "unilib_container_crate_harvest_bottom.png",
                "unilib_container_crate_onion_spanish_side.png",
                "unilib_container_crate_onion_spanish_side.png",
                "unilib_container_crate_onion_spanish_side.png",
                "unilib_container_crate_onion_spanish_side.png",
            },
            groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- From better_farming:onion_crate
        output = "unilib:container_crate_onion_spanish",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", c_harvest},
            {c_harvest, c_harvest, c_harvest},
        }
    })

end
