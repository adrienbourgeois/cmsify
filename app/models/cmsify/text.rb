module Cmsify
  class Text < ActiveRecord::Base
    validates_presence_of :content
    validates :slug, presence: true, uniqueness: true
    belongs_to :owner, polymorphic: true
  end
end
