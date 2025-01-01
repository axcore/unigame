---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stamina_bu.lua
--      Backups for shared functions in ../lib/effects/stamina/stamina_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"stamina\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.stamina.get_saturation(...)
    unilib.utils.show_warning(msg, "unilib.stamina.get_saturation")
end

function unilib.stamina.set_saturation(...)
    unilib.utils.show_warning(msg, "unilib.stamina.set_saturation")
end

function unilib.stamina.register_on_update_saturation(...)
    unilib.utils.show_warning(msg, "unilib.stamina.register_on_update_saturation")
end

function unilib.stamina.update_saturation(...)
    unilib.utils.show_warning(msg, "unilib.stamina.update_saturation")
end

function unilib.stamina.change_saturation(...)
    unilib.utils.show_warning(msg, "unilib.stamina.change_saturation")
end

function unilib.stamina.is_poisoned(...)
    unilib.utils.show_warning(msg, "unilib.stamina.is_poisoned")
end

function unilib.stamina.set_poisoned(...)
    unilib.utils.show_warning(msg, "unilib.stamina.set_poisoned")
end

function unilib.stamina.register_on_poison(...)
    unilib.utils.show_warning(msg, "unilib.stamina.register_on_poison")
end

function unilib.stamina.poison_player(...)
    unilib.utils.show_warning(msg, "unilib.stamina.poison_player")
end

function unilib.stamina.get_exhaustion(...)
    unilib.utils.show_warning(msg, "unilib.stamina.get_exhaustion")
end

function unilib.stamina.set_exhaustion(...)
    unilib.utils.show_warning(msg, "unilib.stamina.set_exhaustion")
end

function unilib.stamina.register_on_exhaust_player(...)
    unilib.utils.show_warning(msg, "unilib.stamina.register_on_exhaust_player")
end

function unilib.stamina.exhaust_player(...)
    unilib.utils.show_warning(msg, "unilib.stamina.exhaust_player")
end

function unilib.stamina.register_on_sprinting(...)
    unilib.utils.show_warning(msg, "unilib.stamina.register_on_sprinting")
end

function unilib.stamina.set_sprinting(...)
    unilib.utils.show_warning(msg, "unilib.stamina.set_sprinting")
end
