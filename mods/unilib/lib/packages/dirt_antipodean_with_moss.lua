---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_antipodean_with_moss = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_antipodean_with_moss.init()

    return {
        description = "Antipodean dirt with moss",
        depends = "dirt_antipodean",
    }

end

function unilib.pkg.dirt_antipodean_with_moss.exec()

    unilib.register_node(
        -- From aotearoa:dirt_with_moss
        "unilib:dirt_antipodean_with_moss",
        "aotearoa:dirt_with_moss",
        mode,
        {
            description = S("Antipodean Dirt with Moss"),
            tiles = {
                "unilib_dirt_antipodean_with_moss_top.png",
                "unilib_dirt_antipodean.png",
                {
                    name = "unilib_dirt_antipodean.png^unilib_dirt_antipodean_with_moss_side.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            -- N.B. default:dirt in original code
            drop = "unilib:dirt_antipodean",
            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )

end
