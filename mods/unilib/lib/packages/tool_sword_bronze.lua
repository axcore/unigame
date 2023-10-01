---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_bronze = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_bronze.init()

    return {
        description = "Bronze sword",
        depends = "metal_bronze",
    }

end

function unilib.pkg.tool_sword_bronze.exec()

    unilib.register_tool("unilib:tool_sword_bronze", "default:sword_bronze", mode, {
        -- From default:sword_bronze
        description = S("Bronze Sword"),
        inventory_image = "unilib_tool_sword_bronze.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.8,
            groupcaps = {
                snappy = {times = {[1] = 2.75, [2] = 1.30, [3] = 0.375}, uses = 25, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From default:sword_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_bronze", "sword")

end
