extends Sprite

### source:
### https://ask.godotengine.org/49947/automatically-create-collisionpolygon2d-gdnative-gdscript
### https://ask.godotengine.org/98607/opaque_to_polygons-gives-empty-array-as-input

func _ready():
	_create_collision_polygon()

func _create_collision_polygon():
		var bm = BitMap.new()
		bm.create_from_image_alpha(texture.get_data())
		# in the original script, it was Rect2(position.x, position.y ...)
		var rect = Rect2(0, 0, texture.get_width(), texture.get_height())
		var my_array = bm.opaque_to_polygons(rect, 0.0001)
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
