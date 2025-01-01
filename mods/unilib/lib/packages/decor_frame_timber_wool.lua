---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fachwerk
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_frame_timber_wool = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fachwerk.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_frame_timber_wool.init()

    return {
        description = "Timber frame with wool",
        notes = "Code in this package is not included in the \"decor_frame_timber_basic\"" ..
                " package, because framed nodes made of wool are very unrealistic. If the" ..
                " \"decor_frame_timber_clay\" package is loaded, you can create framed nodes in" ..
                " many colours, made of baked clay, instead",
        depends = {"shared_fachwerk", "wool_basic"},
    }

end

function unilib.pkg.decor_frame_timber_wool.exec()

    unilib.pkg.shared_fachwerk.register_timber_frame({
        -- From fachwerk:grey, etc. Creates unilib:wool_grey_with_frame_timber, etc
        ingredient = "unilib:wool_grey",
        orig_name = "wool:grey",

        replace_mode = mode,
        simple_flag = true,
    })

    unilib.pkg.shared_fachwerk.register_timber_frame({
        -- From fachwerk:white, etc. Creates unilib:wool_white_with_frame_timber, etc
        ingredient = "unilib:wool_white",
        orig_name = "wool:white",

        replace_mode = mode,
        simple_flag = true,
    })

    unilib.pkg.shared_fachwerk.register_timber_frame({
        -- From fachwerk:yellow, etc. Creates unilib:wool_yellow_with_frame_timber, etc
        ingredient = "unilib:wool_yellow",
        orig_name = "wool:yellow",

        replace_mode = mode,
        simple_flag = true,
    })

end
