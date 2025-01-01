---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_hoe = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function hoe_area(pos, player)

    -- Check for protection
    if core.is_protected(pos, player:get_player_name()) then

        core.record_protection_violation(pos, player:get_player_name())
        return

    end

    -- Radius
    local r = 5

    -- Remove flora (grass, flowers etc.)
    local res = core.find_nodes_in_area(
        {x = pos.x - r, y = pos.y - 1, z = pos.z - r},
        {x = pos.x + r, y = pos.y + 2, z = pos.z + r},
        {"group:flora"}
    )

    for n = 1, #res do
        core.swap_node(res[n], {name = "air"})
    end

    -- Replace dirt with the corresponding tilled soil
    res = nil
    res = core.find_nodes_in_area_under_air(
        {x = pos.x - r, y = pos.y - 1, z = pos.z - r},
        {x = pos.x + r, y = pos.y + 2, z = pos.z + r},
        {"group:soil"}
    )

    for n = 1, #res do

        local this_node = core.get_node(res[n])
        local def_table = core.registered_nodes[this_node.name]
        if def_table ~= nil and def_table.soil ~= nil and def_table.soil.dry ~= nil then
            core.swap_node(res[n], {name = def_table.soil.dry})
        end

    end

end

local function throw_potion(itemstack, player)

    local playerpos = player:get_pos()

    local obj = core.add_entity(
        {x = playerpos.x, y = playerpos.y + 1.5, z = playerpos.z},
        "unilib:entity_admin_tool_hoe"
    )

    local dir = player:get_look_dir()
    local velocity = 20

    obj:setvelocity({
        x = dir.x * velocity,
        y = dir.y * velocity,
        z = dir.z * velocity,
    })

    obj:setacceleration({
        x = dir.x * -3,
        y = -9.5,
        z = dir.z * -3,
    })

    obj:get_luaentity().player = player

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_hoe.init()

    return {
        description = "Admin hoe",

        notes = "A hoe that can remove turf over a wide area. Use by punching a dirt-with-turf" ..
                " node, or \"throw\" the tool by punching the air above it",
    }

end

function unilib.pkg.admin_tool_hoe.exec()

    unilib.register_entity("unilib:entity_admin_tool_hoe", {
        initial_properties = {
            collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
            physical = true,
            player = "",
            textures = {"unilib_admin_tool_hoe.png"},
            visual = "sprite",
            visual_size = {x = 1.0, y = 1.0},
        },

        lastpos = {},

        on_step = function(self, dtime)

            if not self.player then

                self.object:remove()
                return

            end

            local pos = self.object:get_pos()

            if self.lastpos.x ~= nil then

                local vel = self.object:getvelocity()

                -- Only when the hoe hits something physical
                if vel.x == 0 or vel.y == 0 or vel.z == 0 then

                    if self.player ~= "" then

                        -- Round up coordinates to fix glitching through doors
                        self.lastpos = vector.round(self.lastpos)
                        hoe_area(self.lastpos, self.player)

                    end

                    self.object:remove()

                    return

                end

            end

            self.lastpos = pos

        end
    })

    unilib.register_craftitem("unilib:admin_tool_hoe", "farming:hoe_bomb", mode, {
        -- From farming:hoe_bomb
        description = unilib.utils.hint(
            S("Admin Hoe"), S("punch on or above turf to hoe the land")
        ),
        inventory_image = "unilib_admin_tool_hoe.png",
        groups = {flammable = 2, not_in_creative_inventory = unilib.globalshow_admin_item_group},

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type == "node" then

                hoe_area(pointed_thing.above, user)

            else

                throw_potion(itemstack, user)

                if not unilib.utils.is_creative(user:get_player_name()) then

                    itemstack:take_item()
                    return itemstack

                end

            end

        end,
    })

end
