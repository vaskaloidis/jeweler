# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.5'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
# Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Rails.configure do
#   config.less.paths << "#{Rails.root}/lib/less/protractor/stylesheets"
#   config.less.compress = true
# end

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# Application.css
Rails.application.config.assets.precompile += %w( application.css )

# Fonts
Rails.application.config.assets.precompile += %w( http://fonts.googleapis.com/css?family=Arimo:400,700,400italic )
Rails.application.config.assets.precompile += %w( fonts/linecons/css/linecons.css.erb )
Rails.application.config.assets.precompile += %w( fontawesome.css )

# LESS Pre-Parsed Stylesheets
# Rails.application.config.assets.precompile += %w( less/bootstrap.less )
# Rails.application.config.assets.precompile += %w( less/xenon-core.less )
# Rails.application.config.assets.precompile += %w( less/xenon-forms.less )
# Rails.application.config.assets.precompile += %w( less/xenon-components.less )
# Rails.application.config.assets.precompile += %w( less/xenon-skins.less )

Rails.application.config.assets.precompile += %w( jeweler-logo-full-black.png jeweler-logo-full-white.png )

Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( xenon-core.css )
Rails.application.config.assets.precompile += %w( xenon-forms.css )
Rails.application.config.assets.precompile += %w( xenon-components.css )
Rails.application.config.assets.precompile += %w( xenon-skins.css )

# Controller Stylesheets
Rails.application.config.assets.precompile += %w( main.css )

# Javascript
Rails.application.config.assets.precompile += %w( jquery-1.11.1.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( TweenMax.min.js )
Rails.application.config.assets.precompile += %w( resizeable.js )
Rails.application.config.assets.precompile += %w( xenon-api.js )
Rails.application.config.assets.precompile += %w( xenon-toggles.js )
Rails.application.config.assets.precompile += %w( joinable.js )
Rails.application.config.assets.precompile += %w( xenon-widgets.js )
Rails.application.config.assets.precompile += %w( devexpress-web-14.1/js/dx.all.js )
Rails.application.config.assets.precompile += %w( devexpress-web-14.1/js/dx.chartjs.js )
Rails.application.config.assets.precompile += %w( toastr/toastr.min.js )
Rails.application.config.assets.precompile += %w( xenon-custom.js )

Rails.application.config.assets.precompile += %w( home.css )

Rails.application.config.assets.precompile += %w( fontawesome-all.min.css )
Rails.application.config.assets.precompile += %w( home/bootstrap.css )
Rails.application.config.assets.precompile += %w( home/style.css )
Rails.application.config.assets.precompile += %w( home/dark.css )
Rails.application.config.assets.precompile += %w( home/font-icons.css.erb )
Rails.application.config.assets.precompile += %w( home/animate.css )
Rails.application.config.assets.precompile += %w( home/magnific-popup.css )
Rails.application.config.assets.precompile += %w( home/responsive.css )

Rails.application.config.assets.precompile += %w( home/jquery.js )
Rails.application.config.assets.precompile += %w( home/plugins.js )
Rails.application.config.assets.precompile += %w( home/functions.js )

Rails.application.config.assets.precompile += %w( parallax/7.jpg )


