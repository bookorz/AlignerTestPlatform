function [rslt,ack] = serial_set(cmd,COM)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% clear all; clc; close all;
if nargin<2, COM='COM3'; end
% % Create serial object 's'. Specify server machine and port number. 
% s = serial(COM,'BaudRate',38400,'DataBits',8);
% set(s, 'Terminator', 'CR'); 
% 
% % Open connection to the server. 
% fopen(s);

s = instrfindall('Port',COM);

while (get(s, 'BytesAvailable') ~= 0)
    DataReceived = fscanf(s);
end

% Transmit data to the server (or a request for data from the server). 
if cmd == 0
    fprintf(s, '$1SET:SP___:00');
elseif cmd == 1
    fprintf(s, '$1SET:SP___:20');
else
    fprintf(s, cmd);
end
i = 0;
while (get(s, 'BytesAvailable') == 0) 
      i=i+1;
      if i > 2000
          break;
      end
end
DataReceived = fscanf(s);
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

end