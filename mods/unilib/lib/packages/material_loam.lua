---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.material_loam = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_loam.init()

    return {
        description = "Loam",
        notes = "Apparently, clay was not used as a building material in ancient times, but" ..
                " loam was",
        depends = {"clay_ordinary", "sand_ordinary"},
        optional = "bed_mat_straw",
    }

end

function unilib.pkg.material_loam.exec()

    unilib.register_node("unilib:material_loam", "cottages:loam", mode, {
        -- From cottages:loam
        description = S("Loam"),
        tiles = {"unilib_material_loam.png"},
        -- N.B. Duplicate groups in original code
--      groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From cottages:loam
        output = "unilib:material_loam 4",
        recipe = {
            {"unilib:sand_ordinary"},
            {"unilib:clay_ordinary"},
        }
    })
    unilib.register_stairs("unilib:material_loam")

    if unilib.pkg_executed_table["bed_mat_straw"] ~= nil then

        unilib.register_node("unilib:material_loam_with_straw", "cottages:straw_ground", mode, {
            -- From cottages:straw_ground
            description = S("Loam with Straw Cover"),
            tiles = {"unilib_misc_straw_ordinary.png", "unilib_material_loam.png"},
            -- N.B. Duplicate groups in original code
--          groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
            groups = {crumbly = 3},
            sounds = unilib.sound_table.leaves,

            is_ground_content = false,
        })
        unilib.register_craft({
            -- From cottages:loam
            output = "unilib:material_loam_with_straw 2",
            recipe = {
                {"unilib:bed_mat_straw"},
                {"unilib:material_loam"}
            }
        })

    end

end
