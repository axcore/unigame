---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_shield_mounted_extra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_shield_mounted_extra.init()

    return {
        description = "Extended mounted shield set",
        notes = "Shields in all sixteen available designs, and in a range of colours. You can" ..
                " tweak the code in this package to add more colour combinations",
        depends = "shared_castle_shields",
    }

end

function unilib.pkg.misc_shield_mounted_extra.exec()

    local shield_list = {
        {"barry", S("Barry")},
        {"bend", S("Bend")},
        {"bend_sinister", S("Bend Sinister")},
        {"checkly", S("Checkly")},
        {"chevron", S("Chevron")},
        {"chevron_sinister", S("Chevron Sinister")},
        {"cross", S("Cross")},
        {"fess", S("Fess")},
        {"pale", S("Pale")},
        {"paly", S("Paly")},
        {"per_bend", S("Per Bend")},
        {"per_fess", S("Per Fess")},
        {"per_pale", S("Per Pale")},
        {"per_saltire", S("Per Saltire")},
        {"quarterly", S("Quarterly")},
        {"saltire", S("Saltire")},
    }

    local colour_list = {
        {"blue", S("Blue"), "red", S("Red")},
        {"cyan", S("Cyan"), "blue", S("Blue")},
        {"green", S("Green"), "green_dark", S("Dark Green"), },
        {"grey", S("Grey"), "grey_dark", S("Dark Grey")},
        {"magenta", S("Magenta"), "pink", S("Pink")},
        {"orange", S("Orange"), "brown", S("Brown")},
        {"red", S("Red"), "white", S("White")},
        {"violet", S("Violet"), "yellow", S("Yellow")},
        {"white", S("White"), "black", S("Black")},
        {"yellow", S("Yellow"), "black", S("Black")},
    }

    -- Original to unilib
    for _, mini_shield_list in ipairs(shield_list) do

        for _, mini_colour_list in ipairs(colour_list) do

            unilib.pkg.shared_castle_shields.register_mounted_shield({
                part_name = mini_shield_list[1] .. "_" .. mini_colour_list[1] .. "_" ..
                        mini_colour_list[3],
                orig_name = nil,

                replace_mode = mode,
                bg_colour = mini_colour_list[1],
                description = S(
                    "@1 and @2 @3", mini_colour_list[2], mini_colour_list[4], mini_shield_list[2]
                ),
                fg_colour = mini_colour_list[3],
                style = mini_shield_list[1],
            })

        end

    end

end
