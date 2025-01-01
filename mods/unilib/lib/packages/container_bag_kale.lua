---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_bag_kale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_bag_kale.init()

    return {
        description = "Bag of Kale",
        notes = "This container is decorative; it cannot contain things",
        depends = {"item_string_ordinary", "produce_kale"},
    }

end

function unilib.pkg.container_bag_kale.exec()

    local c_harvest = "unilib:produce_kale_harvest"

    unilib.register_node("unilib:container_bag_kale", "better_farming:kale_crate", mode, {
        -- From better_farming:kale_crate
        description = S("Bag of Kale"),
        tiles = {
            "unilib_container_bag_kale_top.png",
            "unilib_container_crate_harvest_bottom.png",
            "unilib_container_bag_rice_arborio_side.png",
            "unilib_container_bag_rice_arborio_side.png",
            "unilib_container_bag_rice_arborio_side.png",
            "unilib_container_bag_rice_arborio_side.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From better_farming:kale_crate
        output = "unilib:container_bag_kale",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", "unilib:item_string_ordinary"},
            {c_harvest, c_harvest, c_harvest},
        },
    })

end
