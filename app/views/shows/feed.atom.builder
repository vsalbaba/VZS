atom_feed do |feed|
  feed.title("Akce VZS")
  feed.updated(@shows.first.created_at)

  @shows.each do |show|
    feed.entry(show) do |entry|
      entry.title("#{l show.date, :format => :with_day} - #{h show.name}")
      entry.content(show.description, :type => 'html')
    end
  end
end

