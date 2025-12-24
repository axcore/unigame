---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_crook_shepherd = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_crook_shepherd.init()

    return {
        description = "Shepherd's crook",
        notes = "Creatures with the \"can_herd_flag\" property (e.g. sheep and goats) will" ..
                " follow any player wielding a crook",
    }

end

function unilib.pkg.tool_crook_shepherd.exec()

    unilib.register_tool("unilib:tool_crook_shepherd", "petz:shepherd_crook", mode, {
        -- From petz:shepherd_crook
        description = S("Shepherd's Crook"),
        inventory_image = "unilib_tool_crook_shepherd.png",

        damage_groups = {fleshy = 1},
        liquids_pointable = false,
        tool_capabilities = {
            groupcaps = {
                crumbly = {times = {[1] = 4.00, [2] = 1.50, [3] = 1.00}, uses = 70, maxlevel = 1}
            },
            max_drop_level = 3,
        },
    })
    unilib.register_craft({
        -- From petz:shepherd_crook
        type = "shaped",
        output = "unilib:tool_crook_shepherd",
        recipe = {
            {"", "group:wood", "unilib:item_whistle_pet"},
            {"", "group:wood", ""},
            {"", "group:wood", ""},
        },
    })

end
