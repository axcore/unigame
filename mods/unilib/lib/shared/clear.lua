---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- clear.lua
--      Set up shared functions for clearing registered biomes/decorations/ores, replacing Minetest
--          clear_registered() calls
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.clear_registered_biomes()

    -- Original to unilib
    -- If several remixes are specified, more than one package may try to clear registered biomes
    -- To prevent this, call this function instead of calling minetest.clear_registered_biomes()
    --      directly. If biomes have already been cleared by an earlier call to this function, they
    --      are not cleared again

    if not unilib.biomes_cleared_flag and not unilib.protect_biomes_flag then

        minetest.clear_registered_biomes()
        unilib.biomes_cleared_flag = true

    end

end

function unilib.clear_registered_decorations()

    -- Original to unilib
    -- If several remixes are specified, more than one package may try to clear registered
    --      decorations
    -- To prevent this, call this function instead of calling
    --      minetest.clear_registered_decorations() directly. If decorations have already been
    --      cleared by an earlier call to this function, they are not cleared again

    if not unilib.decorations_cleared_flag and not unilib.protect_decorations_flag then

        minetest.clear_registered_decorations()
        unilib.decorations_cleared_flag = true

    end

end

function unilib.clear_registered_ores()

    -- Original to unilib
    -- If several remixes are specified, more than one package may try to clear registered ores
    -- To prevent this, call this function instead of calling minetest.clear_registered_ores()
    --      directly. If ores have already been cleared by an earlier call to this function, they
    --      are not cleared again

    if not unilib.ores_cleared_flag and not unilib.protect_ores_flag then

        minetest.clear_registered_ores()
        unilib.ores_cleared_flag = true

    end

end

