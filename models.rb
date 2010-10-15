class User < Mongomatic::Base
  include Mongomatic::Expectations::Helper
  
  def validate
    self.errors << ["Name", "can't be empty"] if self["name"].blank?
  end

end