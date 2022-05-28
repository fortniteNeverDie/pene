extends KinematicBody2D

var vida = 100

var vel_rotacio = 0
var vel_rotacio_max = 200
var vel_max = 5
var velocitat = Vector2()
var pot_disparar = true
var escena_laser = Global.escena_laser
var meteorits_morts = 0
var so_motor = 0

func _physics_process(delta):
	vel_rotacio = 0
	velocitat = Vector2()
	if Input.is_action_pressed('ui_left'):
		vel_rotacio -= vel_rotacio_max
	if Input.is_action_pressed('ui_right'):
		vel_rotacio += vel_rotacio_max
	if Input.is_action_pressed("ui_up"):
		$Particles2D.emitting = true
		move_local_y(-vel_max)
		if so_motor == 0:
			$SoMotor.play()
	if Input.is_action_just_released("ui_up"):
		$Particles2D.emitting = false
		$SoMotor.stop()
		so_motor = 0
		
	if Input.is_action_pressed("ui_up"):
		so_motor = 1
		
	else:
		pass
	if pot_disparar and Input.is_action_pressed('ui_select'):
		dispara()
	global_rotation_degrees += vel_rotacio * delta
	$Centre.global_rotation_degrees = 0
	
	if vida <= 0:
		mor()
	
func dispara():
	pot_disparar = false
	$SoLaser.pitch_scale = rand_range(0.8, 1.2)
	$SoLaser.play()
	crea_bala($Dreta.global_position)
	crea_bala($Esquerra.global_position)
	$TimerDispara.start()

func crea_bala(posicio):
	var nou_laser = escena_laser.instance()
	nou_laser.position = posicio
	nou_laser.rotation_degrees = global_rotation_degrees
	Global.Bales.add_child(nou_laser)
	
func hit(damage):
	vida -= damage
	$AnimationPlayer.play("hit")
	$Centre/TextureProgress.actualitza(vida)

func _on_TimerDispara_timeout():
	pot_disparar = true

func _on_meteorit_mort():
	meteorits_morts += 1
	Global.Marcador.actualitza(meteorits_morts)

func mor():
	get_tree().change_scene("res://Escenes/GameOver.tscn")
