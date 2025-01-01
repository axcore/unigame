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

unilib.pkg.mineral_coal = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_coal.init()

    return {
        description = "Coal (as a mineral)",
    }

end

function unilib.pkg.mineral_coal.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "coal",
        description = S("Coal"),

        combustible_flag = true,
        hardness = 1,
        powder_flag = true,
    })

    unilib.register_craftitem("unilib:mineral_coal_lump", "default:coal_lump", default_add_mode, {
        -- From default:coal_lump
        description = S("Coal Lump"),
        inventory_image = "unilib_mineral_coal_lump.png",
        groups = {coal = 1, flammable = 1},
    })
    unilib.register_craft({
        -- From default:coal_lump
        output = "unilib:mineral_coal_lump 9",
        recipe = {
            {"unilib:mineral_coal_block"},
        },
    })
    unilib.register_craft({
        -- From default:coal_lump
        type = "fuel",
        recipe = "unilib:mineral_coal_lump",
        burntime = 40,
    })

    unilib.register_mineral_powder({
        -- From technic:coal_dust. Creates unilib:mineral_coal_powder
        part_name = "coal",
        orig_name = "technic:coal_dust",

        replace_mode = technic_add_mode,
        description = S("Coal Powder"),
    })
    unilib.register_craft({
        -- From technic:coal_dust
        type = "fuel",
        recipe = "unilib:mineral_coal_powder",
        burntime = 50,
    })

    unilib.register_node("unilib:mineral_coal_block", "default:coalblock", default_add_mode, {
        -- From default:coalblock
        description = S("Coal Block"),
        tiles = {"unilib_mineral_coal_block.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From default:coalblock
        output = "unilib:mineral_coal_block",
        ingredient = "unilib:mineral_coal_lump",
    })
    unilib.register_craft({
        -- From default:coalblock
        type = "fuel",
        recipe = "unilib:mineral_coal_block",
        burntime = 370,
    })
    unilib.register_stairs("unilib:mineral_coal_block")
    unilib.register_carvings("unilib:mineral_coal_block", {
        millwork_flag = true,
    })

end
