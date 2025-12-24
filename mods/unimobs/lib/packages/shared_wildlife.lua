---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wildlife
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_wildlife = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.wildlife.add_mode

-- Localise math functions (for speed)
local max = math.max

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_wildlife.apply_damage_from_nearby_nodes(self)

    -- From init.lua, node_dps_dmg()

    local pos = self.object:get_pos()
    local cbox = self.object:get_properties().collisionbox

    -- Specify a search area
    local pos1 = {x = pos.x + cbox[1], y = pos.y + cbox[2], z = pos.z + cbox[3]}
    local pos2 = {x = pos.x + cbox[4], y = pos.y + cbox[5], z = pos.z + cbox[6]}
    -- Get a table of unique nodes in the area, in the form:
    --      table[node_definition_table] = true
    local overlap_table = unimobs.mobkit_api.get_table_of_nodes_in_area(pos1, pos2)
    local total_damage = 0

    -- Calculate damage
    for def_table, _ in pairs(overlap_table) do

        local dps = def_table.damage_per_second
        if dps then
            total_damage = max(total_damage, dps)
        end

    end

    -- Apply damage, if any
    if total_damage ~= 0 then
        unimobs.mobkit_api.apply_damage(self, total_damage)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_wildlife.init()

    return {
        description = "Shared functions for normal wolves/deers (from wildlife)",
    }

end
