class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def controller_policy(user)
      policy_class = Module.const_get(self.name.pluralize + "ControllerPolicy")

      if policy_class
        policy_class.new(user, nil)
      end
    end
  end
end
