module SpreeContactUs
  module Generators
    class InstallGenerator < Rails::Generators::Base

      argument :file_name, :type => :string, :desc => 'rails app_path', :default => '.'
      source_root File.expand_path('../../templates', __FILE__)

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_contact_us\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/contact_us\n", :before => /\*\//, :verbose => true
      end

      def copy_initializer_file
        template 'spree_contact_us.rb', "#{file_name}/config/initializers/spree_contact_us.rb"
        template 'recaptcha.rb', "#{file_name}/config/initializers/recaptcha.rb"
      end
    end
  end
end
