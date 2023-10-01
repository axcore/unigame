---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_silt_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

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
        sounds = unilib.sound_table.dirt,
    })
    unilib.register_stairs("unilib:sand_silt_antipodean", {
        basic_flag = true,
    })
    if unilib.pkg_executed_table["clay_ordinary"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        if unilib.pkg_executed_table["dirt_peat_antipodean"] ~= nil then

            unilib.register_craft({
                -- From aotearoa:silt
                output = "unilib:dirt_ordinary 4",
                recipe = {
                    {"group:sand", "unilib:clay_ordinary"},
                    {"unilib:sand_silt_antipodean", "unilib:dirt_peat_antipodean"},
                }
            })

        end
        if unilib.pkg_executed_table["misc_wood_rotten"] ~= nil then

            unilib.register_craft({
                -- From aotearoa:silt
                output = "unilib:dirt_ordinary 4",
                recipe = {
                    {"group:sand", "unilib:clay_ordinary"},
                    {"unilib:sand_silt_antipodean", "unilib:misc_wood_rotten"},
                }
            })

        end

    end

end
