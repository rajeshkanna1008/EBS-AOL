DECLARE
   v_user_name          VARCHAR2 (100) := 'TEST_USER';
   v_new_password       VARCHAR2 (100) := :NEWPASSWORD;
   v_status             BOOLEAN        := NULL;
BEGIN
   v_status := fnd_user_pkg.changepassword (v_user_name, v_new_password);

  COMMIT;
   DBMS_OUTPUT.put_line (   'Password is changed successfully for the user '
                         || v_user_name
                        );
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line
         (   'Error encountered while setting new password to the user and the error is '
          || SQLERRM
         );
END;
