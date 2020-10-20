json.message @comment.message
json.id @comment.id
json.user_id @comment.user.id
json.user_name @comment.user.name
json.created_at @comment.created_at.strftime("%Y-%m-%d %H:%M")
json.item_seller @item_seller