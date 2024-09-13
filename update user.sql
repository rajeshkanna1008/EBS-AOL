DECLARE
    v_user_name      VARCHAR2(100) := 'TEST_USER';
    v_email_address  VARCHAR2(100) := 'test@xyz.com';
BEGIN
   fnd_user_pkg.updateuser(x_user_name 					=> v_user_name, 
						   x_owner 						=> NULL,
                           x_unencrypted_password 		=> NULL,
                           x_session_number 			=> 0,
                           x_start_date 				=> NULL,
                           x_end_date 					=> NULL,
                           x_last_logon_date 			=> NULL,
                           x_description 				=> NULL,
                           x_password_date 				=> NULL,
                           x_password_accesses_left 	=> NULL,
                           x_password_lifespan_accesses => NULL,
                           x_password_lifespan_days 	=> NULL,
                           x_employee_id				=> NULL,
                           x_email_address 				=> v_email_address,
                           x_fax 						=> NULL,
                           x_customer_id 				=> NULL,
                           x_supplier_id 				=> NULL,
                           x_user_guid 					=> NULL,
                           x_change_source 				=> NULL);
   --COMMIT;
           dbms_output.put_line('User '
                         || v_user_name
                         || ' is Updated successfully');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error encountered while updating the user and the error is ' || sqlerrm);
END;

/* Output we got after execution is
   User TEST_USER is Updated successfully.

We can cross verify if the email_address is update for the user ‘TEST_USER’ by using the following query
 */
SELECT
    user_id,
    user_name,
    creation_date,
    start_date,
    end_date,
    description,
    email_address
  FROM fnd_user
WHERE
    user_name = 'TEST_USER'