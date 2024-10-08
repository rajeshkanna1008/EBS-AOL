DECLARE
   v_enabled_flag         VARCHAR2 (2)      := 'Y';
   v_summary_flag         VARCHAR2 (2)      := 'Y';
   v_start_date_active    DATE              := SYSDATE;
   v_error_msg            VARCHAR2 (1000)   := NULL;
   v_who_type             fnd_flex_loader_apis.who_type;
   v_request_id           NUMBER;
   v_rec_success          NUMBER;
   v_rec_error            NUMBER;
   v_rec_cnt              NUMBER            := 0;
   v_user_id              NUMBER            := fnd_global.user_id;
   v_login_id             NUMBER            := fnd_global.login_id;
   v_req_id               NUMBER            := fnd_global.conc_request_id;
   v_value_set_name       VARCHAR2 (50)     := 'TESTVALUESET';
   v_value_set_value      VARCHAR2 (50)     := 'SAMPLEVALUE';
BEGIN
   v_who_type.created_by 		:= v_user_id;
   v_who_type.creation_date 	:= SYSDATE;
   v_who_type.last_updated_by 	:= v_user_id;
   v_who_type.last_update_date 	:= SYSDATE;
   v_who_type.last_update_login := v_login_id;

   BEGIN
      fnd_flex_values_pkg.load_row
               (x_flex_value_set_name        	  => v_value_set_name,
                x_parent_flex_value_low     	  => NULL,
                x_flex_value                      => v_value_set_value,
                x_who                             => v_who_type,
                x_enabled_flag                    => v_enabled_flag,
                x_summary_flag                    => v_summary_flag,
                x_start_date_active               => v_start_date_active,
                x_end_date_active                 => NULL,
                x_parent_flex_value_high   		  => NULL,
                x_structured_hierarchy_level  	  => NULL,
                x_hierarchy_level                 => NULL,
                x_compiled_value_attributes  	  => NULL,
                x_value_category                  => NULL,
                x_attribute1                      => NULL,
                x_attribute2                      => NULL,
                x_attribute3                      => NULL,
                x_attribute4                      => NULL,
                x_attribute5                      => NULL,
                x_attribute6                      => NULL,
                x_attribute7                      => NULL,
                x_attribute8                      => NULL,
                x_attribute9                      => NULL,
                x_attribute10                     => NULL,
                x_attribute11                     => NULL,
                x_attribute12                     => NULL,
                x_attribute13                     => NULL,
                x_attribute14                     => NULL,
                x_attribute15                     => NULL,
                x_attribute16                     => NULL,
                x_attribute17                     => NULL,
                x_attribute18                     => NULL,
                x_attribute19                     => NULL,
                x_attribute20                     => NULL,
                x_attribute21                     => NULL,
                x_attribute22                     => NULL,
                x_attribute23                     => NULL,
                x_attribute24                     => NULL,
                x_attribute25                     => NULL,
                x_attribute26                     => NULL,
                x_attribute27                     => NULL,
                x_attribute28                     => NULL,
                x_attribute29                     => NULL,
                x_attribute30                     => NULL,
                x_attribute31                     => NULL,
                x_attribute32                     => NULL,
                x_attribute33                     => NULL,
                x_attribute34                     => NULL,
                x_attribute35                     => NULL,
                x_attribute36                     => NULL,
                x_attribute37                     => NULL,
                x_attribute38                     => NULL,
                x_attribute39                     => NULL,
                x_attribute40                     => NULL,
                x_attribute41                     => NULL,
                x_attribute42                     => NULL,
                x_attribute43                     => NULL,
                x_attribute44                     => NULL,
                x_attribute45                     => NULL,
                x_attribute46                     => NULL,
                x_attribute47                     => NULL,
                x_attribute48                     => NULL,
                x_attribute49                     => NULL,
                x_attribute50                     => NULL,
                x_attribute_sort_order   		  => NULL,
                x_flex_value_meaning     		  => v_value_set_value,
                x_description                     => v_value_set_value
               );
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.put_line ('Error is ' || SUBSTR (SQLERRM, 1, 1000));
   END;
END; 