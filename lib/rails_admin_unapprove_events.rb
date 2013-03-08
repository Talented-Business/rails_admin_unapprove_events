require "rails_admin_unapprove_events/engine"

module RailsAdminUnapproveEvents
end
module RailsAdmin
  module Config
    module Actions
      class UnapproveEvents < RailsAdmin::Config::Actions::Base
				RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          bindings[:abstract_model].to_s == "Event"
        end
        register_instance_option :http_methods do
          [:get, :post]
        end

				register_instance_option :controller do
					Proc.new do
            if request.post? 
              @objects = list_entries(@model_config, :approve_events)
              @objects.each do |object|
                object.update_attribute(:approved, false)
              end  
              flash[:notice] = "You have unapproved #{@objects.count} event(s)."
              redirect_to back_or_index
            else
              render @action.template_name
            end
          end
				end
				register_instance_option :bulkable? do
          true
        end			 
				register_instance_option :link_icon do
          'icon-share'
        end				
      end
    end
  end
end