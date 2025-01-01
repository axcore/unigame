---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_antipodean.init()

    return {
        description = "Antipodean dirt",
    }

end

function unilib.pkg.dirt_antipodean.exec()

    unilib.register_fertile_dirt({
        -- Original code, textures from aotearoa. Creates unilib:dirt_antipodean
        part_name = "dirt_antipodean",
        orig_name = nil,
        def_table = {
            description = S("Antipodean Dirt"),
            tiles = {"unilib_dirt_antipodean.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Antipodean Dirt"),
        compressed_group_table = {crumbly = 2},
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
    })

end
