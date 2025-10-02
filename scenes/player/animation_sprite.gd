class_name CharacterSprite
extends AnimatedSprite2D

func walk_up():
	play_animation("walk_up")
	
func walk_down():
	play_animation("walk_down")
	
func idle():
	play_animation("idle")
	
func die():
	play_animation("die")
	
func damage():
	play_animation("dmg")
	
func attack(dir):
	play_animation("attack" + "_" + dir)
	
func special():
	play_animation("special")
	
func play_animation(name):
	await check_for_uninteruptable(name)
	play(name)
	
func check_for_uninteruptable(name):
	if not is_playing():
		return 
	if animation == "dmg" and (name != "dmg" or name != "die" or name != "attack" or name != "special"):
		await animation_finished
	if (animation == "attack_up" or animation == "attack_down") and name != "die":
		await animation_finished
	if animation == "special":
		await animation_finished
