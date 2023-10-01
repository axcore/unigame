---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.roof_steel_corrugated = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.roof_steel_corrugated.init()

    return {
        description = "Corrugated steel roofing",
        depends = "metal_steel",
        optional = "metal_steel_scrap",
    }

end

function unilib.pkg.roof_steel_corrugated.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:roof_steel_corrugated", "steel:roofing", mode, {
        -- From steel:roofing
        description = S("Corrugated Steel Roofing"),
        tiles = {"unilib_roof_steel_corrugated.png"},
        groups = {bendy = 2, dig_generic = 1, dig_immediate = 2, snappy = 1},
        -- N.B. No sounds in original code
        sounds = unilib.sound_table.metal,

        drawtype = "raillike",
        inventory_image = "unilib_roof_steel_corrugated.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
        },
        walkable = true,
        wield_image = "unilib_roof_steel_corrugated.png",
    })
    -- N.B. Original craft recipe conflicts with recipe in "misc_walkway" package
    --[[
    unilib.register_craft({
        -- From steel:roofing
        output = "unilib:roof_steel_corrugated 6",
        recipe = {
            {c_ingot, c_ingot, c_ingot},
        },
    })
    ]]--
    unilib.register_craft({
        -- From steel:roofing
        output = "unilib:roof_steel_corrugated 8",
        recipe = {
            {"", c_ingot, ""},
            {c_ingot, c_ingot, c_ingot},
        },
    })
    if unilib.pkg_executed_table["metal_steel_scrap"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:metal_steel_scrap",
            recipe = {
                {"unilib:roof_steel_corrugated"},
            },
        })

    end

end
