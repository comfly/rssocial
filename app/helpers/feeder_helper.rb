require 'feedzirra'

module FeederHelper
  

=begin
=================================================================
====================== Feeder class =======================
=================================================================
=end
  
  class Feeder
  
    def self.get_new_remote_entries_for_local_feed(local_feed)
      all_entries_from_feed = self.get_entries_for_feed(local_feed)
      unless all_entries_from_feed.nil?
        self.filter_entries(local_feed.entries, all_entries_from_feed)
      end
    end
  
    def self.store_new_remote_entries_in_local_feed(remote_entries, local_feed)
      remote_entries_array = remote_entries.to_a
      remote_entries_array.each { |remote_entry| local_feed.entries << remote_entry }
      local_feed.save
    end
  
  private

    def self.get_entries_for_feed(feed)
      feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url, on_failure: Proc.new { return nil })
      return nil if feedzirra_feed.entries.empty?
      
      feedzirra_feed.entries.inject(Array.new) do | entries, feedzirra_entry |
        entry = Entry.new
        entry.feed_id = feed.id
        entry.title = feedzirra_entry.title
        entry.url = feedzirra_entry.url
        entry.author = feedzirra_entry.author
        entry.summary = feedzirra_entry.summary
        entry.content = feedzirra_entry.content
        entry.published = feedzirra_entry.published
        entry.tags = feedzirra_entry.categories.join ','
      
        entries << entry
      end
    end

    def self.filter_entries(local_entries, remote_entries)
      local_feed_items = local_entries.to_a.map { |local_entry| { title: local_entry.title, url: local_entry.url, summary: local_entry.summary } }
      remote_entries.to_a.select do |remote_entry|
        local_feed_items.index { |local_feed_item|
          (local_feed_item[:title] == remote_entry.title) &&
          (local_feed_item[:url] == remote_entry.url) &&
          (local_feed_item[:summary] == remote_entry.summary)
        }.nil?
      end
    end
  end

=begin
=================================================================
====================== FeederRunner class =======================
=================================================================
=end
  
  class FeederRunner
    def run(&error_block)
      feeds = Feed.all
      feeds.each do |feed|
        new_entries = Feeder.get_new_remote_entries_for_local_feed(feed)
        unless new_entries.nil?
          error_block.call() unless Feeder.store_new_remote_entries_in_local_feed(new_entries, feed)
        end
      end
    end
  end

end
