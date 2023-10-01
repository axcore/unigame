---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.container_crate_potato_maris_piper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_crate_potato_maris_piper.init()

    return {
        description = "Maris piper potato crate",
        notes = "This container is decorative; it cannot contain things",
        depends = "produce_potato_maris_piper",
    }

end

function unilib.pkg.container_crate_potato_maris_piper.exec()

    local c_harvest = "unilib:produce_potato_maris_piper_harvest"

    unilib.register_node(
        -- From better_farming:potato_crate
        "unilib:container_crate_potato_maris_piper",
        "better_farming:potato_crate",
        mode,
        {
            description = S("Maris Piper Potato Crate"),
            tiles = {
                "unilib_container_crate_potato_maris_piper_top.png",
                "unilib_container_crate_harvest_bottom.png",
                "unilib_container_crate_potato_maris_piper_side.png",
                "unilib_container_crate_potato_maris_piper_side.png",
                "unilib_container_crate_potato_maris_piper_side.png",
                "unilib_container_crate_potato_maris_piper_side.png",
            },
            groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- From better_farming:potato_crate
        output = "unilib:container_crate_potato_maris_piper",
        recipe = {
            {c_harvest, c_harvest, c_harvest},
            {c_harvest, "group:wood", c_harvest},
            {c_harvest, c_harvest, c_harvest},
        }
    })

end
