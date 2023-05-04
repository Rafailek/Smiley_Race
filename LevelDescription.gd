extends RichTextLabel

var level1_description = "This level can be fairly chalenging thanks to rocks scatered around.\n\nLaps: 7"
var level2_description = "The tight paths seem to never give you a break...\n\nLaps:4"

var controls_description = "Move: Arrows\nRestart: R\nGo back to this menu: M"
var controls_description_index = 3

func _on_level_selector_item_selected(index):
	if index == 1:
		set_text(level1_description)
	if index == 2:
		set_text(level2_description)
	
	if index == controls_description_index:
		set_text(controls_description)
