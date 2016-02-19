function Burn( keys )
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon
	local caster = keys.caster

	if pokemon ~= nil then
		--deal 1/8 of Pokemon's max HP as damage
		local damage = pokemon:GetMaxHP()/8
		PokeHelper:DealDamage(target, damage, caster)
	end
end

function Paralyze( keys )
	local target = keys.target
	local ability = keys.ability
	local caster = keys.caster
	
	--25% chance to lose turn to paralysis
	--stunned
	if RandomFloat(0,1) < .25 then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_paralyzed", {})
	end
end

function Freeze( keys )
	local target = keys.target
	local ability = keys.ability

	--20% chance of thawing out
	if RandomFloat(0,1) < .2 then
		target:RemoveModifierByName("modifier_frozen")
	end
end

function Sleep( keys )
	local target = keys.target
	local ability = keys.ability
	
	--sleep lasts 1-3 rounds
	if target.sleepCounter == nil then
		target.sleepCounter = 0
		target.SleepTime = RandomInt(1,3)
	end
	
	target.sleepCounter = target.sleepCounter + 1

	if sleepCounter == sleepTime then
		target:RemoveModifierByName("modifier_sleep")
		target.sleepCounter = nil
	end
end

function Poison( keys )
	local target = keys.target
	local pokemon = target.pokemon
	local caster = keys.caster

	if pokemon ~= nil then
		--deal 1/8 of pokemon's max HP
		local damage = pokemon:GetMaxHP()/8
		PokeHelper:DealDamage(target, damage, caster)
	end
end

function Confusion( keys )
	local target = keys.target
	local pokemon = target.pokemon

	--40% chance of losing confusion
	if RandomFloat(0,1) < .2 then
		target:RemoveModifierByName("modifier_confusion")
	end
end