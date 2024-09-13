set SERVEROUTPUT on; 

declare
V_VALUE_SET_NAME varchar2(255) :='xx_org_value';
V_TABLE_NAME varchar2(255) :='HR_ALL_ORGANIZATION_UNITS';
v_column_name varchar2(255) :='ORGANIZATION_ID';
begin
fnd_global.apps_initialize (user_id        => 1318,
                               resp_id        => 20420,
                               RESP_APPL_ID   => 1);
FND_FLEX_VAL_API.CREATE_VALUESET_TABLE (VALUE_SET_NAME => V_VALUE_SET_NAME ,
                                       FORMAT_TYPE   => 'char',
                                       MAXIMUM_SIZE => 20,
                                       SECURITY_AVAILABLE => 'NO Security',
                                       table_application => 'List of HR Organisations',
                                       TABLE_NAME   => V_TABLE_NAME,
                                       VALUE_COLUMN_NAME  => V_COLUMN_NAME,
                                      VALUE_COLUMN_TYPE => 'number' );   
--                                      VALUE_COLUMN_SIZE => 22,
--                                      where_order_by => 'SYSDATE BETWEEN NVL(date_from, SYSDATE)
--                                                        AND NVL (date_to, SYSDATE) ORDER BY name');
                                     
 commit;
   DBMS_OUTPUT.PUT_LINE ('succeefully created  VALUE SET    ' || V_VALUE_SET_NAME);                                     

END;