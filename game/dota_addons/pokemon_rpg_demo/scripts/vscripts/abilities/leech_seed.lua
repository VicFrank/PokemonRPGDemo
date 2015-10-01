--PP 10
--Power --
--Accuracy 90%
--Type GRASS
--Category Status
--For the moment, ends when the current pokemon is withdrawn
--this ability is in need of a revisit/rework
--change it into a modifier, and allow it to work for every pokemon the party
function LeechSeed( keys )
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local targetPokemon = target.pokemon
	local casterPokemon = caster.pokemon
	local tickInterval = 3
	
	if targetPokemon ~= nil then
		--don't apply this modifier on the same unit twice
		if target.isLeeched ~= nil and target.isLeeched ~= true then
			print("Target already affected by leech seed")
			return
		end
		target.isLeeched = true
		--1/8 of the target's max hp is drained every tick
		local damage = targetPokemon:GetMaxHP()/8
		local heal = damage
		if damage > targetPokemon:GetCurrentHP() then
			heal = targetPokemon:GetCurrentHP()
		end
		Timers:CreateTimer(0,
			function()
				if caster:IsAlive() and target.isLeeched then
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed.vpcf", PATTACH_CUSTOMORIGIN, caster)
					ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
					ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
					ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
					--damage code ripped from pokehelper, consider making CalculatePokemonDamage more versatile
					if target.attackers == nil then
						target.attackers = {}
						target.numAttackers = 0
					end
					
					if target.attackers[casterPokemon] == nil then
						target.numAttackers = target.numAttackers + 1
					end
					target.attackers[casterPokemon] = true

					local damage_table = {}

					damage_table.attacker = caster
					damage_table.damage_type = DAMAGE_TYPE_PURE
					damage_table.ability = ability
					damage_table.victim = target
					damage_table.damage = damage

					targetPokemon:SetCurrentHP(targetPokemon:GetCurrentHP() - damage)
					ApplyDamage(damage_table)
					--now heal the pokemon this is currently out
					casterPokemon:SetCurrentHP(casterPokemon:GetCurrentHP() + heal)
					caster:Heal(heal,caster)
					return tickInterval
				else
					print("Ending leech seed")
					return
				end
			end)
	end
end