module ProjectsHelper
	def have_task(project_id)
		resultado = false
		tasks = Task.where(:project_id => project_id)
		if tasks.count > 0
			resultado = true
		end
		return( resultado)
	end
end
