---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local technic_add_mode = unilib.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel.init()

    return {
        description = "Steel (produced from iron)",
        depends = "metal_iron",
    }

end

function unilib.pkg.metal_steel.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "steel",
        description = S("Steel"),

        alloy_flag = true,
        hardness = 2,
    })

    if unilib.technic_update_flag then

        unilib.register_metal_powder({
            -- From technic:wrought_iron_dust. Creates unilib:metal_steel_powder
            part_name = "steel",
            orig_name = "technic:wrought_iron_dust",

            replace_mode = technic_add_mode,
            description = S("Steel Powder"),
            -- (no steel lump, so the code below uses the iron lump)
            no_lump_flag = true,
        })
        technic.register_grinder_recipe({
            output = "unilib:metal_steel_powder " .. tostring(unilib.grind_metal_ratio),
            input = {"unilib:metal_iron_lump"},
        })

    end

    unilib.register_craftitem("unilib:metal_steel_ingot", "default:steel_ingot", default_add_mode, {
        -- From default:steel_ingot
        description = S("Steel Ingot"),
        inventory_image = "unilib_metal_steel_ingot.png",
        -- N.B. no groups in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    unilib.register_craft({
        -- From default:steel_ingot
        type = "cooking",
        output = "unilib:metal_steel_ingot",
        recipe = "unilib:metal_iron_lump",
    })
    unilib.register_craft({
        -- From default:steel_ingot
        output = "unilib:metal_steel_ingot 9",
        recipe = {
            {"unilib:metal_steel_block"},
        }
    })

    unilib.register_node("unilib:metal_steel_block", "default:steelblock", default_add_mode, {
        -- From default:steelblock
        description = S("Steel Block"),
        tiles = {"unilib_metal_steel_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From default:steelblock
        output = "unilib:metal_steel_block",
        ingredient = "unilib:metal_steel_ingot",
    })
    unilib.register_stairs("unilib:metal_steel_block")
    unilib.register_carvings("unilib:metal_steel_block", {
        millwork_flag = true,
    })

end
