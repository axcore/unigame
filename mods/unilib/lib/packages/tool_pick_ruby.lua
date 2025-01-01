---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_ruby = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_ruby.init()

    return {
        description = "Ruby pickaxe",
        depends = "mineral_ruby",
    }

end

function unilib.pkg.tool_pick_ruby.exec()

    unilib.register_tool("unilib:tool_pick_ruby", "gemtools:pick_ruby", mode, {
        -- From gemtools:pick_ruby
        description = S("Ruby Pickaxe"),
        inventory_image = "unilib_tool_pick_ruby.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 3.00, [2] = 1.40, [3] = 0.70}, uses = 20, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From gemtools:pick_ruby
        part_name = "ruby",
        ingredient = "unilib:mineral_ruby_gem",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_ruby", "pickaxe")

end
