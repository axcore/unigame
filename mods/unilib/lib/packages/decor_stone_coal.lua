---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_coal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_coal.init()

    return {
        description = "Decorative coal stone",
        depends = {"mineral_coal", "stone_ordinary"},
        optional = "metal_steel",
    }

end

function unilib.pkg.decor_stone_coal.exec()

    unilib.register_node("unilib:decor_stone_coal", "moreblocks:coal_stone", mode, {
        -- From moreblocks:coal_stone
        description = S("Decorative Coal Stone"),
        tiles = {"unilib_decor_stone_coal.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:coal_stone
        type = "shapeless",
        output = "unilib:decor_stone_coal",
        recipe = {"unilib:mineral_coal_lump", "unilib:stone_ordinary"},
    })
    if unilib.pkg_executed_table["metal_steel"] ~= nil then

        unilib.register_craft({
            -- From moreblocks:coal_stone
            type = "shapeless",
            output = "unilib:stone_ordinary",
            recipe = {"unilib:metal_steel_ingot", "unilib:decor_stone_coal"},
        })

    end
    unilib.register_stairs("unilib:decor_stone_coal")

end
