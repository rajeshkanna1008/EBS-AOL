DECLARE
   v_user_name     VARCHAR2 (100) := 'TEST_USER';
   v_owner         VARCHAR2 (50)  := NULL;
   v_password      VARCHAR2 (100) := :Password;
   v_description   VARCHAR2 (100) := 'NEW USER';
BEGIN
   fnd_user_pkg.createuser
                           (x_user_name                   => v_user_name,
                            x_owner                       => v_owner,
                            x_unencrypted_password        => v_password,
                            x_session_number              => 0,
                            x_start_date                  => SYSDATE,
                            x_end_date                    => NULL,
                            x_last_logon_date             => NULL,
                            x_description                 => v_description,
                            x_password_date               => NULL,
                            x_password_accesses_left      => NULL,
                            x_password_lifespan_accesses  => NULL,
                            x_password_lifespan_days      => NULL,
                            x_employee_id                 => NULL,
                            x_email_address               => NULL,
                            x_fax                         => NULL,
                            x_customer_id                 => NULL,
                            x_supplier_id                 => NULL,
                            x_user_guid                   => NULL,
                            x_change_source               => NULL
                           );
   COMMIT;
   DBMS_OUTPUT.put_line ('User ' || v_user_name || ' is created successfully');
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line
                (   'Error encountered while creating user and the error is '|| SQLERRM
                );
END;