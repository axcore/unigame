---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.egg_silkworm_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

local generate_min_time = 200
local generate_max_time = 300
local cbox = {
    type = "fixed",
    fixed = {-0.25, -0.5, -0.062500, 0.1875, -0.4375, 0.1875},
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.egg_silkworm_normal.init()

    return {
        description = "Normal ilkworm eggs",
    }

end

function unilib.pkg.egg_silkworm_normal.exec()

    unilib.register_node("unilib:egg_silkworm_normal", "petz:silkworm_eggs", mode, {
        -- From petz:silkworm_eggs
        description = S("Normal Silkworm Eggs"),
        tiles = {"unilib_egg_silkworm_normal.png"},
        groups = {bendy = 2, cracky = 1, falling_node = 1, snappy = 1},
        sounds = unilib.global.sound_table.wood,

        collision_box = cbox,
        drawtype = "mesh",
        inventory_image = "unilib_egg_silkworm_normal_inv.png",
        mesh = "unilib_egg_silkworm_normal.b3d",
        paramtype = "light",
        selection_box = cbox,
        -- N.B. No .stack_max in original code; added for consistency with chicken/duck eggs
        stack_max = unimobs.petz_setting.egg_stack_size,
        visual_scale = 1.0,

        on_construct = function(pos)

            local timer = core.get_node_timer(pos)
            timer:start(random(generate_min_time, generate_max_time))

        end,

        on_timer = function(pos)

            -- N.B. The "mob_silkworm_normal" package is not a dependency of this package, as that
            --      would create a circular dependency
            if not core.registered_entities["unilib:mob_silkworm_normal"] then
                return
            end

            core.set_node(pos, {name = "air"})
            core.add_entity(pos, "unilib:mob_silkworm_normal")

            local pos2 = {x = pos.x + 1, y = pos.y, z = pos.z + 1}
            if core.get_node(pos2) and core.get_node(pos2).name == "air" then
                core.add_entity(pos2, "unilib:mob_silkworm_normal")
            end

            local pos3 = {x = pos.x - 1, y = pos.y, z = pos.z -1}
            if core.get_node(pos3) and core.get_node(pos3).name == "air" then
                core.add_entity(pos3, "unilib:mob_silkworm_normal")
            end

            return false

        end
    })

end
