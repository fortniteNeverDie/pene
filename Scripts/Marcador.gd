extends CanvasLayer

func _ready():
	Global.Marcador = self
	actualitza(self)
	$Label.text = '0'

func actualitza(meteorits):
	$Label.text = str(meteorits)
