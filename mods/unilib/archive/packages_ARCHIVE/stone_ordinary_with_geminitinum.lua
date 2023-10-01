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
register_all("geminitinum", {
	lump = "Geminitinum Crystal",
	cooktime = 200,
	ore_tiles = {{name="xtraores_mineral_geminitinum.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}},
	brick_tiles = {{name="xtraores_geminitinum_brick.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}}},
	block_tiles = {{name="xtraores_geminitinum_block.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}}},
	compressed_block = false,
	chiseled_block = false,
	dust = false,
	drill = {{cracky = {times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=1000, maxlevel=3}, weryhard = {times={[3]=0.01, [2]=0.01, [1]=0.01, [0]=0.01}, uses=1000, maxlevel=3}, crumbly = {times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=1000, maxlevel=3}}, 20},
	chainsaw = {{
		choppy={times={[1]=0.001, [2]=0.001, [3]=0.001}, uses=1000, maxlevel=3},
		snappy={times={[1]=0.01, [2]=0.03, [3]=0.002}, uses=750, maxlevel=3},
	}, 20},
	sword = {{snappy={times={[1]=0.01, [2]=0.03, [3]=0.002}, uses=1000, maxlevel=3}}, 20},
	spear = {{snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=23, maxlevel=3}}, 50},
	ore = {35, -32000, {weryhard=0}},
})
]]--
