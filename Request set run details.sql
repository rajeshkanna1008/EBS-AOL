SELECT DISTINCT r.request_id
      , u.user_name requestor
      , u.description requested_by
      , CASE
           WHEN pt.user_concurrent_program_name = 'Reuqest Set name'
              THEN DECODE(
                  r.description
                   , NULL
				   , pt.user_concurrent_program_name
                   , r.description|| ' ('|| pt.user_concurrent_program_name|| ')')
           ELSE pt.user_concurrent_program_name
        END job_name
      , u.email_address
      , frt.responsibility_name requested_by_resp
      , r.request_date
      , r.requested_start_date
      , DECODE(
           r.hold_flag
         , 'Y', 'Yes'
         , 'N', 'No'
        ) on_hold
      , r.printer
      , r.number_of_copies print_count
      , r.argument_text PARAMETERS
      , r.resubmit_interval resubmit_every
      , r.resubmit_interval_unit_code resubmit_time_period
      , TO_CHAR((r.requested_start_date), 'HH24:MI:SS') start_time,
        NVL2(
           r.resubmit_interval
         , 'Periodically'
         , NVL2(
              r.release_class_id
            , 'On specific days'
            , 'Once'
           )
        ) AS schedule_type
   FROM apps.fnd_user u
      , apps.fnd_printer_styles_tl s
      , apps.fnd_concurrent_requests r
      , apps.fnd_responsibility_tl frt
      , apps.fnd_concurrent_programs_tl pt
      , apps.fnd_concurrent_programs pb
  WHERE pb.application_id = r.program_application_id
    AND r.responsibility_id = frt.responsibility_id
    AND pb.concurrent_program_id = pt.concurrent_program_id
    AND u.user_id = r.requested_by
    AND s.printer_style_name(+) = r.print_style 
    AND pb.concurrent_program_id = r.concurrent_program_id
    AND pb.application_id = pt.application_id
    AND pt.user_concurrent_program_name = 'Report Set'