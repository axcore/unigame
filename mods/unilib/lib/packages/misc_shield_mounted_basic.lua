---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_shields
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_shield_mounted_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_shield_mounted_basic.init()

    return {
        description = "Basic mounted shield set",
        notes = "Shields from the original \"castle\" modpack. For a much larger selection of" ..
                " shields, see the \"misc_shield_mounted_extra\" package",
        depends = "shared_castle_shields",
    }

end

function unilib.pkg.misc_shield_mounted_basic.exec()

    -- From castle_shields:shield_1. Creates unilib:misc_shield_mounted_slash_red_blue
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "bend_sinister_red_blue",
        orig_name = "castle_shields:shield_1",

        replace_mode = mode,
        bg_colour = "red",
        description = S("Red and Blue Bend Sinister"),
        fg_colour = "blue",
        style = "bend_sinister",
    })

    -- From castle_shields:shield_2. Creates unilib:misc_shield_mounted_chevron_cyan_yellow
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "chevron_cyan_yellow",
        orig_name = "castle_shields:shield_2",

        replace_mode = mode,
        bg_colour = "cyan",
        description = S("Cyan and Yellow Chevron"),
        fg_colour = "yellow",
        style = "chevron",
    })

    -- From castle_shields:shield_3. Creates unilib:misc_shield_mounted_cross_grey_green
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "cross_grey_green",
        orig_name = "castle_shields:shield_3",

        replace_mode = mode,
        bg_colour = "grey",
        description = S("Grey and Green Cross"),
        fg_colour = "green",
        style = "cross",
    })

end
