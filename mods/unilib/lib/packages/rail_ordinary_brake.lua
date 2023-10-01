---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carts
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.rail_ordinary_brake = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.carts.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rail_ordinary_brake.init()

    return {
        description = "Ordinary brake rail",
        depends = {"metal_steel", "mineral_coal", "shared_carts"},
    }

end

function unilib.pkg.rail_ordinary_brake.exec()

    local multiple
    if not unilib.mtgame_tweak_flag then
        multiple = 18       -- From carts
    else
        multiple = 27       -- From moreblocks
    end

    unilib.pkg.shared_carts.register_rail({
        -- From carts:brakerail. Creates unilib:rail_ordinary_brake
        part_name = "ordinary_brake",
        orig_name = "carts:brakerail",
        replace_mode = mode,

        def_table = {
            description = S("Ordinary Braking Rail"),
            tiles = {
                "unilib_rail_ordinary_brake_straight.png",
                "unilib_rail_ordinary_brake_curved.png",
                "unilib_rail_ordinary_brake_tjunction.png",
                "unilib_rail_ordinary_brake_crossing.png"
            },
        },
        multiple = multiple,
        param_table = {acceleration = -3},
        recipe_table = {
            {"unilib:metal_steel_ingot", "group:wood", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:mineral_coal_lump", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "group:wood", "unilib:metal_steel_ingot"},
        }
    })

end
