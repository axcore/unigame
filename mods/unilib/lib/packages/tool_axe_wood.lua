---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_wood.init()

    return {
        description = "Wood axe",
    }

end

function unilib.pkg.tool_axe_wood.exec()

    unilib.register_tool("unilib:tool_axe_wood", "default:axe_wood", mode, {
        -- From default:axe_wood
        description = S("Wooden Axe"),
        inventory_image = "unilib_tool_axe_wood.png",
        groups = {axe = 1, flammable = 2},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 2},
            full_punch_interval = 1.0,
            groupcaps = {
                choppy = {times = {[2] = 3.00, [3] = 1.60}, uses = 10, maxlevel = 1},
            },
            max_drop_level = 0,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From default:axe_wood
        part_name = "wood",
        ingredient = "group:wood",
    })
    unilib.register_craft({
        -- From default:axe_wood
        type = "fuel",
        recipe = "unilib:tool_axe_wood",
        burntime = 6,
    })
    unilib.apply_toolranks("unilib:tool_axe_wood", "axe")

end
