---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_cover_fungi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_cover_fungi.init()

    return {
        description = "Ordinary dirt with fungi cover",
        depends = "dirt_ordinary",
        optional = "soil_ordinary",
    }

end

function unilib.pkg.dirt_ordinary_with_cover_fungi.exec()

    unilib.register_node(
        -- From farlands, mapgen:dirt_with_fungi_covered_grass
        "unilib:dirt_ordinary_with_cover_fungi",
        "mapgen:dirt_with_fungi_covered_grass",
        mode,
        {
            description = S("Ordinary Dirt with Fungi Cover"),
            tiles = {
                "unilib_cover_fungi.png",
                "unilib_dirt_ordinary.png",
                "unilib_dirt_ordinary.png^unilib_cover_fungi_side.png",
            },
            groups = {
                crumbly = 1, not_in_creative_inventory = unilib.hide_covered_dirt_group,
                oddly_breakable_by_hand = 1,
            },
            sounds = unilib.global.sound_table.dirt,

            -- N.B. no drop in original code
            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        }
    )
    if unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

        -- N.B. no soil in original code
        unilib.override_item("unilib:dirt_ordinary_with_cover_fungi", {
            soil = {
                base = "unilib:dirt_ordinary_with_cover_fungi",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end

end
