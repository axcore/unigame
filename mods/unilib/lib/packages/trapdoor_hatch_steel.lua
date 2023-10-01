---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_hatch_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_hatch_steel.init()

    return {
        description = "Steel hatch",
        notes = "This trapdoor is not compatible with mesecons",
        depends = {"metal_steel", "shared_cottages"},
    }

end

function unilib.pkg.trapdoor_hatch_steel.exec()

    unilib.pkg.shared_cottages.register_hatch({
        -- From cottages:hatch_steel
        part_name = "steel",
        orig_name = "cottages:hatch_steel",
        img = "unilib_metal_steel_block.png",
        ingredient = "unilib:metal_steel_ingot",

        replace_mode = mode,
        description = S("Steel Hatch"),
    })

end
