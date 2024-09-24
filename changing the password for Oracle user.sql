SET SERVEROUTPUT ON
DECLARE
  v_user_name    VARCHAR2(30):= UPPER('5002');
  v_new_password VARCHAR2(30):= 'Welcome@1';
  v_status       BOOLEAN;
BEGIN
  v_status   := fnd_user_pkg.ChangePassword ( username => v_user_name, 
                                              newpassword => v_new_password 
                                            );
  IF v_status  THEN
    dbms_output.put_line ('The password reset successfully for the User:'||v_user_name);
    COMMIT;
  ELSE
    DBMS_OUTPUT.put_line ('Unable to reset password due to'||SQLCODE||' '||SUBSTR(SQLERRM, 1, 100));
    ROLLBACK;
  END IF;
END;