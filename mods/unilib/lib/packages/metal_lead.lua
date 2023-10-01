---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_lead = {}

local S = unilib.intllib
local technic_add_mode = unilib.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_lead.init()

    return {
        description = "Lead",
    }

end

function unilib.pkg.metal_lead.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "lead",
        description = S("Lead"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_lead_lump", "technic:lead_lump", worldgen_add_mode, {
        -- From technic:lead_lump
        description = S("Lead Lump"),
        inventory_image = "unilib_metal_lead_lump.png",
    })

    unilib.register_metal_powder({
        -- From technic:lead_dust. Creates unilib:metal_lead_powder
        part_name = "lead",
        orig_name = "technic:lead_dust",

        replace_mode = technic_add_mode,
        description = S("Lead Powder"),
    })

    unilib.register_craftitem("unilib:metal_lead_ingot", "technic:lead_ingot", worldgen_add_mode, {
        -- From unilib:metal_lead_ingot
        description = S("Lead Ingot"),
        inventory_image = "unilib_metal_lead_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From unilib:metal_lead_ingot
        type = "cooking",
        output = "unilib:metal_lead_ingot",
        recipe = "unilib:metal_lead_lump",
    })
    unilib.register_craft({
        -- From unilib:metal_lead_ingot
        output = "unilib:metal_lead_ingot 9",
        recipe = {
            {"unilib:metal_lead_block"},
        }
    })

    unilib.register_node("unilib:metal_lead_block", "technic:lead_block", worldgen_add_mode, {
        -- From technic:lead_block
        description = S("Lead Block"),
        tiles = {"unilib_metal_lead_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_3x3({
        -- From technic:lead_block
        output = "unilib:metal_lead_block",
        ingredient = "unilib:metal_lead_ingot",
    })

end
