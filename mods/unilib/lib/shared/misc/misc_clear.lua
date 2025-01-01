---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc_clear.lua
--      Clear registered biomes, decorations and ores on demand
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Clear registered biomes, decorations and ores on demand, replacing Minetest clear_registered()
---------------------------------------------------------------------------------------------------

function unilib.misc._clear_registered_biomes()

    -- Original to unilib
    -- If several remixes are specified, more than one package may try to clear registered biomes
    -- To prevent this, call this function instead of calling core.clear_registered_biomes()
    --      directly. If biomes have already been cleared by an earlier call to this function, they
    --      are not cleared again

    if not unilib.global.biomes_cleared_flag and not unilib.setting.protect_biomes_flag then

        core.clear_registered_biomes()
        unilib.global.biomes_cleared_flag = true

    end

end

function unilib.misc._clear_registered_decorations()

    -- Original to unilib
    -- If several remixes are specified, more than one package may try to clear registered
    --      decorations
    -- To prevent this, call this function instead of calling core.clear_registered_decorations()
    --      directly. If decorations have already been cleared by an earlier call to this function,
    --      they are not cleared again

    if not unilib.global.decorations_cleared_flag and
            not unilib.setting.protect_decorations_flag then

        core.clear_registered_decorations()
        unilib.global.decorations_cleared_flag = true

    end

end

function unilib.misc._clear_registered_ores()

    -- Original to unilib
    -- If several remixes are specified, more than one package may try to clear registered ores
    -- To prevent this, call this function instead of calling core.clear_registered_ores() directly.
    --      If ores have already been cleared by an earlier call to this function, they are not
    --      cleared again

    if not unilib.global.ores_cleared_flag and not unilib.setting.protect_ores_flag then

        core.clear_registered_ores()
        unilib.global.ores_cleared_flag = true

    end

end
