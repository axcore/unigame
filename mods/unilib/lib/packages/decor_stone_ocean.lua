---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_ocean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_ocean.init()

    return {
        description = "Decorative ocean stone",
        depends = "stone_ocean",
    }

end

function unilib.pkg.decor_stone_ocean.exec()

    unilib.register_node("unilib:decor_stone_ocean_carved", "xocean:ocean_carved", mode, {
        -- From xocean:ocean_carved
        description = unilib.utils.brackets(S("Decorative Ocean Stone"), S("Rough carving")),
        tiles = {"unilib_decor_stone_ocean_carved.png"},
        groups = {cracky = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From xocean:ocean_carved
        output = "unilib:decor_stone_ocean_carved",
        ingredient = "unilib:stone_ocean",
    })

    unilib.register_node("unilib:decor_stone_ocean_circle", "xocean:ocean_circular", mode, {
        -- From xocean:ocean_circular
        description = unilib.utils.brackets(S("Decorative Ocean Stone"), S("Circular carving")),
        tiles = {"unilib_decor_stone_ocean_circle.png"},
        groups = {cracky = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From xocean:ocean_circular
        output = "unilib:decor_stone_ocean_circle",
        ingredient = "unilib:decor_stone_ocean_carved",
    })

    unilib.register_node("unilib:decor_stone_ocean_pillar", "xocean:ocean_pillar", mode, {
        -- From xocean:ocean_pillar
        description = unilib.utils.brackets(S("Decorative Ocean Stone"), S("Pillar carving")),
        tiles = {"unilib_decor_stone_ocean_pillar.png"},
        groups = {cracky = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From xocean:ocean_pillar
        output = "unilib:decor_stone_ocean_pillar",
        ingredient = "unilib:stone_ocean_brick",
    })

end
