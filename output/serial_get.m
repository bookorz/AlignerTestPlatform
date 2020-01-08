function [rslt,ack,data] = serial_get(cmd,COM)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% clear all; clc; close all;
if nargin<2, COM='COM3'; end
% % Create serial object 's'. Specify server machine and port number.
% s = serial(COM,'BaudRate',38400,'DataBits',8);
formatOut = 'yyyymmdd';
fileName = strcat('cmd_log_', datestr(now,formatOut),'.txt');
fid_log = fopen(fileName, 'a');
%
% % Open connection to the server.
% fopen(s);

s = instrfindall('Port',COM);
set(s, 'Terminator', 'CR');
% Transmit data to the server (or a request for data from the server).
if cmd == 0
    fprintf(s, '$1GET:POS__:1,1');
elseif cmd == 1
    fprintf(s, '$1GET:ALIGN:0');
elseif cmd == 2
    fprintf(s, '$1GET:POS__:2,1');
else
    fprintf(s, cmd);
%     pause(1);
%     fprintf(s, cmd);
    fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',cmd,'\r\n'], clock);
end
i=0;
while(1)
    ackTimeout = tic;
    while (get(s, 'BytesAvailable') == 0)
       
        t = toc(ackTimeout);
        if t > 3.0

            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ','ack timeout','\r\n'], clock);
            break;
        end
    end
    %if (get(s, 'BytesAvailable') ~= 0)
        DataReceived = fscanf(s);
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',DataReceived,'\r\n'], clock);
    %end
    %     if DataReceived == []
    %         break;
    %     end
    
    i=i+1;
    data(i,:) = DataReceived;
    if strncmp(DataReceived, '$1ACK:', 6)
        break;
    end
end

%     DataReceived = fscanf(s);
if DataReceived ~= 0
    rslt = 0;
    ack = DataReceived;
else
    rslt = 1;
    ack = 9;
end


% % Disconnect and clean up the server connection.
% fclose(s);
% delete(s);
% clear s;
fclose(fid_log);
end