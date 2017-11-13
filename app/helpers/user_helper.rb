module UserHelper
	def administrator(id)
		resultado = false
		user_role = UserRole.where(:user_id => id, :role_id => 1)
		if user_role.count > 0
			resultado = true
		end
		return resultado
	end

	def rol_user(user_id)
		cadena = ""
		ur = UserRole.where(:user_id => user_id).first
		if ur != nil
			cadena = ur.role.name
		end
		return cadena
	end
end
