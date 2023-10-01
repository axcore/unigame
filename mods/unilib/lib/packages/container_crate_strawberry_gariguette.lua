---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_strawberry_gariguette = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_strawberry_gariguette.init()

    return {
        description = "Gariguette strawberry crate",
        notes = "This container is decorative; it cannot contain things",
        depends = {"crop_strawberry_gariguette", "item_string_ordinary"},
    }

end

function unilib.pkg.container_crate_strawberry_gariguette.exec()

    local c_harvest = "unilib:crop_strawberry_gariguette_harvest"

    unilib.register_node(
        -- From better_farming:strawberry_crate
        "unilib:container_crate_strawberry_gariguette",
        "better_farming:strawberry_crate",
        mode,
        {
            description = S("Gariguette Strawberry Crate"),
            tiles = {
                "unilib_container_crate_strawberry_gariguette_top.png",
                "unilib_container_crate_strawberry_gariguette_bottom.png",
                "unilib_container_crate_strawberry_gariguette_side.png",
                "unilib_container_crate_strawberry_gariguette_side.png",
                "unilib_container_crate_strawberry_gariguette_side.png",
                "unilib_container_crate_strawberry_gariguette_side.png",
            },
            groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- From better_farming:strawberry_crate
        output = "unilib:container_crate_strawberry_gariguette",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", "unilib:item_string_ordinary"},
            {c_harvest, c_harvest, c_harvest},
        }
    })

end
