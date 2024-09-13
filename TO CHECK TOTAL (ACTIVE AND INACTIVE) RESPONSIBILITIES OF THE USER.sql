SELECT b.user_name,
         b.user_id,
         b.start_date,
         b.end_date,        
         b.description,
         ftl.application_name,
         c.responsibility_name,
         a.start_date responsibility_start_date,
         a.end_date responsibility_end_date,
         a.description
    FROM fnd_user_resp_groups_direct a,
         fnd_user b,
         fnd_responsibility_vl c,        
         FND_APPLICATION FA,
         fnd_application_tl ftl
   WHERE a.user_id = b.user_id
     AND a.responsibility_id = c.responsibility_id
     AND fa.application_id = a.responsibility_application_id
     AND fa.application_id = ftl.application_id
     AND FTL.LANGUAGE   = USERENV('LANG')
     /*AND SYSDATE BETWEEN a.start_date AND NVL(a.end_date,SYSDATE + 1)
     AND SYSDATE BETWEEN B.START_DATE AND NVL(B.END_DATE,SYSDATE + 1)
     AND SYSDATE BETWEEN C.START_DATE AND NVL(C.END_DATE,SYSDATE + 1)*/
     AND b.user_name = '<USER_NAME>';
