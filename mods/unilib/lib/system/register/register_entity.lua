---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_entity.lua
--      Register entities using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register entities
---------------------------------------------------------------------------------------------------

function unilib.register_entity(entity_name, def_table)

    -- Original to unilib
    -- N.B. There is no unilib.register._register_entity()
    --
    -- Packages should call this function to register an entity, rather than calling
    --      core.register_entity() directly
    --
    -- Args:
    --      entity_name (str): e.g. "unilib:cart_ordinary"
    --      def_table (table): Usual definition table for the entity

    if core.registered_entities[entity_name] ~= nil then

        unilib.utils.show_warning(
            "unilib.register_entity(): Duplicate entity registration",
            entity_name
        )

    end

    -- (At the moment this function is a simple wrapper, but that might change later)
    core.register_entity(entity_name, def_table)

end
