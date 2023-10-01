---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fachwerk
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_frame_timber_brick = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.fachwerk.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_frame_timber_brick.init()

    return {
        description = "Timber frame with brick",
        depends = {"brick_ordinary", "shared_fachwerk"},
    }

end

function unilib.pkg.decor_frame_timber_brick.exec()

    unilib.pkg.shared_fachwerk.register_timber_frame({
        -- From fachwerk:brick, etc. Creates unilib:brick_ordinary_block_with_frame_timber, etc
        ingredient = "unilib:brick_ordinary_block",
        orig_name = "default:brick",

        replace_mode = mode,
        simple_flag = true,
    })

end
