---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_string_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_string_ordinary.init()

    return {
        description = "Ordinary string",
        depends = "crop_cotton",
    }

end

function unilib.pkg.item_string_ordinary.exec()

    unilib.register_craftitem("unilib:item_string_ordinary", "farming:string", mode, {
        -- From farming:string
        description = S("Ordinary String"),
        inventory_image = "unilib_item_string_ordinary.png",
        groups = {flammable = 2},
    })
    unilib.register_craft({
        -- From farming:string
        output = "unilib:item_string_ordinary 2",
        recipe = {
            {"unilib:crop_cotton_harvest"},
            {"unilib:crop_cotton_harvest"},
        },
    })
    unilib.register_craft({
        -- From farming:string
        type = "fuel",
        recipe = "unilib:item_string_ordinary",
        burntime = 1,
    })

end
