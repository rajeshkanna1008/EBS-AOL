set serveroutput on
declare
v_user_name varchar2(255):=upper('PRA');
cursor c1 is
select r.responsibility_key,
a.application_short_name,
r.RESPONSIBILITY_NAME
from
fnd_responsibility_vl r,
fnd_application_vl a
where 
a.APPLICATION_ID=R.APPLICATION_ID
and RESPONSIBILITY_NAME in( 'MRC, USD Assets Reporting',
                            'MRC, USD Projects Reporting');
begin
for rec in c1
loop
fnd_user_pkg.DELRESP (username        => v_user_name,
                       resp_app       => rec.application_short_name,
					   resp_key       => REC.RESPONSIBILITY_KEY,
					   security_group => 'STANDARD'
					                                 );
dbms_output.put_line(rec.RESPONSIBILITY_NAME||'resposibility removed for user  '||v_user_name);
commit;
end loop;

end;







