function [rslt,ack] = serial_z(cmd,COM)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% clear all; clc; close all;
if nargin<2, COM='COM4'; end
% % Create serial object 's'. Specify server machine and port number. 
% s = serial(COM,'BaudRate',38400,'DataBits',8);
% % set(s, 'Terminator', 'CR'); 
% % set(s, 'BytesAvailableFcnMode', 'byte'); 
% % set(s, 'BytesAvailableFcnCount', 8); 
% set(s, 'Timeout', 0.1); 
% 
% % Open connection to the server. 
% fopen(s);

s = instrfindall('Port',COM);

% Transmit data to the server (or a request for data from the server). 
% if cmd == 0
%     fprintf(s, '$1GET:POS__:1,1');
% elseif cmd == 1
%     fprintf(s, '$1GET:ALIGN:0');
% elseif cmd == 2
%     fprintf(s, '$1GET:POS__:2,1');
% else
%     fprintf(s, cmd);
% end

if cmd == 0 %SERVO ON
    txdata = ['01';'05';'00';'30';'FF';'00';'8C';'35'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec); 
    txdata = ['01';'05';'00';'19';'FF';'00';'5D';'FD'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
elseif cmd == 1 %SERVO OFF
    txdata = ['01';'05';'00';'30';'00';'00';'CD';'C5'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
elseif cmd == 2 %ORG
    txdata = ['01';'05';'00';'1C';'FF';'00';'4D';'FC'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
    txdata = ['01';'05';'00';'1C';'00';'00';'0C';'0C'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
elseif cmd == 3 %0MOVE
    txdata = ['01';'0F';'00';'10';'00';'08';'01';'00';'3F';'56'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
    txdata = ['01';'05';'00';'1A';'FF';'00';'AD';'FD'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
    txdata = ['01';'05';'00';'1A';'00';'00';'EC';'0D'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
elseif cmd == 4 %1MOVE
    txdata = ['01';'0F';'00';'10';'00';'08';'01';'01';'FE';'96'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
    txdata = ['01';'05';'00';'1A';'FF';'00';'AD';'FD'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
    txdata = ['01';'05';'00';'1A';'00';'00';'EC';'0D'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
elseif cmd == 5 %RESET
    txdata = ['01';'05';'00';'45';'FF';'00';'9D';'EF'];
    txdata_dec = hex2dec(txdata);
    fwrite(s,txdata_dec,'uint8');
    rxdata_dec = fread(s);
    rxdata = dec2hex(rxdata_dec);
end   
% i=0;
% while(1)
%     j = 0;
%     while (get(s, 'BytesAvailable') == 0) 
%       j=j+1;
%       if j > 1000
%           break;
%       end
%     end
%     DataReceived = fscanf(s);
%     if DataReceived == []
%         break;
%     end
%     if strncmp(DataReceived, '$1ACK:', 6)
%         break;
%     end
%     i=i+1;
%     data(i,:) = DataReceived;
% end

%     DataReceived = fscanf(s);
if rxdata ~= 0
    rslt = 0;
    ack = rxdata;
else
    rslt = 1;
    ack = 9;
end

    
% % Disconnect and clean up the server connection.
% fclose(s); 
% delete(s); 
% clear s;

end