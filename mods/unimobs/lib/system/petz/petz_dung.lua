---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_dung.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local ceil = math.ceil
local random = math.random

local search_radius = 3

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_poop.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.make_mob_produce_dung(self, pos)

    -- From petz.poop()
    -- Called by brain packages like "brain_herbivore" and "brain_flying"
    -- If dung is enabled globally, and if the specified mob can produce dung, then occasionally
    --      create the dung node
    -- (The rate at which a mob produces dung is specified in settings)

    -- Basic checks
    if not unimobs.petz_setting.enable_dung_flag or
            (not self.is_tamed_flag and not self.is_wild_flag) or
            not self.dung_name or
            core.registered_items[self.dung_name] == nil or
            self.is_baby_flag or
            unimobs.petz_api.is_mob_jumping(self) or
            not unimobs.petz_api.is_mob_standing_still(self) then
        return
    end

    -- Increase the probability of dung production according to the "incontinence" gene
    local dung_rate = unimobs.petz_setting.average_dung_production_rate
    local genetic_value = self.genetic_table["incontinence"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "incontinence")
    if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

        local reduction_factor = unimobs.petz_setting.genetic_incontinence_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        dung_rate = ceil(dung_rate * (1 - reduction_factor))

    end

    if random(1, dung_rate) > 1 then
        return
    end

    -- Dung must replace air, and cannot be placed in mid-air
    local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
    if not stand_pos then
        return
    end

    local stand_node = core.get_node_or_nil(stand_pos)
    local below_pos = vector.new(stand_pos.x, stand_pos.y - 1, stand_pos.z)
    local node_below = core.get_node_or_nil(below_pos)
    if not stand_node or
            stand_node.name ~= "air" or
            not node_below or
            node_below.name == "air" then
        return
    end

    -- Special check for scat; can only be produced near trees
    if self.dung_name == "unilib:misc_dung_scat" and
            core.find_node_near(pos, search_radius, "group:tree") == nil then
        return
    end

    -- Produce dung
    core.set_node(stand_pos, {name = self.dung_name})

end
