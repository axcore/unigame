---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_stick_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_stick_ordinary.init()

    return {
        description = "Ordinary stick",
        optional = "plant_shrub_dry",
    }

end

function unilib.pkg.item_stick_ordinary.exec()

    unilib.register_craftitem("unilib:item_stick_ordinary", "default:stick", mode, {
        -- From default:stick
        description = S("Ordinary Stick"),
        inventory_image = "unilib_item_stick_ordinary.png",
        groups = {flammable = 2, stick = 1},
    })
    unilib.register_craft({
        -- From default:stick
        output = "unilib:item_stick_ordinary 4",
        recipe = {
            {"group:wood"},
        },
    })
    unilib.register_craft({
        -- From default:stick
        type = "fuel",
        recipe = "unilib:item_stick_ordinary",
        burntime = 1,
    })
    if unilib.setting.mtgame_tweak_flag then

        if unilib.global.pkg_executed_table["plant_shrub_dry"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                output = "unilib:item_stick_ordinary",
                recipe = {
                    {"unilib:plant_shrub_dry"},
                },
            })

        end

        unilib.register_craft({
            -- From moreblocks
            output = "unilib:item_stick_ordinary",
            recipe = {
                {"group:sapling"},
            },
        })

    end

end
