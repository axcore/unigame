---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shears_steel = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shears_steel.init()

    return {
        description = "Steel shears",
        notes = "The default shears for unimobs; however, it can only be used as shears if the" ..
                " item appears in the list of shears in settings (which it does, by default)." ..
                " Can be used to shear sheep, pluck feathers from birds, and to remove various" ..
                " items from ponies. Use shears by right-clicking a creature (usually, they" ..
                " must be tamed first)",
        depends = "metal_steel",
    }

end

function unilib.pkg.tool_shears_steel.exec()

    -- N.B. The code to handle the use of this tool appears elsewhere; for example the code to
    --      shear sheep appears in the "mob_sheep_normal" package

    unilib.register_tool("unilib:tool_shears_steel", "petz:shears", mode, {
        -- From petz:shears
        description = S("Steel Shears"),
        inventory_image = "unilib_tool_shears_steel.png",
        -- N.B. shears = 1 not in original code
        groups = {flammable = 2, shears = 1},
    })
    unilib.register_craft({
        -- From petz:shears
        type = "shaped",
        output = "unilib:tool_shears_steel",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"", "group:stick", "unilib:metal_steel_ingot"},
        },
    })

end
