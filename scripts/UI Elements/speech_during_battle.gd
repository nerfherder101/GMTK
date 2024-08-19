extends Control


@export_category("Speech Options")
@export_group("Dialogue")
@export var successful_parry: Array[String] = ["Haha!", "Almost got me!", "You ain't nothing!"]
@export var successful_attack: Array[String] = ["Take that!", "I'm the best!", "No match for me"]
@export var unsuccesful_parry: Array[String] = ["Ugh!", "Nooo!", "Hey! Stop!"]
@export var unsuccesful_attack: Array[String] = ["I missed!", "I'll get you next time!", "Oh no..."]
@export var passive_charged: Array[String] = ["I'm all powerful!", "Thank you for that"]
@export var on_defeat: Array[String] = ["Noooo!", "MY TOY!"]
@export var on_victory: Array[String] = ["HAHA!", "YES!", "I'M THE BEST!"]
