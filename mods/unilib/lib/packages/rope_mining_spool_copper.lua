---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_mining_spool_copper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ropes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_mining_spool_copper.init()

    return {
        description = "Copper spool for mining rope",
        nodes = "Adds spools in varying lengths, which when placed in the world, lower ropes" ..
                " at one metre per second until the spool's limit is reached",
        depends = {"metal_copper", "shared_ropes"},
    }

end

function unilib.pkg.rope_mining_spool_copper.exec()

    for i = 1, 5 do

        unilib.pkg.shared_ropes.register_spool({
            -- From ropes:wood1rope_block, etc. Creates unilib:rope_mining_spool_copper_50m etc
            part_name = "copper",
            orig_name = "ropes:copper" .. i .. "rope_block",
            description = S("Copper Spool"),
            ingredient = "unilib:metal_copper_ingot",
            tint = "#c88648",

            replace_mode = mode,
            multiple = i,
        })

    end

end
