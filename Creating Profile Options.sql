DECLARE
   l_application_id 	 		NUMBER;
   l_profile_option_name 		VARCHAR2(30) := 'YOUR_PROFILE_OPTION_NAME';
   l_profile_option_value_type  VARCHAR2(30) := 'VARCHAR2'; -- Change to 'NUMBER' for numeric options
   l_user_or_site 				NUMBER := 1; -- 1 for User, 2 for Site
   l_status 					VARCHAR2(1);
BEGIN
   -- Get the Application ID for your application
   SELECT application_id
   INTO l_application_id
   FROM fnd_application_vl
   WHERE application_short_name = 'YOUR_APPLICATION_SHORT_NAME';

   -- Insert the profile option
   FND_PROFILE_OPTIONS.INSERT_ROW (
      application_id 			=> l_application_id,
      profile_option_name 		=> l_profile_option_name,
      profile_option_value_type => l_profile_option_value_type,
      user_or_site 				=> l_user_or_site,
      start_date_active 		=> SYSDATE,
      end_date_active 			=> NULL,
      user_profile_option_name 	=> NULL,
      description 				=> 'Your Profile Option Description',
      user_changeable 			=> 'Y', -- 'Y' for user-changeable, 'N' for not user-changeable
      site_changeable 			=> 'Y' -- 'Y' for site-changeable, 'N' for not site-changeable
   );

   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Profile option created successfully.');
END;
/
