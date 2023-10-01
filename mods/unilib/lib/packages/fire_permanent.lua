---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fire_permanent = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.fire.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.fire_permanent.add(pos, igniter)

    -- Adapted from underch/functions.lua
    -- Usually called as a node's .on_ignite function

    local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
    if minetest.get_node(flame_pos).name == "air" then
        minetest.set_node(flame_pos, {name = "unilib:fire_permanent"})
    end

end

function unilib.pkg.fire_permanent.remove(pos, oldnode)

    -- Adapted from underch/functions.lua
    -- Usually called as a node's .after_destruct function

    pos.y = pos.y + 1
    if minetest.get_node(pos).name == "unilib:fire_permanent" then
        minetest.remove_node(pos)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fire_permanent.init()

    return {
        description = "Permanent flame",
    }

end

function unilib.pkg.fire_permanent.exec()

    -- From fire:permanent_flame
    local def_table = table.copy(unilib.get_generic_fire())
    def_table.description = S("Permanent Flame")

    unilib.register_node("unilib:fire_permanent", "fire:permanent_flame", mode, def_table)

end
