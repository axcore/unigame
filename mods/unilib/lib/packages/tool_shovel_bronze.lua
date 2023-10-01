---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_bronze = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_bronze.init()

    return {
        description = "Bronze shovel",
        depends = "metal_bronze",
    }

end

function unilib.pkg.tool_shovel_bronze.exec()

    unilib.register_tool("unilib:tool_shovel_bronze", "default:shovel_bronze", mode, {
        -- From default:shovel_bronze
        description = S("Bronze Shovel"),
        inventory_image = "unilib_tool_shovel_bronze.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1.1,
            groupcaps = {
                crumbly = {times = {[1] = 1.65, [2] = 1.05, [3] = 0.45}, uses = 25, maxlevel = 2},
            },
            max_drop_level = 1,
        },
        wield_image = "unilib_tool_shovel_bronze.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From default:shovel_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })
    unilib.apply_toolranks("unilib:tool_shovel_bronze", "shovel")

end
