json.id @chat.id
json.user_id @chat.user_id
json.room_id @chat.room_id
json.message @chat.message
json.created_at @chat.created_at.strftime("%Y/%m/%d %H:%M")
json.user_name @chat.user.name