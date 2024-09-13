
DECLARE
   l_ret_code VARCHAR2(1);
   l_msg_data VARCHAR2(2000);
BEGIN
   -- Specify the name and application of the profile option you want to delete
      l_ret_code 			:= FND_PROFILE_OPTIONS.DELETE_ROW(
      p_appl_short_name 	=> 'YOUR_APP_SHORT_NAME',
      p_profile_option_name => 'YOUR_PROFILE_OPTION_NAME',
      x_msg_data 			=> l_msg_data
   );

   IF l_ret_code = 'S' THEN
      DBMS_OUTPUT.PUT_LINE('Profile option deleted successfully.');
      COMMIT;
   ELSE
      DBMS_OUTPUT.PUT_LINE('Error: ' || l_msg_data);
   END IF;
END;