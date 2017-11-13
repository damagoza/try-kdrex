module UserHelper
	def administrator(id)
		resultado = false
		user_role = UserRole.where(:user_id => id, :role_id => 1)
		if user_role.count > 0
			resultado = true
		end
		return resultado
	end
end
