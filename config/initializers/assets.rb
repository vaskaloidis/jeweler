# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

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

# Application.css.less
Rails.application.config.assets.precompile += %w( application.css.less )

# Fonts
Rails.application.config.assets.precompile += %w( http://fonts.googleapis.com/css?family=Arimo:400,700,400italic )
Rails.application.config.assets.precompile += %w( fonts/linecons/css/linecons.css )
Rails.application.config.assets.precompile += %w( fonts/fontawesome/css/font-awesome.min.css )

# LESS Pre-Parsed Stylesheets
Rails.application.config.assets.precompile += %w( bootstrap.css.less )
Rails.application.config.assets.precompile += %w( xenon-core.css.less )
Rails.application.config.assets.precompile += %w( xenon-forms.css.less )
Rails.application.config.assets.precompile += %w( xenon-components.css.less )
Rails.application.config.assets.precompile += %w( xenon-skins.css.less )

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
Rails.application.config.assets.precompile += %w( devexpress-web-14.1/js/dx.chartjs.j )
Rails.application.config.assets.precompile += %w( toastr/toastr.min.js )
Rails.application.config.assets.precompile += %w( xenon-custom.js );

# Rails.application.config.assets.precompile += %w( jewler-logo-full-black.png );
# Rails.application.config.assets.precompile += %w( jewler-logo-mini-small-black.png );