---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_watermelon_tiny = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_watermelon_tiny.init()

    return {
        description = "Tiny watermelon",
        optional = {"dye_basic", "item_fertiliser_mulch"},
    }

end

function unilib.pkg.crop_watermelon_tiny.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:watermelon_plant_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:seed_watermelon_plant (creates unilib:crop_watermelon_tiny_seed),
        --      cropocalypse:watermelon_plant_1 etc (creates unilib:crop_watermelon_tiny_grow_1
        --      etc)
        part_name = "watermelon_tiny",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:watermelon_plant",
        seed_orig_name = "cropocalypse:seed_watermelon_plant",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        harvest_description = S("Tiny Watermelon"),
        harvest_group_table = {crop_watermelon = 1, flammable = 4},
        -- N.B. The harvestable item is the node defined below, not a craftitem as usual
        harvest_override = "unilib:crop_watermelon_tiny_harvest",
        max_light = unilib.constant.light_max,
        min_light = 13,
        place_param2 = 3,
        seed_description = S("Tiny Watermelon Seed"),
    })

    -- N.B. The harvestable item is the node defined below, not a craftitem as usual
    unilib.register_node(
        -- From cropocalypse:watermelon_plant
        "unilib:crop_watermelon_tiny_harvest",
        "cropocalypse:watermelon_plant",
        mode,
        {
            description = S("Tiny Watermelon"),
            tiles = {
                "unilib_crop_watermelon_tiny_harvest_top.png",
                "unilib_crop_watermelon_tiny_harvest_top.png",
                "unilib_crop_watermelon_tiny_harvest.png",
                "unilib_crop_watermelon_tiny_harvest.png",
                "unilib_crop_watermelon_tiny_harvest.png",
                "unilib_crop_watermelon_tiny_harvest.png"
            },
            -- N.B. plant = 1 not in original code; added for compatibility with other harvested
            --      pumpkin nodes
            groups = {
                choppy = 2, flammable = 1, oddly_breakable_by_hand = 2, plant = 1, watermelon = 1,
            },
            sounds = unilib.global.sound_table.wood,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.25, -0.5, -0.25, 0.25, 0, 0.25},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "clip",
        }
    )
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green_dark 2",
            recipe = {
                {"unilib:crop_watermelon_tiny_harvest"},
            },
        })

    end

    if unilib.global.pkg_executed_table["item_fertiliser_mulch"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:watermelon_plant
            type = "shapeless",
            output = "unilib:item_fertiliser_mulch",
            recipe = {"unilib:crop_watermelon_tiny_harvest"},
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_watermelon_tiny_harvest",
        juice_description = S("Watermelon"),
        juice_type = "watermelon",
        rgb = "#ba1c19",

        orig_flag = false,
    })

end
