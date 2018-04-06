module ApplicationHelper


  def self.build_languages_dropdown
    cat = self.categories
    string = "<select class='form-control' name='project[language]' id='project_language' >"
    cat.each do |c|
      string = string + "<option value='" + c + "'>" + c.capitalize + "</option>"
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
      return '<i class="devicon ' + devicon + '"></i>'
    else
      return ''
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
    cat.push("redis")
    cat.push("travis")
    return cat
  end

end
