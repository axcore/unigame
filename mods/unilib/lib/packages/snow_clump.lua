---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.snow_clump = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.snow_clump.init()

    return {
        description = "Clump of snow",
        notes = "Looks superficially similar to the ordinary snow (when in the player's" ..
                " inventory), but this clump cannot be placed in the world, and is dropped by" ..
                " non-ordinary snows (compacted, heavy, soft and firn)",
        notes = "Dropped by various snow blocks from the pedology mod",
    }

end

function unilib.pkg.snow_clump.exec()

    unilib.register_craftitem("unilib:snow_clump", "pedology:lump_snow", mode, {
        -- From pedology:lump_snow
        description = S("Clump of Snow"),
        inventory_image = "unilib_snow_clump.png",

        wield_image = "unilib_snow_clump.png",
    })

end
