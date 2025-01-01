---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.item_paper_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_paper_ordinary.init()

    return {
        description = "Ordinary paper",
        depends = "plant_papyrus_ordinary",
    }

end

function unilib.pkg.item_paper_ordinary.exec()

    unilib.register_craftitem("unilib:item_paper_ordinary", "default:paper", mode, {
        -- From default:paper
        description = S("Ordinary Paper"),
        inventory_image = "unilib_item_paper_ordinary.png",
        groups = {flammable = 3},
    })
    if not unilib.setting.mtgame_tweak_flag then

        unilib.register_craft({
            -- From default:paper
            output = "unilib:item_paper_ordinary",
            recipe = {
                {
                    "unilib:plant_papyrus_ordinary",
                    "unilib:plant_papyrus_ordinary",
                    "unilib:plant_papyrus_ordinary",
                },
            },
        })

    else

        unilib.register_craft({
            -- From moreblocks/redefinitions.lua
            output = "unilib:item_paper_ordinary 4",
            recipe = {
                {
                    "unilib:plant_papyrus_ordinary",
                    "unilib:plant_papyrus_ordinary",
                    "unilib:plant_papyrus_ordinary",
                },
            },
        })

    end
    unilib.register_craft({
        -- From default:paper
        type = "fuel",
        recipe = "unilib:item_paper_ordinary",
        burntime = 1,
    })

end
