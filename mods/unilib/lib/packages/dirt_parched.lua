---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_parched = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_parched.init()

    return {
        description = "Parched dirt",
    }

end

function unilib.pkg.dirt_parched.exec()

    unilib.register_fertile_dirt({
        -- From farlands, mapgen:dry_dirt. Creates unilib:dirt_parched
        part_name = "dirt_parched",
        orig_name = "mapgen:dry_dirt",
        def_table = {
            description = S("Parched Dirt"),
            tiles = {"unilib_dirt_parched.png"},
            -- N.B. dry_dirt = 1 not in original code
            groups = {crumbly = 3, dry_dirt = 1},
            sounds = unilib.sound_table.dirt,

            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        -- N.B. no soil in original code; but since "unilib:dirt_dry" has soil, this dirt does too
        dry_soil = "unilib:soil_arid",
        wet_soil = "unilib:soil_arid_wet",
    })

end
