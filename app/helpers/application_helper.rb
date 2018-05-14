module ApplicationHelper

  def self.money(input)
    require 'action_view'

    input = ActionView::Base.new.number_to_currency(input)
    input = self.prettify(input)
    return input.to_s
  end

  def self.alphabet
    return ("a".."z").to_a
  end

  def self.name_pretty(pretty_name)
    pretty_name.gsub! '_', ' '
    pretty_name.capitalize!
    return pretty_name
  end

  def self.uglify(ugly_name)
    ugly_name.gsub! ' ', '_'
    ugly_name.downcase
    return ugly_name
  end

  def self.note_event_action(note)
    case note.note_type
    when 'commit'
      'Committed Code'
    when 'event'
      case note.event_type
      when 'task_created'
        return 'Created a Task'
      when 'task_updated'
        return 'Updated a Task'
      when 'task_deleted'
        return 'Deleted a Task'
      when 'sprint_opened'
        return 'Opened a Sprint'
      when 'sprint_closed'
        return 'Closed a Sprint'
      when 'hours_reported'
        return 'Reported Hours'
      when 'task_completed'
        return 'Completed a Task'
      when 'sprint_completed'
        return 'Completed a Sprint'
      when 'payment_request_cancelled'
        return 'Cancelled a Payment Request'
      when 'current_task_changed'
        return 'Changed Current Task'
      when 'current_sprint_changed'
        return 'Changed the Current Sprint'
      else
        return ''
      end
    when 'project_update'
      return 'Posted a Project Update'
    when 'payment_request'
      return 'Requested a Payment'
    when 'payment'
      'Made a Payment'
    when 'note'
      return 'Posted a Note'
    when 'demo'
      return 'Posted a Demo of ' + note.content
    else
      return ''
    end
  end

  def self.note_icon_header_section(note_type)
    case note_type
    when 'project_update'
      return '<div class="cbp_tmicon timeline-bg-warning">
                  <i class="far fa-clock"></i>
                </div>'
    when 'event'
      return '<div class="cbp_tmicon timeline-bg-info">
              <i class="far fa-clock"></i>
            </div>'
    when 'note'
      return '<div class="cbp_tmicon timeline-bg-success">
                  <i class="fas fa-sticky-note"></i>
                </div>'
    when 'demo'
      return '<div class="cbp_tmicon timeline-bg-red">
                  <i class="fa-binoculars"></i>
                </div>'
    when 'payment'
      return ' <div class="cbp_tmicon timeline-bg-success">
                  <i class="fas fa-dollar-sign"></i>
                </div>'
    when 'payment_request'
      return '<div class="cbp_tmicon timeline-bg-success">
                  <i style="color:white !important" class="fas fa-hand-holding-usd white-icon"></i>
                </div>'
    when 'commit'
      return '<div class="cbp_tmicon timeline-bg-danger">
                  <i class="fas fa-code-branch"></i>
                </div>'
    else
      return '<div class="cbp_tmicon timeline-bg-success">
                  <i class="fas fa-sticky-note"></i>
                </div>'
    end
  end

  def self.note_icon_color(note_type)
    case note_type
    when 'project_update'
      return 'warning'
    when 'event'
      return 'info'
    when 'note'
      return 'success'
    when 'demo'
      return 'danger'
    when 'payment'
      return 'success'
    when 'payment_request'
      return 'success'
    when 'commit'
      return 'danger'
    else
      return 'success'
    end
  end

  def self.note_icon(note_type)
    case note_type
    when 'project_update'
      return '<i class="far fa-clock"></i>'
    when 'event'
      return '<i class="far fa-clock"></i>'
    when 'note'
      return '<i class="fas fa-sticky-note"></i>'
    when 'demo'
      return '<i class="fa-binoculars"></i>'
    when 'payment'
      return '<i class="fas fa-dollar-sign"></i>'
    when 'payment_request'
      return '<i style="color:white !important" class="fas fa-hand-holding-usd white-icon"></i>'
    when 'commit'
      return '<i class="fas fa-code-branch"></i>'
    else
      return '<i class="fas fa-sticky-note"></i>'
    end

  end

  def self.sprint_percent(project)
    total_tasks = project.current_sprint.tasks.count
    completed_tasks = project.current_sprint.completed_tasks.count
    if total_tasks > 0
      tasks_diff = completed_tasks.to_f / total_tasks.to_f
    else
      tasks_diff = 0
    end
    progress_total = (project.sprint_current - 1.0) + tasks_diff.to_f
    progress_percent = (progress_total.to_f / project.sprint_total.to_f) * 100.to_f
    return progress_percent
  end

  def self.alphabet
    return ("a".."zz").to_a
  end

  def self.display_project_nav?(controller_name, action_name)

    if (controller_name == 'projects' and action_name != 'index' and action_name != 'new') or
        (controller_name == 'invoices') or
        (controller_name == 'project_customers') or
        (controller_name == 'payments' and action_name == 'index')
      return true
    else
      return false
    end

  end

  def self.github_object(project)
    github = Github.new oauth: project.owner.oauth
    # logger.debug('GitHub User: ' + ApplicationHelper.github_user(project))
    # logger.debug('GitHub Repo: ' + ApplicationHelper.github_repo(project))
    return github
  end

  def self.github_hook_configured?(project)
    begin
      gh = self.github_object(project)
      hooks = gh.repos.hooks.all ApplicationHelper.github_user(project), ApplicationHelper.github_repo(project)

    rescue
      # logger.error("ERROR - Getting Github Repo Hooks")
      # return false
      return true # TODO: Finish this feature
    end

    if hooks.empty?
      return false
    else
      return true
    end
  end


  def self.github_user(project)
    uri = URI(project.github_url)
    return uri.path.split('/').second
  end

  def self.github_repo(project)
    uri = URI(project.github_url)
    return uri.path.split('/').third
  end

  def self.is_number?(number)
    if Float(number)
      return true
    elsif BigDecimal(number)
      return true
    elsif Integer(number)
      return true
    else
      return false
    end

  rescue
    return false

  end

  def self.prettify(number)
    # to_i == number ? to_i : number

    if number == number.to_i
      return number.to_i
    else
      return number
    end

  end

  # Devicon Icons & Form Helper
  #
  # TODO: Move these to another helper, and
  #       figure out why it was not working
  #       in another helper last time

  def self.build_languages_dropdown(selected)
    cat = self.dropdown_categories
    string = "<select class='form-control' name='project[language]' id='project_language' >"
    cat.each do |c|
      if c == selected
        string = string + "<option selected value='" + c + "'>" + self.category_pretty(c) + "</option>"
      else
        string = string + "<option value='" + c + "'>" + self.category_pretty(c) + "</option>"
      end
    end
    string = string + "</select>"
    return string
  end

  def self.build_language_icon(category)
    devicon = ''
    case category.downcase
    when "heroku"
      devicon = 'devicon-heroku-plain-wordmark colored'
    when "go"
      devicon = 'devicon-go-line colored'
    when "github"
      devicon = 'devicon-github-plain-wordmark colored'
    when "docker"
      devicon = 'devicon-docker-plain-wordmark colored'
    when "css"
      devicon = 'devicon-css3-plain colored'
    when "apache"
      devicon = 'devicon-apache-plain-wordmark colored'
    when "html"
      devicon = 'devicon-html5-plain-wordmark colored'
    when "bootstrap"
      devicon = 'devicon-bootstrap-plain-wordmark colored'
    when "java ee"
    when "javafx"
    when "java"
      devicon = 'devicon-java-plain-wordmark colored'
    when "jquery"
      devicon = 'devicon-jquery-plain-wordmark colored'
    when "mips"
    when "c++"
      devicon = 'devicon-cplusplus-plain colored'
    when "laravel"
      devicon = 'devicon-laravel-plain-wordmark colored'
    when "linux"
      devicon = 'devicon-linux-plain colored'
    when "opengl"
    when "sml"
    when "javascript"
      devicon = 'devicon-javascript-plain colored'
    when "mongo db"
      devicon = 'devicon-mongodb-plain-wordmark colored'
    when "c"
      devicon = 'devicon-c-line-wordmark colored'
    when "yacc"
    when "circuit"
    when "php"
      devicon = 'devicon-php-plain colored'
    when "mysql"
      devicon = 'devicon-mysql-plain-wordmark colored'
    when "node js"
      devicon = 'devicon-nodejs-plain colored'
    when "photoshop"
      devicon = 'devicon-photoshop-line colored'
    when "rails"
      devicon = 'devicon-rails-plain-wordmark colored'
    when "postgres"
      devicon = 'devicon-postgresql-plain-wordmark colored'
    when "ruby"
      devicon = 'devicon-ruby-plain-wordmark colored'
    when "redis"
      devicon = 'devicon-redis-plain-wordmark colored'
    when "mac osx"
      devicon = 'devicon-apple-original colored'
    when "sass"
      devicon = 'devicon-sass-original colored'
    when "ubuntu"
      devicon = 'devicon-ubuntu-plain-wordmark colored'
    when "bower"
      devicon = 'devicon-bower-plain-wordmark colored'
    when "wordpress"
      devicon = 'devicon-Bluehelmet-plain-wordmark colored'
    when "css"
      # devicon = 'devicon-css3-plain-wordmark colored'
    when "hosted"
      devicon = 'devicon-docker-plain-wordmark colored'
    when "python"
      devicon = 'devicon-python-plain-wordmark colored'
    when "maven"
    when "maven mojo"
    when "composer"
    when "mips"
    when "gulp"
      devicon = 'devicon-gulp-plain colored'
    when "grunt"
      devicon = 'devicon-grunt-line-wordmark colored'
    when "phpstorm"
      devicon = 'devicon-phpstorm-plain-wordmark colored'
    when "react"
      devicon = 'devicon-react-original-wordmark colored'
    when "swift"
      devicon = 'devicon-swift-plain-wordmark colored'
    when "wordpress"
      devicon = 'devicon-wordpress-plain-wordmark colored'
    when "tomcat"
      devicon = 'devicon-tomcat-line-wordmark colored'
    when "redis"
      devicon = 'devicon-redis-plain-wordmark colored'
    when "travis"
      devicon = 'devicon-travis-plain-wordmark colored'
    end

    if !devicon.empty?
      return '<i class="devicon ' + devicon + '"></i>'.html_safe
    else
      return ''
    end
  end

  def self.category_pretty(category)
    pretty = Hash.new
    pretty["java ee"] = "Java EE"
    pretty["javafx"] = "Java FX"
    pretty["jquery"] = "JQuery"
    pretty["mips"] = "MIPS"
    pretty["c++"] = "C++"
    pretty["opengl"] = "OpenGL"
    pretty["sml"] = "SML"
    pretty["mongo db"] = "Mongo DB"
    pretty["yacc"] = "YACC"
    pretty["php"] = "PHP"
    pretty["mysql"] = "MySQL"
    pretty["node js"] = "Node JS"
    pretty["rails"] = "Ruby on Rails"
    pretty["mac osx"] = "Mac OSX"
    pretty["sass"] = "SASS"
    pretty["css"] = "CSS"
    pretty["maven mojo"] = "Maven MOJO"
    pretty["phpstorm"] = "PhpStorm"

    if pretty.has_key?(category)
      return pretty.fetch(category)
    else
      return category.capitalize
    end

  end

  def self.dropdown_categories
    cat = Array.new
    cat.push("go")
    cat.push("docker")
    cat.push("css")
    cat.push("apache")
    cat.push("html")
    cat.push("bootstrap")
    cat.push("java ee")
    cat.push("javafx")
    cat.push("java")
    cat.push("jquery")
    cat.push("mips")
    cat.push("c++")
    cat.push("laravel")
    cat.push("linux")
    cat.push("opengl")
    cat.push("sml")
    cat.push("javascript")
    cat.push("mongo db")
    cat.push("c")
    cat.push("yacc")
    cat.push("circuit")
    cat.push("php")
    cat.push("mysql")
    cat.push("node js")
    cat.push("photoshop")
    cat.push("rails")
    cat.push("postgres")
    cat.push("ruby")
    cat.push("redis")
    cat.push("mac osx")
    cat.push("sass")
    cat.push("ubuntu")
    cat.push("bower")
    cat.push("wordpress")
    cat.push("css")
    cat.push("python")
    cat.push("maven")
    cat.push("maven mojo")
    cat.push("composer")
    cat.push("mips")
    cat.push("gulp")
    cat.push("grunt")
    cat.push("phpstorm")
    cat.push("react")
    cat.push("swift")
    cat.push("wordpress")
    cat.push("tomcat")
    cat.push("travis")
    return cat
  end

  def self.categories
    cat = Array.new
    cat.push("heroku")
    cat.push("go")
    cat.push("github")
    cat.push("docker")
    cat.push("css")
    cat.push("apache")
    cat.push("html")
    cat.push("bootstrap")
    cat.push("java ee")
    cat.push("javafx")
    cat.push("java")
    cat.push("jquery")
    cat.push("mips")
    cat.push("c++")
    cat.push("laravel")
    cat.push("linux")
    cat.push("opengl")
    cat.push("sml")
    cat.push("javascript")
    cat.push("mongo db")
    cat.push("c")
    cat.push("yacc")
    cat.push("circuit")
    cat.push("php")
    cat.push("mysql")
    cat.push("node js")
    cat.push("photoshop")
    cat.push("rails")
    cat.push("postgres")
    cat.push("ruby")
    cat.push("redis")
    cat.push("mac osx")
    cat.push("sass")
    cat.push("ubuntu")
    cat.push("bower")
    cat.push("wordpress")
    cat.push("css")
    cat.push("hosted")
    cat.push("python")
    cat.push("maven")
    cat.push("maven mojo")
    cat.push("composer")
    cat.push("mips")
    cat.push("gulp")
    cat.push("grunt")
    cat.push("phpstorm")
    cat.push("react")
    cat.push("swift")
    cat.push("wordpress")
    cat.push("tomcat")
    cat.push("travis")
    return cat
  end

end
