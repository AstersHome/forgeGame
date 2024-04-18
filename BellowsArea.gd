extends Area

export var bellows_drop_height = 1.0
export(float) var bellows_drop_rate = bellows_drop_height / 3 / 60

var _stepped_on = false

func _ready():
	connect("body_entered", self, "_on_area_body_entered")
	connect("body_exited", self, "_on_area_body_exited")
	
func _on_area_body_entered(body):
	print("You're squishing me!!!")
	_stepped_on = true
	
func _on_area_body_exited(body):
	_stepped_on = false
	
var _dropped_height = 0
var velocity = Vector3.ZERO
func _physics_process(delta):
	if _stepped_on and _dropped_height < bellows_drop_height:
		velocity = -transform.basis.y * bellows_drop_rate
		_dropped_height += bellows_drop_rate
		get_parent().translate(velocity)
		print("dropping")
	elif _stepped_on:
		print("fully dropped")
	elif not _stepped_on and _dropped_height > 0:
		velocity = -transform.basis.y * -bellows_drop_rate
		_dropped_height -= bellows_drop_rate
		get_parent().translate(velocity)
		print("rising")
		
