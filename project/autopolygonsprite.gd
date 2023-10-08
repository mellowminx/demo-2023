extends Sprite

### attach this script to a Sprite node with a transparent image texture
### Sprite must be child node of StaticBody2D or KinematicBody2D
###
### source:
### https://ask.godotengine.org/49947/automatically-create-collisionpolygon2d-gdnative-gdscript
### https://ask.godotengine.org/98607/opaque_to_polygons-gives-empty-array-as-input
###
### this seems to work fine even if the Sprite node is not a child of a StaticBody2D or KinematicBody2D node
### however, it's better to make the Sprite a child node of a StaticBody2D or KinematicBody2D node
### so that you can reposition the parent node and have the Sprite and CollisionPolygon just follow
###
### tested in Godot 3.5.3
### turn on Debug -> Visible Collision Shapes in the Godot menu to check if it works

func _ready():
	_create_collision_polygon()

func _create_collision_polygon():
		var bm = BitMap.new()
		bm.create_from_image_alpha(texture.get_data())
		# in the original script, it was Rect2(position.x, position.y ...)
		var rect = Rect2(0, 0, texture.get_width(), texture.get_height())
		# change (rect, 2) for more or less precision
		# for ex. (rect, 5) will have the polygon points spaced apart more
		# (rect, 0.0001) will have points spaced very close together for a precise outline
		var my_array = bm.opaque_to_polygons(rect, 2)
		# optional - check if opaque_to_polygons() was able to get data
#		print(my_array)
		var my_polygon = Polygon2D.new()
		my_polygon.set_polygons(my_array)
		var offsetX = 0
		var offsetY = 0
		if (texture.get_width() % 2 != 0):
			offsetX = 1
		if (texture.get_height() % 2 != 0):
			offsetY = 1
		for i in range(my_polygon.polygons.size()):
			var my_collision = CollisionPolygon2D.new()
			my_collision.set_polygon(my_polygon.polygons[i])
			my_collision.position -= Vector2((texture.get_width() / 2) + offsetX, (texture.get_height() / 2) + offsetY) * scale.x
			my_collision.scale = scale
			get_parent().call_deferred("add_child", my_collision)
