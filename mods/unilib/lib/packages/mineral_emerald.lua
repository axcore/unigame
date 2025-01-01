---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_emerald = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_emerald.init()

    return {
        description = "Emerald (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_emerald.exec()

    local no_lump_flag = true
    if unilib.setting.underch_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then
        no_lump_flag = false
    end

    unilib.register_mineral({
        -- Original to unilib
        part_name = "emerald",
        description = S("Emerald"),

        gem_flag = true,
        hardness = 3,
        no_lump_flag = no_lump_flag,
    })

    if unilib.setting.underch_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        -- (Dropped instead of the gem variant, if the polishing machine is available)
        unilib.register_craftitem("unilib:mineral_emerald_lump", nil, mode, {
            -- Original to unilib
            description = S("Emerald Lump"),
            inventory_image = "unilib_mineral_emerald_lump.png",
        })

    end

    unilib.register_craftitem("unilib:mineral_emerald_gem", "underch:emerald", mode, {
        -- From underch:emerald
        description = S("Emerald Gem"),
        inventory_image = "unilib_mineral_emerald_gem.png",
    })
    unilib.register_craft({
        -- From underch:emerald
        type = "shapeless",
        output = "unilib:mineral_emerald_gem 9",
        recipe = {"unilib:mineral_emerald_block"},
    })
    unilib.register_craft({
        -- From underch:emerald
        type = "shapeless",
        output = "unilib:mineral_emerald_gem 2",
        recipe = {"unilib:mineral_emerald_crystal_large"},
    })

    unilib.register_node("unilib:mineral_emerald_block", "underch:emerald_block", mode, {
        -- From underch:emerald_block
        description = S("Emerald Block"),
        tiles = {"unilib_mineral_emerald_block.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.glass,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From underch:emerald_block
        output = "unilib:mineral_emerald_block",
        ingredient = "unilib:mineral_emerald_gem",
    })
    unilib.register_stairs("unilib:mineral_emerald_block")
    unilib.register_carvings("unilib:mineral_emerald_block", {
        millwork_flag = true,
    })

    unilib.register_node("unilib:mineral_emerald_crystal_large", "underch:emerald_crystal", mode, {
        -- From underch:emerald_crystal
        description = S("Large Emerald Crystal"),
        tiles = {"unilib_mineral_emerald_crystal_large.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.glass,

        drawtype = "mesh",
        is_ground_content = false,
        light_source = 4,
        mesh = "unilib_mineral_crystal_large.obj",
        paramtype = "light",
        paramtype2 = "facedir",
    })

end
