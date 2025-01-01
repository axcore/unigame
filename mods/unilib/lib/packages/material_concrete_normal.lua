---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cement
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_concrete_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cement.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_concrete_normal.init()

    return {
        description = "Normal concrete",
        notes = "Rough concrete is created when wet cement dries. Using a sander creates smooth" ..
                " concrete. Can be coloured using dyes, or with an airbrush (if the unifieddyes" ..
                " mod is available)",
        depends = "material_cement_normal",
        optional = "dye_basic",
    }

end

function unilib.pkg.material_concrete_normal.exec()

    local dry_img = "unilib_sand_ordinary.png^(unilib_gravel_ordinary.png^[opacity:128)"
    local wet_img = "(" .. dry_img .. ")^[colorize:#000000:60"

    local hard_img = wet_img
    if unilib.setting.concrete_reduce_contrast_flag then
        hard_img = "(" .. wet_img .. ")^[brighten"
    end

    local sanded_img = "(unilib_sand_ordinary.png^(unilib_stone_sandstone_ordinary.png" ..
            "^[opacity:128)^[brighten)"

    local hint = S("can be coloured with dyes")
    if unilib.setting.unifieddyes_update_flag then
        hint = S("can be coloured using a dye airbrush")
    end

    unilib.dyes.register_node_with_dye(
        -- From cement:hard
        "unilib:material_concrete_normal_rough",
        "cement:hard",
        mode,
        {
            description = unilib.utils.hint(S("Rough Normal Concrete"), hint),
            tiles = {hard_img},
            -- N.B. concrete = 1 not in original code; added to match concrete from basic_materials
            groups = {concrete = 1, cracky = 2},
            sounds = unilib.global.sound_table.stone,

--          drawtype = "color",
            is_ground_content = false,
            -- N.B. Specify our own palette, used if basic dyes are used
            palette = "unilib_palette_material_concrete_normal.png",
--          paramtype2 = "color",

--          on_punch = do_colourise,
        }
    )

    unilib.dyes.register_node_with_dye(
        -- From cement:sanded
        "unilib:material_concrete_normal_smooth",
        "cement:sanded",
        mode,
        {
            description = unilib.utils.hint(S("Smooth Normal Concrete"), hint),
            tiles = {sanded_img},
            -- N.B. concrete = 1 not in original code; added to match concrete from basic_materials
            groups = {concrete = 1, cracky = 2},
            sounds = unilib.global.sound_table.stone,

--          drawtype = "color",
            is_ground_content = false,
            -- N.B. Specify our own palette, used if basic dyes are used
            palette = "unilib_palette_material_concrete_normal.png",
--          paramtype2 = "color",

--          on_punch = do_colourise,
        }
    )

end

function unilib.pkg.material_concrete_normal.post()

    -- N.B. The original code only handles ordinary water; here, we will handle all types of water

    -- (Be compatible with minetest_game, because why not)
    local water_list = {
        "default:water_source",
        "default:water_flowing",
        "default:river_water_source",
        "default:river_water_flowing",
    }

    -- Add all unilib waters
    for _, data_table in pairs(unilib.global.generic_liquid_table) do

        if data_table.water_flag then

            table.insert(water_list, data_table.source_name)
            table.insert(water_list, data_table.flowing_name)

        end

    end

    -- Register the ABM
    unilib.register_abm({
        -- From cement/init.lua
        label = "Converts wet cement to concrete [material_concrete_normal]",
        nodenames = {"unilib:material_cement_normal_wet"},

        catch_up = true,
        chance = 3,
        interval = 10,

        action = function(pos, node)

            if core.find_node_near(pos, 1, water_list) == nil then
                core.set_node(pos, {name = "unilib:material_concrete_normal_rough"})
            end

        end,
    })

end
