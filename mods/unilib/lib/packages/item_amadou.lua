---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_amadou = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_amadou.init()

    return {
        description = "Amadou",
        notes = "Derived from tinder mushrooms, and used as a fuel",
        depends = "plant_fungus_tinder",
        optional = "tnt_ordinary",
    }

end

function unilib.pkg.item_amadou.exec()

    unilib.register_craftitem("unilib:item_amadou", "nsspf:amadou", mode, {
        -- From nsspf:amadou
        description = S("Amadou"),
        image = "unilib_item_amadou.png",
    })
    unilib.register_craft({
        -- From nsspf:amadou
        type = "shapeless",
        output = "unilib:item_amadou",
        recipe = {"unilib:plant_fungus_tinder"},
    })
    unilib.register_craft({
        -- From nsspf:amadou
        type = "fuel",
        recipe = "unilib:item_amadou",
        burntime = 120,
    })

    if unilib.pkg_executed_table["tnt_ordinary"] ~= nil then

        unilib.register_craftitem("unilib:item_amadou_lasting", "nsspf:lasting_amadou", mode, {
            -- From nsspf:lasting_amadou
            description = S("Long-Lasting Amadou"),
            image = "unilib_item_amadou_lasting.png",
        })
        unilib.register_craft({
            -- From nsspf:lasting_amadou
            type = "shapeless",
            output = "unilib:item_amadou_lasting",
            recipe = {"unilib:tnt_gunpowder", "unilib:item_amadou"},
        })
        unilib.register_craft({
            -- From nsspf:lasting_amadou
            type = "fuel",
            recipe = "unilib:item_amadou_lasting",
            burntime = 300,
        })

    end

end
