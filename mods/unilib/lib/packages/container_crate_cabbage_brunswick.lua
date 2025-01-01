---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_cabbage_brunswick = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_cabbage_brunswick.init()

    return {
        description = "Brunswick cabbage crate",
        notes = "This container is decorative; it cannot contain things",
        depends = "crop_cabbage_brunswick",
    }

end

function unilib.pkg.container_crate_cabbage_brunswick.exec()

    local c_harvest = "unilib:crop_cabbage_brunswick_harvest"

    unilib.register_node(
        -- From better_farming:cabbage_crate
        "unilib:container_crate_cabbage_brunswick",
        "better_farming:cabbage_crate",
        mode,
        {
            description = S("Brunswick Cabbage Crate"),
            tiles = {
                "unilib_container_crate_cabbage_brunswick_top.png",
                "unilib_container_crate_harvest_bottom.png",
                "unilib_container_crate_cabbage_brunswick_side.png",
                "unilib_container_crate_cabbage_brunswick_side.png",
                "unilib_container_crate_cabbage_brunswick_side.png",
                "unilib_container_crate_cabbage_brunswick_side.png",
            },
            groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
            sounds = unilib.global.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- From better_farming:cabbage_crate
        output = "unilib:container_crate_cabbage_brunswick",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", c_harvest},
            {c_harvest, c_harvest, c_harvest},
        },
    })

end
