---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_antipodean_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_antipodean_dark.init()

    return {
        description = "Dark Antipodean dirt",
        optional = "soil_antipodean_dark",
    }

end

function unilib.pkg.dirt_antipodean_dark.exec()

    unilib.register_fertile_dirt({
        -- Original code, textures from aotearoa. Creates unilib:dirt_antipodean_dark
        part_name = "dirt_antipodean_dark",
        orig_name = nil,
        def_table = {
            description = S("Dark Antipodean Dirt"),
            tiles = {"unilib_dirt_antipodean_dark.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Dark Antipodean Dirt"),
        compressed_group_table = {crumbly = 2},
        -- N.B. unilib:soil_ordinary, etc in original code
        dry_soil = "unilib:soil_antipodean_dark",
        wet_soil = "unilib:soil_antipodean_dark_wet",
    })

end
