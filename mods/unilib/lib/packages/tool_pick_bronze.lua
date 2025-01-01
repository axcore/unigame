---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_bronze.init()

    return {
        description = "Bronze pickaxe",
        depends = "metal_bronze",
    }

end

function unilib.pkg.tool_pick_bronze.exec()

    unilib.register_tool("unilib:tool_pick_bronze", "default:pick_bronze", mode, {
        -- From default:pick_bronze
        description = S("Bronze Pickaxe"),
        inventory_image = "unilib_tool_pick_bronze.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            groupcaps = {
                cracky = {times = {[1] = 4.50, [2] = 1.80, [3] = 0.90}, uses = 20, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From default:pick_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_bronze", "pickaxe")

end
