---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_petz_straw = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

local edible_table = {
    -- (From "misc_straw_ordinary_block" package)
    ["unilib:misc_straw_ordinary_block"] = true,
    ["bale:bale"] = true,
    -- (From "misc_straw_ordinary" package)
    ["unilib:misc_straw_ordinary_bale"] = true,
    ["darkage:straw_bale"] = true,
    -- (From "misc_straw_ordinary_bound" package)
    ["unilib:misc_straw_ordinary_bound"] = true,
    ["castle_farming:bound_straw"] = true,
}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_straw.is_straw_edible(full_name)

    -- Original to unimobs
    -- Original petz modpack only marks one item (bale:bale) as edible by creatures; unimobs
    --      designates a wider range of straw items as edible

    if edible_table[full_name] then
        return true
    else
        return false
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_straw.init()

    return {
        description = "Shared functions for edible straw (from petz)",
    }

end
