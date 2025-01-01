---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sapphire = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sapphire.init()

    return {
        description = "Sapphire (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_sapphire.exec()

    local no_lump_flag = true
    if unilib.setting.underch_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then
        no_lump_flag = false
    end

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sapphire",
        description = S("Sapphire"),

        gem_flag = true,
        hardness = 3,
        no_lump_flag = no_lump_flag,
    })

    if unilib.setting.underch_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        -- (Dropped instead of the gem variant, if the polishing machine is available)
        unilib.register_craftitem("unilib:mineral_sapphire_lump", nil, mode, {
            -- Original to unilib
            description = S("Sapphire Lump"),
            inventory_image = "unilib_mineral_sapphire_lump.png",
        })

    end

    unilib.register_craftitem("unilib:mineral_sapphire_gem", "underch:sapphire", mode, {
        -- From underch:sapphire
        description = S("Sapphire Gem"),
        inventory_image = "unilib_mineral_sapphire_gem.png",
    })
    unilib.register_craft({
        -- From underch:sapphire
        type = "shapeless",
        output = "unilib:mineral_sapphire_gem 9",
        recipe = {"unilib:mineral_sapphire_block"},
    })
    unilib.register_craft({
        -- From underch:sapphire
        type = "shapeless",
        output = "unilib:mineral_sapphire_gem 2",
        recipe = {"unilib:mineral_sapphire_crystal_large"},
    })

    unilib.register_node("unilib:mineral_sapphire_block", "underch:sapphire_block", mode, {
        -- From underch:sapphire_block
        description = S("Sapphire Block"),
        tiles = {"unilib_mineral_sapphire_block.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.glass,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From underch:sapphire_block
        output = "unilib:mineral_sapphire_block",
        ingredient = "unilib:mineral_sapphire_gem",
    })
    unilib.register_stairs("unilib:mineral_sapphire_block")
    unilib.register_carvings("unilib:mineral_sapphire_block", {
        millwork_flag = true,
    })

    unilib.register_node(
        -- From underch:sapphire_crystal
        "unilib:mineral_sapphire_crystal_large",
        "underch:sapphire_crystal",
        mode,
        {
            description = S("Large Sapphire Crystal"),
            tiles = {"unilib_mineral_sapphire_crystal_large.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.glass,

            drawtype = "mesh",
            is_ground_content = false,
            light_source = 4,
            mesh = "unilib_mineral_crystal_large.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        }
    )

end
