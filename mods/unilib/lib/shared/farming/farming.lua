---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- farming.lua
--      Set up farming
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.farming = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for farming
local base_file = unilib.core.path_mod .. "/lib/shared/farming/farming_base.lua"

function unilib.farming.get_max_light(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._get_max_light(...)

end

function unilib.farming.get_min_light(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._get_min_light(...)

end

function unilib.farming.add_to_fredo_grow_list(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._add_to_fredo_grow_list(...)

end

function unilib.farming.insert_into_grow_list(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._insert_into_grow_list(...)

end

function unilib.farming.refill_seed(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._refill_seed(...)

end

function unilib.farming.place_item_as_seed(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._place_item_as_seed(...)

end

function unilib.farming.grow_crop(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._grow_crop(...)

end

function unilib.farming.on_timer_do_growth(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._on_timer_do_growth(...)

end

function unilib.farming.on_timer_prepare_growth(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._on_timer_prepare_growth(...)

end

function unilib.farming.register_growth_stages(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.farming._register_growth_stages(...)

end

-- Registry functions for mtgame crops
local cm_file = unilib.core.path_mod .. "/lib/shared/farming/farming_crop_mtgame.lua"

function unilib.register_crop_mtgame(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    if not t[cm_file] then t[cm_file] = true; dofile(cm_file) end
    return unilib.farming._register_crop_mtgame(...)

end

-- Registry functions for farming_redo crops
local cf_file = unilib.core.path_mod .. "/lib/shared/farming/farming_crop_fredo.lua"

function unilib.register_crop_fredo(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    if not t[cf_file] then t[cf_file] = true; dofile(cf_file) end
    return unilib.farming._register_crop_fredo(...)

end

-- Registry functions for farming_redo produce
local pf_file = unilib.core.path_mod .. "/lib/shared/farming/farming_produce_fredo.lua"

function unilib.register_produce_fredo(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    if not t[pf_file] then t[pf_file] = true; dofile(pf_file) end
    return unilib.farming._register_produce_fredo(...)

end

-- Statistical functions for farming
local stat_file = unilib.core.path_mod .. "/lib/shared/farming/farming_statistics.lua"

function unilib.farming.clamp_to_min_max(...)

    if not t[stat_file] then t[stat_file] = true; dofile(stat_file) end
    return unilib.farming._clamp_to_min_max(...)

end

function unilib.farming.do_standard_normal_distribution(...)

    if not t[stat_file] then t[stat_file] = true; dofile(stat_file) end
    return unilib.farming._do_standard_normal_distribution(...)

end

function unilib.farming.do_poisson_distribution(...)

    if not t[stat_file] then t[stat_file] = true; dofile(stat_file) end
    return unilib.farming._do_poisson_distribution(...)

end
