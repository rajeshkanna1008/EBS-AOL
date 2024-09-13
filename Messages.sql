SET serveroutput ON

DECLARE
    my_message VARCHAR2(100);
BEGIN
    --Initialise Apps Session
    fnd_global.apps_initialize(user_id      => 1014765,
                               resp_id      => 20419,
                               resp_appl_id => 0); 
    --Clear the existing session
    fnd_message.clear;
    
    --Set the message name
    FND_MESSAGE.SET_NAME('FND','XXX_TEST_MSG1');
--    
--    fnd_message.set_token('USERNAME', fnd_global.user_name); 
--    fnd_message.set_token('TIME', to_char(sysdate, 'DD-MM-YYYY HH24:MI:SS'));

FND_MESSAGE.SET_TOKEN('TIMESTAMP',to_char(SYSDATE,'DD-MM-YYYY HH:MI:SS'));
FND_MESSAGE.SET_TOKEN('USERNAME',FND_GLOBAL.USER_NAME);
    
    --Retrieve the message
    my_message := fnd_message.get;

    --Output the message
    dbms_output.put_line(my_message);
END;
