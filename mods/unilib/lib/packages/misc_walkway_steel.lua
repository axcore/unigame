---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    factory_bridges
-- Code:    LGPL-2.1
-- Media:   LGPL-2.1
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_walkway_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.factory_bridges.add_mode

---------------------------------------------------------------------------------------------------
-- Local variables
---------------------------------------------------------------------------------------------------

-- Dimensions table
local s = {l = -0.5, m = 0, h = 0.5, s = 0.01}

-- Elements table
local e = {}

e.a = {
    {s.l+000*s.s, s.l+000*s.s, s.l+000*s.s, s.h-000*s.s, s.l+003*s.s, s.h-000*s.s},
}

e.b = {
    {s.l+000*s.s, s.l+000*s.s, s.l+000*s.s, s.h-000*s.s, s.l+003*s.s, s.m+000*s.s},
    {s.l+000*s.s, s.m+000*s.s, s.m+000*s.s, s.h-000*s.s, s.m+003*s.s, s.h-000*s.s},
}

e.c = {
    {s.l+006*s.s, s.l+000*s.s, s.l+006*s.s, s.h-006*s.s, s.l+003*s.s, s.h-006*s.s},
    {s.l+006*s.s, s.l+006*s.s, s.h-006*s.s, s.h-006*s.s, s.h-006*s.s, s.h-003*s.s},
}

e.d = {
    {s.l+000*s.s, s.l+000*s.s, s.h-006*s.s, s.h-000*s.s, s.l+003*s.s, s.h-000*s.s},
    {s.h-006*s.s, s.l+000*s.s, s.l+000*s.s, s.h-000*s.s, s.l+003*s.s, s.h-000*s.s},
    {s.l+000*s.s, s.l+000*s.s, s.l+000*s.s, s.h-000*s.s, s.l+003*s.s, s.l+006*s.s},
    {s.l+000*s.s, s.l+000*s.s, s.l+000*s.s, s.l+006*s.s, s.l+003*s.s, s.h-000*s.s},
    {s.l+000*s.s, s.h-003*s.s, s.h-006*s.s, s.h-000*s.s, s.h-000*s.s, s.h-000*s.s},
    {s.h-006*s.s, s.h-003*s.s, s.l+000*s.s, s.h-000*s.s, s.h-000*s.s, s.h-000*s.s},
    {s.l+000*s.s, s.h-003*s.s, s.l+000*s.s, s.h-000*s.s, s.h-000*s.s, s.l+006*s.s},
    {s.l+000*s.s, s.h-003*s.s, s.l+000*s.s, s.l+006*s.s, s.h-000*s.s, s.h-000*s.s},
    {s.l+000*s.s, s.l+000*s.s, s.h-006*s.s, s.l+003*s.s, s.h-000*s.s, s.h-000*s.s},
    {s.h-003*s.s, s.l+000*s.s, s.h-006*s.s, s.h+000*s.s, s.h-000*s.s, s.h-000*s.s},
    {s.l+000*s.s, s.l+000*s.s, s.m+000*s.s, s.l+003*s.s, s.h-000*s.s, s.m-006*s.s},
    {s.h-003*s.s, s.l+000*s.s, s.m+000*s.s, s.h+000*s.s, s.h-000*s.s, s.m-006*s.s},
    {s.m-003*s.s, s.l+000*s.s, s.l+000*s.s, s.m+003*s.s, s.h-000*s.s, s.l+003*s.s},
    {s.l+003*s.s, s.l+022*s.s, s.l+003*s.s, s.l+006*s.s, s.l+028*s.s, s.h-000*s.s},
    {s.l+003*s.s, s.h-028*s.s, s.l+003*s.s, s.l+006*s.s, s.h-022*s.s, s.h-000*s.s},
    {s.h-006*s.s, s.l+022*s.s, s.l+003*s.s, s.h-003*s.s, s.l+028*s.s, s.h-000*s.s},
    {s.h-006*s.s, s.h-028*s.s, s.l+003*s.s, s.h-003*s.s, s.h-022*s.s, s.h-000*s.s},
    {s.l+003*s.s, s.l+022*s.s, s.l+003*s.s, s.h-003*s.s, s.l+028*s.s, s.l+006*s.s},
    {s.l+003*s.s, s.h-028*s.s, s.l+003*s.s, s.h-003*s.s, s.h-022*s.s, s.l+006*s.s},
}

e.e = {
    {s.l+001*s.s, s.l+000*s.s, s.h-005*s.s, s.l+005*s.s, s.h-000*s.s, s.h-001*s.s},
    {s.h-005*s.s, s.l+000*s.s, s.h-005*s.s, s.h-001*s.s, s.h-000*s.s, s.h-001*s.s},
    {s.h-005*s.s, s.l+000*s.s, s.l+001*s.s, s.h-001*s.s, s.h-000*s.s, s.l+005*s.s},
    {s.l+001*s.s, s.l+000*s.s, s.l+001*s.s, s.l+005*s.s, s.h-000*s.s, s.l+005*s.s},
    {s.l+023*s.s, s.l+000*s.s, s.h-005*s.s, s.l+027*s.s, s.h-000*s.s, s.h-001*s.s},
    {s.h-027*s.s, s.l+000*s.s, s.h-005*s.s, s.h-023*s.s, s.h-000*s.s, s.h-001*s.s},
    {s.h-005*s.s, s.l+000*s.s, s.l+023*s.s, s.h-001*s.s, s.h-000*s.s, s.l+027*s.s},
    {s.h-005*s.s, s.l+000*s.s, s.h-027*s.s, s.h-001*s.s, s.h-000*s.s, s.h-023*s.s},
    {s.h-027*s.s, s.l+000*s.s, s.l+001*s.s, s.h-023*s.s, s.h-000*s.s, s.l+005*s.s},
    {s.l+023*s.s, s.l+000*s.s, s.l+001*s.s, s.l+027*s.s, s.h-000*s.s, s.l+005*s.s},
    {s.l+001*s.s, s.l+000*s.s, s.l+023*s.s, s.l+005*s.s, s.h-000*s.s, s.l+027*s.s},
    {s.l+001*s.s, s.l+000*s.s, s.h-027*s.s, s.l+005*s.s, s.h-000*s.s, s.h-023*s.s},
    {s.l+000*s.s, s.l+023*s.s, s.h-005*s.s, s.h-000*s.s, s.l+027*s.s, s.h-001*s.s},
    {s.l+000*s.s, s.h-027*s.s, s.h-005*s.s, s.h-000*s.s, s.h-023*s.s, s.h-001*s.s},
}

e.f = {
    {s.l+000*s.s, s.h-003*s.s, s.h-006*s.s, s.l+006*s.s, s.h-000*s.s, s.h-000*s.s},
    {s.h-006*s.s, s.h-003*s.s, s.l+000*s.s, s.h-000*s.s, s.h-000*s.s, s.l+006*s.s},
    {s.l+000*s.s, s.h-003*s.s, s.l+000*s.s, s.l+006*s.s, s.h-000*s.s, s.l+006*s.s},
}

e.g = {
    {s.l+024*s.s, s.l+003*s.s, s.h-006*s.s, s.l+030*s.s, s.l+006*s.s, s.h-003*s.s},
    {s.h-030*s.s, s.l+003*s.s, s.h-006*s.s, s.h-024*s.s, s.l+006*s.s, s.h-003*s.s},
}

e.h = {
    {s.l+001*s.s, s.l+000*s.s, s.l+023*s.s, s.l+005*s.s, s.h+024*s.s, s.l+027*s.s},
    {s.l+001*s.s, s.m+000*s.s, s.h-027*s.s, s.l+005*s.s, s.h+075*s.s, s.h-023*s.s},
    {s.h-001*s.s, s.l+000*s.s, s.l+023*s.s, s.h-005*s.s, s.h+024*s.s, s.l+027*s.s},
    {s.h-001*s.s, s.m+000*s.s, s.h-027*s.s, s.h-005*s.s, s.h+075*s.s, s.h-023*s.s},
}

e.i = {
    {s.l+000*s.s, s.h+000*s.s, s.l+000*s.s, s.l+006*s.s, s.h+003*s.s, s.l+003*s.s},
    {s.l+000*s.s, s.h+003*s.s, s.l+003*s.s, s.l+006*s.s, s.h+006*s.s, s.l+006*s.s},
    {s.l+000*s.s, s.h+006*s.s, s.l+006*s.s, s.l+006*s.s, s.h+009*s.s, s.l+009*s.s},
    {s.l+000*s.s, s.h+009*s.s, s.l+009*s.s, s.l+006*s.s, s.h+012*s.s, s.l+012*s.s},
    {s.l+000*s.s, s.h+012*s.s, s.l+012*s.s, s.l+006*s.s, s.h+015*s.s, s.l+015*s.s},
    {s.l+000*s.s, s.h+015*s.s, s.l+015*s.s, s.l+006*s.s, s.h+018*s.s, s.l+018*s.s},
    {s.l+000*s.s, s.h+018*s.s, s.l+018*s.s, s.l+006*s.s, s.h+021*s.s, s.l+021*s.s},
    {s.l+000*s.s, s.h+021*s.s, s.l+021*s.s, s.l+006*s.s, s.h+024*s.s, s.l+024*s.s},
    {s.l+000*s.s, s.h+024*s.s, s.l+024*s.s, s.l+006*s.s, s.h+027*s.s, s.l+027*s.s},
    {s.l+000*s.s, s.h+027*s.s, s.l+027*s.s, s.l+006*s.s, s.h+030*s.s, s.l+030*s.s},
    {s.l+000*s.s, s.h+030*s.s, s.l+030*s.s, s.l+006*s.s, s.h+033*s.s, s.l+033*s.s},
    {s.l+000*s.s, s.h+033*s.s, s.l+033*s.s, s.l+006*s.s, s.h+036*s.s, s.l+036*s.s},
    {s.l+000*s.s, s.h+036*s.s, s.l+036*s.s, s.l+006*s.s, s.h+039*s.s, s.l+039*s.s},
    {s.l+000*s.s, s.h+039*s.s, s.l+039*s.s, s.l+006*s.s, s.h+042*s.s, s.l+042*s.s},
    {s.l+000*s.s, s.h+042*s.s, s.l+042*s.s, s.l+006*s.s, s.h+045*s.s, s.l+045*s.s},
    {s.l+000*s.s, s.h+045*s.s, s.l+045*s.s, s.l+006*s.s, s.h+048*s.s, s.l+048*s.s},
    {s.l+000*s.s, s.h+048*s.s, s.l+048*s.s, s.l+006*s.s, s.h+051*s.s, s.l+051*s.s},
    {s.l+000*s.s, s.h+051*s.s, s.l+051*s.s, s.l+006*s.s, s.h+054*s.s, s.l+054*s.s},
    {s.l+000*s.s, s.h+054*s.s, s.l+054*s.s, s.l+006*s.s, s.h+057*s.s, s.l+057*s.s},
    {s.l+000*s.s, s.h+057*s.s, s.l+057*s.s, s.l+006*s.s, s.h+060*s.s, s.l+060*s.s},
    {s.l+000*s.s, s.h+060*s.s, s.l+060*s.s, s.l+006*s.s, s.h+063*s.s, s.l+063*s.s},
    {s.l+000*s.s, s.h+063*s.s, s.l+063*s.s, s.l+006*s.s, s.h+066*s.s, s.l+066*s.s},
    {s.l+000*s.s, s.h+066*s.s, s.l+066*s.s, s.l+006*s.s, s.h+069*s.s, s.l+069*s.s},
    {s.l+000*s.s, s.h+069*s.s, s.l+069*s.s, s.l+006*s.s, s.h+072*s.s, s.l+072*s.s},
    {s.l+000*s.s, s.h+072*s.s, s.l+072*s.s, s.l+006*s.s, s.h+075*s.s, s.l+075*s.s},
    {s.l+000*s.s, s.h+075*s.s, s.l+075*s.s, s.l+006*s.s, s.h+078*s.s, s.l+078*s.s},
    {s.l+000*s.s, s.h+078*s.s, s.l+078*s.s, s.l+006*s.s, s.h+081*s.s, s.l+081*s.s},
    {s.l+000*s.s, s.h+081*s.s, s.l+081*s.s, s.l+006*s.s, s.h+084*s.s, s.l+084*s.s},
    {s.l+000*s.s, s.h+084*s.s, s.l+084*s.s, s.l+006*s.s, s.h+087*s.s, s.l+087*s.s},
    {s.l+000*s.s, s.h+087*s.s, s.l+087*s.s, s.l+006*s.s, s.h+090*s.s, s.l+090*s.s},
    {s.l+000*s.s, s.h+090*s.s, s.l+090*s.s, s.l+006*s.s, s.h+093*s.s, s.l+093*s.s},
    {s.l+000*s.s, s.h+093*s.s, s.l+093*s.s, s.l+006*s.s, s.h+096*s.s, s.l+096*s.s},
    {s.l+000*s.s, s.h+096*s.s, s.l+096*s.s, s.l+006*s.s, s.h+100*s.s, s.l+100*s.s},
    {s.h-000*s.s, s.h+000*s.s, s.l+000*s.s, s.h-006*s.s, s.h+003*s.s, s.l+003*s.s},
    {s.h-000*s.s, s.h+003*s.s, s.l+003*s.s, s.h-006*s.s, s.h+006*s.s, s.l+006*s.s},
    {s.h-000*s.s, s.h+006*s.s, s.l+006*s.s, s.h-006*s.s, s.h+009*s.s, s.l+009*s.s},
    {s.h-000*s.s, s.h+009*s.s, s.l+009*s.s, s.h-006*s.s, s.h+012*s.s, s.l+012*s.s},
    {s.h-000*s.s, s.h+012*s.s, s.l+012*s.s, s.h-006*s.s, s.h+015*s.s, s.l+015*s.s},
    {s.h-000*s.s, s.h+015*s.s, s.l+015*s.s, s.h-006*s.s, s.h+018*s.s, s.l+018*s.s},
    {s.h-000*s.s, s.h+018*s.s, s.l+018*s.s, s.h-006*s.s, s.h+021*s.s, s.l+021*s.s},
    {s.h-000*s.s, s.h+021*s.s, s.l+021*s.s, s.h-006*s.s, s.h+024*s.s, s.l+024*s.s},
    {s.h-000*s.s, s.h+024*s.s, s.l+024*s.s, s.h-006*s.s, s.h+027*s.s, s.l+027*s.s},
    {s.h-000*s.s, s.h+027*s.s, s.l+027*s.s, s.h-006*s.s, s.h+030*s.s, s.l+030*s.s},
    {s.h-000*s.s, s.h+030*s.s, s.l+030*s.s, s.h-006*s.s, s.h+033*s.s, s.l+033*s.s},
    {s.h-000*s.s, s.h+033*s.s, s.l+033*s.s, s.h-006*s.s, s.h+036*s.s, s.l+036*s.s},
    {s.h-000*s.s, s.h+036*s.s, s.l+036*s.s, s.h-006*s.s, s.h+039*s.s, s.l+039*s.s},
    {s.h-000*s.s, s.h+039*s.s, s.l+039*s.s, s.h-006*s.s, s.h+042*s.s, s.l+042*s.s},
    {s.h-000*s.s, s.h+042*s.s, s.l+042*s.s, s.h-006*s.s, s.h+045*s.s, s.l+045*s.s},
    {s.h-000*s.s, s.h+045*s.s, s.l+045*s.s, s.h-006*s.s, s.h+048*s.s, s.l+048*s.s},
    {s.h-000*s.s, s.h+048*s.s, s.l+048*s.s, s.h-006*s.s, s.h+051*s.s, s.l+051*s.s},
    {s.h-000*s.s, s.h+051*s.s, s.l+051*s.s, s.h-006*s.s, s.h+054*s.s, s.l+054*s.s},
    {s.h-000*s.s, s.h+054*s.s, s.l+054*s.s, s.h-006*s.s, s.h+057*s.s, s.l+057*s.s},
    {s.h-000*s.s, s.h+057*s.s, s.l+057*s.s, s.h-006*s.s, s.h+060*s.s, s.l+060*s.s},
    {s.h-000*s.s, s.h+060*s.s, s.l+060*s.s, s.h-006*s.s, s.h+063*s.s, s.l+063*s.s},
    {s.h-000*s.s, s.h+063*s.s, s.l+063*s.s, s.h-006*s.s, s.h+066*s.s, s.l+066*s.s},
    {s.h-000*s.s, s.h+066*s.s, s.l+066*s.s, s.h-006*s.s, s.h+069*s.s, s.l+069*s.s},
    {s.h-000*s.s, s.h+069*s.s, s.l+069*s.s, s.h-006*s.s, s.h+072*s.s, s.l+072*s.s},
    {s.h-000*s.s, s.h+072*s.s, s.l+072*s.s, s.h-006*s.s, s.h+075*s.s, s.l+075*s.s},
    {s.h-000*s.s, s.h+075*s.s, s.l+075*s.s, s.h-006*s.s, s.h+078*s.s, s.l+078*s.s},
    {s.h-000*s.s, s.h+078*s.s, s.l+078*s.s, s.h-006*s.s, s.h+081*s.s, s.l+081*s.s},
    {s.h-000*s.s, s.h+081*s.s, s.l+081*s.s, s.h-006*s.s, s.h+084*s.s, s.l+084*s.s},
    {s.h-000*s.s, s.h+084*s.s, s.l+084*s.s, s.h-006*s.s, s.h+087*s.s, s.l+087*s.s},
    {s.h-000*s.s, s.h+087*s.s, s.l+087*s.s, s.h-006*s.s, s.h+090*s.s, s.l+090*s.s},
    {s.h-000*s.s, s.h+090*s.s, s.l+090*s.s, s.h-006*s.s, s.h+093*s.s, s.l+093*s.s},
    {s.h-000*s.s, s.h+093*s.s, s.l+093*s.s, s.h-006*s.s, s.h+096*s.s, s.l+096*s.s},
    {s.h-000*s.s, s.h+096*s.s, s.l+096*s.s, s.h-006*s.s, s.h+100*s.s, s.l+100*s.s},
}

e.j = {
    {s.l+000*s.s, s.l+000*s.s, s.l+012*s.s, s.l+001*s.s, s.l+003*s.s, s.l+033*s.s},
    {s.l+000*s.s, s.l+003*s.s, s.l+015*s.s, s.l+001*s.s, s.l+006*s.s, s.l+035*s.s},
    {s.l+000*s.s, s.l+006*s.s, s.l+018*s.s, s.l+001*s.s, s.l+009*s.s, s.l+038*s.s},
    {s.l+000*s.s, s.l+009*s.s, s.l+021*s.s, s.l+001*s.s, s.l+012*s.s, s.l+041*s.s},
    {s.l+000*s.s, s.l+012*s.s, s.l+024*s.s, s.l+001*s.s, s.l+015*s.s, s.l+044*s.s},
    {s.l+000*s.s, s.l+015*s.s, s.l+027*s.s, s.l+001*s.s, s.l+018*s.s, s.l+047*s.s},
    {s.l+000*s.s, s.l+018*s.s, s.l+030*s.s, s.l+001*s.s, s.l+021*s.s, s.l+050*s.s},
    {s.l+000*s.s, s.l+021*s.s, s.l+033*s.s, s.l+001*s.s, s.l+024*s.s, s.l+053*s.s},
    {s.l+000*s.s, s.l+024*s.s, s.l+036*s.s, s.l+001*s.s, s.l+027*s.s, s.l+056*s.s},
    {s.l+000*s.s, s.l+027*s.s, s.l+039*s.s, s.l+001*s.s, s.l+030*s.s, s.l+059*s.s},
    {s.l+000*s.s, s.l+030*s.s, s.l+041*s.s, s.l+001*s.s, s.l+033*s.s, s.l+062*s.s},
    {s.l+000*s.s, s.l+033*s.s, s.l+044*s.s, s.l+001*s.s, s.l+036*s.s, s.l+065*s.s},
    {s.l+000*s.s, s.l+036*s.s, s.l+047*s.s, s.l+001*s.s, s.l+039*s.s, s.l+068*s.s},
    {s.l+000*s.s, s.l+039*s.s, s.l+050*s.s, s.l+001*s.s, s.l+042*s.s, s.l+071*s.s},
    {s.l+000*s.s, s.l+042*s.s, s.l+053*s.s, s.l+001*s.s, s.l+045*s.s, s.l+074*s.s},
    {s.l+000*s.s, s.l+045*s.s, s.l+056*s.s, s.l+001*s.s, s.l+048*s.s, s.l+077*s.s},
    {s.l+000*s.s, s.l+048*s.s, s.l+059*s.s, s.l+001*s.s, s.l+051*s.s, s.l+080*s.s},
    {s.l+000*s.s, s.l+051*s.s, s.l+062*s.s, s.l+001*s.s, s.l+054*s.s, s.l+083*s.s},
    {s.l+000*s.s, s.l+054*s.s, s.l+065*s.s, s.l+001*s.s, s.l+057*s.s, s.l+086*s.s},
    {s.l+000*s.s, s.l+057*s.s, s.l+068*s.s, s.l+001*s.s, s.l+060*s.s, s.l+089*s.s},
    {s.l+000*s.s, s.l+060*s.s, s.l+071*s.s, s.l+001*s.s, s.l+063*s.s, s.l+092*s.s},
    {s.l+000*s.s, s.l+063*s.s, s.l+074*s.s, s.l+001*s.s, s.l+066*s.s, s.l+095*s.s},
    {s.l+000*s.s, s.l+066*s.s, s.l+077*s.s, s.l+001*s.s, s.l+069*s.s, s.l+098*s.s},
    {s.l+000*s.s, s.l+069*s.s, s.l+080*s.s, s.l+001*s.s, s.l+072*s.s, s.l+101*s.s},
    {s.l+000*s.s, s.l+072*s.s, s.l+083*s.s, s.l+001*s.s, s.l+075*s.s, s.l+104*s.s},
    {s.l+000*s.s, s.l+075*s.s, s.l+086*s.s, s.l+001*s.s, s.l+078*s.s, s.l+107*s.s},
    {s.l+000*s.s, s.l+078*s.s, s.l+089*s.s, s.l+001*s.s, s.l+081*s.s, s.l+110*s.s},
    {s.l+000*s.s, s.l+081*s.s, s.l+092*s.s, s.l+001*s.s, s.l+084*s.s, s.l+113*s.s},
    {s.l+000*s.s, s.l+084*s.s, s.l+095*s.s, s.l+001*s.s, s.l+087*s.s, s.l+116*s.s},
    {s.l+000*s.s, s.l+087*s.s, s.l+098*s.s, s.l+001*s.s, s.l+090*s.s, s.l+119*s.s},
    {s.l+000*s.s, s.l+090*s.s, s.l+101*s.s, s.l+001*s.s, s.l+093*s.s, s.l+121*s.s},
    {s.l+000*s.s, s.l+093*s.s, s.l+104*s.s, s.l+001*s.s, s.l+096*s.s, s.l+124*s.s},
    {s.l+000*s.s, s.l+096*s.s, s.l+107*s.s, s.l+001*s.s, s.l+099*s.s, s.l+127*s.s},
    {s.l+000*s.s, s.l+099*s.s, s.l+110*s.s, s.l+001*s.s, s.l+102*s.s, s.l+130*s.s},
    {s.h-000*s.s, s.l+000*s.s, s.l+012*s.s, s.h-001*s.s, s.l+003*s.s, s.l+033*s.s},
    {s.h-000*s.s, s.l+003*s.s, s.l+015*s.s, s.h-001*s.s, s.l+006*s.s, s.l+035*s.s},
    {s.h-000*s.s, s.l+006*s.s, s.l+018*s.s, s.h-001*s.s, s.l+009*s.s, s.l+038*s.s},
    {s.h-000*s.s, s.l+009*s.s, s.l+021*s.s, s.h-001*s.s, s.l+012*s.s, s.l+041*s.s},
    {s.h-000*s.s, s.l+012*s.s, s.l+024*s.s, s.h-001*s.s, s.l+015*s.s, s.l+044*s.s},
    {s.h-000*s.s, s.l+015*s.s, s.l+027*s.s, s.h-001*s.s, s.l+018*s.s, s.l+047*s.s},
    {s.h-000*s.s, s.l+018*s.s, s.l+030*s.s, s.h-001*s.s, s.l+021*s.s, s.l+050*s.s},
    {s.h-000*s.s, s.l+021*s.s, s.l+033*s.s, s.h-001*s.s, s.l+024*s.s, s.l+053*s.s},
    {s.h-000*s.s, s.l+024*s.s, s.l+036*s.s, s.h-001*s.s, s.l+027*s.s, s.l+056*s.s},
    {s.h-000*s.s, s.l+027*s.s, s.l+039*s.s, s.h-001*s.s, s.l+030*s.s, s.l+059*s.s},
    {s.h-000*s.s, s.l+030*s.s, s.l+041*s.s, s.h-001*s.s, s.l+033*s.s, s.l+062*s.s},
    {s.h-000*s.s, s.l+033*s.s, s.l+044*s.s, s.h-001*s.s, s.l+036*s.s, s.l+065*s.s},
    {s.h-000*s.s, s.l+036*s.s, s.l+047*s.s, s.h-001*s.s, s.l+039*s.s, s.l+068*s.s},
    {s.h-000*s.s, s.l+039*s.s, s.l+050*s.s, s.h-001*s.s, s.l+042*s.s, s.l+071*s.s},
    {s.h-000*s.s, s.l+042*s.s, s.l+053*s.s, s.h-001*s.s, s.l+045*s.s, s.l+074*s.s},
    {s.h-000*s.s, s.l+045*s.s, s.l+056*s.s, s.h-001*s.s, s.l+048*s.s, s.l+077*s.s},
    {s.h-000*s.s, s.l+048*s.s, s.l+059*s.s, s.h-001*s.s, s.l+051*s.s, s.l+080*s.s},
    {s.h-000*s.s, s.l+051*s.s, s.l+062*s.s, s.h-001*s.s, s.l+054*s.s, s.l+083*s.s},
    {s.h-000*s.s, s.l+054*s.s, s.l+065*s.s, s.h-001*s.s, s.l+057*s.s, s.l+086*s.s},
    {s.h-000*s.s, s.l+057*s.s, s.l+068*s.s, s.h-001*s.s, s.l+060*s.s, s.l+089*s.s},
    {s.h-000*s.s, s.l+060*s.s, s.l+071*s.s, s.h-001*s.s, s.l+063*s.s, s.l+092*s.s},
    {s.h-000*s.s, s.l+063*s.s, s.l+074*s.s, s.h-001*s.s, s.l+066*s.s, s.l+095*s.s},
    {s.h-000*s.s, s.l+066*s.s, s.l+077*s.s, s.h-001*s.s, s.l+069*s.s, s.l+098*s.s},
    {s.h-000*s.s, s.l+069*s.s, s.l+080*s.s, s.h-001*s.s, s.l+072*s.s, s.l+101*s.s},
    {s.h-000*s.s, s.l+072*s.s, s.l+083*s.s, s.h-001*s.s, s.l+075*s.s, s.l+104*s.s},
    {s.h-000*s.s, s.l+075*s.s, s.l+086*s.s, s.h-001*s.s, s.l+078*s.s, s.l+107*s.s},
    {s.h-000*s.s, s.l+078*s.s, s.l+089*s.s, s.h-001*s.s, s.l+081*s.s, s.l+110*s.s},
    {s.h-000*s.s, s.l+081*s.s, s.l+092*s.s, s.h-001*s.s, s.l+084*s.s, s.l+113*s.s},
    {s.h-000*s.s, s.l+084*s.s, s.l+095*s.s, s.h-001*s.s, s.l+087*s.s, s.l+116*s.s},
    {s.h-000*s.s, s.l+087*s.s, s.l+098*s.s, s.h-001*s.s, s.l+090*s.s, s.l+119*s.s},
    {s.h-000*s.s, s.l+090*s.s, s.l+101*s.s, s.h-001*s.s, s.l+093*s.s, s.l+121*s.s},
    {s.h-000*s.s, s.l+093*s.s, s.l+104*s.s, s.h-001*s.s, s.l+096*s.s, s.l+124*s.s},
    {s.h-000*s.s, s.l+096*s.s, s.l+107*s.s, s.h-001*s.s, s.l+099*s.s, s.l+127*s.s},
    {s.h-000*s.s, s.l+099*s.s, s.l+110*s.s, s.h-001*s.s, s.l+102*s.s, s.l+130*s.s},
}

e.k = {
    {s.l+001*s.s, s.l-100*s.s, s.l+023*s.s, s.l+005*s.s, s.l+024*s.s, s.l+027*s.s},
    {s.l+001*s.s, s.l-050*s.s, s.h-027*s.s, s.l+005*s.s, s.l+075*s.s, s.h-023*s.s},
    {s.h-001*s.s, s.l-100*s.s, s.l+023*s.s, s.h-005*s.s, s.l+024*s.s, s.l+027*s.s},
    {s.h-001*s.s, s.l-050*s.s, s.h-027*s.s, s.h-005*s.s, s.l+075*s.s, s.h-023*s.s},
}

e.l = {
    {s.l+000*s.s, s.l+000*s.s, s.l+000*s.s, s.l+006*s.s, s.l+003*s.s, s.l+003*s.s},
    {s.l+000*s.s, s.l+003*s.s, s.l+003*s.s, s.l+006*s.s, s.l+006*s.s, s.l+006*s.s},
    {s.l+000*s.s, s.l+006*s.s, s.l+006*s.s, s.l+006*s.s, s.l+009*s.s, s.l+009*s.s},
    {s.l+000*s.s, s.l+009*s.s, s.l+009*s.s, s.l+006*s.s, s.l+012*s.s, s.l+012*s.s},
    {s.l+000*s.s, s.l+012*s.s, s.l+012*s.s, s.l+006*s.s, s.l+015*s.s, s.l+015*s.s},
    {s.l+000*s.s, s.l+015*s.s, s.l+015*s.s, s.l+006*s.s, s.l+018*s.s, s.l+018*s.s},
    {s.l+000*s.s, s.l+018*s.s, s.l+018*s.s, s.l+006*s.s, s.l+021*s.s, s.l+021*s.s},
    {s.l+000*s.s, s.l+021*s.s, s.l+021*s.s, s.l+006*s.s, s.l+024*s.s, s.l+024*s.s},
    {s.l+000*s.s, s.l+024*s.s, s.l+024*s.s, s.l+006*s.s, s.l+027*s.s, s.l+027*s.s},
    {s.l+000*s.s, s.l+027*s.s, s.l+027*s.s, s.l+006*s.s, s.l+030*s.s, s.l+030*s.s},
    {s.l+000*s.s, s.l+030*s.s, s.l+030*s.s, s.l+006*s.s, s.l+033*s.s, s.l+033*s.s},
    {s.l+000*s.s, s.l+033*s.s, s.l+033*s.s, s.l+006*s.s, s.l+036*s.s, s.l+036*s.s},
    {s.l+000*s.s, s.l+036*s.s, s.l+036*s.s, s.l+006*s.s, s.l+039*s.s, s.l+039*s.s},
    {s.l+000*s.s, s.l+039*s.s, s.l+039*s.s, s.l+006*s.s, s.l+042*s.s, s.l+042*s.s},
    {s.l+000*s.s, s.l+042*s.s, s.l+042*s.s, s.l+006*s.s, s.l+045*s.s, s.l+045*s.s},
    {s.l+000*s.s, s.l+045*s.s, s.l+045*s.s, s.l+006*s.s, s.l+048*s.s, s.l+048*s.s},
    {s.l+000*s.s, s.l+048*s.s, s.l+048*s.s, s.l+006*s.s, s.l+051*s.s, s.l+051*s.s},
    {s.l+000*s.s, s.l+051*s.s, s.l+051*s.s, s.l+006*s.s, s.l+054*s.s, s.l+054*s.s},
    {s.l+000*s.s, s.l+054*s.s, s.l+054*s.s, s.l+006*s.s, s.l+057*s.s, s.l+057*s.s},
    {s.l+000*s.s, s.l+057*s.s, s.l+057*s.s, s.l+006*s.s, s.l+060*s.s, s.l+060*s.s},
    {s.l+000*s.s, s.l+060*s.s, s.l+060*s.s, s.l+006*s.s, s.l+063*s.s, s.l+063*s.s},
    {s.l+000*s.s, s.l+063*s.s, s.l+063*s.s, s.l+006*s.s, s.l+066*s.s, s.l+066*s.s},
    {s.l+000*s.s, s.l+066*s.s, s.l+066*s.s, s.l+006*s.s, s.l+069*s.s, s.l+069*s.s},
    {s.l+000*s.s, s.l+069*s.s, s.l+069*s.s, s.l+006*s.s, s.l+072*s.s, s.l+072*s.s},
    {s.l+000*s.s, s.l+072*s.s, s.l+072*s.s, s.l+006*s.s, s.l+075*s.s, s.l+075*s.s},
    {s.l+000*s.s, s.l+075*s.s, s.l+075*s.s, s.l+006*s.s, s.l+078*s.s, s.l+078*s.s},
    {s.l+000*s.s, s.l+078*s.s, s.l+078*s.s, s.l+006*s.s, s.l+081*s.s, s.l+081*s.s},
    {s.l+000*s.s, s.l+081*s.s, s.l+081*s.s, s.l+006*s.s, s.l+084*s.s, s.l+084*s.s},
    {s.l+000*s.s, s.l+084*s.s, s.l+084*s.s, s.l+006*s.s, s.l+087*s.s, s.l+087*s.s},
    {s.l+000*s.s, s.l+087*s.s, s.l+087*s.s, s.l+006*s.s, s.l+090*s.s, s.l+090*s.s},
    {s.l+000*s.s, s.l+090*s.s, s.l+090*s.s, s.l+006*s.s, s.l+093*s.s, s.l+093*s.s},
    {s.l+000*s.s, s.l+093*s.s, s.l+093*s.s, s.l+006*s.s, s.l+096*s.s, s.l+096*s.s},
    {s.l+000*s.s, s.l+096*s.s, s.l+096*s.s, s.l+006*s.s, s.l+100*s.s, s.l+100*s.s},
    {s.h-000*s.s, s.l+000*s.s, s.l+000*s.s, s.h-006*s.s, s.l+003*s.s, s.l+003*s.s},
    {s.h-000*s.s, s.l+003*s.s, s.l+003*s.s, s.h-006*s.s, s.l+006*s.s, s.l+006*s.s},
    {s.h-000*s.s, s.l+006*s.s, s.l+006*s.s, s.h-006*s.s, s.l+009*s.s, s.l+009*s.s},
    {s.h-000*s.s, s.l+009*s.s, s.l+009*s.s, s.h-006*s.s, s.l+012*s.s, s.l+012*s.s},
    {s.h-000*s.s, s.l+012*s.s, s.l+012*s.s, s.h-006*s.s, s.l+015*s.s, s.l+015*s.s},
    {s.h-000*s.s, s.l+015*s.s, s.l+015*s.s, s.h-006*s.s, s.l+018*s.s, s.l+018*s.s},
    {s.h-000*s.s, s.l+018*s.s, s.l+018*s.s, s.h-006*s.s, s.l+021*s.s, s.l+021*s.s},
    {s.h-000*s.s, s.l+021*s.s, s.l+021*s.s, s.h-006*s.s, s.l+024*s.s, s.l+024*s.s},
    {s.h-000*s.s, s.l+024*s.s, s.l+024*s.s, s.h-006*s.s, s.l+027*s.s, s.l+027*s.s},
    {s.h-000*s.s, s.l+027*s.s, s.l+027*s.s, s.h-006*s.s, s.l+030*s.s, s.l+030*s.s},
    {s.h-000*s.s, s.l+030*s.s, s.l+030*s.s, s.h-006*s.s, s.l+033*s.s, s.l+033*s.s},
    {s.h-000*s.s, s.l+033*s.s, s.l+033*s.s, s.h-006*s.s, s.l+036*s.s, s.l+036*s.s},
    {s.h-000*s.s, s.l+036*s.s, s.l+036*s.s, s.h-006*s.s, s.l+039*s.s, s.l+039*s.s},
    {s.h-000*s.s, s.l+039*s.s, s.l+039*s.s, s.h-006*s.s, s.l+042*s.s, s.l+042*s.s},
    {s.h-000*s.s, s.l+042*s.s, s.l+042*s.s, s.h-006*s.s, s.l+045*s.s, s.l+045*s.s},
    {s.h-000*s.s, s.l+045*s.s, s.l+045*s.s, s.h-006*s.s, s.l+048*s.s, s.l+048*s.s},
    {s.h-000*s.s, s.l+048*s.s, s.l+048*s.s, s.h-006*s.s, s.l+051*s.s, s.l+051*s.s},
    {s.h-000*s.s, s.l+051*s.s, s.l+051*s.s, s.h-006*s.s, s.l+054*s.s, s.l+054*s.s},
    {s.h-000*s.s, s.l+054*s.s, s.l+054*s.s, s.h-006*s.s, s.l+057*s.s, s.l+057*s.s},
    {s.h-000*s.s, s.l+057*s.s, s.l+057*s.s, s.h-006*s.s, s.l+060*s.s, s.l+060*s.s},
    {s.h-000*s.s, s.l+060*s.s, s.l+060*s.s, s.h-006*s.s, s.l+063*s.s, s.l+063*s.s},
    {s.h-000*s.s, s.l+063*s.s, s.l+063*s.s, s.h-006*s.s, s.l+066*s.s, s.l+066*s.s},
    {s.h-000*s.s, s.l+066*s.s, s.l+066*s.s, s.h-006*s.s, s.l+069*s.s, s.l+069*s.s},
    {s.h-000*s.s, s.l+069*s.s, s.l+069*s.s, s.h-006*s.s, s.l+072*s.s, s.l+072*s.s},
    {s.h-000*s.s, s.l+072*s.s, s.l+072*s.s, s.h-006*s.s, s.l+075*s.s, s.l+075*s.s},
    {s.h-000*s.s, s.l+075*s.s, s.l+075*s.s, s.h-006*s.s, s.l+078*s.s, s.l+078*s.s},
    {s.h-000*s.s, s.l+078*s.s, s.l+078*s.s, s.h-006*s.s, s.l+081*s.s, s.l+081*s.s},
    {s.h-000*s.s, s.l+081*s.s, s.l+081*s.s, s.h-006*s.s, s.l+084*s.s, s.l+084*s.s},
    {s.h-000*s.s, s.l+084*s.s, s.l+084*s.s, s.h-006*s.s, s.l+087*s.s, s.l+087*s.s},
    {s.h-000*s.s, s.l+087*s.s, s.l+087*s.s, s.h-006*s.s, s.l+090*s.s, s.l+090*s.s},
    {s.h-000*s.s, s.l+090*s.s, s.l+090*s.s, s.h-006*s.s, s.l+093*s.s, s.l+093*s.s},
    {s.h-000*s.s, s.l+093*s.s, s.l+093*s.s, s.h-006*s.s, s.l+096*s.s, s.l+096*s.s},
    {s.h-000*s.s, s.l+096*s.s, s.l+096*s.s, s.h-006*s.s, s.l+100*s.s, s.l+100*s.s},
}

-- Diagonal railing
e.m = {}
for i = 0, 95, 5 do

    table.insert(e.m, {
        s.l+i*s.s, s.h-003*s.s, s.l+i*s.s,
        s.l+(i+5)*s.s, s.h-000*s.s, s.l+(i+5)*s.s
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_walkway_steel.init()

    return {
        description = "Various support structures for walkways",
        notes = "The entire mod has been arrange inside a single package for efficiency",
        depends = "metal_steel",
    }

end

function unilib.pkg.misc_walkway_steel.exec()

    local hatch_img = "unilib_misc_walkway_steel_hatch.png"
    local platform_img = "unilib_misc_walkway_steel_platform.png"
    local steps_img = "unilib_misc_walkway_steel_steps.png"
    local support_img = "unilib_misc_walkway_steel_support.png"

    -- Support structures

    unilib.register_node("unilib:misc_walkway_steel_support_1", "factory_bridges:a01", mode, {
        -- From factory_bridges:a01
        description = unilib.utils.brackets(S("Steel Walkway Support"), S("One corner post")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[01], e.f[01]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a01
        output = "unilib:misc_walkway_steel_support_1",
        recipe = {
            {"", "unilib:misc_walkway_steel_item_block", ""},
            {"", "unilib:misc_walkway_steel_item_pole", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_2", "factory_bridges:a02", mode, {
        -- From factory_bridges:a02
        description = unilib.utils.brackets(S("Steel Walkway Support"), S("Two corner posts")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[01], e.f[01], e.e[02], e.f[02]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a02
        output = "unilib:misc_walkway_steel_support_2",
        recipe = {
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
            {"", "", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_3", "factory_bridges:a03", mode, {
        -- From factory_bridges:a03
        description = unilib.utils.brackets(S("Steel Walkway Support"), S("Three corner posts")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[01], e.f[01], e.e[02], e.f[02], e.e[03], e.f[03]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a03
        output = "unilib:misc_walkway_steel_support_3",
        recipe = {
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
            {"", "", ""},
            {"", "", "unilib:misc_walkway_steel_support_1"},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_4", "factory_bridges:a04", mode, {
        -- From factory_bridges:a04
        description = unilib.utils.brackets(S("Steel Walkway Support"), S("Four corner posts")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[01], e.f[01], e.e[02], e.f[02], e.e[03], e.f[03], e.e[04], e.f[04]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a04
        output = "unilib:misc_walkway_steel_support_4",
        recipe = {
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
            {"", "", ""},
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_5", "factory_bridges:a05", mode, {
        -- From factory_bridges:a05
        description = unilib.utils.brackets(S("Steel Walkway Support"), S("Remote control")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[05], e.e[06], e.d[05]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a05
        output = "unilib:misc_walkway_steel_support_5",
        recipe = {
            {"", "unilib:misc_walkway_steel_item_beam", ""},
            {"unilib:misc_walkway_steel_item_pole", "", "unilib:misc_walkway_steel_item_pole"},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_6", "factory_bridges:a05dia", mode, {
        -- From factory_bridges:a05dia
        description = unilib.utils.brackets(S("Steel Walkway Support"), S("Diagonal corner posts")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {s.l+023*s.s, s.l+000*s.s, s.l+023*s.s, s.l+027*s.s, s.h-000*s.s, s.l+027*s.s},
                {s.h-027*s.s, s.l+000*s.s, s.h-027*s.s, s.h-023*s.s, s.h-000*s.s, s.h-023*s.s},
                e.m[01], e.m[02], e.m[03], e.m[04], e.m[05], e.m[06], e.m[07], e.m[08], e.m[09],
                e.m[10], e.m[11], e.m[12], e.m[13], e.m[14], e.m[15], e.m[16], e.m[17], e.m[18],
                e.m[19], e.m[20], e.m[21], e.m[22], e.m[23], e.m[24], e.m[25], e.m[26], e.m[27],
                e.m[28], e.m[29], e.m[30], e.m[31], e.m[32], e.m[33],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a05dia
        output = "unilib:misc_walkway_steel_support_6",
        recipe = {
            {"unilib:misc_walkway_steel_support_5", "", ""},
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"", "", "unilib:misc_walkway_steel_support_5"},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_7", "factory_bridges:a06", mode, {
        -- From factory_bridges:a06
        description = unilib.utils.brackets(
            S("Steel Walkway Support"), S("Far handrail, near right-corner post")
        ),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[05], e.e[06], e.d[05], e.e[03], e.f[03]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a06
        output = "unilib:misc_walkway_steel_support_7",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"", "", ""},
            {"", "", "unilib:misc_walkway_steel_support_1"},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_8", "factory_bridges:a07", mode, {
        -- From factory_bridges:a07
        description = unilib.utils.brackets(
            S("Steel Walkway Support"), S("Far handrail, near left-corner post")
        ),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[05], e.e[06], e.d[05], e.e[04], e.f[04]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a07
        output = "unilib:misc_walkway_steel_support_8",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"", "", ""},
            {"unilib:misc_walkway_steel_support_1", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_9", "factory_bridges:a08", mode, {
        -- From factory_bridges:a08
        description = unilib.utils.brackets(
            S("Steel Walkway Support"), S("Far handrail, near-corner posts")
        ),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[05], e.e[06], e.d[05], e.e[03], e.f[03], e.e[04], e.f[04]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a08
        output = "unilib:misc_walkway_steel_support_9",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"", "", ""},
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_10", "factory_bridges:a09", mode, {
        -- From factory_bridges:a09
        description = unilib.utils.brackets(S("Steel Walkway Support"), S("Far and left railings")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[05], e.e[06], e.d[05], e.e[11], e.e[12], e.d[08]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a09
        output = "unilib:misc_walkway_steel_support_10",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"unilib:misc_walkway_steel_support_5", "", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_11", "factory_bridges:a10", mode, {
        -- From factory_bridges:a10
        description = unilib.utils.brackets(
            S("Steel Walkway Support"), S("Far and left railings, near right-corner post")
        ),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[05], e.e[06], e.d[05], e.e[11], e.e[12], e.d[08], e.e[03], e.f[03]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a10
        output = "unilib:misc_walkway_steel_support_11",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"unilib:misc_walkway_steel_support_5", "", ""},
            {"", "", "unilib:misc_walkway_steel_support_1"},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_12", "factory_bridges:a11", mode, {
        -- From factory_bridges:a11
        description =
                unilib.utils.brackets(S("Steel Walkway Support"), S("Left and right railings")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.e[07], e.e[08], e.d[06], e.e[11], e.e[12], e.d[08]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a11
        output = "unilib:misc_walkway_steel_support_12",
        recipe = {
            {"", "", ""},
            {"unilib:misc_walkway_steel_support_5", "", "unilib:misc_walkway_steel_support_5"},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_13", "factory_bridges:a12", mode, {
        -- From factory_bridges:a12
        description = unilib.utils.brackets(
            S("Steel Walkway Support"), S("Left, right and far railings")
        ),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.e[07], e.e[08], e.d[06], e.e[11], e.e[12], e.d[08], e.e[05], e.e[06], e.d[05],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a12
        output = "unilib:misc_walkway_steel_support_13",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"unilib:misc_walkway_steel_support_5", "", "unilib:misc_walkway_steel_support_5"},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_14", "factory_bridges:a13", mode, {
        -- From factory_bridges:a13
        description = unilib.utils.brackets(S("Steel Walkway Support"), S("Sloping left handrail")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.k[01], e.k[02], e.l[01], e.l[02], e.l[03], e.l[04], e.l[05], e.l[06], e.l[07],
                e.l[08], e.l[09], e.l[10], e.l[11], e.l[12], e.l[13], e.l[14], e.l[15], e.l[16],
                e.l[17], e.l[18], e.l[19], e.l[20], e.l[21], e.l[22], e.l[23], e.l[24], e.l[25],
                e.l[26], e.l[27], e.l[28], e.l[29], e.l[30], e.l[31], e.l[32], e.l[33],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a13
        output = "unilib:misc_walkway_steel_support_14",
        recipe = {
            {"", "unilib:misc_walkway_steel_item_beam", "unilib:misc_walkway_steel_item_pole"},
            {"", "unilib:misc_walkway_steel_item_pole", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_15", "factory_bridges:a14", mode, {
        -- From factory_bridges:a14
        description =
                unilib.utils.brackets(S("Steel Walkway Support"), S("Sloping right handrail")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.k[03], e.k[04], e.l[34], e.l[35], e.l[36], e.l[37], e.l[38], e.l[39], e.l[40],
                e.l[41], e.l[42], e.l[43], e.l[44], e.l[45], e.l[46], e.l[47], e.l[48], e.l[49],
                e.l[50], e.l[51], e.l[52], e.l[53], e.l[54], e.l[55], e.l[56], e.l[57], e.l[58],
                e.l[59], e.l[60], e.l[61], e.l[62], e.l[63], e.l[64], e.l[65], e.l[66],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a14
        output = "unilib:misc_walkway_steel_support_15",
        recipe = {
            {"unilib:misc_walkway_steel_item_pole", "unilib:misc_walkway_steel_item_beam", ""},
            {"", "unilib:misc_walkway_steel_item_pole", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_16", "factory_bridges:a15", mode, {
        -- From factory_bridges:a15
        description =
                unilib.utils.brackets(S("Steel Walkway Support"), S("Inclined double handrail")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.k[01], e.k[02], e.k[03], e.k[04], e.l[01], e.l[02], e.l[03], e.l[04], e.l[05],
                e.l[06], e.l[07], e.l[08], e.l[09], e.l[10], e.l[11], e.l[12], e.l[13], e.l[14],
                e.l[15], e.l[16], e.l[17], e.l[18], e.l[19], e.l[20], e.l[21], e.l[22], e.l[23],
                e.l[24], e.l[25], e.l[26], e.l[27], e.l[28], e.l[29], e.l[30], e.l[31], e.l[32],
                e.l[33], e.l[34], e.l[35], e.l[36], e.l[37], e.l[38], e.l[39], e.l[40], e.l[41],
                e.l[42], e.l[43], e.l[44], e.l[45], e.l[46], e.l[47], e.l[48], e.l[49], e.l[50],
                e.l[51], e.l[52], e.l[53], e.l[54], e.l[55], e.l[56], e.l[57], e.l[58], e.l[59],
                e.l[60], e.l[61], e.l[62], e.l[63], e.l[64], e.l[65], e.l[66],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:a15
        output = "unilib:misc_walkway_steel_support_16",
        recipe = {
            {"", "", ""},
            {"unilib:misc_walkway_steel_support_14", "", "unilib:misc_walkway_steel_support_15"},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_17", "factory_bridges:s00", mode, {
        -- From factory_bridges:s00
        description =
                unilib.utils.brackets(S("Steel Walkway Support"), S("Open vertical staircase")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        climbable = true,
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {type = "fixed", fixed = {e.d[09], e.d[10], e.e[13], e.e[14]}},
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:s00
        output = "unilib:misc_walkway_steel_support_17",
        recipe = {
            {"", "unilib:misc_walkway_steel_item_pole", ""},
            {"unilib:misc_walkway_steel_item_beam", "", "unilib:misc_walkway_steel_item_beam"},
            {"", "unilib:misc_walkway_steel_item_pole", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_18", "factory_bridges:s01", mode, {
        -- From factory_bridges:s01
        description =
                unilib.utils.brackets(S("Steel Walkway Support"), S("Closed vertical staircase")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        climbable = true,
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.d[09], e.d[10], e.e[13], e.e[14], e.d[11], e.d[12], e.d[13], e.d[14], e.d[15],
                e.d[16], e.d[17], e.d[18], e.d[19],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:s01
        output = "unilib:misc_walkway_steel_support_18",
        recipe = {
            {
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_item_beam",
            },
            {
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_support_17",
                "unilib:misc_walkway_steel_item_beam",
            },
            {
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_item_beam",
            },
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_19", "factory_bridges:s02", mode, {
        -- From factory_bridges:s02
        description =
                unilib.utils.brackets(S("Steel Walkway Support"), S("Top of vertical ladder")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.d[09], e.d[10], e.d[11], e.d[12], e.d[13], e.d[06], e.d[07], e.d[08]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:s02
        output = "unilib:misc_walkway_steel_support_19",
        recipe = {
            {
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_item_beam",
            },
            {
                "unilib:misc_walkway_steel_item_beam",
                "",
                "unilib:misc_walkway_steel_item_beam",
            },
            {
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_item_beam",
            },
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_20", "factory_bridges:s03", mode, {
        -- From factory_bridges:s03
        description = unilib.utils.brackets(
            S("Steel Walkway Support"), S("Staircase with exit to right")
        ),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        climbable = true,
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.d[09], e.d[10], e.e[13], e.e[14], e.d[11], e.d[13], e.d[08], e.d[07]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:s03
        output = "unilib:misc_walkway_steel_support_20",
        recipe = {
            {"unilib:misc_walkway_steel_item_beam", "", ""},
            {"unilib:misc_walkway_steel_item_beam", "unilib:misc_walkway_steel_support_17", ""},
            {"unilib:misc_walkway_steel_item_beam", "unilib:misc_walkway_steel_item_beam", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_21", "factory_bridges:s04", mode, {
        -- From factory_bridges:s04
        description =
                unilib.utils.brackets(S("Steel Walkway Support"), S("Staircase with exit to left")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        climbable = true,
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.d[09], e.d[10], e.e[13], e.e[14], e.d[12], e.d[13], e.d[06], e.d[07]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:s04
        output = "unilib:misc_walkway_steel_support_21",
        recipe = {
            {"", "", "unilib:misc_walkway_steel_item_beam"},
            {"", "unilib:misc_walkway_steel_support_17", "unilib:misc_walkway_steel_item_beam"},
            {"", "unilib:misc_walkway_steel_item_beam", "unilib:misc_walkway_steel_item_beam"},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_support_22", "factory_bridges:s05", mode, {
        -- From factory_bridges:s05
        description =
                unilib.utils.brackets(S("Steel Walkway Support"), S("Staircase with dual exits")),
        tiles = {support_img},
        groups = {cracky = 2},
        -- (no sounds)

        climbable = true,
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.d[09], e.d[10], e.e[13], e.e[14], e.d[13], e.d[07]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:s05
        output = "unilib:misc_walkway_steel_support_22",
        recipe = {
            {"", "", ""},
            {"", "unilib:misc_walkway_steel_support_17", ""},
            {"unilib:misc_walkway_steel_item_beam", "", "unilib:misc_walkway_steel_item_beam"},
        },
    })

    -- Platforms

    unilib.register_node("unilib:misc_walkway_steel_platform_1", "factory_bridges:b00", mode, {
        -- From factory_bridges:b00
        description = unilib.utils.brackets(S("Steel Walkway Platform"), S("Bottom plate")),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {type = "fixed", fixed = {e.a[01]}},
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b00
        output = "unilib:misc_walkway_steel_platform_1 10",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_2", "factory_bridges:b01", mode, {
        -- From factory_bridges:b01
        description = unilib.utils.brackets(S("Steel Walkway Platform"), S("One corner post")),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {type = "fixed", fixed = {e.a[01], e.e[01], e.f[01]}},
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b01
        output = "unilib:misc_walkway_steel_platform_2",
        recipe = {
            {"unilib:misc_walkway_steel_support_1", "", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_3", "factory_bridges:b02", mode, {
        -- From factory_bridges:b02
        description = unilib.utils.brackets(S("Steel Walkway Platform"), S("Two corner posts")),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {type = "fixed", fixed = {e.a[01], e.e[01], e.f[01], e.e[02], e.f[02]}},
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b02
        output = "unilib:misc_walkway_steel_platform_3",
        recipe = {
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b02
        output = "unilib:misc_walkway_steel_platform_3",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_2", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_4", "factory_bridges:b03", mode, {
        -- From factory_bridges:b03
        description = unilib.utils.brackets(S("Steel Walkway Platform"), S("Three corner posts")),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.a[01], e.e[01], e.f[01], e.e[02], e.f[02], e.e[03], e.f[03]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b03
        output = "unilib:misc_walkway_steel_platform_4",
        recipe = {
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", "unilib:misc_walkway_steel_support_1"},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b03
        output = "unilib:misc_walkway_steel_platform_4",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_3", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_5", "factory_bridges:b04", mode, {
        -- From factory_bridges:b04
        description = unilib.utils.brackets(S("Steel Walkway Platform"), S("Four corner posts")),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.a[01], e.e[01], e.f[01], e.e[02], e.f[02], e.e[03], e.f[03], e.e[04], e.f[04],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b04
        output = "unilib:misc_walkway_steel_platform_5",
        recipe = {
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b04
        output = "unilib:misc_walkway_steel_platform_5",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_4", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_6", "factory_bridges:b05", mode, {
        -- From factory_bridges:b05
        description = unilib.utils.brackets(S("Steel Walkway Platform"), S("Remote control")),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {type = "fixed", fixed = {e.a[01], e.e[05], e.e[06], e.d[05]}},
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b05
        output = "unilib:misc_walkway_steel_platform_6",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_7", "factory_bridges:b06", mode, {
        -- From factory_bridges:b06
        description = unilib.utils.brackets(
            S("Steel Walkway Platform"), S("Railing and near right-corner post")
        ),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {type = "fixed", fixed = {e.a[01], e.e[05], e.e[06], e.d[05], e.e[03], e.f[03]}},
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b06
        output = "unilib:misc_walkway_steel_platform_7",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", "unilib:misc_walkway_steel_support_1"},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b06
        output = "unilib:misc_walkway_steel_platform_7",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_7", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_8", "factory_bridges:b07", mode, {
        -- From factory_bridges:b07
        description = unilib.utils.brackets(
            S("Steel Walkway Platform"), S("Far railing and near left-corner post")
        ),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {type = "fixed", fixed = {e.a[01], e.e[05], e.e[06], e.d[05], e.e[04], e.f[04]}},
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b07
        output = "unilib:misc_walkway_steel_platform_8",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"unilib:misc_walkway_steel_support_1", "", ""},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b07
        output = "unilib:misc_walkway_steel_platform_8",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_8", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_9", "factory_bridges:b08", mode, {
        -- From factory_bridges:b08
        description = unilib.utils.brackets(
            S("Steel Walkway Platform"), S("Far railing and near corner posts")
        ),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.a[01], e.e[05], e.e[06], e.d[05], e.e[03], e.f[03], e.e[04], e.f[04]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b08
        output = "unilib:misc_walkway_steel_platform_9",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"unilib:misc_walkway_steel_support_1", "", "unilib:misc_walkway_steel_support_1"},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b08
        output = "unilib:misc_walkway_steel_platform_9",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_9", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_10", "factory_bridges:b09", mode, {
        -- From factory_bridges:b09
        description =
                unilib.utils.brackets(S("Steel Walkway Platform"), S("Far and left railings")),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.a[01], e.e[05], e.e[06], e.d[05], e.e[11], e.e[12], e.d[08]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b09
        output = "unilib:misc_walkway_steel_platform_10",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"unilib:misc_walkway_steel_support_5", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b09
        output = "unilib:misc_walkway_steel_platform_10",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_10", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_11", "factory_bridges:b10", mode, {
        -- From factory_bridges:b10
        description = unilib.utils.brackets(
            S("Steel Walkway Platform"), S("Far and left railings, and near corner-right post")
        ),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.a[01], e.e[05], e.e[06], e.d[05], e.e[11], e.e[12], e.d[08], e.e[03], e.f[03],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b10
        output = "unilib:misc_walkway_steel_platform_11",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {"unilib:misc_walkway_steel_support_5", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", "unilib:misc_walkway_steel_support_1"},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b10
        output = "unilib:misc_walkway_steel_platform_11",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_11", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_12", "factory_bridges:b11", mode, {
        -- From factory_bridges:b11
        description =
                unilib.utils.brackets(S("Steel Walkway Platform"), S("Left and right railings")),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.a[01], e.e[07], e.e[08], e.d[06], e.e[11], e.e[12], e.d[08]},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b11
        output = "unilib:misc_walkway_steel_platform_12",
        recipe = {
            {"", "", ""},
            {
                "unilib:misc_walkway_steel_support_5",
                "unilib:misc_walkway_steel_platform_1",
                "unilib:misc_walkway_steel_support_5",
            },
            {"", "", ""},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b11
        output = "unilib:misc_walkway_steel_platform_12",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_12", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_platform_13", "factory_bridges:b12", mode, {
        -- From factory_bridges:b12
        description = unilib.utils.brackets(
            S("Steel Walkway Platform"), S("Left, right and far railings")
        ),
        tiles = {platform_img, platform_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.a[01], e.e[07], e.e[08], e.d[06], e.e[11], e.e[12], e.d[08], e.e[05], e.e[06],
                e.d[05],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:b12
        output = "unilib:misc_walkway_steel_platform_13",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_5", ""},
            {
                "unilib:misc_walkway_steel_support_5",
                "unilib:misc_walkway_steel_platform_1",
                "unilib:misc_walkway_steel_support_5",
            },
            {"", "", ""},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:b12
        output = "unilib:misc_walkway_steel_platform_13",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_13", ""},
            {"", "unilib:misc_walkway_steel_platform_1", ""},
            {"", "", ""},
        },
    })

    -- Steps

    unilib.register_node("unilib:misc_walkway_steel_steps_1", "factory_bridges:c00", mode, {
        -- From factory_bridges:c00
        description = unilib.utils.brackets(S("Steel Walkway Steps"), S("Simple")),
        tiles = {steps_img, steps_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.b[01], e.b[02], e.j[01], e.j[02], e.j[03], e.j[04], e.j[05], e.j[06], e.j[07],
                e.j[08], e.j[09], e.j[10], e.j[11], e.j[12], e.j[13], e.j[14], e.j[15], e.j[16],
                e.j[17], e.j[18], e.j[19], e.j[20], e.j[21], e.j[22], e.j[23], e.j[24], e.j[25],
                e.j[26], e.j[27], e.j[28], e.j[29], e.j[30], e.j[31], e.j[32], e.j[33], e.j[34],
                e.j[35], e.j[36], e.j[37], e.j[38], e.j[39], e.j[40], e.j[41], e.j[42], e.j[43],
                e.j[44], e.j[45], e.j[46], e.j[47], e.j[48], e.j[49], e.j[50], e.j[51], e.j[52],
                e.j[53], e.j[54], e.j[55], e.j[56], e.j[57], e.j[58], e.j[59], e.j[60], e.j[61],
                e.j[62], e.j[63], e.j[64], e.j[65], e.j[66], e.j[67], e.j[68],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:c00
        output = "unilib:misc_walkway_steel_steps_1 2",
        recipe = {
            {"unilib:misc_walkway_steel_item_beam", "unilib:misc_walkway_steel_platform_1", ""},
            {"unilib:misc_walkway_steel_platform_1", "unilib:misc_walkway_steel_item_beam", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_steps_2", "factory_bridges:c01", mode, {
        -- From factory_bridges:c01
        description = unilib.utils.brackets(S("Steel Walkway Steps"), S("Left handrail")),
        tiles = {steps_img, steps_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.b[01], e.b[02], e.h[01], e.h[02], e.j[01], e.j[02], e.j[03], e.j[04], e.j[05],
                e.j[06], e.j[07], e.j[08], e.j[09], e.j[10], e.j[11], e.j[12], e.j[13], e.j[14],
                e.j[15], e.j[16], e.j[17], e.j[18], e.j[19], e.j[20], e.j[21], e.j[22], e.j[23],
                e.j[24], e.j[25], e.j[26], e.j[27], e.j[28], e.j[29], e.j[30], e.j[31], e.j[32],
                e.j[33], e.j[34], e.j[35], e.j[36], e.j[37], e.j[38], e.j[39], e.j[40], e.j[41],
                e.j[42], e.j[43], e.j[44], e.j[45], e.j[46], e.j[47], e.j[48], e.j[49], e.j[50],
                e.j[51], e.j[52], e.j[53], e.j[54], e.j[55], e.j[56], e.j[57], e.j[58], e.j[59],
                e.j[60], e.j[61], e.j[62], e.j[63], e.j[64], e.j[65], e.j[66], e.j[67], e.j[68],
                e.i[01], e.i[02], e.i[03], e.i[04], e.i[05], e.i[06], e.i[07], e.i[08], e.i[09],
                e.i[10], e.i[11], e.i[12], e.i[13], e.i[14], e.i[15], e.i[16], e.i[17], e.i[18],
                e.i[19], e.i[20], e.i[21], e.i[22], e.i[23], e.i[24], e.i[25], e.i[26], e.i[27],
                e.i[28], e.i[29], e.i[30], e.i[31], e.i[32], e.i[33],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:c01
        output = "unilib:misc_walkway_steel_steps_2",
        recipe = {
            {"", "", ""},
            {"unilib:misc_walkway_steel_support_14", "unilib:misc_walkway_steel_steps_1", ""},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_steps_3", "factory_bridges:c02", mode, {
        -- From factory_bridges:c02
        description = unilib.utils.brackets(S("Steel Walkway Steps"), S("Right handrail")),
        tiles = {steps_img, steps_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.b[01], e.b[02], e.h[03], e.h[04], e.j[01], e.j[02], e.j[03], e.j[04], e.j[05],
                e.j[06], e.j[07], e.j[08], e.j[09], e.j[10], e.j[11], e.j[12], e.j[13], e.j[14],
                e.j[15], e.j[16], e.j[17], e.j[18], e.j[19], e.j[20], e.j[21], e.j[22], e.j[23],
                e.j[24], e.j[25], e.j[26], e.j[27], e.j[28], e.j[29], e.j[30], e.j[31], e.j[32],
                e.j[33], e.j[34], e.j[35], e.j[36], e.j[37], e.j[38], e.j[39], e.j[40], e.j[41],
                e.j[42], e.j[43], e.j[44], e.j[45], e.j[46], e.j[47], e.j[48], e.j[49], e.j[50],
                e.j[51], e.j[52], e.j[53], e.j[54], e.j[55], e.j[56], e.j[57], e.j[58], e.j[59],
                e.j[60], e.j[61], e.j[62], e.j[63], e.j[64], e.j[65], e.j[66], e.j[67], e.j[68],
                e.i[34], e.i[35], e.i[36], e.i[37], e.i[38], e.i[39], e.i[40], e.i[41], e.i[42],
                e.i[43], e.i[44], e.i[45], e.i[46], e.i[47], e.i[48], e.i[49], e.i[50], e.i[51],
                e.i[52], e.i[53], e.i[54], e.i[55], e.i[56], e.i[57], e.i[58], e.i[59], e.i[60],
                e.i[61], e.i[62], e.i[63], e.i[64], e.i[65], e.i[66],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:c02
        output = "unilib:misc_walkway_steel_steps_3",
        recipe = {
            {"", "", ""},
            {"", "unilib:misc_walkway_steel_steps_1", "unilib:misc_walkway_steel_support_15"},
            {"", "", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_steps_4", "factory_bridges:c03", mode, {
        -- From factory_bridges:c03
        description = unilib.utils.brackets(S("Steel Walkway Steps"), S("Dual handrails")),
        tiles = {steps_img, steps_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                e.b[01], e.b[02], e.h[01], e.h[02], e.h[03], e.h[04], e.j[01], e.j[02], e.j[03],
                e.j[04], e.j[05], e.j[06], e.j[07], e.j[08], e.j[09], e.j[10], e.j[11], e.j[12],
                e.j[13], e.j[14], e.j[15], e.j[16], e.j[17], e.j[18], e.j[19], e.j[20], e.j[21],
                e.j[22], e.j[23], e.j[24], e.j[25], e.j[26], e.j[27], e.j[28], e.j[29], e.j[30],
                e.j[31], e.j[32], e.j[33], e.j[34], e.j[35], e.j[36], e.j[37], e.j[38], e.j[39],
                e.j[40], e.j[41], e.j[42], e.j[43], e.j[44], e.j[45], e.j[46], e.j[47], e.j[48],
                e.j[49], e.j[50], e.j[51], e.j[52], e.j[53], e.j[54], e.j[55], e.j[56], e.j[57],
                e.j[58], e.j[59], e.j[60], e.j[61], e.j[62], e.j[63], e.j[64], e.j[65], e.j[66],
                e.j[67], e.j[68], e.i[01], e.i[02], e.i[03], e.i[04], e.i[05], e.i[06], e.i[07],
                e.i[08], e.i[09], e.i[10], e.i[11], e.i[12], e.i[13], e.i[14], e.i[15], e.i[16],
                e.i[17], e.i[18], e.i[19], e.i[20], e.i[21], e.i[22], e.i[23], e.i[24], e.i[25],
                e.i[26], e.i[27], e.i[28], e.i[29], e.i[30], e.i[31], e.i[32], e.i[33], e.i[34],
                e.i[35], e.i[36], e.i[37], e.i[38], e.i[39], e.i[40], e.i[41], e.i[42], e.i[43],
                e.i[44], e.i[45], e.i[46], e.i[47], e.i[48], e.i[49], e.i[50], e.i[51], e.i[52],
                e.i[53], e.i[54], e.i[55], e.i[56], e.i[57], e.i[58], e.i[59], e.i[60], e.i[61],
                e.i[62], e.i[63], e.i[64], e.i[65], e.i[66],
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From factory_bridges:c03
        output = "unilib:misc_walkway_steel_steps_4",
        recipe = {
            {"", "", ""},
            {
                "unilib:misc_walkway_steel_support_14",
                "unilib:misc_walkway_steel_steps_1",
                "unilib:misc_walkway_steel_support_15",
            },
            {"", "", ""},
        },
    })
    unilib.register_craft({
        -- From factory_bridges:c03
        output = "unilib:misc_walkway_steel_steps_4",
        recipe = {
            {"", "unilib:misc_walkway_steel_support_16", ""},
            {"", "unilib:misc_walkway_steel_steps_1", ""},
            {"", "", ""},
        },
    })

    -- Hatches

    unilib.register_node("unilib:misc_walkway_steel_hatch_closed", "factory_bridges:d00", mode, {
        -- From factory_bridges:d00
        description = unilib.utils.brackets(S("Steel Walkway Hatch"), S("Closed")),
        tiles = {hatch_img, hatch_img, support_img},
        groups = {cracky = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.c[01], e.g[01], e.g[02], e.d[01], e.d[02], e.d[03], e.d[04]},
        },
        paramtype = "light",
        paramtype2 = "facedir",

        on_rightclick = function(pos, node)

            core.set_node(
                pos, {name = "unilib:misc_walkway_steel_hatch_open", param2 = node.param2}
            )

        end,
    })
    unilib.register_craft({
        -- From factory_bridges:d00
        output = "unilib:misc_walkway_steel_hatch_closed",
        recipe = {
            {"", "unilib:misc_walkway_steel_item_beam", ""},
            {
                "unilib:misc_walkway_steel_item_beam",
                "unilib:misc_walkway_steel_platform_1",
                "unilib:misc_walkway_steel_item_beam",
            },
            {"", "unilib:misc_walkway_steel_item_beam", ""},
        },
    })

    unilib.register_node("unilib:misc_walkway_steel_hatch_open", "factory_bridges:d01", mode, {
        -- From factory_bridges:d01
        description = unilib.utils.brackets(S("Steel Walkway Hatch"), S("Open")),
        tiles = {hatch_img},
        groups = {cracky = 2, not_in_creative_inventory = 1},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        drop = "unilib:misc_walkway_steel_hatch_closed",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {e.c[02], e.g[01], e.g[02], e.d[01], e.d[02], e.d[03], e.d[04]},
        },
        paramtype = "light",
        paramtype2 = "facedir",

        on_rightclick = function(pos, node)

            core.set_node(
                pos, {name = "unilib:misc_walkway_steel_hatch_closed", param2 = node.param2}
            )

        end,
    })

    -- Construction (craft)items
    -- N.B. I had to guess the names of these items; the original code does not name them

    unilib.register_craftitem("unilib:misc_walkway_steel_item_pole", "factory_bridges:i00", mode, {
        -- From factory_bridges:i00
        description = unilib.utils.brackets(S("Steel Walkway Construction Item"), S("Pole")),
        inventory_image = "unilib_misc_walkway_steel_item_pole.png",
        stack_max = 200,
    })
    unilib.register_craft({
        -- From factory_bridges:i00
        output = "unilib:misc_walkway_steel_item_pole 200",
        recipe = {
            {"", "", "unilib:metal_steel_ingot"},
            {"", "", ""},
            {"unilib:metal_steel_ingot", "", ""},
        },
    })

    unilib.register_craftitem("unilib:misc_walkway_steel_item_block", "factory_bridges:i01", mode, {
        -- From factory_bridges:i01
        description = unilib.utils.brackets(S("Steel Walkway Construction Item"), S("Block")),
        inventory_image = "unilib_misc_walkway_steel_item_block.png",
        stack_max = 350,
    })
    unilib.register_craft({
        -- From factory_bridges:i01
        output = "unilib:misc_walkway_steel_item_block 350",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "default:stick"},
        },
    })

    unilib.register_craftitem("unilib:misc_walkway_steel_item_beam", "factory_bridges:i02", mode, {
        -- From factory_bridges:i02
        description = unilib.utils.brackets(S("Steel Walkway Construction Item"), S("Beam")),
        inventory_image = "unilib_misc_walkway_steel_item_beam.png",
    })
    unilib.register_craft({
        -- From factory_bridges:i02
        output = "unilib:misc_walkway_steel_item_beam",
        recipe = {
            {
                "unilib:misc_walkway_steel_item_block",
                "unilib:misc_walkway_steel_item_block",
                "unilib:misc_walkway_steel_item_block",
            },
        },
    })

end
