---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carts
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.rail_ordinary_powered = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.carts.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rail_ordinary_powered.init()

    return {
        description = "Ordinary powered rail",
        depends = {"metal_steel", "mineral_mese", "shared_carts"},
    }

end

function unilib.pkg.rail_ordinary_powered.exec()

    local multiple
    if not unilib.setting.mtgame_tweak_flag then
        multiple = 18       -- From carts
    else
        multiple = 27       -- From moreblocks
    end

    unilib.pkg.shared_carts.register_rail({
        -- From carts:powerrail. Creates unilib:rail_ordinary_powered
        part_name = "ordinary_powered",
        orig_name = "carts:powerrail",
        replace_mode = mode,

        def_table = {
            description = S("Ordinary Powered Rail"),
            tiles = {
                "unilib_rail_ordinary_powered_straight.png",
                "unilib_rail_ordinary_powered_curved.png",
                "unilib_rail_ordinary_powered_tjunction.png",
                "unilib_rail_ordinary_powered_crossing.png"
            },
        },
        multiple = multiple,
        param_table = {acceleration = 5},
        recipe_table = {
            {"unilib:metal_steel_ingot", "group:wood", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:mineral_mese_crystal", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "group:wood", "unilib:metal_steel_ingot"},
        },
    })

end
