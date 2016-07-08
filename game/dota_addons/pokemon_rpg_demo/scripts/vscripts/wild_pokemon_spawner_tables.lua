local tROUTE_1 = {
	{name = "pidgey", cSumSpawnRate = 55, minLevel = 2, maxLevel = 5},
	{name = "rattata", cSumSpawnRate = 100, minLevel = 2, maxLevel = 4}
}

local tROUTE_22 = {
	{name = "rattata", cSumSpawnRate = 50, minLevel = 2, maxLevel = 4},
	{name = "spearow", cSumSpawnRate = 60, minLevel = 3, maxLevel = 4},
	{name = "nidoran_male", cSumSpawnRate = 80, minLevel = 2, maxLevel = 4},
	{name = "nidoran_female", cSumSpawnRate = 100, minLevel = 2, maxLevel = 4}
}

local tROUTE_2 = {
	{name = "pidgey", cSumSpawnRate = 10, minLevel = 3, maxLevel = 3},
	{name = "pidgey", cSumSpawnRate = 20, minLevel = 5, maxLevel = 5},
	{name = "pidgey", cSumSpawnRate = 30, minLevel = 7, maxLevel = 7},
	{name = "rattata", cSumSpawnRate = 70, minLevel = 3, maxLevel = 4},
	{name = "nidoran_male", cSumSpawnRate = 85, minLevel = 4, maxLevel = 6},
	{name = "nidoran_female", cSumSpawnRate = 100, minLevel = 4, maxLevel = 6}
}

local tVIRIDIAN_FOREST = {
	{name = "caterpie", cSumSpawnRate = 25, minLevel = 3, maxLevel = 6},
	{name = "metapod", cSumSpawnRate = 45, minLevel = 4, maxLevel = 6},
	{name = "weedle", cSumSpawnRate = 70, minLevel = 3, maxLevel = 6},
	{name = "kakuna", cSumSpawnRate = 90, minLevel = 4, maxLevel = 6},
	{name = "pikachu", cSumSpawnRate = 95, minLevel = 3, maxLevel = 5},
	{name = "pidgey", cSumSpawnRate = 99, minLevel = 4, maxLevel = 8},
	{name = "pidgeotto", cSumSpawnRate = 100, minLevel = 4, maxLevel = 8}
}

local tROUTE_3 = {
	{name = "pidgey", cSumSpawnRate = 50, minLevel = 7, maxLevel = 9},
	{name = "spearow", cSumSpawnRate = 90, minLevel = 6, maxLevel = 11},
	{name = "jigglypuff", cSumSpawnRate = 100, minLevel = 5, maxLevel = 7}
}

local tMT_MOON1 = {
	{name = "clefairy", cSumSpawnRate = 1, minLevel = 11, maxLevel = 11},
	{name = "zubat", cSumSpawnRate = 80, minLevel = 6, maxLevel = 11},
	{name = "paras", cSumSpawnRate = 85, minLevel = 8, maxLevel = 8},
	{name = "geodude", cSumSpawnRate = 100, minLevel = 8, maxLevel = 10}
}

local tMT_MOON2 = {
	{name = "clefairy", cSumSpawnRate = 6, minLevel = 10, maxLevel = 12},
	{name = "zubat", cSumSpawnRate = 60, minLevel = 10, maxLevel = 13},
	{name = "paras", cSumSpawnRate = 75, minLevel = 13, maxLevel = 13},
	{name = "geodude", cSumSpawnRate = 100, minLevel = 8, maxLevel = 10}
}

local tROUTE_4 = {
	{name = "rattat", cSumSpawnRate = 45, minLevel = 8, maxLevel = 12},
	{name = "spearow", cSumSpawnRate = 85, minLevel = 8, maxLevel = 12},
	{name = "sandshrew", cSumSpawnRate = 100, minLevel = 8, maxLevel = 10}
}

--------------------------------------------------------------------------------
-- All roamer lists
--------------------------------------------------------------------------------
local tROAM_UNITS_ALL = {
	route_1 = tROUTE_1,
	route_2 = tROUTE_2,
	route_3 = tROUTE_3,
	route_4 = tROUTE_4,
	route_22 = tROUTE_22,
	viridian_forest = tVIRIDIAN_FOREST,
	mt_moon1 = tMT_MOON1,
	mt_moon2 = tMT_MOON2
}

return tROAM_UNITS_ALL
