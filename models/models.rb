class User < Mongomatic::Base
  include Mongomatic::Expectations::Helper
  
  def validate
    self.errors << ["nick", "can't be empty"] if self["nick"].blank?
  end
  
  def self.create_indexes
    collection.create_index('nick', :unique => true)
  end
  def self.drop_indexes
    collection.drop_indexes
  end

end

class Posting < Mongomatic::Base
  include Mongomatic::Expectations::Helper
  
  def validate
  end
  
  def creator_nick
    User.find_one( {:_id => self[:creator]} )[:nick]
  end
  
  def creator
    User.find_one( {:_id => self[:creator]} )[:nick]
  end

end