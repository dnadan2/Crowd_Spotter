extends Spatial
const eyeColours = ["res://Heads/eye_colour_blue.tres", "res://Heads/eye_colour_brown.tres", "res://Heads/eye_colour_green.tres", "res://Heads/eye_colour_hazel.tres"]
const hairColours = ["res://Heads/hair_colour_black.tres", "res://Heads/hair_colour_blond.tres", "res://Heads/hair_colour_brown.tres", "res://Heads/hair_colour_ginger.tres", "res://Heads/hair_colour_grey.tres"]
const skinColours = ["res://Heads/skin_colour_chestnut.tres", "res://Heads/skin_colour_espresso.tres", "res://Heads/skin_colour_golden.tres", "res://Heads/skin_colour_ivory.tres", "res://Heads/skin_colour_natural.tres", "res://Heads/skin_colour_porcelain.tres"]

func _ready():
	var headInUse = get_node("KayKit_AnimatedCharacter_v12/KayKit Animated Character/Skeleton/Head/Head" + str(round(randf() * 3) + 1))
	var hairTexture = load(hairColours[round(randf() * hairColours.size()-1)])
	var eyeTexture = load(eyeColours[round(randf() * eyeColours.size()-1)])
	var skinTexture = load(skinColours[round(randf() * skinColours.size()-1)])
	
	headInUse.set_surface_material(0, skinTexture)
	headInUse.set_surface_material(1, eyeTexture)
	
	if headInUse.get_surface_material_count() > 2:
		headInUse.set_surface_material(2, hairTexture)
	
	if headInUse.get_child_count() > 0:
		headInUse.get_child(0).set_surface_material(0, hairTexture)
	
	headInUse.show()
