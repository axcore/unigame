---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
register_all("cobalt", {
	pick = {{cracky = {times={[1]=1.5, [2]=0.85, [3]=0.40}, uses=60, maxlevel=3}, weryhard = {times={[3]=3.00}, uses=60, maxlevel=3}}, 8},
	shovel = {{crumbly = {times={[1]=0.90, [2]=0.40, [3]=0.20}, uses=60, maxlevel=3}}, 7},
	axe = {{
			choppy={times={[1]=1.80, [2]=0.70, [3]=0.30}, uses=60, maxlevel=3},
			snappy={times={[1]=1.50, [2]=0.70, [3]=0.20}, uses=50, maxlevel=3},
	}, 9},
	sword = {{snappy={times={[1]=1.50, [2]=0.70, [3]=0.20}, uses=70, maxlevel=3}}, 10},
	spear = {{snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=23, maxlevel=3}}, 10},
	ore = {20, -1000, {cracky=1}},
})
]]--
