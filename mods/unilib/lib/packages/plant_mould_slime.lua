---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_mould_slime = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_mould_slime.init()

    return {
        description = "Slime mould",
        notes = "Can be crafted into blocks which cause no fall damage",
        optional = "flower_fire",
    }

end

function unilib.pkg.plant_mould_slime.exec()

    local full_name = "unilib:plant_mould_slime"

    unilib.register_node(full_name, "ethereal:slime_mold", mode, {
        -- From ethereal:slime_mold
        description = S("Slime Mould"),
        tiles = {"unilib_plant_mould_slime.png"},
        groups = {attached_node = 1, crumbly = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "raillike",
        drop = "",
        floodable = true,
        inventory_image = "unilib_plant_mould_slime.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
        },
        walkable = false,
        wield_image = "unilib_plant_mould_slime.png",
        use_texture_alpha = "clip",
    })

    if unilib.global.pkg_executed_table["flower_fire"] ~= nil then

        unilib.register_node("unilib:plant_mould_slime_block", "ethereal:slime_block", mode, {
            -- From ethereal:slime_block
            description = S("Slime Mould Block"),
            tiles = {"unilib_plant_mould_slime_block.png"},
            groups = {bouncy = 100, crumbly = 3, disable_jump = 1, fall_damage_add_percent = -100},
            sounds = unilib.global.sound_table.leaves,

            inventory_image = core.inventorycube("unilib_plant_mould_slime_block.png"),
        })
        unilib.register_craft({
            -- From ethereal:slime_block
            output = "unilib:plant_mould_slime_block",
            recipe = {
                {full_name, full_name, full_name},
                {full_name, "unilib:flower_fire_dust", full_name},
                {full_name, full_name, full_name},
            },
        })

    end

    unilib.register_decoration_generic("ethereal_plant_mould_slime", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:plant_mould_slime",

        fill_ratio = 0.1,
        sidelen = 80,
    })

end
