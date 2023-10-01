---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_maptools = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_maptools.toolcaps_table = {
    damage_groups = {fleshy = 1000},
    full_punch_interval = 0.1,
    groupcaps = {
        bendy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        choppy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        cracky = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        crumbly = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        fleshy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        snappy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        unbreakable = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
    },
    max_drop_level = 3,
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_maptools.on_drop(itemstack, player)

    unilib.show_warning(
        "shared_maptools package: Admin nodes and tools cannot be dropped!",
        itemstack:get_name()
    )

end

function unilib.pkg.shared_maptools.register_node(full_name, orig_name, replace_mode, def_table)

    -- Increases the interaction range when holding maptools nodes to make building easier, and
    --      make some other tweaks

    def_table.range = 12
    def_table.stack_max = 65535
    def_table.drop = ""
    def_table.on_drop = unilib.pkg.shared_maptools.on_drop

    if def_table.groups then

        if not def_table.groups.dig_immediate then
            def_table.groups.unbreakable = 1
        end

        def_table.groups.not_in_creative_inventory = unilib.show_admin_item_group

    else

        def_table.groups = {
            not_in_creative_inventory = unilib.show_admin_item_group, unbreakable = 1,
        }

    end

    -- Not in original code: invisible items should still generate a sound when placed in the world
    if def_table.sounds == nil then
        def_table.sounds = unilib.sound_table.node
    end

    -- Prevent maptools nodes from being exploded by TNT
    def_table.on_blast = function() end

    -- Register the node
    unilib.register_node(full_name, orig_name, replace_mode, def_table)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_maptools.init()

    return {
        description = "Shared functions for admin packages (from maptools)",
    }

end
