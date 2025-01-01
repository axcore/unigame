---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carts
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.rail_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.carts.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rail_ordinary.init()

    return {
        description = "Ordinary rail",
        depends = {"metal_steel", "shared_carts"},
    }

end

function unilib.pkg.rail_ordinary.exec()

    local multiple
    if not unilib.setting.mtgame_tweak_flag then
        multiple = 18       -- From carts
    else
        multiple = 27       -- From moreblocks
    end

    unilib.pkg.shared_carts.register_rail({
        -- From carts:rail. Creates unilib:rail_ordinary
        part_name = "ordinary",
        orig_name = "carts:rail",
        replace_mode = mode,

        def_table = {
            description = S("Ordinary Rail"),
            tiles = {
                "unilib_rail_ordinary_straight.png",
                "unilib_rail_ordinary_curved.png",
                "unilib_rail_ordinary_tjunction.png",
                "unilib_rail_ordinary_crossing.png"
            },
            inventory_image = "unilib_rail_ordinary_straight.png",
            wield_image = "unilib_rail_ordinary_straight.png",
        },
        multiple = multiple,
        param_table = {},
        recipe_table = {
            {"unilib:metal_steel_ingot", "group:wood", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "group:wood", "unilib:metal_steel_ingot"},
        },
    })

end
