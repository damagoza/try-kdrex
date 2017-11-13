class UserMailer < ApplicationMailer
	default from: "wolfsupremeshop@gmail.com"
	 
	def notification_task(project, user)
		@user = user
		@project = project
		mail(to: @user.email, subject: 'Te asignaron una tarea al proyecto #{@project.name}')
	end	
end	

