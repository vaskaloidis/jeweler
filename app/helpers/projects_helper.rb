module ProjectsHelper

  def language_select
    languages.map.with_index { |category, index| [prettyify_language(category), index] }
  end

  def prettyify_language(category)
    pretty = {}
    pretty['java ee'] = 'Java EE'
    pretty['javafx'] = 'Java FX'
    pretty['jquery'] = 'JQuery'
    pretty['mips'] = 'MIPS'
    pretty['c++'] = 'C++'
    pretty['opengl'] = 'OpenGL'
    pretty['sml'] = 'SML'
    pretty['mongo db'] = 'Mongo DB'
    pretty['yacc'] = 'YACC'
    pretty['php'] = 'PHP'
    pretty['mysql'] = 'MySQL'
    pretty['node js'] = 'Node JS'
    pretty['rails'] = 'Ruby on Rails'
    pretty['mac osx'] = 'Mac OSX'
    pretty['sass'] = 'SASS'
    pretty['css'] = 'CSS'
    pretty['phpstorm'] = 'PhpStorm'
    return pretty.fetch(category) if pretty.has_key?(category)
    return category.titleize unless category.nil?
    category
  end

  def languages
    cat = []
    cat << 'go'
    cat << 'docker'
    cat << 'css'
    cat << 'apache'
    cat << 'html'
    cat << 'bootstrap'
    cat << 'java ee'
    cat << 'javafx'
    cat << 'java'
    cat << 'jquery'
    cat << 'mips'
    cat << 'c++'
    cat << 'laravel'
    cat << 'linux'
    cat << 'opengl'
    cat << 'sml'
    cat << 'javascript'
    cat << 'mongo db'
    cat << 'c'
    cat << 'yacc'
    cat << 'php'
    cat << 'mysql'
    cat << 'node js'
    cat << 'photoshop'
    cat << 'rails'
    cat << 'postgres'
    cat << 'ruby'
    cat << 'redis'
    cat << 'mac osx'
    cat << 'sass'
    cat << 'ubuntu'
    cat << 'bower'
    cat << 'wordpress'
    cat << 'css'
    cat << 'python'
    cat << 'gulp'
    cat << 'grunt'
    cat << 'react'
    cat << 'swift'
    cat << 'wordpress'
    cat << 'tomcat'
    cat.sort!
  end

  def devicon_class(category)
    case category
    when 'heroku' then 'devicon-heroku-plain-wordmark colored'
    when 'go' then 'devicon-go-line colored'
    when 'github' then 'devicon-github-plain-wordmark colored'
    when 'docker' then 'devicon-docker-plain-wordmark colored'
    when 'css' then 'devicon-css3-plain colored'
    when 'apache' then 'devicon-apache-plain-wordmark colored'
    when 'html' then 'devicon-html5-plain-wordmark colored'
    when 'bootstrap' then 'devicon-bootstrap-plain-wordmark colored'
    when 'java', 'javafx', 'java ee' then 'devicon-java-plain-wordmark colored'
    when 'jquery' then 'devicon-jquery-plain-wordmark colored'
    when 'c++', 'mips' then 'devicon-cplusplus-plain colored'
    when 'laravel' then 'devicon-laravel-plain-wordmark colored'
    when 'linux' then 'devicon-linux-plain colored'
    when 'javascript', 'sml', 'opengl' then  'devicon-javascript-plain colored'
    when 'mongo db' then 'devicon-mongodb-plain-wordmark colored'
    when 'c' then 'devicon-c-line-wordmark colored'
    when 'php', 'yacc' then 'devicon-php-plain colored'
    when 'mysql' then 'devicon-mysql-plain-wordmark colored'
    when 'node js' then 'devicon-nodejs-plain colored'
    when 'photoshop' then 'devicon-photoshop-line colored'
    when 'rails' then 'devicon-rails-plain-wordmark colored'
    when 'postgres' then 'devicon-postgresql-plain-wordmark colored'
    when 'ruby' then 'devicon-ruby-plain-wordmark colored'
    when 'mac osx' then 'devicon-apple-original colored'
    when 'sass' then 'devicon-sass-original colored'
    when 'ubuntu' then 'devicon-ubuntu-plain-wordmark colored'
    when 'bower' then 'devicon-bower-plain-wordmark colored'
    when 'hosted' then 'devicon-docker-plain-wordmark colored'
    when 'python' then 'devicon-python-plain-wordmark colored'
    when 'gulp' then 'devicon-gulp-plain colored'
    when 'grunt' then 'devicon-grunt-line-wordmark colored'
    when 'phpstorm' then 'devicon-phpstorm-plain-wordmark colored'
    when 'react' then 'devicon-react-original-wordmark colored'
    when 'swift' then 'devicon-swift-plain-wordmark colored'
    when 'wordpress' then 'devicon-wordpress-plain-wordmark colored'
    when 'tomcat' then 'devicon-tomcat-line-wordmark colored'
    when 'redis' then 'devicon-redis-plain-wordmark colored'
    when 'travis' then 'devicon-travis-plain-wordmark colored'
    else ''
    end
  end

  def language_icon(language)
    return '' if language.nil?
    language = languages.at(language) if language.number?
    '<i class="devicon ' + devicon_class(language) + '"></i>'
  end

end
