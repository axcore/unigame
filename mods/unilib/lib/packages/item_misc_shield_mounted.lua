---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_shields
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_misc_shield_mounted = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_misc_shield_mounted.init()

    return {
        description = "Mounted shields set",
    }

end

function unilib.pkg.item_misc_shield_mounted.exec()

    -- From castle_shields:shield_1. Creates unilib:misc_shield_mounted_slash_red_blue
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "slash_red_blue",
        orig_name = "castle_shields:shield_1",

        replace_mode = mode,
        bg_colour = "red",
        description = S("Red and Blue Slash"),
        fg_colour = "blue",
        style = "slash",
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
        description = S("Grey and Green Chevron"),
        fg_colour = "green",
        style = "cross",
    })

end
