# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/ then '/'
    when /^the events page$/ then '/events'
    when /^the past events page$/ then '/past-events'
    when /^the donate page$/ then '/donations'
    when /^the new donation page$/ then '/donations/new'
    when /^the edit page of the first task of the first event$/ then '/events/1/tasks/1/edit'
    when /^the add task page for the first event$/ then '/events/1/tasks/new'
    when /^the tasks page for the first event$/ then '/events/1/tasks'
    when /^the first event rsvp page$/ then '/events/1/guests/new'
    when /^the first event page$/ then '/events/1'

      # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
