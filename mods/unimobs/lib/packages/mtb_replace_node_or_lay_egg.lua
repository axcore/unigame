---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_replace_node_or_lay_egg = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_replace_node_or_lay_egg.do_action(self)

    -- Adapted from petz.bh_replace()
    -- The specified mob tries to replace a node with a different one (for example, a sheep eats
    --      turf, replacing a dirt-with-turf node with a plain dirt node)
    -- On success, the mob's milk, wool (etc) is replenished, if possible. On failure, an
    --      egg-laying mob can try to lay an egg

    -- N.B. Original code was able to replace a node and lay an egg in a single call to this
    --      function; in unimobs, we do one or the other
    if unimobs.kitz_api.make_mob_replace_node(
        self, "unilib_eat_petz", unimobs.petz_setting.max_hear_distance
    ) then

        -- Replenish the mob's milk, wool (etc), or do nothing
        unimobs.petz_api.replenish_mob(self)

    elseif self.egg_name then

        unimobs.petz_api.lay_egg(self)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_replace_node_or_lay_egg.init()

    return {
        description = "Standard mob meta-behaviour: replace a node or lay an egg",
    }

end
