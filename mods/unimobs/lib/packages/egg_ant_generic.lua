---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.egg_ant_generic = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.egg_ant_generic.init()

    return {
        description = "Generic ant egg",
        notes = "Laid by queen ants on anthill beds (as specified by the \"mtb_lay_ant_egg\"" ..
                " package). Each egg has an 81% chance of producing a worker ant, 16% chance" ..
                " of producing a warrior ant, and 3% chance of producing a queen",
    }

end

function unilib.pkg.egg_ant_generic.exec()

    unilib.register_node("unilib:egg_ant_generic", "petz:antegg", mode, {
        -- From petz:antegg
        description = S("Ant Egg"),
        tiles =  {"unilib_egg_ant_generic.png"},
        groups = {snappy = 2},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        light_source = unilib.constant.light_max - 10,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, 0, 0.25},
            },
        },
        param2 = 50,
        paramtype = "light",
        paramtype2 = "glasslikeliquidlevel",
        -- N.B. No .stack_max in original code; added for consistency with chicken/duck eggs
        stack_max = unimobs.petz_setting.egg_stack_size,
        sunlight_propagates = true,
        use_texture_alpha = "blend",
        walkable = true,

        on_construct = function(pos)

            local timer = core.get_node_timer(pos)
            local lay_egg_interval =
                    unimobs.petz_api.get_custom_msetting("ant_queen", "custom_lay_egg_interval")
            timer:start(unimobs.petz_api.get_random_interval(lay_egg_interval))

        end,

        on_timer = function(pos)

            local entity_name
            local chance = random(1, 100)
            if chance >= 20 then
                entity_name = "unilib:mob_ant_worker"
            elseif chance >= 4 then
                entity_name = "unilib:mob_ant_warrior"
            else
                entity_name = "unilib:mob_ant_queen"
            end

            if not core.registered_entities[entity_name] then
                return true
            end

            -- Spawn the ant and remove the egg
            core.add_entity(pos, entity_name)
            core.set_node(pos, {name = "air"})

            return false

        end,
    })

end
