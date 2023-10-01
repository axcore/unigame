---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_hatch_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_hatch_wood.init()

    return {
        description = "Wooden hatch",
        notes = "This trapdoor is not compatible with mesecons",
        depends = "shared_cottages",
    }

end

function unilib.pkg.trapdoor_hatch_wood.exec()

    unilib.pkg.shared_cottages.register_hatch({
        -- From cottages:hatch_wood
        part_name = "wood",
        orig_name = "cottages:hatch_wood",
        img = "unilib_misc_wood_rustic.png",
        -- N.B. Original code used "stairs:slab_wood"
        ingredient = "group:wood_stair_slab",

        replace_mode = mode,
        description = S("Wooden Hatch"),
    })

end
