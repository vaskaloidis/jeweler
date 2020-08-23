class GitHubRepo < GitHubUser
	attr_reader :project, :user

	def initialize(project)
		@project = project
		@user    = @project.owner
		super(@user)
	end

	def configured?
		@configured ||= project_configured? && user_configured?
	end

	def project_configured?
		@project_configured ||= !project.github_repo_id.nil?
	end

	def name
		@name ||= repository.name
	end

	def url
		@url ||= begin
			return false unless configured?
			"https://github.com/#{username}/#{name}"
		end
	end

	def webhook
		@webhook ||= GitHubWebhook.new(self)
	end

	def uninstall!
		webhook.uninstall! if webhook.installed?
		project.update!(github_repo_id: nil) if project_configured?
	end

	protected

	def id
		@id ||= project.github_repo_id
	end

	def repository
		@repository ||= api.repository(id)
	end

end
