DECLARE
   v_user_name            VARCHAR2 (100) := 'TEST_USER';
   v_responsibility_name  VARCHAR2 (100) := 'System Administrator';
   v_application_name     VARCHAR2 (100) := NULL;
   v_responsibility_key   VARCHAR2 (100) := NULL;
   v_security_group       VARCHAR2 (100) := NULL;
BEGIN
   SELECT fa.application_short_name,
                 fr.responsibility_key,
                 frg.security_group_key,                     
                 frt.description
      INTO  v_application_name,
                 v_responsibility_key,
                 v_security_group,
                 v_description
     FROM fnd_responsibility fr,
                 fnd_application fa,
                 fnd_security_groups frg,
                 fnd_responsibility_tl frt
    WHERE fr.application_id = fa.application_id
      AND    fr.data_group_id = frg.security_group_id
      AND    fr.responsibility_id = frt.responsibility_id
      AND    frt.LANGUAGE = USERENV ('LANG')
      AND    frt.responsibility_name = v_responsibility_name;

   fnd_user_pkg.delresp (username       => v_user_name,
                         resp_app       => v_application_name,
                         resp_key       => v_responsibility_key,
                         security_group => v_security_group
                                             );
   COMMIT;

   DBMS_OUTPUT.put_line (   'Responsiblity '
                         || v_responsibility_name
                         || ' is removed from the user '
                         || v_user_name
                         || ' Successfully'
                        );
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line
         (   'Error encountered while deleting responsibilty from the user and the error is '
          || SQLERRM
         );
END;