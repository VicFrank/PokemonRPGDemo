--PP 40
--Power 20
--Accuracy 100%
--Type NORMAL
--Category Physical
--[[
	Removes the following effects:
	Bind, Clamp, Fire Spin, Infestation, Leech Seed, Magma Storm, Sand Tomb, Spikes, Stealth Rock, Sticky Web, Toxic Spikes, Whirlpool, Wrap
]]
function RapidSpinStart( keys )
	--remove the relevant debuffs
	local caster = keys.caster
	caster.isLeeched = false
	
	caster.rapid_spin_table = {}
end

function RapidSpinEnd( keys )
	local caster = keys.caster
	caster:StopSound("Hero_Juggernaut.BladeFuryStart")
end

function RapidSpin( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon
	
	local check = false
	-- Check if its a target from before
	for _,v in ipairs(caster.rapid_spin_table) do
		if v == target then
			check = true
		end
	end

	if not check then
		if pokemon ~= nil then
			table.insert(caster.rapid_spin_table, target)
			PokeHelper:CalculatePokemonDamage(ability, caster, target, "NORMAL")
		end
	end
end