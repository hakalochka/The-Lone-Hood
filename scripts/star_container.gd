extends HBoxContainer

func update_stars(stars: int):
	var star = get_children()
	
	for i in range(stars):
		star[i].modulate = Color(1, 1, 1, 1)
		
	
	for i in range(stars, star.size()):
		star[i].modulate = Color(0.15, 0.15, 0.15 ,1)
