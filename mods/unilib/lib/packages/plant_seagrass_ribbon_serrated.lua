---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seagrass_ribbon_serrated = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seagrass_ribbon_serrated.init()

    return {
        description = "Serrated ribbon seagrass",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.plant_seagrass_ribbon_serrated.exec()

    unilib.pkg.shared_decorations_sea.register_seagrass({
        -- From decorations_sea:seagrass_06. Creates unilib:plant_seagrass_ribbon_serrated
        part_name = "ribbon_serrated",
        orig_name = "decorations_sea:seagrass_06",

        replace_mode = mode,
        description = S("Serrated Ribbon Seagrass"),
        max_height = 1,
        sci_name = "Cymodocea serrulata",
    })
    -- (not compatible with flowerpots)

    unilib.pkg.shared_decorations_sea.register_simple_decoration(
        -- From decorations_sea/mapgen.lua
        "plant_seagrass_ribbon_serrated", 1, "short_grass"
    )

end
