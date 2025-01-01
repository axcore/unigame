---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_bronze.init()

    return {
        description = "Bronze axe",
        depends = "metal_bronze",
    }

end

function unilib.pkg.tool_axe_bronze.exec()

    unilib.register_tool("unilib:tool_axe_bronze", "default:axe_bronze", mode, {
        -- From default:axe_bronze
        description = S("Bronze Axe"),
        inventory_image = "unilib_tool_axe_bronze.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            groupcaps = {
                choppy = {times = {[1] = 2.75, [2] = 1.70, [3] = 1.15}, uses = 20, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_axe({
        -- From default:axe_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_axe_bronze", "axe")

end
