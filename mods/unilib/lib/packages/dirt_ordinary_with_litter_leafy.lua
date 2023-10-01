---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_litter_leafy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_litter_leafy.init()

    return {
        description = "Ordinary dirt with leafy litter",
        depends = "dirt_ordinary",
        optional = "soil_ordinary",
    }

end

function unilib.pkg.dirt_ordinary_with_litter_leafy.exec()

    unilib.register_node(
        -- From farlands, mapgen:dirt_with_leafygrass
        "unilib:dirt_ordinary_with_litter_leafy",
        "mapgen:dirt_with_leafygrass",
        mode,
        {
            description = S("Ordinary Dirt with Leafy Litter"),
            tiles = {
                "unilib_litter_leafy.png",
                "unilib_dirt_ordinary.png",
                "unilib_dirt_ordinary.png^unilib_litter_leafy_side.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            -- N.B. no drop in original code
            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )
    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then

        -- N.B. no soil in original code
        unilib.override_item("unilib:dirt_ordinary_with_litter_leafy", {
            soil = {
                base = "unilib:dirt_ordinary_with_litter_leafy",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end

end
