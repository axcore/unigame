---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.rail_copper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rail_copper.init()

    return {
        description = "Copper rail",
        depends = {"metal_copper", "shared_carts"},
    }

end

function unilib.pkg.rail_copper.exec()

    unilib.pkg.shared_carts.register_rail({
        -- From moreores:copper_rail. Creates unilib:rail_copper
        part_name = "copper",
        orig_name = "moreores:copper_rail",
        replace_mode = mode,

        def_table = {
            description = S("Copper Rail"),
            tiles = {
                "unilib_rail_copper_straight.png",
                "unilib_rail_copper_curved.png",
                "unilib_rail_copper_tjunction.png",
                "unilib_rail_copper_crossing.png"
            },
            inventory_image = "unilib_rail_copper_straight.png",
            wield_image = "unilib_rail_copper_straight.png",
        },
        multiple = 24,
        param_table = {},
        recipe_table = {
            {"unilib:metal_copper_ingot", "group:wood", "unilib:metal_copper_ingot"},
            {"unilib:metal_copper_ingot", "", "unilib:metal_copper_ingot"},
            {"unilib:metal_copper_ingot", "group:wood", "unilib:metal_copper_ingot"},
        }
    })

end
