---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- atmosphere_bu.lua
--      Backups for shared functions in ../lib/effects/atmosphere/atmosphere_base.lua
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- N.B. No warning messages in this case

---------------------------------------------------------------------------------------------------
-- Shared functions (weather effects)
---------------------------------------------------------------------------------------------------

function unilib.awards.register_sky_colours(...)
end

function unilib.awards.unregister_sky_colours(...)
end

function unilib.awards.register_cloud_density(...)
end

function unilib.awards.unregister_cloud_density(...)
end

function unilib.awards.register_weather_prototype(...)
end

function unilib.awards.register_weather(...)
end

function unilib.awards.set_weather(...)
end

function unilib.awards.reset_weather(...)
    return false
end

function unilib.awards.set_weather_unlock_time(...)
end

function unilib.awards.get_weather(...)
end

function unilib.awards.get_wind(...)
    return nil, "north", 0
end

function unilib.awards.sample_weather(...)
end

function unilib.awards.is_weather_in_range(...)
    return false
end

function unilib.awards.get_list_of_weather_effects(...)
    return {}
end

function unilib.awards.get_list_of_weather_tags(...)
    return {}
end

function unilib.awards.get_weather_effect_description(...)
end

function unilib.awards.get_weather_prototype_description(...)
end

---------------------------------------------------------------------------------------------------
-- Shared functions (ambient/environment effects)
---------------------------------------------------------------------------------------------------

function unilib.awards.register_ambient(...)
end

function unilib.awards.register_environment(...)
end
