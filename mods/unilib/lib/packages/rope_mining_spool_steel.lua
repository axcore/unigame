---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_mining_spool_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ropes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_mining_spool_steel.init()

    return {
        description = "Steel spool for mining rope",
        nodes = "Adds spools in varying lengths, which when placed in the world, lower ropes" ..
                " at one metre per second until the spool's limit is reached",
        depends = {"metal_steel", "shared_ropes"},
    }

end

function unilib.pkg.rope_mining_spool_steel.exec()

    for i = 1, 9 do

        unilib.pkg.shared_ropes.register_spool({
            -- From ropes:steel1rope_block, etc. Creates unilib:rope_mining_spool_steel_50m etc
            part_name = "steel",
            orig_name = "ropes:steel" .. i .. "rope_block",
            description = S("Steel Spool"),
            ingredient = "unilib:metal_steel_ingot",
            tint = "#ffffff",

            replace_mode = mode,
            multiple = i,
        })

    end

end
