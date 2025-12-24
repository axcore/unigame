---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_projectile_cobweb = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_projectile_cobweb.init()

    return {
        description = "Throwable cobweb",
        depends = {"item_string_ordinary", "shared_petz_projectiles"},
    }

end

function unilib.pkg.misc_projectile_cobweb.exec()

    local c_string = "unilib:item_string_ordinary"

    unilib.register_node("unilib:misc_projectile_cobweb", "petz:cobweb", mode, {
        -- From petz:cobweb
        description = S("Throwable Cobweb"),
        tiles = {"unilib_misc_projectile_cobweb.png"},
        groups = {disable_jump = 1, snappy = 1},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = c_string,
        inventory_image = "unilib_misc_projectile_cobweb.png",
        liquid_alternative_flowing = "unilib:misc_projectile_cobweb",
        liquid_alternative_source = "unilib:misc_projectile_cobweb",
        liquid_range = 0,
        liquid_renewable = false,
        liquid_viscosity = 11,
        liquidtype = "source",
        paramtype = "light",
        sunlight_propagates = true,
        visual_scale = 1.2,
        walkable = false,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            -- Cobwebs placed by player do not disappear
            if placer:is_player() then

                local timer = core.get_node_timer(pos)
                timer:stop()

            end

        end,

        on_construct = function(pos)

            -- Thrown cobwebs disappear after a time
            local timer = core.get_node_timer(pos)
            timer:start(unimobs.petz_setting.cobweb_decay_interval)

        end,

        on_timer = function(pos, elapsed)

            core.remove_node(pos)
            return false

        end,
    })
    unilib.register_craft({
        -- From petz:cobweb
        output = "unilib:misc_projectile_cobweb",
        recipe = {
            {c_string, "", c_string},
            {"", c_string, ""},
            {c_string, "", c_string},
        },
    })

    unilib.pkg.shared_petz_projectiles.register_entity(
        "unilib:entity_misc_projectile_cobweb",
        "unilib:misc_projectile_cobweb",
        1,
        "cobweb",
        nil,
        "unilib_misc_projectile_cobweb"
    )

end
