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

--------------------------------------------------------------------------------
-- All roamer lists
--------------------------------------------------------------------------------
local tROAM_UNITS_ALL = {
	route_1 = tROUTE_1,
	route_2 = tROUTE_2,
	route_22 = tROUTE_22,
	viridian_forest = tVIRIDIAN_FOREST
}

return tROAM_UNITS_ALL
