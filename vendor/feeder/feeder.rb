require 'feedzirra'

module Feeder
  def get_entries_for_feed(feed)
    Feedzirra::Feed.fetch_and_parse(feed.feed_url).entires.inject(Array.new) do | entries, feedzirra_entry |
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
  end

  def get_feedzirra_feed_for_feed(feed)

  end
end