json.array!(@events) do |event|

  json.extract! event, :id, :title, :content
  json.start event.start
  json.end event.end
  json.url event_path(event)
end