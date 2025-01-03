---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_tomato_cherry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_tomato_cherry.init()

    return {
        description = "Cherry tomato crate",
        notes = "This container is decorative; it cannot contain things",
        depends = "crop_tomato_cherry",
    }

end

function unilib.pkg.container_crate_tomato_cherry.exec()

    local c_harvest = "unilib:crop_tomato_cherry_harvest"

    unilib.register_node(
        -- From better_farming:tomato_crate
        "unilib:container_crate_tomato_cherry",
        "better_farming:tomato_crate",
        mode,
        {
            description = S("Cherry Tomato Crate"),
            tiles = {
                "unilib_container_crate_tomato_cherry_top.png",
                "unilib_container_crate_harvest_bottom.png",
                "unilib_container_crate_tomato_cherry_side.png",
                "unilib_container_crate_tomato_cherry_side.png",
                "unilib_container_crate_tomato_cherry_side.png",
                "unilib_container_crate_tomato_cherry_side.png",
            },
            groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
            sounds = unilib.global.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- From better_farming:tomato_crate
        output = "unilib:container_crate_tomato_cherry",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", c_harvest},
            {c_harvest, c_harvest, c_harvest},
        },
    })

end
