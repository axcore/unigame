---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_silt_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_silt_antipodean.init()

    return {
        description = "Antipodean silt",
        optional = {"clay_ordinary", "dirt_ordinary", "dirt_peat_antipodean", "misc_wood_rotten"},
    }

end

function unilib.pkg.sand_silt_antipodean.exec()

    unilib.register_node("unilib:sand_silt_antipodean", "aotearoa:silt", mode, {
        -- From aotearoa:silt
        description = S("Antipodean Silt"),
        tiles = {"unilib_sand_silt_antipodean.png"},
        groups = {crumbly = 3, soil = 1},
        sounds = unilib.global.sound_table.dirt,
    })
    if unilib.global.pkg_executed_table["clay_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        if unilib.global.pkg_executed_table["dirt_peat_antipodean"] ~= nil then

            unilib.register_craft({
                -- From aotearoa:silt
                output = "unilib:dirt_ordinary 4",
                recipe = {
                    {"group:sand", "unilib:clay_ordinary"},
                    {"unilib:sand_silt_antipodean", "unilib:dirt_peat_antipodean"},
                },
            })

        end
        if unilib.global.pkg_executed_table["misc_wood_rotten"] ~= nil then

            unilib.register_craft({
                -- From aotearoa:silt
                output = "unilib:dirt_ordinary 4",
                recipe = {
                    {"group:sand", "unilib:clay_ordinary"},
                    {"unilib:sand_silt_antipodean", "unilib:misc_wood_rotten"},
                },
            })

        end

    end

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_silt_antipodean_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Antipodean Silt"),
            tiles = {"unilib_sand_silt_antipodean_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_silt_antipodean", "unilib:sand_silt_antipodean_compressed"
        )

    end

end
