---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat_antipodean.init()

    return {
        description = "Antipodean peat",
        notes = "Occasionally drops iron",
        depends = "metal_iron",
    }

end

function unilib.pkg.dirt_peat_antipodean.exec()

    unilib.register_node("unilib:dirt_peat_antipodean", "aotearoa:peat", mode, {
        -- From aotearoa:peat
        description = S("Antipodean Peat"),
        tiles = {"unilib_dirt_peat_antipodean.png"},
        groups = {crumbly = 3},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
            dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
        }),

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:metal_iron_lump"}, rarity = 200},
                {items = {"unilib:dirt_peat_antipodean"}},
            },
        },
        is_ground_content = unilib.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From aotearoa:peat
        type = "fuel",
        recipe = "unilib:dirt_peat_antipodean",
        burntime = 30,
    })

end
