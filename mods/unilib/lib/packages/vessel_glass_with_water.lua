---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_glass_with_water = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_glass_with_water.init()

    return {
        description = "Glass of water",
        depends = "vessel_glass_empty",
        optional = "item_fibre_hemp",
    }

end

function unilib.pkg.vessel_glass_with_water.exec()

    -- N.B. Converted the original mod's craftitem into a node, to match other glass vessels
    --[[
    unilib.register_craftitem("unilib:vessel_glass_with_water", "farming:glass_water", mode, {
        -- From farming:glass_water
        description = S("Glass of Water"),
        inventory_image = "unilib_vessel_glass_with_water.png",
        groups = {flammable = 3, food_water_glass = 1, vessel = 1},
    })
    ]]--
    unilib.register_node("unilib:vessel_glass_with_water", "farming:glass_water", mode, {
        -- From farming:glass_water
        description = S("Glass of Water"),
        tiles = {"unilib_vessel_glass_with_water.png"},
        -- N.B. No attached_node = 1, dig_immediate = 3 in original code; omitted flammable = 3
        groups = {attached_node = 1, dig_immediate = 3, food_water_glass = 1, vessel = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_vessel_glass_with_water.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        walkable = false,
        wield_image = "unilib_vessel_glass_with_water.png",

        -- N.B. No .on_use() in original code (the glass of water could not be drunk)
        on_use = unilib.cuisine.drink_on_use(
            "unilib:vessel_glass_with_water", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.vessel_glass_with_water.post()

    local c_vessel = "unilib:vessel_glass_empty"

    unilib.register_craft({
        -- From farming:glass_water
        output = "unilib:vessel_glass_with_water 4",
        recipe = {
            {c_vessel, c_vessel},
            {c_vessel, c_vessel},
            {"group:potable_bucket", ""},
        },
        replacements = unilib.global.potable_bucket_list,
    })

    if unilib.global.pkg_executed_table["item_fibre_hemp"] ~= nil then

        -- In the original code, the crafting recipe required hemp for river water, but no hemp for
        --      (ordinary) water
        -- However, in unilib ordinary water is defined as potable. Therefore only add this craft
        --      recipe if there's a bucket of non-potable water with which to use it
        for _, data_table in pairs(unilib.global.full_bucket_table) do

            if data_table.water_flag and not data_table.potable_flag then

                unilib.register_craft({
                    -- From farming:glass_water
                    output = "unilib:vessel_glass_with_water 4",
                    recipe = {
                        {c_vessel, c_vessel},
                        {c_vessel, c_vessel},
                        {"group:water_bucket", "unilib:item_fibre_hemp"},
                    },
                    replacements = unilib.global.water_bucket_list,
                })

                break

            end

        end

    end

end
