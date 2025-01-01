---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fachwerk
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_frame_timber_clay = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fachwerk.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_frame_timber_clay.init()

    return {
        description = "Timber frame with clay",
        notes = "Creates timber frames from ordinary clay, and (if available) the fifteen" ..
                " (coloured) baked clays",
        depends = {"clay_ordinary", "shared_fachwerk"},
        optional = {"clay_baked_basic", "clay_brown"},
    }

end

function unilib.pkg.decor_frame_timber_clay.exec()

    unilib.pkg.shared_fachwerk.register_timber_frame({
        -- From fachwerk:clay, etc. Creates unilib:clay_ordinary_with_frame_timber, etc
        ingredient = "unilib:clay_ordinary",
        orig_name = "default:clay",

        replace_mode = mode,
    })

    -- Add baked clays in many colours
    if unilib.setting.fachwerk_extra_nodes_flag and
            unilib.global.pkg_executed_table["clay_baked_basic"] ~= nil then

        local clay_list = {
            "black", "blue", "brown", "cyan", "green", "green_dark", "grey", "grey_dark",
            "magenta", "natural", "orange", "pink", "red", "violet", "white", "yellow",
        }

        for _, part_name in pairs(clay_list) do

            local ingredient = "unilib:clay_baked_" .. part_name
            local def_table = core.registered_nodes[ingredient]

            if def_table ~= nil then

                unilib.pkg.shared_fachwerk.register_timber_frame({
                    -- Original to unilib. Creates unilib:clay_baked_black_with_frame_timber, etc
                    ingredient = ingredient,
                    orig_name = nil,

                    replace_mode = mode,
                })

            end

        end

    end

    -- Also add brown clays, because they are ubiquitous in the "underground challenge" mod
    if unilib.setting.fachwerk_extra_nodes_flag and
            unilib.global.pkg_executed_table["clay_brown"] ~= nil then

        unilib.pkg.shared_fachwerk.register_timber_frame({
            -- Original to unilib. Creates unilib:clay_baked_black_with_frame_timber, etc
            ingredient = "unilib:clay_brown",
            orig_name = nil,

            replace_mode = mode,
        })

    end

end
