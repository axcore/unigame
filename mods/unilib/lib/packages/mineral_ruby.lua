---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_ruby = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_ruby.init()

    return {
        description = "Ruby (as a mineral)",
    }

end

function unilib.pkg.mineral_ruby.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "ruby",
        description = S("Ruby"),

        gem_flag = true,
        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_ruby_gem", "underch:ruby", mode, {
        -- From underch:ruby
        description = S("Ruby"),
        inventory_image = "unilib_mineral_ruby_gem.png",
    })
    unilib.register_craft({
        -- From underch:ruby
        type = "shapeless",
        output = "unilib:mineral_ruby_gem 9",
        recipe = {"unilib:mineral_ruby_block"}
    })
    unilib.register_craft({
        -- From underch:ruby
        type = "shapeless",
        output = "unilib:mineral_ruby_gem 2",
        recipe = {"unilib:mineral_ruby_crystal_large"}
    })

    unilib.register_node("unilib:mineral_ruby_block", "underch:ruby_block", mode, {
        -- From underch:ruby_block
        description = S("Ruby Block"),
        tiles = {"unilib_mineral_ruby_block.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.glass,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From underch:ruby_block
        output = "unilib:mineral_ruby_block",
        ingredient = "unilib:mineral_ruby_gem",
    })
    unilib.register_stairs("unilib:mineral_ruby_block")

    unilib.register_node("unilib:mineral_ruby_crystal_large", "underch:ruby_crystal", mode, {
        -- From underch:ruby_crystal
        description = S("Large Ruby Crystal"),
        tiles = {"unilib_mineral_ruby_crystal_large.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.glass,

        drawtype = "mesh",
        is_ground_content = false,
        light_source = 4,
        mesh = "unilib_mineral_crystal_large.obj",
        paramtype = "light",
        paramtype2 = "facedir",
    })

end
