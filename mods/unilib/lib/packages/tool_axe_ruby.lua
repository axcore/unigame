---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_ruby = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_ruby.init()

    return {
        description = "Ruby axe",
        depends = "mineral_ruby",
    }

end

function unilib.pkg.tool_axe_ruby.exec()

    unilib.register_tool("unilib:tool_axe_ruby", "gemtools:axe_ruby", mode, {
        -- From gemtools:axe_ruby
        description = S("Ruby Axe"),
        inventory_image = "unilib_tool_axe_ruby.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 2.30, [2] = 1.20, [3] = 0.80}, uses = 20, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_axe({
        -- From gemtools:axe_ruby
        part_name = "ruby",
        ingredient = "unilib:mineral_ruby_gem",
    })
    unilib.tools.apply_toolranks("unilib:tool_axe_ruby", "axe")

end
