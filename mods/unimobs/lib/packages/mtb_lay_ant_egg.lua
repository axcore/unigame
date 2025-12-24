---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_lay_ant_egg = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_lay_ant_egg.do_action(self)

    -- Adapted from petz.bh_lay_antegg()
    -- Called only for queen ants
    -- If there is air in front the queen, and an anthill bed node beneath it, then lays eggs

    if self.egg_count >=
            unimobs.petz_api.get_custom_msetting("ant_queen", "custom_max_laid_eggs") then
        return
    end

    -- Lay in front of (hence the air node) and above an ant bed node
    local front_node, front_pos = unimobs.petz_api.get_node_at_named_location(self, "front")
    local front_below_node, _ = unimobs.petz_api.get_node_at_named_location(self, "front_below")

    if front_pos and
            front_node.name == "air" and
            front_below_node and
            front_below_node.name == "unilib:misc_anthill_bed" then

        core.place_node(front_pos, {name = "unilib:egg_ant_generic"})
        self.egg_count = unimobs.mobkit_api.add_mob_memory(self, "egg_count", self.egg_count + 1)
        return true

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_lay_ant_egg.init()

    return {
        description = "Standard mob meta-behaviour: lay ant eggs",
        depends = {"egg_ant_generic", "misc_anthill"},
    }

end
