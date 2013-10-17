require Padrino.root('config/sensitive_settings.rb')
Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = Sequel.connect(SensitiveSettings.database(Padrino.env), :loggers => [logger])
