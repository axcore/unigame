---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_granules_coal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_granules_coal.init()

    return {
        description = "Block of coal granules",
        notes = "Can be used to craft coal blocks, and is flammable",
        optional = "mineral_coal",
    }

end

function unilib.pkg.misc_granules_coal.exec()

    unilib.register_node("unilib:misc_granules_coal_block", "underch:coal_dust", mode, {
        -- From underch:coal_dust
        description = S("Block of Coal Granules"),
        tiles = {"unilib_misc_granules_coal_block.png"},
        groups = {crumbly = 2, falling_node = 1, flammable = 1},
        sounds = unilib.sound_table.sand,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From underch:coal_dust
        type = "fuel",
        recipe = "unilib:misc_granules_coal_block",
        burntime = 40,
    })
    if unilib.pkg_executed_table["mineral_coal"] ~= nil then

        unilib.register_craft_3x3({
            -- From underch:coal_dust
            output = "unilib:mineral_coal_block",
            ingredient = "unilib:misc_granules_coal_block",
        })

    end

end
