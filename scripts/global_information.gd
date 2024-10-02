extends Node

var tool : String
var is_zoom : bool
var selected_color : Color
var dimensions : Vector2i = Vector2i(15,32)

var project_name : String

@export var colorPalettes = {
	"default": [Color("#FFFFFF"), Color("#000000"), Color("#33FF57"), Color("#3357FF"), Color("#FF33A6"), Color("#FF8F33"), Color("#33FFF0"), Color("#8F33FF"), Color("#FF3333"), Color("#33FF9A"), Color("#FF33E7"), Color("#33D4FF"), Color("#FFD433"), Color("#33FF83"), Color("#A633FF"), Color("#FF33B5")],
	"gray" : [Color("#A9A9A9"), Color("#808080"), Color("#696969"), Color("#D3D3D3"), Color("#C0C0C0"), Color("#BEBEBE"), Color("#B0B0B0"), Color("#E0E0E0"), Color("#F5F5F5"), Color("#DCDCDC"), Color("#F8F8F8"), Color("#D0D0D0"), Color("#B4B4B4"), Color("#A0A0A0"), Color("#C8C8C8")],
	"purple" : [Color("#6A0D91"), Color("#8A2C77"), Color("#9B4F9F"), Color("#B065C8"), Color("#D47C9B"), Color("#CE8EE3"), Color("#B39BC4"), Color("#E3B8D1"), Color("#A77DBB"), Color("#9B6C9E"), Color("#D2A3E2"), Color("#7B4C93"), Color("#E2C2E2"), Color("#A64C91"), Color("#D79BEB")],
	"green" : [Color("#004d00"), Color("#006400"), Color("#228B22"), Color("#2E8B57"), Color("#3CB371"), Color("#66CDAA"), Color("#8FBC8F"), Color("#98FB98"), Color("#9ACD32"), Color("#ADFF2F"), Color("#7FFF00"), Color("#00FF00"), Color("#32CD32"), Color("#9FDD8C"), Color("#D0F0C0")],
	"red" : [Color("#8B0000"), Color("#B22222"), Color("#DC143C"), Color("#FF0000"), Color("#FF4500"), Color("#FF6347"), Color("#FF7F50"), Color("#FA8072"), Color("#F08080"), Color("#E9967A"), Color("#CD5C5C"), Color("#D2691E"), Color("#A52A2A"), Color("#B22222"), Color("#C71585")],
	"blue" : [Color("#00008B"), Color("#0000FF"), Color("#0000CD"), Color("#4682B4"), Color("#4169E1"), Color("#1E90FF"), Color("#87CEFA"), Color("#ADD8E6"), Color("#B0E0E6"), Color("#5F9EA0"), Color("#6495ED"), Color("#00BFFF"), Color("#00CED1"), Color("#7B68EE"), Color("#6A5ACD")],
	"orange" : [Color("#FF4500"), Color("#FF6347"), Color("#FF7F50"), Color("#FFA500"), Color("#FF8C00"), Color("#F4A460"), Color("#D2691E"), Color("#FFB6C1"), Color("#FDBA74"), Color("#FF9C6C"), Color("#FF6F00"), Color("#FF7043"), Color("#F57C00"), Color("#F9A825"), Color("#FFAB91")],
	"yellow" : [Color("#FFFF00"), Color("#FFD700"), Color("#FFA500"), Color("#F0E68C"), Color("#FFFFE0"), Color("#FAFAD2"), Color("#FFE4B5"), Color("#FFFACD"), Color("#FFEFD5"), Color("#FFEBCD"), Color("#F5DEB3"), Color("#E3C9A3"), Color("#F7E7CE"), Color("#E1C699"), Color("#D4AF37")],
	"cold" : [Color("#00BFFF"), Color("#1E90FF"), Color("#4682B4"), Color("#5F9EA0"), Color("#87CEEB"), Color("#B0E0E6"), Color("#ADD8E6"), Color("#C0C0C0"), Color("#D3D3D3"), Color("#E0FFFF"), Color("#F0F8FF"), Color("#F5FFFA"), Color("#F0FFFF"), Color("#E6E6FA"), Color("#DCE6F0")],
	"warm" : [Color("#FF4500"), Color("#FF6347"), Color("#FF7F50"), Color("#FF8C00"), Color("#FFA07A"), Color("#F4A460"), Color("#FFD700"), Color("#FFA500"), Color("#FFB6C1"), Color("#FF69B4"), Color("#FF1493"), Color("#FF00FF"), Color("#FF00FF"), Color("#FFDAB9"), Color("#FFE4B5")],
	"earthy": [Color("#8B4513"), Color("#A0522D"), Color("#D2691E"), Color("#F4A460"), Color("#DEB887"), Color("#F5DEB3"), Color("#D2B48C"), Color("#BC8F8F"), Color("#F0E68C"), Color("#C2B280"), Color("#E3DAC9"), Color("#A9A9A9"), Color("#C0C0C0"), Color("#D8BFD8"), Color("#E4D96F")]
}
