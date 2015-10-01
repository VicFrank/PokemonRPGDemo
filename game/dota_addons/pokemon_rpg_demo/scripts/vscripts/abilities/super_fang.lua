--PP 10
--Power varies
--Accuracy 90%
--Type NORMAL
--Category Physical (physical)
--does damage equal to 50% of the target's current HP
function SuperFang( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil and pokemon:GetType1() ~= "GHOST" and pokemon:GetType2() ~= "GHOST" then
		local damage = pokemon:GetCurrentHP() / 2
		--damage code ripped from pokehelper, consider making CalculatePokemonDamage more versatile
		if target.attackers == nil then
			target.attackers = {}
			target.numAttackers = 0
		end
		
		if target.attackers[caster.pokemon] == nil then
			target.numAttackers = target.numAttackers + 1
		end
		target.attackers[caster.pokemon] = true

		local damage_table = {}

		damage_table.attacker = caster
		damage_table.damage_type = DAMAGE_TYPE_PURE
		damage_table.ability = ability
		damage_table.victim = target
		damage_table.damage = damage

		pokemon:SetCurrentHP(pokemon:GetCurrentHP() - damage)
		ApplyDamage(damage_table)
	end
end