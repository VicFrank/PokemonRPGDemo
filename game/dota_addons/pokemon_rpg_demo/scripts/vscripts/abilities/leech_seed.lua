--PP 10
--Power --
--Accuracy 90%
--Type GRASS
--Category Status
function LeechStart( keys )
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local pokemon = target.pokemon
	
	--leech seed should persist even if you swap out the caster
	--but for now, we'll just keep it for the original pokemon
	if caster.trainer ~= nil then
		
	end
end

function Leech( keys )
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local pokemon = target.pokemon
	local casterPokemon = caster.pokemon
	
	if not caster:IsAlive() then
		target:RemoveModifierByName("modifier_leech_seed")
		return
	end
	
	if pokemon ~= nil then
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed.vpcf", PATTACH_CUSTOMORIGIN, caster)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
		EmitSoundOn("Hero_Treant.LeechSeed.Tick", target)
		
		local damage = pokemon:GetMaxHP()/8
		local heal = damage
		
		if damage > pokemon:GetCurrentHP() then
			heal = pokemon:GetCurrentHP()
		end
		
		PokeHelper:DealDamage( target, damage, caster )
		
		PokeHelper:AddKillCredit(target, casterPokemon)
		
		--don't revive dead pokemon
		if casterPokemon:GetCurrentHP() > 0 then
			casterPokemon:SetCurrentHP(casterPokemon:GetCurrentHP() + heal)
			caster:Heal(heal,caster)
			print("leech seed heal")
			print(caster:GetPlayerOwner())
			CustomGameEventManager:Send_ServerToPlayer(caster:GetPlayerOwner(), "update_health", healthData )
		end
	end
end