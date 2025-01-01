---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_gaia = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_gaia.init()

    -- MT setting changes, that would normally go in override.lua, go here

    -- (Resetting the list of super dirts requires special handling, as
    --      unilib.global.super_dirt_table has already been set up)
    local super_dirt_set
    unilib.global.super_dirt_table = {}

    for _, super_dirt in pairs({
        "black", "brown", "clayey", "coarse", "dark", "dried", "dry", "ordinary", "parched",
        "sandy", "silt_coarse", "silt_fine"
    }) do
        if super_dirt_set == nil then
            super_dirt_set = super_dirt
        else
            super_dirt_set = super_dirt_set .. " " .. super_dirt
        end

        unilib.global.super_dirt_table[super_dirt] = true
        unilib.global.super_dirt_table["dirt_" .. super_dirt] = true

    end

    unilib.super_dirt_set = super_dirt_set

    return {
        description = "Override package for the \"gaia\" remix",
        notes = "This is an optional addition to the \"gaia\" remix, automatically overriding" ..
                " some Minetest settings to produce a customised player experience",
    }

end
