require 'feedzirra'

class Feeder

  def self.perform
    feeds = Feed.all
    feeds.each do |feed|
      new_entries = Feeder.get_new_remote_entries_for_local_feed(feed)
      unless new_entries.nil?
        if Feeder.store_new_remote_entries_in_local_feed(new_entries, feed)
          self.logger.info "Saved #{new_entries.size} new entries for feed '#{feed.title}'"
          self.log_into_console "Saved #{new_entries.size} new entries for feed '#{feed.title}'"
        else
          self.logger.error "Unable to store new Remotes in Local feed '#{feed.title}'"
          self.log_into_console "Unable to store new Remotes in Local feed '#{feed.title}'"
        end
      end
    end
  end

private

  def self.log_into_console info
    # Uncomment the following line to see the logs in the console
    # puts info
  end

  def self.logger
    Rails.logger
  end

  def self.get_new_remote_entries_for_local_feed(local_feed)
    all_entries_from_feed = self.get_entries_for_feed(local_feed)
    if all_entries_from_feed.nil?
      self.logger.info "No new entries loaded for feed '#{local_feed.title}'"
      self.log_into_console "No new entries loaded for feed '#{local_feed.title}'"
    else
      local_feeds_from_db = local_feed.entries.recent(15)
      
      self.logger.info "Obtained #{local_feeds_from_db.size} items from DB."
      self.log_into_console "Obtained #{local_feeds_from_db.size} items from DB."
      
      self.filter_entries(local_feeds_from_db, all_entries_from_feed)
    end
  end

  def self.store_new_remote_entries_in_local_feed(remote_entries, local_feed)
    remote_entries_array = remote_entries.to_a
    remote_entries_array.each { |remote_entry| local_feed.entries << remote_entry }
    local_feed.save
  end
  
  def self.get_entries_for_feed(feed)
    feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url, on_failure: Proc.new { return nil })
    if feedzirra_feed.nil?
      self.logger.error 'Unable to instantiate Feedzirra.'
      self.log_into_console 'Unable to instantiate Feedzirra.'
    end
    return nil if feedzirra_feed.entries.empty?
    
    self.logger.info "Got #{feedzirra_feed.entries.size} entries for feed '#{feedzirra_feed.title}'"
    self.log_into_console "Got #{feedzirra_feed.entries.size} entries for feed '#{feedzirra_feed.title}'"
    
    feedzirra_feed.entries.inject(Array.new) do | entries, feedzirra_entry |
      entry = Entry.new
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
    
    self.logger.info "Number of entries before filtering: #{remote_entries.size}"
    self.log_into_console "Number of entries before filtering: #{remote_entries.size}"
    
    result = remote_entries.to_a.select do |remote_entry|
      local_feed_items.index { |local_feed_item|
        (local_feed_item[:title] == remote_entry.title) &&
        (local_feed_item[:url] == remote_entry.url) &&
        (local_feed_item[:summary] == remote_entry.summary)
      }.nil?
    end
    
    self.logger.info "Number of entries after filtering: #{result.size}"
    self.log_into_console "Number of entries after filtering: #{result.size}"
    result
  end
end

puts "Start running Feeder"

Feeder.perform

puts "End running Feeder"
