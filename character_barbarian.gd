extends Spatial
const eyeColours = ["res://Heads/eye_colour_blue.tres", "res://Heads/eye_colour_brown.tres", "res://Heads/eye_colour_green.tres", "res://Heads/eye_colour_hazel.tres", "res://Heads/eye_colour_purple.tres"]
const hairColours = ["res://Heads/hair_colour_black.tres", "res://Heads/hair_colour_blond.tres", "res://Heads/hair_colour_brown.tres", "res://Heads/hair_colour_ginger.tres", "res://Heads/hair_colour_grey.tres", "res://Heads/hair_colour_green.tres", "res://Heads/hair_colour_blue.tres"]
const skinColours = ["res://Heads/skin_colour_chestnut.tres", "res://Heads/skin_colour_espresso.tres", "res://Heads/skin_colour_golden.tres", "res://Heads/skin_colour_ivory.tres", "res://Heads/skin_colour_natural.tres", "res://Heads/skin_colour_porcelain.tres"]

var lastAnimation = 4
const ANIMATION_TIME = 5

func _ready():
	var idleAnimation = get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").get_animation("Idle").duplicate()
	get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").remove_animation("Idle")
	get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").add_animation("Idle", idleAnimation)
	
	var headInUse = get_node("KayKit_AnimatedCharacter_v12/KayKit Animated Character/Skeleton/Head/Head" + str(round(randf() * 3) + 1))
	var hairTexture = load(hairColours[round(randf() * (hairColours.size()-1))])
	var eyeTexture = load(eyeColours[round(randf() * (eyeColours.size()-1))])
	var skinTexture = load(skinColours[round(randf() * (skinColours.size()-1))])
	
	headInUse.set_surface_material(0, skinTexture)
	headInUse.set_surface_material(1, eyeTexture)
	
	if headInUse.get_surface_material_count() > 2:
		headInUse.set_surface_material(2, hairTexture)
	
	if headInUse.get_child_count() > 0:
		headInUse.get_child(0).set_surface_material(0, hairTexture)
	
	headInUse.show()
	
	call_function_after("playIdle", randf())

func _process(delta):
	lastAnimation += delta
	
	if lastAnimation > ANIMATION_TIME && randf() > .999:
		var animation = ["Dance", "Wave", "AttackSpinning", "Jump", "Cheer"]
		
		lastAnimation = 0
		
		get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").queue(animation[randf() * (animation.size() - 1)])
		get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").get_animation("Idle").set_loop(false)
		call_function_after("queueIdle", .75)

func queueIdle():
	get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").get_animation("Idle").set_loop(true)
	get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").queue("Idle")

func playIdle():
	get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").get_animation("Idle").set_loop(true)
	get_node("KayKit_AnimatedCharacter_v12/AnimationPlayer").play_backwards("Idle")

func call_function_after(function, seconds):
	var timer = Timer.new()
	timer.set_wait_time(seconds)
	timer.connect("timeout", self, function) 
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()
