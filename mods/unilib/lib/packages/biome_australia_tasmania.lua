---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_tasmania = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_tasmania.init()

    return {
        description = "Tasmania biome",
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_tasmania.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf"

    else

        node_filler = "unilib:dirt_antipodean"
        -- Produces unilib:dirt_antipodean_dark_with_turf_tasmania
        node_top = unilib.pkg.dirt_custom_antipodean.generate_dark_antipodean_dirt(
            "tasmania", S("Tasmania Turf"), "#98A102:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_tasmania.lua, "tasmania" biome
        name = "australia_tasmania",
        description = unilib.utils.brackets(S("Tasmania biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 3,
        y_max = unilib.constant.y_max,
        y_min = 36,
        heat_point = 15,
        humidity_point = 85,
    })

end
