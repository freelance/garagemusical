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
  
  def add_profile(profile)
    self.push("profile_id", profile["_id"])
  end

end

class Posting < Mongomatic::Base
  include Mongomatic::Expectations::Helper
  
  def validate
  end
  
  def creator_nick
    creator = User.find_one( {:_id => self[:creator]} )
    creator.nil? ? nil : creator[:nick]
  end
  
  def add_reply
    self.inc("replies", 1)
  end

  def before_insert
    self["last_edit"] = Time.now
  end

end

class Reply < Mongomatic::Base
  include Mongomatic::Expectations::Helper
  
  def validate
  end

end