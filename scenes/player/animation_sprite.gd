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
	await animation_finished
	set_frame_progress(1.0)
	
func damage():
	play_animation("dmg")
	
func attack(dir):
	play_animation("attack" + "_" + dir)
	
func special():
	play_animation("special")
	
func play_animation(name):
	if await check_for_uninteruptable(name):
		play(name)
			
func check_for_uninteruptable(name):
	if not is_playing():
		return true
	if animation == "dmg" and (name != "dmg" or name != "die" or name != "attack" or name != "special"):
		await animation_finished
	elif (animation == "attack_up" or animation == "attack_down") and name != "die":
		await animation_finished
	elif animation == "special":
		await animation_finished
	elif animation == "die":
		return false
	return true
