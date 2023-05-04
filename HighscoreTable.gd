extends RichTextLabel

var level1_scores = {
section_name = "Level1",
first_name="Marlee",
first_time=31.415,
second_name="Barunka",
second_time=40.4,
third_name="Heidi",
third_time=69.696
}

var level2_scores = {
section_name = "Level2",
first_name="Marlee",
first_time=31.415,
second_name="Barunka",
second_time=40.4,
third_name="Heidi",
third_time=69.696
}

var score_file = ConfigFile.new()

func _ready():
	
	var err = score_file.load("res://HighscoreData.cfg")
	
	if err != OK:
		$AcceptDialog.visible = true
	else:
		load_scores_into_dictionary(level1_scores)
		load_scores_into_dictionary(level2_scores)
	

func load_scores_into_dictionary(dict):
	var first_name_value = score_file.get_value(dict.get("section_name"), "1st_name")
	var first_time_value = score_file.get_value(dict.get("section_name"), "1st_time")
	var second_name_value = score_file.get_value(dict.get("section_name"), "2nd_name")
	var second_time_value = score_file.get_value(dict.get("section_name"), "2nd_time")
	var third_name_value = score_file.get_value(dict.get("section_name"), "3rd_name")
	var third_time_value = score_file.get_value(dict.get("section_name"), "3rd_time")
	dict["first_name"] = first_name_value
	dict["first_time"] = first_time_value
	dict["second_name"] = second_name_value
	dict["second_time"] = second_time_value
	dict["third_name"] = third_name_value
	dict["third_time"] = third_time_value

func _on_level_selector_item_selected(index):
	if index == 1:
		set_text( 
		str(level1_scores.get("first_name")) + ": " + str(level1_scores.get("first_time")) +"\n"+
		str(level1_scores.get("second_name")) + ": " + str(level1_scores.get("second_time")) +"\n"+
		str(level1_scores.get("third_name")) + ": " + str(level1_scores.get("third_time")))
	if index == 2:
		set_text( 
		str(level2_scores.get("first_name")) + ": " + str(level2_scores.get("first_time")) +"\n"+
		str(level2_scores.get("second_name")) + ": " + str(level2_scores.get("second_time")) +"\n"+
		str(level2_scores.get("third_name")) + ": " + str(level2_scores.get("third_time")))


func _on_accept_dialog_confirmed():
	for level in $"../LevelSelector".get_item_count() - 2 :
		score_file.set_value("Level"+str(level+1), "1st_name", "Marlee")
		score_file.set_value("Level"+str(level+1), "1st_time", 60.000)
		score_file.set_value("Level"+str(level+1), "2nd_name", "Barunka")
		score_file.set_value("Level"+str(level+1), "2nd_time", 60.000)
		score_file.set_value("Level"+str(level+1), "3rd_name", "Heidi")
		score_file.set_value("Level"+str(level+1), "3rd_time", 60.000)
		
	score_file.save("res://HighscoreData.cfg")
	
	load_scores_into_dictionary(level1_scores)
	load_scores_into_dictionary(level2_scores)
