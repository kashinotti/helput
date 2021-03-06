json.array!(@events) do |event|

  json.extract! event, :id, :title, :content
  json.start Time.zone.parse(event.start.to_s).strftime("%F %T")
  json.end Time.zone.parse(event.end.to_s).strftime("%F %T")
  json.url event_path(event)
end