class EntryStatus < ActiveRecord::Base
  belongs_to :entry, :inverse_of => :entry_statuses
  belongs_to :user, :inverse_of => :entry_statuses
end
