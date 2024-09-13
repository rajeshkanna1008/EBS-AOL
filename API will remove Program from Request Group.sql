BEGIN
  FND_PROGRAM.remove_from_group(‘TEST_SHORT_PROG’ -- program_short_name
  , ‘System Administration’                       -- application
  , ‘System Administrator Reports’                -- Report Group Name
  , ‘Application Object Library’);                -- Report Group Application
  COMMIT;
END;