---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cocoon_silkworm = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

local generate_min_time = 400
local generate_max_time = 600
local cbox = {
    type = "fixed",
    fixed = {-0.125, -0.5, -0.375, 0.0625, -0.25, 0.3125},
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cocoon_silkworm.init()

    return {
        description = "Silkworm cocoon",
    }

end

function unilib.pkg.misc_cocoon_silkworm.exec()

    unilib.register_node("unilib:misc_cocoon_silkworm", "petz:cocoon", mode, {
        -- From petz:cocoon
        description = S("Silkworm Cocoon"),
        tiles = {"unilib_misc_cocoon_silkworm.png"},
        groups = {bendy = 2, cracky = 1, snappy = 1},
        sounds = unilib.global.sound_table.wood,

        collision_box = cbox,
        drawtype = "mesh",
        inventory_image = "unilib_misc_cocoon_silkworm_inv.png",
        mesh = "unilib_misc_cocoon_silkworm.b3d",
        paramtype = "light",
        selection_box = cbox,
        visual_scale = 1.0,

        on_construct = function(pos)

            local timer = core.get_node_timer(pos)
            timer:start(random(generate_min_time, generate_max_time))

        end,

        on_timer = function(pos)

            -- N.B. The "mob_moth_normal" package is not a dependency of this package, as that would
            --      create a circular dependency
            if not core.registered_entities["unilib:mob_moth_normal"] then
                return
            end

            -- Only spawn at night, so the moth doesn't die
            if pos and unimobs.petz_api.is_night() then

                core.add_entity(pos, "unilib:mob_moth_normal")
                core.set_node(pos, {name = "air"})
                return false

            else

                return true

            end

        end,
    })

end
