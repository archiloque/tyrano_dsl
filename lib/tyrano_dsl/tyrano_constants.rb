require_relative 'tyrano_dsl'

# Constants used to access Tyrano data
module TyranoDsl::TyranoConstants

  BUILDER_CONFIG_FILE = ['builder_config.json']

  CHARA_DEFINE_FILE = ['data', 'scenario', 'system', 'chara_define.ks']

  CHARACTER_IMAGE_DIRECTORY = ['data', 'fgimage']

  CHARACTER_IMAGE_FULL_DIRECTORY = CHARACTER_IMAGE_DIRECTORY + ['chara']

  BACKGROUND_IMAGE_DIRECTORY = ['data', 'bgimage']

  BUILDER_CONFIG_VARIABLE_PATH = 'map_var'

  BUILDER_CONFIG_CHARACTERS_PATH = 'map_chara'

  SCENE_DIRECTORY = ['data', 'scenario']

  SCENE_SYSTEM_DIRECTORY = SCENE_DIRECTORY + ['system']

end