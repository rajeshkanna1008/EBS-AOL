SELECT DISTINCT fcpl.user_concurrent_program_name,
                fcp.concurrent_program_name,
                fapp.application_name,
                frg.request_group_name,
                fnrtl.responsibility_name
  FROM apps.fnd_request_groups         frg,
       apps.fnd_application_tl         fapp,
       apps.fnd_request_group_units    frgu,
       apps.fnd_concurrent_programs    fcp,
       apps.fnd_concurrent_programs_tl fcpl,
       apps.fnd_responsibility         fnr,
       apps.fnd_responsibility_tl      fnrtl
 WHERE     frg.application_id = fapp.application_id
       AND frg.application_id = frgu.application_id
       AND frg.request_group_id = frgu.request_group_id
       AND frg.request_group_id = fnr.request_group_id
       AND fnr.responsibility_id = fnrtl.responsibility_id
       AND frgu.request_unit_id = fcp.concurrent_program_id
       AND frgu.unit_application_id = fcp.application_id
       AND fcp.concurrent_program_id = fcpl.concurrent_program_id
       AND fcpl.user_concurrent_program_name LIKE
              '<Your concurrent program name>'
       AND fnrtl.LANGUAGE = 'US'
       AND fapp.LANGUAGE = 'US';