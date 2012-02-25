module EtabliocmsActualities

  class Engine < ::Rails::Engine

    initializer "etabliocms_core.initialize" do |app|
      EtabliocmsCore.setup do |config|
        config.modules ||= []
        config.modules << :actualities
      end
    end

    initializer "etabliocms_core.link_public_assets" do |app|
      app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    end

  end

end
