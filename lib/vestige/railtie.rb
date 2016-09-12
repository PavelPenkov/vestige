module Vestige
  class Railtie < ::Rails::Railtie
    initializer "vestige.configure_rails_initialization" do
      require_relative 'rack'
      ::Rails.application.middleware.insert_after(::ActionDispatch::RequestId, Rack)
    end

    generators do
      require_relative "generators/install_generator"
    end
  end
end
