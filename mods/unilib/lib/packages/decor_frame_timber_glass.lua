---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fachwerk
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_frame_timber_glass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.fachwerk.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_frame_timber_glass.init()

    return {
        description = "Timber frame with glass",
        depends = {"glass_ordinary", "shared_fachwerk"},
        optional = {
            "glass_clean",
            "glass_clean_rhombus",
            "glass_clean_round",
            "glass_clean_square",
            "glass_coal",
            "glass_dirty",
            "glass_glow",
            "glass_glow_rhombus",
            "glass_glow_round",
            "glass_glow_square",
            "glass_glow_super",
            "glass_iron",
            "glass_obsidian",
        },
    }

end

function unilib.pkg.decor_frame_timber_glass.exec()

    unilib.pkg.shared_fachwerk.register_timber_frame({
        -- From fachwerk:glass, etc. Creates unilib:glass_ordinary_with_frame_timber, etc
        ingredient = "unilib:glass_ordinary",
        orig_name = "default:glass",

        replace_mode = mode,
        simple_flag = true,
    })

    if unilib.fachwerk_extra_nodes_flag then

        for _, part_name in pairs({
            "clean", "clean_rhombus", "clean_round", "clean_square", "coal", "dirty", "glow",
            "glow_clean", "glow_rhombus", "glow_round", "glow_square", "glow_super",
            "glow_super_clean", "iron", "obsidian",
        }) do
            -- (To save a bit of time, we won't check the package is loaded; just check whether the
            --      glass node exists
            local ingredient = "unilib:glass_" .. part_name
            local def_table = minetest.registered_nodes[ingredient]

            if def_table ~= nil then

                unilib.pkg.shared_fachwerk.register_timber_frame({
                    -- Original to unilib. Creates unilib:glass_clean_with_frame_timber, etc
                    ingredient = ingredient,
                    orig_name = nil,

                    replace_mode = mode,
                })

            end

        end

    end

end
