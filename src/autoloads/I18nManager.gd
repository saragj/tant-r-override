extends Node

const LOCALE_PATHS = {
	"en": "res://assets/i18n/en.json",
	"es": "res://assets/i18n/es.json",
	"ja": "res://assets/i18n/ja.json",
}

const DEFAULT_LOCALE = "en"

func _ready() -> void:
	_load_translations()
	TranslationServer.set_locale(DEFAULT_LOCALE)

func _load_translations() -> void:
	for locale: String in LOCALE_PATHS.keys():
		var json_path = LOCALE_PATHS[locale]
		var translation = Translation.new()
		translation.locale = locale

		# Cargar JSON
		var json = JSON.new()
		var file = FileAccess.open(json_path, FileAccess.READ)
		if file:
			var error = json.parse(file.get_as_text())
			if error == OK:
				var data = json.data as Dictionary
				# Añadir cada clave-valor a la traducción
				for key: String in data.keys():
					var value = data[key]
					translation.add_message(key, value)

				# Registrar la traducción en el servidor
				TranslationServer.add_translation(translation)
			else:
				push_error("Failed to parse JSON: %s" % json_path)
		else:
			push_error("Failed to open file: %s" % json_path)

func set_locale(locale: String) -> void:
	if LOCALE_PATHS.has(locale):
		TranslationServer.set_locale(locale)
	else:
		push_error("Unsupported locale: %s" % locale)

func get_current_locale() -> String:
	return TranslationServer.get_locale()

func get_available_locales() -> Array[String]:
	return LOCALE_PATHS.keys()
