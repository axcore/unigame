---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fire_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fire.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fire_ordinary.init()

    return {
        description = "Ordinary fire",
    }

end

function unilib.pkg.fire_ordinary.exec()

    -- Prepare the node definition
    -- From fire:basic_flame
    local def_table = table.copy(unilib.fire.get_generic_definition())

    def_table.description = S("Ordinary Fire")
    def_table.groups.not_in_creative_inventory = 1

    def_table.on_timer = function(pos)

        if not core.find_node_near(pos, 1, {"group:flammable"}) then

            core.remove_node(pos)
            return

        end

        -- Restart timer
        return true

    end

    def_table.on_construct = function(pos)
        core.get_node_timer(pos):start(math.random(30, 60))
    end

    -- Register the node
    unilib.register_node("unilib:fire_ordinary", "fire:basic_flame", mode, def_table)

end
