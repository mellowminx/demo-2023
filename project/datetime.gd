extends Node2D

func _ready():
	
	get_local_date()

func get_local_date():
	
	var local_date = Time.get_date_dict_from_system(false)
	
	print(local_date)
