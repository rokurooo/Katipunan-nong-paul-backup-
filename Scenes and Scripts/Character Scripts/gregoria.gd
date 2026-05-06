extends CharacterBody2D

@export var max_health: int = 100 
@export var speed: float = 200.0   
@export var attack_range: float = 150.0
@export var attack_damage: int = 25
@export var attack_cooldown: float = 1.0

#rake
signal curhealth
signal ui
#

var health: int = max_health
var is_dead: bool = false
var is_selected: bool = false
var move_target: Vector2
var target_enemy: Node2D = null
var original_scale: Vector2

@onready var sfx_hit: AudioStreamPlayer2D = $sfx_hit
@onready var sfx_death: AudioStreamPlayer2D = $sfx_death
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var taunt_timer: Timer = Timer.new()
@onready var attack_timer: Timer = Timer.new()
@onready var healanim: AnimatedSprite2D = $healanim
@onready var ring: Panel = $Ring

func _ready() -> void:
	Globalcharactercheck.alivecharacters["Gregoria De Jesús"] = true
	move_target = global_position
	
	add_to_group("player")
	add_to_group("aggro_target")  # Enemies target Tank!
	
	add_child(taunt_timer)
	add_child(attack_timer)
	attack_timer.one_shot = true
	attack_timer.wait_time = attack_cooldown
	attack_timer.timeout.connect(_on_attack_ready)
	
	sprite.play("Idle")

# INPUT – Only move when selected
func _input(event: InputEvent) -> void:
	if not is_selected or is_dead: return
	
	if event.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		var hit = _get_clicked_enemy(mouse_pos)
		if hit:
			target_enemy = hit
			print("Targeted: ", target_enemy.name)
		else:
			move_target = mouse_pos
# PHYSICS – Auto-taunt + follow + click-move
func _physics_process(_delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		if sprite.animation != "Idle":
			sprite.play("Idle")
		return

	if target_enemy and is_instance_valid(target_enemy):
		var dist = global_position.distance_to(target_enemy.global_position)
		
		if dist <= attack_range:
			velocity = Vector2.ZERO
			sprite.flip_h = global_position.x > target_enemy.global_position.x
			

			if attack_timer.is_stopped():
				sprite.play("Attack")  
				sfx_hit.play() 
				_attack_target()              
			
			elif sprite.animation != "Attack":
				sprite.play("Attack")
		
		else:
			var dir = global_position.direction_to(target_enemy.global_position)
			velocity = dir * speed
			sprite.flip_h = dir.x < 0
			if sprite.animation != "Walk":
				sprite.play("Walk")
	
	elif global_position.distance_to(move_target) > 10.0:
		var dir = global_position.direction_to(move_target)
		velocity = dir * speed
		sprite.flip_h = dir.x < 0
		if sprite.animation != "Walk":
			sprite.play("Walk")
	
	# 3. IDLE
	else:
		velocity = Vector2.ZERO
		if sprite.animation != "Idle":
			sprite.play("Idle")

	move_and_slide()

func _attack_target() -> void:
	if not is_instance_valid(target_enemy):
		return
	
	print("HIT! ", target_enemy.name, " for ", attack_damage)
	target_enemy.take_damage(attack_damage)
	attack_timer.start() 

func _on_attack_ready() -> void:
	pass 
func _on_selection_area_selection_toggled(selected_now: bool) -> void:
	emit_signal("ui",true)
	is_selected = selected_now
	ring.show()
	if not is_selected:
		emit_signal("ui",false)
		move_target = global_position
		ring.hide()
		velocity = Vector2.ZERO

func take_damage(amount: int) -> void:
	if is_dead: return
	health -= amount
	modulate = Color.RED
	get_tree().create_timer(0.2).timeout.connect(func(): modulate = Color.WHITE)
	print("Tank HP: ", health, "/", max_health)
	if health <= 0:
		die()
	
func heal(amount: int) -> void:
	health = min(health + amount, max_health)
	modulate = Color.GREEN
	get_tree().create_timer(0.2).timeout.connect(func(): modulate = Color.WHITE)
	healanim.show()
	healanim.play("Heal")
	await healanim.animation_finished
	healanim.hide()

func die() -> void:
	Globalcharactercheck.alivecharacters["Gregoria De Jesús"] = false
	is_dead = true
	set_physics_process(false)
	sprite.play("Death")
	sfx_death.play()
	await sprite.animation_finished
	queue_free()

func _get_clicked_enemy(pos: Vector2) -> Node2D:
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collision_mask = 2
	var hits = get_world_2d().direct_space_state.intersect_point(query)
	for hit in hits:
		if hit.collider.is_in_group("enemies"):
			return hit.collider
	return null


#	rake
func _health_update_rake(value: float) -> void:
	emit_signal("curhealth",value)
#	
