function rslt = serial_cam_capture(COM,Num)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% clear all; clc; close all;
if nargin<1, COM='COM2'; end
% % Create serial object 's'. Specify server machine and port number. 
% s = serial(COM,'BaudRate',38400,'DataBits',8);
% set(s, 'Terminator', 'CR'); 
% set(s, 'Timeout', 1); 
% 
% % Open connection to the server. 
% fopen(s);

s = instrfindall('Port',COM);

% Transmit data to the server (or a request for data from the server). 
% A = [37;67;77;68;58;83;84;65;84;13];
% fwrite(s, A);
% fprintf(s, '%CMD:STAT');
% 
% while (get(s, 'BytesAvailable') == 0) 
% end
% % s.BytesAvailable
% DataReceived = fscanf(s)
% if strcmp(DataReceived, '%ACK:STAT')
    fprintf(s, ['%CMD:CAP',num2str(Num)]);
    
    i = 0;
    while (get(s, 'BytesAvailable') == 0) 
      i=i+1;
      if i > 1000
          break;
      end
    end
    DataReceived_cam = fscanf(s);
    
    if strncmp(DataReceived_cam, ['%ACK:CAP',num2str(Num)], 9)
        rslt = 0;
    else
        rslt = 1;
    end
%     if strcmp(DataReceived, '%ACK:CAPT')
% 
%     else
% %         fprintf(s, '$CMD:STOP');
% %         while (get(s, 'BytesAvailable') == 0) 
% %         end
% %         DataReceived = fscanf(s)
%     end
% else
% %     fprintf(s, '$CMD:STOP');
% %     while (get(s, 'BytesAvailable') == 0) 
% %     end
% %     DataReceived = fscanf(s)
% end

% % Disconnect and clean up the server connection.
% fclose(s); 
% delete(s); 
% clear s;

end