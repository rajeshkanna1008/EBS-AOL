select * from v$parameter where name like '%utl_file%';
--===========================================
set serveroutput on;

create or replace procedure xxx_emp (errbuf out varchar2,
                                     retcode out varchar2)
as
cursor xx_emp is
    select emp_id,emp_name,dob,hiredate,salary from emp;
    file_name utl_file.file_type;
--    l_count number := 0;
begin
    file_name := utl_file.fopen('UTL_FILE','XXX_EMP_DTL.txt','W');
	
    for i in xx_emp 
    loop
        --l_count := l_count+1;
        utl_file.put_line(file_name,i.emp_id||','||i.emp_name||','||i.dob||','||i.hiredate||','||i.salary);
    end loop;
    utl_file.fclose(file_name);
exception 
    when utl_file.invalid_operation
    then
    dbms_output.put_line('invalid operation');
    utl_file.fclose_all;
	dbms_output.put_line('File created.');
end;
--=========================================

set serveroutput on;

declare
l_errbuf varchar2(20);
l_retcode varchar2(20);
begin
xxx_emp(l_errbuf,l_retcode);
dbms_output.put_line('Status ---> '||l_retcode);
end;

--=============================================

CREATE OR REPLACE DIRECTORY utl_file AS 'E:';

GRANT READ, WRITE ON DIRECTORY utl_file TO APEX;

grant  execute on sys.utl_file to apex;

select * from v$parameter where name like '%utl%';

 
CREATE DIRECTORY utl_file AS 'E:\sql';


SELECT * 
FROM all_objects
WHERE object_name ='UTL_FILE';

--======================================
UTL_FILE
--======================================

-- Check for UTL_FILE package is exist or not
select * from all_objects
    where object_name like 'UTL_FILE';
    
-- Check if the logged in user has execute privilege on UTL_FILE
 
select grantee
from all_tab_privs
where table_name = 'UTL_FILE';

--UTL_FILE uses Oracle directories, not OS directories. Do not write file location like this: D:\app

--Instead, login as SYS and create an Oracle directory with a reference to a valid OS directory path.

create or replace directory utl_dir
  as 'D:\app';
 
--Directory created.
--Grant read and write privilege to the application user (or PUBLIC) on the new directory.

grant read, write
    on directory utl_dir
    to apex;
 
--Grant succeeded.
--Note that the directory path can be case-sensitive

-- Check if ‘file location’ in the script exists on the Oracle server

select directory_name
     , directory_path
     from all_directories;
 
-- DIRECTORY_NAME   DIRECTORY_PATH
---------------- --------------
-- UTL_FILE          E:\sql
-- ORACLECLRDIR      C:\Oracledb\WINDOWS.X64_193000_db_home\bin\clr

--Check if ‘file location’ in the script has write permissions for the logged in user

 select grantee
    , privilege
    from all_tab_privs
    where table_name = 'UTL_FILE';

select * from all_tab_privs;
-- GRANTEE   PRIVILEGE
--------- ------------------------
--PUBLIC	    EXECUTE
--APEX	        EXECUTE
--APEX	        READ
--APEX	        WRITE
--ORACLE_OCM    EXECUTE
--WMSYS	        EXECUTE
--ORDSYS	    EXECUTE
--ORDPLUGINS	EXECUTE

--=======================================

Shell Script cheat sheet
**************************
 https://devhints.io/bash  *						   
**************************

--================================================================

-- Inbound

options (skip = 1)
load data
infile 'items.txt'
truncate into table xx_emp2
fields terminated by ','
(emp_id ,
	Organization_Id ,
	Name,
	Website,
	Country,
	Description,
	Founded,
	Industry,
	Number_of_employees)
	
--save the above code with .ctl extension (cntl_file.ctl)

sql Loader syntax = sqlldr username/password control = control file name along with extension

sqlldr APEX/Rajesh11 control = cntl_file.ctl
 
--==============================================================================================

CREATE OR REPLACE PROCEDURE insert_data_from_file AS
  file_handle UTL_FILE.FILE_TYPE;
  file_line   VARCHAR2(4000);
BEGIN
  -- Open the file for reading
  file_handle := UTL_FILE.FOPEN('UTL_FILE', 'XXX_EMP_DTL.txt', 'R');
  
  -- Loop through the file and insert data into the table
  LOOP
    UTL_FILE.GET_LINE(file_handle, file_line);
    -- You can parse and process the data as needed
    INSERT INTO emp (emp_id,emp_name,dob,hiredate,salary) 
             values (regexp_substr(file_line, '[^,]+', 1, 1),
                     regexp_substr(file_line, '[^,]+', 1, 2),
                     regexp_substr(file_line, '[^,]+', 1, 3),
                     regexp_substr(file_line, '[^,]+', 1, 4),
                     regexp_substr(file_line, '[^,]+', 1, 5));
    -- Commit after inserting data if needed
     COMMIT;
  END LOOP;
  
  -- Close the file
  UTL_FILE.FCLOSE(file_handle);
EXCEPTION
  WHEN UTL_FILE.INVALID_PATH THEN
    DBMS_OUTPUT.PUT_LINE('Invalid path for the directory.');
  WHEN UTL_FILE.INVALID_MODE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file mode.');
  WHEN UTL_FILE.INVALID_FILEHANDLE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
  WHEN UTL_FILE.INVALID_OPERATION THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file operation.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

--====================================================

BEGIN
  INSERT_DATA_FROM_FILE;
--rollback;
END;
/

select * from emp;


--============================

CREATE OR REPLACE PROCEDURE insert_data_from_file (l_file_loc in varchar2)AS
  file_handle UTL_FILE.FILE_TYPE;
  file_line   VARCHAR2(4000);
  v_first_row BOOLEAN := TRUE;
BEGIN
  -- Open the file for reading
  file_handle := UTL_FILE.FOPEN('UTL_FILE', l_file_loc, 'R');
  
  -- Loop through the file and insert data into the table
  LOOP
    UTL_FILE.GET_LINE(file_handle, file_line); -- it is used to read data line by line.
	
	IF v_first_row THEN
      v_first_row := FALSE;
      CONTINUE; -- Skip this iteration and continue with the next
    END IF;

    INSERT INTO emp (emp_id,emp_name,dob,hiredate,salary) 
             values (regexp_substr(file_line, '[^,]+', 1, 1),
                     regexp_substr(file_line, '[^,]+', 1, 2),
                     regexp_substr(file_line, '[^,]+', 1, 3),
                     regexp_substr(file_line, '[^,]+', 1, 4),
                     regexp_substr(file_line, '[^,]+', 1, 5));

     COMMIT;
  END LOOP;
  
  -- Close the file
  UTL_FILE.FCLOSE(file_handle);
EXCEPTION
  WHEN UTL_FILE.INVALID_PATH THEN
    DBMS_OUTPUT.PUT_LINE('Invalid path for the directory.');
  WHEN UTL_FILE.INVALID_MODE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file mode.');
  WHEN UTL_FILE.INVALID_FILEHANDLE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
  WHEN UTL_FILE.INVALID_OPERATION THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file operation.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

BEGIN
  INSERT_DATA_FROM_FILE('XXX_EMP_DTL.txt');
END;

/

select * from emp;

truncate table emp;

--==========================================================
************************************************************

CREATE OR REPLACE PROCEDURE insert_data_from_file (l_file_loc in varchar2)AS
  file_handle UTL_FILE.FILE_TYPE;
  file_line   VARCHAR2(4000);
  v_first_row BOOLEAN := TRUE;
BEGIN
  -- Open the file for reading
  file_handle := UTL_FILE.FOPEN('UTL_FILE', l_file_loc, 'R');
  
  -- Loop through the file and insert data into the table
  LOOP
    UTL_FILE.GET_LINE(file_handle, file_line); -- it is used to read data line by line.
	
	IF v_first_row THEN
      v_first_row := FALSE;
      CONTINUE; -- Skip this iteration and continue with the next
    END IF;

    INSERT INTO emp (emp_id,emp_name,dob,hiredate,salary) 
             values (regexp_substr(file_line, '[^,]+', 1, 1),
                     regexp_substr(file_line, '[^,]+', 1, 2),
                     regexp_substr(file_line, '[^,]+', 1, 3),
                     regexp_substr(file_line, '[^,]+', 1, 4),
                     regexp_substr(file_line, '[^,]+', 1, 5));

     COMMIT;
  END LOOP;
  
  -- Close the file
  UTL_FILE.FCLOSE(file_handle);
EXCEPTION
  WHEN UTL_FILE.INVALID_PATH THEN
    DBMS_OUTPUT.PUT_LINE('Invalid path for the directory.');
  WHEN UTL_FILE.INVALID_MODE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file mode.');
  WHEN UTL_FILE.INVALID_FILEHANDLE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
  WHEN UTL_FILE.INVALID_OPERATION THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file operation.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

BEGIN
  INSERT_DATA_FROM_FILE('XXX_EMP_DTL.txt');
--rollback;
END;
/

select * from emp;

truncate table emp;

-- Global temp tables



***************************************************************

--global temporary table
create global temporary table test33(
                                     id number,
                                     name varchar2(200)
                                     )on commit delete rows; -- transaction specific
                                     
insert into test33 values(1,'Raj');
commit;
select * from test33;     


create global temporary table test34(
                                     id number,
                                     name varchar2(200)
                                     )on commit preserve rows; --session specific 

insert into test34 values(1,'Raj');
commit;
select * from test34;  

-- private temporary table.
create private temporary table ora$ppt_temp1(id number, name varchar2(200)) on commit preserve definition;

CREATE PRIVATE TEMPORARY TABLE ora$ppt_temp2(
    id INT,
    name VARCHAR2(100)
) ON COMMIT PRESERVE DEFINITION;



***********************************************************************
155290297
Madupu1108@



Hi Sir,
Below are my Bank Details.

Bank Name: Union Bank Of India
Branch: Sulthanabad.
Account Number:122710100097599
Account Name: MADUPU RAJESH
IFSC: UBIN0812277

***************************
select * from fnd_concurrent_programs_vl where user_concurrent_program_name = 'Payables Open Interface Import'; 

select * from fnd_concurrent_programs where concurrent_program_name = 'INCIAR'; 

select * from fnd_concurrent_requests where concurrent_program_id = 33263;

select * from fnd_responsibility_vl where responsibility_id = 57017;

select * from fnd_application where application_id = 200;

select * from fnd_user_resp_groups_direct where responsibility_id = 20634;

select * from fnd_lookup_values_vl where lookup_type = 'XXX_EDI_SUPPLIER_LIST';