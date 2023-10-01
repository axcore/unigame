---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_iron = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_iron.init()

    return {
        description = "Decorative iron stone",
        depends = {"metal_steel", "stone_ordinary"},
        optional = "mineral_coal",
    }

end

function unilib.pkg.decor_stone_iron.exec()

    unilib.register_node("unilib:decor_stone_iron", "moreblocks:iron_stone", mode, {
        -- From moreblocks:iron_stone
        description = S("Decorative Iron Stone"),
        tiles = {"unilib_decor_stone_iron.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:iron_stone
        type = "shapeless",
        output = "unilib:decor_stone_iron",
        recipe = {"unilib:metal_steel_ingot", "unilib:stone_ordinary"},
    })
    if unilib.pkg_executed_table["mineral_coal"] ~= nil then

        unilib.register_craft({
            -- From moreblocks:iron_stone
            type = "shapeless",
            output = "unilib:stone_ordinary",
            recipe = {"unilib:mineral_coal_lump", "unilib:decor_stone_iron"},
        })

    end
    unilib.register_stairs("unilib:decor_stone_iron")

end
