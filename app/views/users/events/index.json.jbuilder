json.array!(@events) do |event|
  
  new_hash = { start: event.start_date, end: event.end_date }
  
  json.extract! event, :id, :title, :content
  json.merge! new_hash
  json.start event.start_date
  json.end event.end_date
  json.url event_url(event)
end