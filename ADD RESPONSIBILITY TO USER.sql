DECLARE
v_user_name varchar2(255):=upper('XX_AKHIL');
cursor c1 is
select r.responsibility_key,
a.application_short_name,
r.RESPONSIBILITY_NAME
from
fnd_responsibility_vl r,
fnd_application_vl a
where 
A.APPLICATION_ID=R.APPLICATION_ID
and r.RESPONSIBILITY_NAME = 'System Administrator';
begin
for rec in c1
loop
fnd_user_pkg.addresp (username        => v_user_name,
                    RESP_APP       => REC.APPLICATION_SHORT_NAME,
                    resp_key       => REC.RESPONSIBILITY_KEY,
                    security_group => 'STANDARD',
                    description     => null       ,
                    start_date     =>  sysdate      ,
                    END_DATE       => NULL         );
dbms_output.put_line(rec.RESPONSIBILITY_NAME||'resposibility assigend to user :'||v_user_name);
commit;
end loop;
exception 
when others then
NULL;
END;
/

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
and RESPONSIBILITY_NAME in( 'Application Developer',
                            'Functional Administrator');
begin
for rec in c1
loop
fnd_user_pkg.addresp (username        => v_user_name,
                       resp_app       => rec.application_short_name,
					   resp_key       => REC.RESPONSIBILITY_KEY,
					   security_group => 'STANDARD',
					   description     => null       ,
					   start_date     =>  sysdate      ,
					   end_date       => null         );
dbms_output.put_line(rec.RESPONSIBILITY_NAME||'resposibility assigend to user'||v_user_name);
commit;
end loop;
exception 
when others then
null;
end;