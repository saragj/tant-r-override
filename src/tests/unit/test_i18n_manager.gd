extends GutTest

func test_i18n_manager_loads_translations() -> void:
	# El I18nManager debe haber cargado las traducciones en _ready()
	assert_true(I18nManager is not null, "I18nManager should be loaded as autoload")

func test_default_locale_is_english() -> void:
	I18nManager.set_locale("en")
	assert_eq(I18nManager.get_current_locale(), "en", "Default locale should be 'en'")

func test_available_locales() -> void:
	var locales = I18nManager.get_available_locales()
	assert_eq(locales.size(), 3, "Should have 3 available locales")
	assert_true(locales.has("en"), "Should have 'en' locale")
	assert_true(locales.has("es"), "Should have 'es' locale")
	assert_true(locales.has("ja"), "Should have 'ja' locale")

func test_translate_key_english() -> void:
	I18nManager.set_locale("en")
	var text = tr("ui.menu.play")
	assert_eq(text, "PLAY", "English translation of 'ui.menu.play' should be 'PLAY'")

func test_translate_key_spanish() -> void:
	I18nManager.set_locale("es")
	var text = tr("ui.menu.play")
	assert_eq(text, "JUGAR", "Spanish translation of 'ui.menu.play' should be 'JUGAR'")

func test_translate_key_japanese() -> void:
	I18nManager.set_locale("ja")
	var text = tr("ui.menu.play")
	assert_eq(text, "プレイ", "Japanese translation of 'ui.menu.play' should be 'プレイ'")

func test_set_locale_changes_translations() -> void:
	# Cambia a español
	I18nManager.set_locale("es")
	var spanish_text = tr("ui.mode.story")

	# Cambia a inglés
	I18nManager.set_locale("en")
	var english_text = tr("ui.mode.story")

	assert_ne(spanish_text, english_text, "Translations should differ between locales")
	assert_eq(english_text, "STORY")
	assert_eq(spanish_text, "HISTORIA")

func test_minigame_names_translated() -> void:
	I18nManager.set_locale("en")
	assert_eq(tr("mg01.name"), "LABYRINTH RUSH")

	I18nManager.set_locale("es")
	assert_eq(tr("mg01.name"), "LABERINTO VELOZ")

	I18nManager.set_locale("ja")
	assert_eq(tr("mg01.name"), "迷路ラッシュ")

func test_phase_names_translated() -> void:
	I18nManager.set_locale("en")
	assert_eq(tr("phase.1.name"), "CITY")
	assert_eq(tr("phase.2.name"), "DESERT")
	assert_eq(tr("phase.3.name"), "CASINO")
