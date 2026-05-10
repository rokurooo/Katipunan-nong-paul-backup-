extends CharacterBody2D

@export var max_health: int = 150
@export var speed: float = 300.0
@export var heal_range: float = 120.0
@export var heal_amount: int = 15
@export var heal_cooldown: float = 2.0

#rake
signal curhealth
signal ui
var multiplier: float = 1.0
#

var health: int = max_health
var is_dead: bool = false
var is_selected: bool = false          # Only affects movement, NOT healing!

var move_target: Vector2

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var heal_timer: Timer = Timer.new()
@onready var sfx_heal: AudioStreamPlayer2D = $sfx_heal
@onready var sfx_death: AudioStreamPlayer2D = $sfx_death
@onready var healanim: AnimatedSprite2D = $healanim
@onready var ring: Panel = $Ring

func _ready() -> void:
	Globalcharactercheck.alivecharacters["Apolinario Mabini"] = true
	move_target = global_position
	
	add_to_group("player")
	add_to_group("aggro_target")
	
	add_child(heal_timer)
	heal_timer.one_shot = true
	heal_timer.wait_time = heal_cooldown
	heal_timer.timeout.connect(_on_heal_ready)
	
	sprite.play("Idle")

# INPUT – Only movement when selected
func _input(event: InputEvent) -> void:
	if not is_selected or is_dead: return
	
	if event.is_action_pressed("click"):
		move_target = get_global_mouse_position()

func _physics_process(_delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return

	if heal_timer.is_stopped():
		var target = _find_best_heal_target()
		if target:
			velocity = Vector2.ZERO
			sprite.flip_h = global_position.x > target.global_position.x
			if sprite.animation != "Heal":
				sprite.play("Heal")
			_heal_target(target)
			heal_timer.start()
			sfx_heal.play()
			move_and_slide()
			return

	if is_selected and global_position.distance_to(move_target) > 10.0:
		var dir = global_position.direction_to(move_target)
		velocity = dir * speed
		sprite.flip_h = dir.x < 0
		if sprite.animation != "Walk":
			sprite.play("Walk")
	
	else:
		velocity = Vector2.ZERO
		if sprite.animation != "Idle" and heal_timer.time_left == 0:
			sprite.play("Idle")

	move_and_slide()

func _find_best_heal_target() -> Node2D:
	var allies = get_tree().get_nodes_in_group("player")
	var best: Node2D = null
	var lowest_ratio = 1.0
	
	for ally in allies:
		if not is_instance_valid(ally) or ally.is_dead: continue
		if ally.health >= ally.max_health: continue
		if global_position.distance_to(ally.global_position) > heal_range: continue
		
		var ratio = float(ally.health) / ally.max_health
		if ratio < lowest_ratio:
			lowest_ratio = ratio
			best = ally
	
	return best

func _heal_target(target: Node2D) -> void:
	if target.has_method("heal"):
		target.heal(heal_amount)
	else:
		target.health = min(target.health + heal_amount, target.max_health)
	
	print("Healer auto-healed ", target.name, " (+", heal_amount, ")")

func _on_heal_ready() -> void:
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
	Globalcharactercheck.alivecharacters["Apolinario Mabini"] = false
	is_dead = true
	set_physics_process(false)
	sprite.play("Death")
	sfx_death.play()
	await sprite.animation_finished
	queue_free()


#	rake
func _health_update_rake(value: float) -> void:
	emit_signal("curhealth",value)
	

#	
