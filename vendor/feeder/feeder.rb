require 'feedzirra'

module Feeder
  def get_feedzirra_feed_for_feed(feed)
    feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url)

    entries = Array.new
    feedzirra_feed.entires.each do | feedzirra_entry |
      entry = Entry.new
      entry.feed_id = feed.id
      entry.title = feedzirra_entry.title
      entry.url = feedzirra_entry.url
      entry.author = feedzirra_entry.author
      entry.summary = feedzirra_entry.summary
      entry.content = feedzirra_entry.content
      entry.published = feedzirra_entry.published
      entry.tags = feedzirra_entry.tags
      
      entries << entry
    end
    
    feed
  end
end