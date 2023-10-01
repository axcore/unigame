---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seagrass_zostera = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seagrass_zostera.init()

    return {
        description = "Zostera seagrass",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.plant_seagrass_zostera.exec()

    unilib.pkg.shared_decorations_sea.register_seagrass({
        -- From decorations_sea:seagrass_04. Creates unilib:plant_seagrass_zostera
        part_name = "zostera",
        orig_name = "decorations_sea:seagrass_04",

        replace_mode = mode,
        description = S("Zostera Seagrass"),
        max_height = 1,
        sci_name = "Zostera muelleri",
    })
    -- (not compatible with flowerpots)

    unilib.pkg.shared_decorations_sea.register_simple_decoration(
        -- From decorations_sea/mapgen.lua
        "plant_seagrass_zostera", 1, "short_grass"
    )

end
