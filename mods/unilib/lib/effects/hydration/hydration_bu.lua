---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- hydration_bu.lua
--      Backups for shared functions in ../lib/effects/hydration/hydration_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"hydration\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.hydration.do_drink(...)
    unilib.utils.show_warning(msg, "unilib.hydration.do_drink")
end

function unilib.hydration.get_hydro(...)
    unilib.utils.show_warning(msg, "unilib.hydration.get_hydro")
end

function unilib.hydration.set_hydro(...)
    unilib.utils.show_warning(msg, "unilib.hydration.set_hydro")
end

function unilib.hydration.on_use(...)
    unilib.utils.show_warning(msg, "unilib.hydration.on_use")
end

function unilib.hydration.on_rightclick(...)
    unilib.utils.show_warning(msg, "unilib.hydration.on_rightclick")
end

function unilib.hydration.enable_drinking_from_container(...)

    -- N.B. Commonly called from various packages, so don't show a warning
--  unilib.utils.show_warning(msg, "unilib.hydration.enable_drinking_from_container")

end

function unilib.hydration.enable_water_storage(...)

    -- N.B. Commonly called from various packages, so don't show a warning
--  unilib.utils.show_warning(msg, "unilib.hydration.enable_water_storage")

end

function unilib.hydration.enable_static_drinking(...)

    -- N.B. Commonly called from various packages, so don't show a warning
--  unilib.utils.show_warning(msg, "unilib.hydration.enable_static_drinking")

end

function unilib.hydration.fountain_abm(...)
    unilib.utils.show_warning(msg, "unilib.hydration.fountain_abm")
end
