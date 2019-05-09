class AboutController < ApplicationController
before_action :set_leaders

private

def set_leaders
  @leaders = Leader.by_created
end

end
