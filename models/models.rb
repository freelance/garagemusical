class User < Mongomatic::Base
  include Mongomatic::Expectations::Helper
  
  def validate
    self.errors << ["Name", "can't be empty"] if self["name"].blank?
  end
  
  def self.create_indexes
    collection.create_index('nick', :unique => true)
  end
  def self.drop_indexes
    collection.drop_indexes
  end

end

class Posting < Mongomatic::Base
end