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

unilib.pkg.metal_gold = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local technic_add_mode = unilib.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_gold.init()

    return {
        description = "Gold",
    }

end

function unilib.pkg.metal_gold.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "gold",
        description = S("Gold"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_gold_lump", "default:gold_lump", default_add_mode, {
        -- From default:gold_lump
        description = S("Gold Lump"),
        inventory_image = "unilib_metal_gold_lump.png"
    })

    unilib.register_metal_powder({
        -- From technic:gold_dust. Creates unilib:metal_gold_powder
        part_name = "gold",
        orig_name = "technic:gold_dust",

        replace_mode = technic_add_mode,
        description = S("Gold Powder"),
    })

    unilib.register_craftitem("unilib:metal_gold_ingot", "default:gold_ingot", default_add_mode, {
        -- From default:gold_ingot
        description = S("Gold Ingot"),
        inventory_image = "unilib_metal_gold_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From default:gold_ingot
        type = "cooking",
        output = "unilib:metal_gold_ingot",
        recipe = "unilib:metal_gold_lump",
    })
    unilib.register_craft({
        -- From default:gold_ingot
        output = "unilib:metal_gold_ingot 9",
        recipe = {
            {"unilib:metal_gold_block"},
        }
    })

    unilib.register_node("unilib:metal_gold_block", "default:goldblock", default_add_mode, {
        -- From default:goldblock
        description = S("Gold Block"),
        tiles = {"unilib_metal_gold_block.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From default:goldblock
        output = "unilib:metal_gold_block",
        ingredient = "unilib:metal_gold_ingot",
    })
    unilib.register_stairs("unilib:metal_gold_block")
    unilib.register_carvings("unilib:metal_gold_block", {
        millwork_flag = true,
    })

end
