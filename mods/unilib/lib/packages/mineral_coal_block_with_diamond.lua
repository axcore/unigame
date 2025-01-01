---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_coal_block_with_diamond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_coal_block_with_diamond.init()

    return {
        description = "Coal block with diamond as ore",
        depends = {"fire_permanent", "mineral_coal", "mineral_diamond"},
    }

end

function unilib.pkg.mineral_coal_block_with_diamond.exec()

    local c_coal_lump = "unilib:mineral_coal_lump"
    local c_diamond = "unilib:mineral_diamond_gem"

    unilib.register_node("unilib:mineral_coal_block_with_diamond", "underch:coal_diamond", mode, {
        -- From underch:coal_diamond
        description = unilib.utils.brackets(S("Diamond Ore"), S("Coal Block")),
        tiles = {"unilib_mineral_coal_block.png^unilib_mineral_diamond.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            items = {
                {items = {c_coal_lump .. " 8", c_diamond}},
            },
        },
        is_ground_content = false,

        after_destruct = unilib.pkg.fire_permanent.remove,
        on_ignite = unilib.pkg.fire_permanent.add,
    })
    unilib.register_craft({
        -- From underch:coal_diamond
        output = "unilib:mineral_coal_block_with_diamond",
        recipe = {
            {c_coal_lump, c_coal_lump, c_coal_lump},
            {c_coal_lump, c_diamond, c_coal_lump},
            {c_coal_lump, c_coal_lump, c_coal_lump},
        },
    })

end
