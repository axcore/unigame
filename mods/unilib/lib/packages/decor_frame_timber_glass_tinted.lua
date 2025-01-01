---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fachwerk
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_frame_timber_glass_tinted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fachwerk.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_frame_timber_glass_tinted.init()

    return {
        description = "Timber frame with glass",
        depends = {"glass_tinted_basic", "shared_fachwerk"},
    }

end

function unilib.pkg.decor_frame_timber_glass_tinted.exec()

    if not unilib.setting.fachwerk_extra_nodes_flag then
        return
    end

    local glass_list = {
        "black", "blue", "brown", "cyan", "green", "green_dark", "grey", "grey_dark", "magenta",
        "orange", "pink", "red", "violet", "white", "yellow",
    }

    for _, part_name in pairs(glass_list) do

        local ingredient = "unilib:glas_tinted_" .. part_name
        local def_table = core.registered_nodes[ingredient]

        if def_table ~= nil then

            unilib.pkg.shared_fachwerk.register_timber_frame({
                -- Original to unilib. Creates unilib:glass_tinted_black_with_frame_timber, etc
                ingredient = ingredient,
                orig_name = nil,

                replace_mode = mode,
                simple_flag = true,
                transparent_flag = true,
            })

        end

    end

end
