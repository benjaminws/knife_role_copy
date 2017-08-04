require 'chef/knife'

class Chef
  class Knife
    class RoleCopy < Knife

      deps do
        require 'chef/role'
        require 'chef/json_compat'
      end

      banner "knife role copy ROLE NEW_ROLE (options)"

      def run
        @original_role_name = @name_args[0]
        @new_role_name = @name_args[1]

        if @original_role_name.nil?
          show_usage
          ui.fatal("You must specify a role name to copy from")
          exit 1
        end

        if @new_role_name.nil?
          show_usage
          ui.fatal("You must specify a new role name")
          exit 1
        end

        # This sucks, but there's no clean way to check
        # if a load failed. I have a patch for that though :P
        begin
          try_new_role = Chef::Role.load(@new_role_name)
          ui.fatal("Role #{@new_role_name} already exists")
          exit 1
        rescue Net::HTTPServerException
          self.do_copy()
        end
      end

      def do_copy
        original_role = Chef::Role.load(@original_role_name)
        new_role = Chef::Role.new
        new_role.name(@new_role_name)
        new_role.description("#{original_role.description} (Copy from #{original_role.name})")
        new_role.run_list(original_role.run_list)
        new_role.env_run_lists(original_role.env_run_lists)
        new_role.default_attributes(original_role.default_attributes)
        new_role.override_attributes(original_role.override_attributes)
        create_object(new_role, object_class: Chef::Role)
      end
    end
  end
end
