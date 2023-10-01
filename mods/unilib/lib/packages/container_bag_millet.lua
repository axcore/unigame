---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_bag_millet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_bag_millet.init()

    return {
        description = "Bag of Millet",
        notes = "This container is decorative; it cannot contain things",
        depends = "produce_millet",
    }

end

function unilib.pkg.container_bag_millet.exec()

    local c_harvest = "unilib:produce_millet_harvest"

    unilib.register_node("unilib:container_bag_millet", "better_farming:millet_crate", mode, {
        -- From better_farming:millet_crate
        description = S("Bag of Millet"),
        tiles = {
            "unilib_container_crate_millet_top.png",
            "unilib_container_crate_harvest_bottom.png",
            "unilib_container_bag_rice_arborio_side.png",
            "unilib_container_bag_rice_arborio_side.png",
            "unilib_container_bag_rice_arborio_side.png",
            "unilib_container_bag_rice_arborio_side.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From better_farming:millet_crate
        output = "unilib:container_bag_millet",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", c_harvest},
            {c_harvest, c_harvest, c_harvest},
        }
    })

end
