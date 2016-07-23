function Burn( keys )
	local target = keys.target
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
	print("paralyze")
	if RandomFloat(0,1) < .25 then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_paralyzed", {})
	end
end

function Freeze( keys )
	local target = keys.target
	local pokemon = target.pokemon

	--20% chance of thawing out
	if RandomFloat(0,1) < .2 then
		target:RemoveModifierByName("modifier_frozen")
		pokemon:ClearStatus()
	end
end

function Sleep( keys )
	local target = keys.target
	local pokemon = target.pokemon
	
	--sleep lasts 1-3 rounds
	if target.sleepCounter == nil or target.sleepCounter < 0 then
		target.sleepCounter = RandomInt(1,3)
	end
	
	target.sleepCounter = target.sleepCounter - 1

	if target.sleepCounter < 0 then
		target:RemoveModifierByName("modifier_sleep")
		pokemon:ClearStatus()
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

function ConfusionStart( keys )
	local target = keys.target

	target.confusionCounter = RandomInt(1,4)
end

function DisplayAbilityName( keys )
	local caster = keys.caster
	local ability = caster:GetCurrentActiveAbility()

	if (ability ~= nil) then
		caster:AddSpeechBubble(1, ability:GetAbilityName(), 1, 0, 0)
	end
end