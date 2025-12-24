---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_projectile_lantern = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

local throw_strength = 20

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_projectile_lantern.init()

    return {
        description = "Jack-o'-lantern Grenade",
        notes = "Can be crafted, or fired by the (admin) lantern gun",
        depends = {
            "item_string_ordinary",
            "light_lantern_jack_yellow",
            "shared_petz_projectiles",
            "tnt_ordinary",
        },
    }

end

function unilib.pkg.misc_projectile_lantern.exec()

    unilib.register_node("unilib:misc_projectile_lantern", "petz:jack_o_lantern_grenade", mode, {
        -- From petz:jack_o_lantern_grenade
        description = unilib.utils.hint(
            S("Jack-o'-lantern Grenade"), S("press \"use\" key to throw")
        ),
        -- N.B. Replaced original petz textures with those adapted from farming_redo, so that
        --      ordinary jack-o'-lanterns and this grenade look better when placed together
        tiles = {
            "unilib_produce_pumpkin_yellow_grow_bottom.png" ..
                    "^unilib_produce_pumpkin_yellow_grow_top_overlay.png",
            "unilib_produce_pumpkin_yellow_grow_bottom.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_produce_pumpkin_yellow_grow_side.png",
            "unilib_produce_pumpkin_yellow_grow_side.png" ..
                    "^unilib_misc_projectile_lantern_overlay.png",
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        -- N.B. paramtype2 = "facedir" not in original code
        paramtype2 = "facedir",
        visual_scale = 0.35,

        on_use = function(itemstack, user, pointed_thing)

            unimobs.kitz_api.make_sound(
                "player",
                user,
                "unilib_misc_projectile_lantern_fireball",
                unimobs.petz_setting.max_hear_distance
            )

            if not unilib.pkg.shared_petz_projectiles.spawn_projectile(
                user, throw_strength, "unilib:entity_misc_projectile_lantern"
            ) then

                -- Something went wrong
                return

            end

            itemstack:take_item()
            return itemstack

        end,
    })
    unilib.register_craft({
        -- From petz:jack_o_lantern_grenade
        type = "shapeless",
        output = "unilib:misc_projectile_lantern",
        recipe = {
            "unilib:light_lantern_jack_yellow_off",
            "unilib:tnt_gunpowder",
            "unilib:item_string_ordinary",
        },
    })

    unilib.pkg.shared_petz_projectiles.register_entity(
        "unilib:entity_misc_projectile_lantern",
        "unilib:misc_projectile_lantern",
        unimobs.petz_setting.pumpkin_grenade_damage,
        "fire",
        "fire",
        "unilib_misc_projectile_lantern_firecracker"
    )

end
