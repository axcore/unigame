---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_bronze.init()

    return {
        description = "Bronze ladder",
        depends = "metal_bronze",
    }

end

function unilib.pkg.ladder_bronze.exec()

    unilib.register_ladder({
        -- From mtg_plus:ladder_bronze. Creates unilib:ladder_bronze
        part_name = "bronze",
        orig_name = "mtg_plus:ladder_bronze",
        ingredient = "unilib:metal_bronze_ingot",

        replace_mode = mode,
        description = S("Bronze Ladder"),
        group_table = {cracky = 2},
        multiple = 15,
        sound_name = "metal",
    })

end
