---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_shield_mounted_british = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_shield_mounted_british.init()

    return {
        description = "British mounted shield set",
        notes = "Small selection of mounted shield in classic colour combinations",
        depends = "shared_castle_shields",
    }

end

function unilib.pkg.misc_shield_mounted_british.exec()

    -- Original to unilib
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "cross_white_red",
        orig_name = nil,

        replace_mode = mode,
        bg_colour = "white",
        description = S("English Cross"),
        fg_colour = "red",
        style = "cross",
    })

    -- Original to unilib
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "saltire_blue_white",
        orig_name = nil,

        replace_mode = mode,
        bg_colour = "blue",
        description = S("Scottish Saltire"),
        fg_colour = "white",
        style = "saltire",
    })

    -- Original to unilib
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "per_fess_green_dark_white",
        orig_name = nil,

        replace_mode = mode,
        bg_colour = "green_dark",
        description = S("Welsh Per Fess"),
        fg_colour = "white",
        style = "per_fess",
    })

    -- Original to unilib
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "cross_yellow_red",
        orig_name = nil,

        replace_mode = mode,
        bg_colour = "yellow",
        description = S("Ulster Cross"),
        fg_colour = "red",
        style = "cross",
    })

    -- Original to unilib
    unilib.pkg.shared_castle_shields.register_mounted_shield({
        part_name = "per_pale_green_orange",
        orig_name = nil,

        replace_mode = mode,
        bg_colour = "green",
        description = S("Irish Cross"),
        fg_colour = "orange",
        style = "per_pale",
    })

end
