---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cavern_crystal_salt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cavern_crystal_salt.init()

    return {
        description = "Cavern salt crystal",
        notes = "A set of five crystals, with the same colour but different sizes",
    }

end

function unilib.pkg.misc_cavern_crystal_salt.exec()

    local size_list = {1.0, 1.2, 1.4, 1.6, 1.7}

    for i in ipairs(size_list) do

        local full_name, orig_name

        full_name = "unilib:misc_cavern_crystal_salt_" .. i
        if i == 1 then
            orig_name = "caverealms:salt_gem"
        else
            orig_name = "caverealms:salt_gem_" .. i
        end

        local vs = size_list[i]

        unilib.register_node(full_name, orig_name, mode, {
            -- From caverealms:salt_gem, etc
            description = S("Cavern Salt Crystal"),
            tiles = {"unilib_misc_cavern_crystal_salt.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 1},
            sounds = unilib.sound_table.glass,

            buildable_to = true,
            drawtype = "plantlike",
            -- N.B. In the original code, a single inventory texture was used for all five items
--          inventory_image = "unilib_misc_cavern_crystal_salt.png",
            inventory_image = "unilib_misc_cavern_crystal_salt_" .. i .. "_inv.png",
            light_source = 11,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5 * vs, -0.5 * vs, -0.5 * vs, 0.5 * vs, -5/16 * vs, 0.5 * vs},
            },
            visual_scale = vs,
            walkable = false,
            wield_image = "unilib_misc_cavern_crystal_salt.png",
        })

    end

end
