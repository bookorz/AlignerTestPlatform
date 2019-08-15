function [rslt,ack,t] = serial_command(cmd,COM)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%fid_log = fopen('aligner_cmd.txt', 'a');
formatOut = 'yyyymmdd';
fileName = strcat('aligner_cmd_', datestr(now,formatOut),'.txt');
fid_log = fopen(fileName, 'a');
clock_log = clock;
% clear all; clc; close all;
if nargin<2, COM='COM3'; end
% % Create serial object 's'. Specify server machine and port number.
% s = serial(COM,'BaudRate',38400,'DataBits',8);
% set(s, 'Terminator', 'CR');
%
% % Open connection to the server.
% fopen(s);

s = instrfindall('Port',COM);
if (get(s, 'BytesAvailable') ~= 0)
    DataReceived = fscanf(s);
end

% Transmit data to the server (or a request for data from the server).
fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',cmd,'\r\n'], clock_log);
if cmd == 0
    fprintf(s, '$1CMD:HOME_');
elseif cmd == 1
    fprintf(s, '$1CMD:ALIGN:0');
elseif cmd == 2
    fprintf(s, '$1CMD:ALIGN:045000,0,2,00,30,15,9'); %300 wafer
elseif cmd == 3
    fprintf(s, '$1CMD:MOVED:1,2,+00001000');
elseif cmd == 4
    fprintf(s, '$1CMD:MOVED:1,2,-00001000');
elseif cmd == 5
    fprintf(s, '$1CMD:MOVED:2,2,+00001000');
elseif cmd == 6
    fprintf(s, '$1CMD:MOVED:2,2,-00001000');
elseif cmd == 7
    fprintf(s, '$1CMD:MOVED:3,2,+00001000');
elseif cmd == 8
    fprintf(s, '$1CMD:MOVED:3,2,-00001000');
elseif cmd == 9
    fprintf(s, '$1CMD:MOVED:3,2,-00360000');
elseif cmd == 10
    fprintf(s, '$1CMD:MOVED:3,2,+00360000');
elseif cmd == 11
    fprintf(s, '$1CMD:MOVED:3,2,-00090000');
elseif cmd == 12
    fprintf(s, '$1CMD:ALIGN:0,0,2,00,80,00');
elseif cmd == 13
    fprintf(s, '$1CMD:ALIGN:1,1,1,00,00,50,9');
elseif cmd == 14
    fprintf(s, '$1CMD:EORG_:03');
elseif cmd == 15
    fprintf(s, '$1CMD:WHLD_:1');
elseif cmd == 16
    fprintf(s, '$1CMD:WRLS_:1');
elseif cmd == 17
    fprintf(s, '$1CMD:MOVED:3,2,+00000100');
elseif cmd == 18
    fprintf(s, '$1CMD:MOVED:3,2,-00000100');
elseif cmd == 19
    fprintf(s, '$1CMD:MOVED:3,1,+00022000');
elseif cmd == 20
    fprintf(s, '$1CMD:MOVED:3,1,+00022100');
elseif cmd == 21
    fprintf(s, '$1CMD:MOVED:3,1,+00022200');
elseif cmd == 22
    fprintf(s, '$1CMD:MOVED:1,1,+00056600');
elseif cmd == 23
    fprintf(s, '$1CMD:MOVED:1,1,+00056700');
elseif cmd == 24
    fprintf(s, '$1CMD:MOVED:1,1,+00056800');
elseif cmd == 25
    fprintf(s, '$1CMD:MOVED:2,1,+00016200');
elseif cmd == 26
    fprintf(s, '$1CMD:MOVED:2,1,+00016300');
elseif cmd == 27
    fprintf(s, '$1CMD:MOVED:2,1,+00016400');
else
    fprintf(s, cmd);
end

% i = 0;
% while (get(s, 'BytesAvailable') == 0)
%   i=i+1;
%   if i > 1000
%       break;
%   end
% end
% DataReceived = fscanf(s);

ackTimeout = tic;

while (get(s, 'BytesAvailable') == 0)
    t = toc(ackTimeout);
    if t > 3.0
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ','ack timeout','\r\n'], clock_log);
        break;
    end
end
if (get(s, 'BytesAvailable') ~= 0)
    DataReceived = fscanf(s);
end

MotionTimeout = tic;

while (get(s, 'BytesAvailable') == 0)
    t2 = toc(MotionTimeout);
    %fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ','motion timeout t:', num2str(roundn(t2,-3)) ,'\r\n'], clock);
    if t2 > 60.0        
        break;
    end
end
if (get(s, 'BytesAvailable') ~= 0)
    DataReceived = fscanf(s);
end


if DataReceived ~= 0
    rslt = 0;
    ack = DataReceived;
    clock_log = clock;
    fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',ack,'\r\n'], clock_log);
else
    rslt = 1;
    ack = 9;
end
fclose(fid_log);
% % Disconnect and clean up the server connection.
% fclose(s);
% delete(s);
% clear s;

end