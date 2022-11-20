extends KinematicBody2D
var moveSpeed : int = 250
var defaultSpeed = 250
var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()
var hasKey = false
var cutCount: int = 1

func _physics_process(delta):
	moveSpeed = defaultSpeed
	all_sprites_invisible()
	$Stop.visible = true
	var vel = Vector2()
	  
	  # inputs
	if Input.is_action_pressed("move_up"):
		all_sprites_invisible()
		$Walk_Up.visible = true
		$AnimationPlayer.play("Walk_Up")
		vel.y -= 1
		facingDir = Vector2(0, -1)

	elif Input.is_action_pressed("move_down"):
		all_sprites_invisible()
		$Walk_Backwards.visible = true
		$AnimationPlayer.play("Walk_Down")
		vel.y += 1
		facingDir = Vector2(0, 1)

	elif Input.is_action_pressed("move_left"):
		all_sprites_invisible()
		$Walk_Left.visible = true
		$AnimationPlayer.play("Walk_Left")
		vel.x -= 1
		facingDir = Vector2(-1, 0)

	elif Input.is_action_pressed("move_right"):
		all_sprites_invisible()
		$Walk_Right.visible = true
		$AnimationPlayer.play("Walk_Right")
		vel.x += 1
		facingDir = Vector2(1, 0)
	
	if Input.is_action_just_pressed("ui_select"):
		use_scissors()

	vel = vel.normalized()

	# move the player
	move_and_slide(vel * moveSpeed)
		
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.name.begins_with("Wall") and hasKey:
			collision.collider.queue_free()
			hasKey = false
		if collision.collider.name.begins_with("Flower"):
			get_parent().player_touched_flower()

func use_scissors():
	if cutCount > 0:
		$ScissorArea.monitoring = true
		$ScissorArea.monitorable = true
		
		# Will set to false on the next frame
		$ScissorArea.set_deferred("monitoring", false)
		$ScissorArea.set_deferred("monitorable", false)
		cutCount -= 1

func all_sprites_invisible():
	$Stop.visible = false
	$Walk_Left.visible = false
	$Walk_Right.visible = false
	$Walk_Backwards.visible = false
	$Walk_Up.visible = false
	
func setKey(haveKey):
	hasKey = haveKey
