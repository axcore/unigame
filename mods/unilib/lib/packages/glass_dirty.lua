---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_dirty = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_dirty.init()

    return {
        description = "Dirty glass",
        depends = {"dirt_ordinary", "glass_ordinary"},
        optional = {"glass_clean", "item_sweeper"},
    }

end

function unilib.pkg.glass_dirty.exec()

    unilib.register_node("unilib:glass_dirty", "mtg_plus:dirty_glass", mode, {
        -- From mtg_plus:dirty_glass
        description = S("Dirty Glass"),
        tiles = {"unilib_glass_dirty.png", "unilib_glass_dirty_detail.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = false,
    })
    unilib.register_craft({
        -- From mtg_plus:dirty_glass
        output = "unilib:glass_dirty 3",
        recipe = {
            {"", "unilib:dirt_ordinary", ""},
            {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
        }
    })

    if unilib.pkg_executed_table["item_sweeper"] ~= nil then

        unilib.register_craft({
            -- From mtg_plus:dirty_glass
            type = "shapeless",
            output = "unilib:glass_ordinary",
            recipe = {"unilib:glass_dirty", "unilib:item_sweeper"},
        })

        if unilib.pkg_executed_table["glass_clean"] ~= nil then

            unilib.register_craft({
                -- From mtg_plus:dirty_glass
                type = "shapeless",
                output = "unilib:glass_clean",
                recipe = {"unilib:glass_dirty", "unilib:item_sweeper", "unilib:item_sweeper"},
            })

        end

    end

    if unilib.pkg_executed_table["glass_clean"] ~= nil then

        unilib.register_craft({
            -- From mtg_plus:dirty_glass
            output = "unilib:glass_dirty",
            recipe = {
                {"unilib:dirt_ordinary"},
                {"unilib:glass_clean"}
            }
        })

    end

end
