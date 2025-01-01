---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cavern_crystal_spike = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cavern_crystal_spike.init()

    return {
        description = "Cavern spike crystal",
    }

end

function unilib.pkg.misc_cavern_crystal_spike.exec()

    local size_list = {1.0, 1.2, 1.4, 1.6, 1.7}

    for i in ipairs(size_list) do

        local full_name, orig_name

        full_name = "unilib:misc_cavern_crystal_spike_" .. i
        if i == 1 then
            orig_name = "caverealms:spike"
        else
            orig_name = "caverealms:spike_" .. i
        end

        local vs = size_list[i]

        unilib.register_node(full_name, orig_name, mode, {
            -- From caverealms:spike, etc
            description = S("Cavern Spike Crystal"),
            tiles = {"unilib_misc_cavern_crystal_spike.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 1},
            -- N.B. stone in original code
            sounds = unilib.global.sound_table.glass,

            buildable_to = true,
            drawtype = "plantlike",
            -- N.B. In the original code, a single inventory texture was used for all five items
--          inventory_image = "unilib_misc_cavern_crystal_spike.png",
            inventory_image = "unilib_misc_cavern_crystal_spike_" .. i .. "_inv.png",
            light_source = 3,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5 * vs, -0.5 * vs, -0.5 * vs, 0.5 * vs, -5/16 * vs, 0.5 * vs},
            },
            visual_scale = vs,
            walkable = false,
            wield_image = "unilib_misc_cavern_crystal_spike.png",
        })

    end

end
