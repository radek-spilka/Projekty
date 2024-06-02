extends Node

var data = {
	"Player":{
		"best_score" : "0",
		"tutorial_over" : "no"
	}
}

var file = File.new()

func write_to_money(money):
	if int(data["Player"]["best_score"]) < int(money):
		data["Player"]["best_score"] = str(money)

	file.open("user://SaveFile.json", File.WRITE)
	file.store_string(JSON.print(data, "\t", false))
	file.close()

