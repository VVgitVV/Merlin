Rails.application.config.assets.version = "1.0"

# Precompile additional assets
Rails.application.config.assets.precompile += %w(
  application.scss
)

# Add asset load paths
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'stylesheets')