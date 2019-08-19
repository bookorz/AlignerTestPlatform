function aligner_autotest_calibration(action)
% aligner test gui
if nargin<1, action='initialize'; end
% LogPath = 'D:\AlignerTest.log';
% L = log4m.getLogger(LogPath);
% L.setLogLevel(L.ALL);
%fid_log = fopen('aligner_autotest_calibration_log.txt', 'a');
formatOut = 'yyyymmdd';
fileName = strcat('aligner_autotest_calibration_log_', datestr(now,formatOut),'.txt');
fid_log = fopen(fileName, 'a');
fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ','Program Start','\r\n'], clock);
switch(action)
    case 'initialize'	% 圖形視窗及UI控制物件的初始化。
        % 產生新圖形視窗，其左下角之座標為[30, 30]，
        % 長度為300，高度為200（均以Pixel為單位）
        set(0,'Units','pixels');
        scrsz = get(0,'ScreenSize');
        %         hFigure = figure('Name','Aligner Test Calibration', ...
        %             'NumberTitle','off', ...
        %             'tag', 'ui4figure', ...
        %             'OuterPosition', [1 scrsz(4)/3+1 scrsz(3)/2 scrsz(4)*2/3]);
        hFigure = figure('Name','Aligner Test Calibration', ...
            'NumberTitle','off', ...
            'tag', 'ui4figure', ...
            'OuterPosition', [1 50 940 700]);
        % 以寫入模式開啟txt檔案
        fid = fopen('testconfigure.txt');
        % 以浮點數格式寫入資料並換行
        default = fscanf(fid, '%s');
        % 關檔
        fclose(fid);
        default = regexp(default,',','split');
        
        waferRadius = str2num(char(default(1)));   %150000;
        testSpeed = str2num(char(default(2)));   %60;
        testCount = str2num(char(default(3)));   %30;
        angleNotch = str2num(char(default(4)));   %90000;
        offsetX = str2num(char(default(5)));   %2500;
        offsetY = str2num(char(default(6)));   %2500;
        offsetTheta = str2num(char(default(7)));   %90000;
        download_data = str2num(char(default(8)));  %1;
        path = default(9);   %'20180104test';
        path = path{1};
        y_start = str2num(char(default(10)));   %6;
        y_end = str2num(char(default(11)));   %8;
        %         bw_inverse = str2num(char(default(12)));   %1;
        threshold_gray = str2num(char(default(12)));   %40;
        threshold_filter = str2num(char(default(13)));   %100000;
        COM_cylinder = default(14);   %'COM4';
        COM_cylinder = COM_cylinder{1};
        COM_aligner = default(15);   %'COM3';
        COM_aligner = COM_aligner{1};
        COM_camera = default(16);   %'COM2';
        COM_camera = COM_camera{1};
        COM_cameraarc = default(17);   %'COM';
        COM_cameraarc = COM_cameraarc{1};
        Num = str2num(char(default(18)));   %0;
        xOffset = str2num(char(default(19)));   %0;
        picCount = str2num(char(default(20)));   %5;
        %	CheckBox
        %         hText_imageprocessheader = uicontrol('style', 'text', ...
        % 			'tag', 'ui4imageprocessheader', ...
        %             'horizontalalignment', 'left', ...
        % 			'string', 'Image Process', ...
        %             'unit','characters', ...
        % 			'position', [105, 23, 35, 2]);
        % 		hCheckBox_bwinverse = uicontrol('style', 'checkbox', ...
        % 			'tag', 'ui4bwinverse', ...
        % 			'string', 'B/W Inverse', ...
        %             'unit','characters', ...
        % 			'position', [105, 21, 35, 2], ...
        %             'value', bw_inverse);
        hText_loaddataheader = uicontrol('style', 'text', ...
            'tag', 'ui4loaddataheader', ...
            'horizontalalignment', 'left', ...
            'string', 'CCD & Encoder', ...
            'unit','characters', ...
            'position', [35, 3, 30, 2]);
        hCheckBox_loaddata = uicontrol('style', 'checkbox', ...
            'tag', 'ui4loaddata', ...
            'string', 'Download Data', ...
            'unit','characters', ...
            'position', [35, 1, 30, 2], ...
            'value', download_data);
        % 第二個UI控制物件，用以指定X軸及Y軸的格子點數目。
        hText_xoffsetheader = uicontrol('style', 'text', ...
            'tag', 'ui4xoffsetheader', ...
            'horizontalalignment', 'left', ...
            'string', 'X Offset (um)', ...
            'unit','characters', ...
            'position', [145, 23, 35, 2]);
        hEdit_xoffset = uicontrol('style', 'edit', ...
            'tag', 'ui4xoffset', ...
            'string', int2str(xOffset), ...
            'unit','characters', ...
            'position', [145, 21, 35, 2]);
        hText_waferradiusheader = uicontrol('style', 'text', ...
            'tag', 'ui4waferradiusheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Wafer Radius (um)', ...
            'unit','characters', ...
            'position', [35, 23, 30, 2]);
        hEdit_waferradius = uicontrol('style', 'edit', ...
            'tag', 'ui4waferradius', ...
            'string', int2str(waferRadius), ...
            'unit','characters', ...
            'position', [35, 21, 30, 2]);
        hText_testspeedheader = uicontrol('style', 'text', ...
            'tag', 'ui4testspeedheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Test Speed (%)', ...
            'unit','characters', ...
            'position', [35, 19, 30, 2]);
        hEdit_testspeed = uicontrol('style', 'edit', ...
            'tag', 'ui4testspeed', ...
            'string', int2str(testSpeed), ...
            'unit','characters', ...
            'position', [35, 17, 30, 2]);
        hText_anglenotchheader = uicontrol('style', 'text', ...
            'tag', 'ui4anglenotchheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Notch Angle (mdeg)', ...
            'unit','characters', ...
            'position', [35, 15, 30, 2]);
        hEdit_anglenotch = uicontrol('style', 'edit', ...
            'tag', 'ui4anglenotch', ...
            'string', int2str(angleNotch), ...
            'unit','characters', ...
            'position', [35, 13, 30, 2]);
        hText_testcountheader = uicontrol('style', 'text', ...
            'tag', 'ui4testcountheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Test Count', ...
            'unit','characters', ...
            'position', [35, 7, 30, 2]);
        hEdit_testcount = uicontrol('style', 'edit', ...
            'tag', 'ui4testcount', ...
            'string', int2str(testCount), ...
            'unit','characters', ...
            'position', [35, 5, 30, 2]);
        hText_offsetxheader = uicontrol('style', 'text', ...
            'tag', 'ui4offsetxheader', ...
            'horizontalalignment', 'left', ...
            'string', 'X Offset(um)', ...
            'unit','characters', ...
            'position', [70, 11, 30, 2]);
        hEdit_x = uicontrol('style', 'edit', ...
            'tag', 'ui4offsetx', ...
            'string', int2str(offsetX), ...
            'unit','characters', ...
            'position', [70, 9, 30, 2]);
        hText_offsetyheader = uicontrol('style', 'text', ...
            'tag', 'ui4offsetyheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Y Offset(um)', ...
            'unit','characters', ...
            'position', [70, 7, 30, 2]);
        hEdit_y = uicontrol('style', 'edit', ...
            'tag', 'ui4offsety', ...
            'string', int2str(offsetY), ...
            'unit','characters', ...
            'position', [70, 5, 30, 2]);
        hText_offsetthetaheader = uicontrol('style', 'text', ...
            'tag', 'ui4offsetthetaheader', ...
            'horizontalalignment', 'left', ...
            'string', 'T Offset(mdeg)', ...
            'unit','characters', ...
            'position', [70, 3, 30, 2]);
        hEdit_theta = uicontrol('style', 'edit', ...
            'tag', 'ui4offsettheta', ...
            'string', int2str(offsetTheta), ...
            'unit','characters', ...
            'position', [70, 1, 30, 2]);
        hText_ycutstartheader = uicontrol('style', 'text', ...
            'tag', 'ui4ycutstartheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Y Start (0~End)', ...
            'unit','characters', ...
            'position', [70, 7, 30, 2]);
        hEdit_ycutstart = uicontrol('style', 'edit', ...
            'tag', 'ui4ycutstart', ...
            'string', y_start, ...
            'unit','characters', ...
            'position', [70, 5, 30, 2]);
        hText_ycutendheader = uicontrol('style', 'text', ...
            'tag', 'ui4ycutendheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Y End (Start~12)', ...
            'unit','characters', ...
            'position', [70, 3, 30, 2]);
        hEdit_ycutend = uicontrol('style', 'edit', ...
            'tag', 'ui4ycutend', ...
            'string', y_end, ...
            'unit','characters', ...
            'position', [70, 1, 30, 2]);
        hText_thresholdgrayheader = uicontrol('style', 'text', ...
            'tag', 'ui4thresholdgrayheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Gray Threshold', ...
            'unit','characters', ...
            'position', [70, 15, 30, 2]);
        hEdit_thresholdgray = uicontrol('style', 'edit', ...
            'tag', 'ui4thresholdgray', ...
            'string', threshold_gray, ...
            'unit','characters', ...
            'position', [70, 13, 30, 2]);
        hText_thresholdfilterheader = uicontrol('style', 'text', ...
            'tag', 'ui4thresholdfilterheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Filter Threshold', ...
            'unit','characters', ...
            'position', [70, 11, 30, 2]);
        hEdit_thresholdfilter = uicontrol('style', 'edit', ...
            'tag', 'ui4thresholdfilter', ...
            'string', threshold_filter, ...
            'unit','characters', ...
            'position', [70, 9, 30, 2]);
        hText_pathheader = uicontrol('style', 'text', ...
            'tag', 'ui4pathheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Folder (Path)', ...
            'unit','characters', ...
            'position', [35, 11, 30, 2]);
        hEdit_path = uicontrol('style', 'edit', ...
            'tag', 'ui4path', ...
            'string', path, ...
            'unit','characters', ...
            'position', [35, 9, 30, 2]);
        hText_cylinderportheader = uicontrol('style', 'text', ...
            'tag', 'ui4cylinderportheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Cylinder Port', ...
            'unit','characters', ...
            'position', [70, 15, 30, 2]);
        hEdit_cylinderport = uicontrol('style', 'edit', ...
            'tag', 'ui4cylinderport', ...
            'string', COM_cylinder, ...
            'unit','characters', ...
            'position', [70, 13, 30, 2]);
        hText_alignerportheader = uicontrol('style', 'text', ...
            'tag', 'ui4alignerportheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Aligner Port', ...
            'unit','characters', ...
            'position', [70, 11, 30, 2]);
        hEdit_alignerport = uicontrol('style', 'edit', ...
            'tag', 'ui4alignerport', ...
            'string', COM_aligner, ...
            'unit','characters', ...
            'position', [70, 9, 30, 2]);
        hText_cameraportheader = uicontrol('style', 'text', ...
            'tag', 'ui4cameraportheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Camera Port', ...
            'unit','characters', ...
            'position', [70, 7, 30, 2]);
        hEdit_cameraport = uicontrol('style', 'edit', ...
            'tag', 'ui4cameraport', ...
            'string', COM_camera, ...
            'unit','characters', ...
            'position', [70, 5, 30, 2]);
        hText_cameraarcportheader = uicontrol('style', 'text', ...
            'tag', 'ui4cameraarcportheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Camera(arc) Port', ...
            'unit','characters', ...
            'position', [70, 3, 30, 2]);
        hEdit_cameraarcport = uicontrol('style', 'edit', ...
            'tag', 'ui4cameraarcport', ...
            'string', COM_cameraarc, ...
            'unit','characters', ...
            'position', [70, 1, 30, 2]);
        hText_picturecountheader = uicontrol('style', 'text', ...
            'tag', 'ui4picturecountheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Picture Count', ...
            'unit','characters', ...
            'position', [105, 9, 35, 2]);
        hEdit_picturecount = uicontrol('style', 'edit', ...
            'tag', 'ui4picturecount', ...
            'string', picCount, ...
            'unit','characters', ...
            'position', [105, 7, 35, 2]);
        % 第三個UI控制物件，用以指定顯示曲面所用到的調色盤。
        %         hText_testmodeheader = uicontrol('style', 'text', ...
        % 			'tag', 'ui4testmodeheader', ...
        %             'horizontalalignment', 'left', ...
        % 			'string', 'Test Mode', ...
        %             'unit','characters', ...
        % 			'position', [70, 15, 30, 2]);
        hPopupMenu_testmode = uicontrol('style', 'popupmenu', ...
            'tag', 'ui4testmode', ...
            'string', 'Fix|Step(Center)|Step(Notch)|Theta(Only)', ...
            'unit','characters', ...
            'value',3, ...
            'position', [70, 15, 30, 2]);
        %         hText_userheader = uicontrol('style', 'text', ...
        %             'tag', 'ui4userheader', ...
        %             'horizontalalignment', 'left', ...
        %             'string', 'User Interface', ...
        %             'unit','characters', ...
        %             'position', [70, 23, 30, 2]);
        hPopupMenu_user = uicontrol('style', 'popupmenu', ...
            'tag', 'ui4user', ...
            'string', 'Operator|Engineer', ...
            'unit','characters', ...
            'position', [70, 23, 30, 2]);
        %         hText_interfaceheader = uicontrol('style', 'text', ...
        % 			'tag', 'ui4interfaceheader', ...
        %             'horizontalalignment', 'left', ...
        % 			'string', 'Interface', ...
        %             'unit','characters', ...
        % 			'position', [70, 19, 30, 2]);
        hPopupMenu_interface = uicontrol('style', 'popupmenu', ...
            'tag', 'ui4interface', ...
            'string', 'Device Port|Device Command|Image Process|Test Mode', ...
            'unit','characters', ...
            'position', [70, 18, 30, 2]);
        hPopupMenu_number = uicontrol('style', 'popupmenu', ...
            'tag', 'ui4number', ...
            'string', 'Platform 0|Platform 1', ...
            'unit','characters', ...
            'value',Num+1, ...
            'position', [70, 20, 30, 2]);
        hPopupMenu_alignertype = uicontrol('style', 'popupmenu', ...
            'tag', 'ui4alignertype', ...
            'string', 'Vacuum Type|Clamp Type', ...
            'unit','characters', ...
            'value',Num+1, ...
            'position', [70, 17, 30, 2]);
        hPopupMenu_wafertype = uicontrol('style', 'popupmenu', ...
            'tag', 'ui4wafertype', ...
            'string', 'Notch Type|Flat Type', ...
            'unit','characters', ...
            'value',Num+1, ...
            'position', [70, 14, 30, 2]);
        hPopupMenu_display = uicontrol('style', 'popupmenu', ...
            'tag', 'ui4display', ...
            'string', 'Take Time|Center Position|Notch Position', ...
            'unit','characters', ...
            'value',1, ...
            'position', [105, 23, 35, 2]);
        %   Buttun
        hToggleButtun_cylinderinitial = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4cylinderinitial', ...
            'string', 'Cylinder Initial', ...
            'unit','characters', ...
            'position', [5, 21, 25, 4]);
        hToggleButtun_alignerinitial = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4alignerinitial', ...
            'string', 'Aligner Initial', ...
            'unit','characters', ...
            'position', [5, 17, 25, 4]);
        hToggleButtun_align = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4align', ...
            'string', 'Align', ...
            'unit','characters', ...
            'position', [5, 13, 25, 4]);
        hToggleButtun_capture = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4capture', ...
            'string', 'Capture', ...
            'unit','characters', ...
            'position', [5, 9, 25, 4]);
        hToggleButtun_calculate = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4calculate', ...
            'string', 'Calculate', ...
            'unit','characters', ...
            'position', [5, 5, 25, 4]);
        hToggleButtun_run = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4run', ...
            'string', 'Run', ...
            'unit','characters', ...
            'backgroundcolor', [0.9 0.8 0.7], ...
            'foregroundcolor', [0.1 0.2 0.3], ...
            'position', [5, 1, 25, 4]);
        hToggleButtun_hold = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4hold', ...
            'string', 'Hold', ...
            'unit','characters', ...
            'position', [70, 13, 30, 4]);
        hToggleButtun_release = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4release', ...
            'string', 'Release', ...
            'unit','characters', ...
            'position', [70, 9, 30, 4]);
        hToggleButtun_move0 = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4move0', ...
            'string', 'Move Down', ...
            'unit','characters', ...
            'position', [70, 5, 30, 4]);
        hToggleButtun_move1 = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4move1', ...
            'string', 'Move Up', ...
            'unit','characters', ...
            'position', [70, 1, 30, 4]);
        hToggleButtun_communicate = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4communicate', ...
            'string', 'Communicate', ...
            'unit','characters', ...
            'position', [70, 1, 30, 4]);
        hToggleButtun_calibrate = uicontrol('style', 'togglebutton', ...
            'tag', 'ui4calibrate', ...
            'string', 'Calibrate', ...
            'unit','characters', ...
            'position', [70, 9, 30, 4]);
        %   Text
        hText_offsetheader = uicontrol('style', 'text', ...
            'tag', 'ui4offsetheader', ...
            'horizontalalignment', 'left', ...
            'string', 'Max-Min', ...
            'unit','characters', ...
            'position', [145, 5, 35, 2]);
        hText_offsetmm = uicontrol('style', 'text', ...
            'tag', 'ui4resultoffsetmm', ...
            'horizontalalignment', 'left', ...
            'string', 'Offset(mm):', ...
            'unit','characters', ...
            'position', [145, 3, 35, 2]);
        hText_offsetdeg = uicontrol('style', 'text', ...
            'tag', 'ui4resultoffsetdeg', ...
            'horizontalalignment', 'left', ...
            'string', 'Offset(deg):', ...
            'unit','characters', ...
            'position', [145, 1, 35, 2]);
        hText_aligntime = uicontrol('style', 'text', ...
            'tag', 'ui4aligntime', ...
            'horizontalalignment', 'left', ...
            'string', 'Time(s):', ...
            'unit','characters', ...
            'position', [105, 19, 35, 2]);
        hText_centerposition = uicontrol('style', 'text', ...
            'tag', 'ui4centerposition', ...
            'horizontalalignment', 'left', ...
            'string', 'Center Position', ...
            'unit','characters', ...
            'position', [105, 19, 35, 2]);
        hText_centerx = uicontrol('style', 'text', ...
            'tag', 'ui4centerx', ...
            'horizontalalignment', 'left', ...
            'string', 'X(mm):', ...
            'unit','characters', ...
            'position', [105, 19, 35, 2]);
        hText_centery = uicontrol('style', 'text', ...
            'tag', 'ui4centery', ...
            'horizontalalignment', 'left', ...
            'string', 'Y(mm):', ...
            'unit','characters', ...
            'position', [105, 17, 35, 2]);
        hText_notchposition = uicontrol('style', 'text', ...
            'tag', 'ui4notchposition', ...
            'horizontalalignment', 'left', ...
            'string', 'Notch Position', ...
            'unit','characters', ...
            'position', [105, 19, 35, 2]);
        hText_notchx = uicontrol('style', 'text', ...
            'tag', 'ui4notchx', ...
            'horizontalalignment', 'left', ...
            'string', 'X(mm):', ...
            'unit','characters', ...
            'position', [105, 19, 35, 2]);
        hText_notchy = uicontrol('style', 'text', ...
            'tag', 'ui4notchy', ...
            'horizontalalignment', 'left', ...
            'string', 'Y(mm):', ...
            'unit','characters', ...
            'position', [105, 17, 35, 2]);
        hText_aligntimeaverage = uicontrol('style', 'text', ...
            'tag', 'ui4aligntimeaverage', ...
            'horizontalalignment', 'left', ...
            'string', 'Average(s):', ...
            'unit','characters', ...
            'position', [105, 17, 35, 2]);
        hText_aligntimemax = uicontrol('style', 'text', ...
            'tag', 'ui4aligntimemax', ...
            'horizontalalignment', 'left', ...
            'string', 'Max(s):', ...
            'unit','characters', ...
            'position', [105, 15, 35, 2]);
        hText_aligntimemin = uicontrol('style', 'text', ...
            'tag', 'ui4aligntimemin', ...
            'horizontalalignment', 'left', ...
            'string', 'Min(s):', ...
            'unit','characters', ...
            'position', [105, 13, 35, 2]);
        hText_centerpositionaverage = uicontrol('style', 'text', ...
            'tag', 'ui4centerpositionaverage', ...
            'horizontalalignment', 'left', ...
            'string', 'Average', ...
            'unit','characters', ...
            'position', [105, 15, 35, 2]);
        hText_centerxaverage = uicontrol('style', 'text', ...
            'tag', 'ui4centerxaverage', ...
            'horizontalalignment', 'left', ...
            'string', 'X(mm):', ...
            'unit','characters', ...
            'position', [105, 13, 35, 2]);
        hText_centeryaverage = uicontrol('style', 'text', ...
            'tag', 'ui4centeryaverage', ...
            'horizontalalignment', 'left', ...
            'string', 'Y(mm):', ...
            'unit','characters', ...
            'position', [105, 11, 35, 2]);
        hText_notchpositionaverage = uicontrol('style', 'text', ...
            'tag', 'ui4notchpositionaverage', ...
            'horizontalalignment', 'left', ...
            'string', 'Average', ...
            'unit','characters', ...
            'position', [105, 15, 35, 2]);
        hText_notchxaverage = uicontrol('style', 'text', ...
            'tag', 'ui4notchxaverage', ...
            'horizontalalignment', 'left', ...
            'string', 'X(mm):', ...
            'unit','characters', ...
            'position', [105, 13, 35, 2]);
        hText_notchyaverage = uicontrol('style', 'text', ...
            'tag', 'ui4notchyaverage', ...
            'horizontalalignment', 'left', ...
            'string', 'Y(mm):', ...
            'unit','characters', ...
            'position', [105, 11, 35, 2]);
        hText_currentsituation = uicontrol('style', 'text', ...
            'tag', 'ui4currentsituation', ...
            'horizontalalignment', 'left', ...
            'string', '', ...
            'unit','characters', ...
            'position', [105, 1, 35, 4]);
        hText_fqc = uicontrol('style', 'text', ...
            'tag', 'ui4fqc', ...
            'horizontalalignment', 'left', ...
            'string', '', ...
            'unit','characters', ...
            'position', [145, 19, 35, 2]);
        hText_fqc1 = uicontrol('style', 'text', ...
            'tag', 'ui4fqc1', ...
            'horizontalalignment', 'left', ...
            'string', '', ...
            'unit','characters', ...
            'position', [145, 17, 35, 2]);
        hText_fqc2 = uicontrol('style', 'text', ...
            'tag', 'ui4fqc2', ...
            'horizontalalignment', 'left', ...
            'string', '', ...
            'unit','characters', ...
            'position', [145, 15, 35, 2]);
        hText_fqc3 = uicontrol('style', 'text', ...
            'tag', 'ui4fqc3', ...
            'horizontalalignment', 'left', ...
            'string', '', ...
            'unit','characters', ...
            'position', [145, 13, 35, 2]);
        hText_fqc4 = uicontrol('style', 'text', ...
            'tag', 'ui4fqc4', ...
            'horizontalalignment', 'left', ...
            'string', '', ...
            'unit','characters', ...
            'position', [145, 11, 35, 2]);
        hText_fqc5 = uicontrol('style', 'text', ...
            'tag', 'ui4fqc5', ...
            'horizontalalignment', 'left', ...
            'string', '', ...
            'unit','characters', ...
            'position', [145, 9, 35, 2]);
        hText_fqc6 = uicontrol('style', 'text', ...
            'tag', 'ui4fqc6', ...
            'horizontalalignment', 'left', ...
            'string', '', ...
            'unit','characters', ...
            'position', [145, 7, 35, 2]);
        hText_param193 = uicontrol('style', 'text', ...
            'tag', 'ui4param193', ...
            'horizontalalignment', 'left', ...
            'string', '26:', ...
            'unit','characters', ...
            'position', [70, 7, 30, 2]);
        hText_param194 = uicontrol('style', 'text', ...
            'tag', 'ui4param194', ...
            'horizontalalignment', 'left', ...
            'string', '27:', ...
            'unit','characters', ...
            'position', [70, 5, 30, 2]);
        hText_param195 = uicontrol('style', 'text', ...
            'tag', 'ui4param195', ...
            'horizontalalignment', 'left', ...
            'string', '28:', ...
            'unit','characters', ...
            'position', [70, 3, 30, 2]);
        hText_param196 = uicontrol('style', 'text', ...
            'tag', 'ui4param196', ...
            'horizontalalignment', 'left', ...
            'string', '29:', ...
            'unit','characters', ...
            'position', [70, 1, 30, 2]);
        
        % 在圖形視窗內產生一個圖軸，其左下角之座標為[0.1, 0.2],
        % 長度為0.8，高度為0.8（使用標準化的單位，即圖形的左下角為[0, 0]，
        % 長度及高度都是1。）
        hAxes_plot = axes('Color', 'none', ...
            'GridLineStyle', ':', ...
            'XGrid', 'on', ...
            'YGrid', 'on', ...
            'tag', 'ui4plot', ...
            'CreateFcn', 'aligner_autotest_calibration(''setuserinterface'')', ...
            'Position', [0.05 0.55 0.9 0.4]);
        
        % 第一個UI控制物件的反應指令為「grid」。
        % 		set(hCheckBox_bwinverse, 'callback', 'bwinverse');
        % 第二個UI控制物件的反應指令為「ui02('setPointNum')」。
        % 		set(hEdit_testcount, 'callback', 'aligner_autotest_calibration(''setTestCount'')');
        % 第三個UI控制物件的反應指令為「ui02('setColorMap')」。
        set(hPopupMenu_testmode, 'callback', 'aligner_autotest_calibration(''settestmode'')');
        set(hPopupMenu_user, 'callback', 'aligner_autotest_calibration(''setuserinterface'')');
        set(hPopupMenu_interface, 'callback', 'aligner_autotest_calibration(''setuserinterface'')');
        set(hPopupMenu_alignertype, 'callback', 'aligner_autotest_calibration(''setuserinterface'')');
        set(hPopupMenu_display, 'callback', 'aligner_autotest_calibration(''setdisplay'')');
        
        set(hToggleButtun_cylinderinitial, 'callback', 'aligner_autotest_calibration(''cylinderinitial'')');
        set(hToggleButtun_alignerinitial, 'callback', 'aligner_autotest_calibration(''alignerinitial'')');
        set(hToggleButtun_align, 'callback', 'aligner_autotest_calibration(''align'')');
        set(hToggleButtun_capture, 'callback', 'aligner_autotest_calibration(''capture'')');
        set(hToggleButtun_calculate, 'callback', 'aligner_autotest_calibration(''calculate'')');
        set(hToggleButtun_run, 'callback', 'aligner_autotest_calibration(''run'')');
        set(hToggleButtun_hold, 'callback', 'aligner_autotest_calibration(''hold'')');
        set(hToggleButtun_release, 'callback', 'aligner_autotest_calibration(''release'')');
        set(hToggleButtun_move0, 'callback', 'aligner_autotest_calibration(''move0'')');
        set(hToggleButtun_move1, 'callback', 'aligner_autotest_calibration(''move1'')');
        set(hToggleButtun_communicate, 'callback', 'aligner_autotest_calibration(''communicate'')');
        set(hToggleButtun_calibrate, 'callback', 'aligner_autotest_calibration(''calibrate'')');
        %set(hToggleButtun_calibrate, 'callback', 'aligner_autotest_calibration(''thetatest'')');%20190816 暫時測試用
        %         objs = findobj('Style','togglebutton');
        %         set(objs,'FontSize', 10);
        %         objs = findobj('Style','popupMenu');
        %         set(objs,'FontSize', 10);
        %         objs = findobj('Style','edit');
        %         set(objs,'FontSize', 10);
        objs = findobj('FontSize',8);
        set(objs,'FontSize', 14);
        hText_versionheader = uicontrol('style', 'text', ...
            'tag', 'ui4versionheader', ...
            'horizontalalignment', 'left', ...
            'string', 'ver. 2.00', ...
            'unit','characters', ...
            'position', [180, 49, 10, 1]);
        % 	case 'setTestCount'	% 第二個UI控制物件的callback。
        % 		% 找出第一及第二個UI控制物件的握把。
        % 		hCheckBox = findobj(0, 'tag', 'ui4grid');
        % 		hEdit_testcount = findobj(0, 'tag', 'ui4testCount');
        %
        % 		% 取得第二個UI控制物件的數值。
        % 		testCount = round(str2num(get(hEdit_testcount, 'string')));
        %
        % 		% 若數字太大或太小，則設定為10。
        % % 		if pointNum <= 1 | pointNum > 100,
        % % 			pointNum = 10;
        % % 			set(h2, 'string', int2str(testCount));
        % % 		end
        %
        % 		% 根據所得的數字，重畫peaks曲面。
        % % 		[xx, yy, zz] = peaks(pointNum);
        % % 		surf(xx, yy, zz);
        % % 		axis tight;
        %
        % 		% 根據第一個UI控制物件，決定是否要畫格線。
        % 		if get(hCheckBox, 'value')==1,
        % 			grid on;
        % 		else
        % 			grid off;
        % 		end
    case 'settestmode'	% 第三個UI控制物件的callback。
        % 找出第三個UI控制物件的握把。
        hPopupMenu_testmode = findobj(0, 'tag', 'ui4testmode');
        hText_offsetxheader = findobj(0, 'tag', 'ui4offsetxheader');
        hText_offsetyheader = findobj(0, 'tag', 'ui4offsetyheader');
        hText_offsetthetaheader = findobj(0, 'tag', 'ui4offsetthetaheader');
        % 根據第三個UI控制物件來決定使用的色盤矩陣。
        switch get(hPopupMenu_testmode, 'value')
            case 1  %fix
                set(hText_offsetxheader,'String','X Offset(um)');
                set(hText_offsetyheader,'String','Y Offset(um)');
                set(hText_offsetthetaheader,'String','T Offset(mdeg)');
            case 2  %step center
                set(hText_offsetxheader,'String','Center Mag(um)');
                set(hText_offsetyheader,'String','Center Dir(mdeg)');
                set(hText_offsetthetaheader,'String','T Offset(mdeg)');
            case 3  %step notch
                set(hText_offsetxheader,'String','X Offset(um)');
                set(hText_offsetyheader,'String','Y Offset(um)');
                set(hText_offsetthetaheader,'String','Notch Dir(mdeg)');
            case 4 %Theta(Only)
                set(hText_offsetxheader,'String','X Offset(um)');
                set(hText_offsetyheader,'String','Y Offset(um)');
                set(hText_offsetthetaheader,'String','Notch Dir(mdeg)');
            otherwise
                disp('Unknown option');
                fclose(fid_log);
                return;
        end
    case 'setdisplay'
        hPopupMenu_display = findobj(0, 'tag', 'ui4display');
        hText_aligntime = findobj(0, 'tag', 'ui4aligntime');
        hText_centerposition = findobj(0, 'tag', 'ui4centerposition');
        hText_centerx = findobj(0, 'tag', 'ui4centerx');
        hText_centery = findobj(0, 'tag', 'ui4centery');
        hText_notchposition = findobj(0, 'tag', 'ui4notchposition');
        hText_notchx = findobj(0, 'tag', 'ui4notchx');
        hText_notchy = findobj(0, 'tag', 'ui4notchy');
        hText_aligntimeaverage = findobj(0, 'tag', 'ui4aligntimeaverage');
        hText_aligntimemax = findobj(0, 'tag', 'ui4aligntimemax');
        hText_aligntimemin = findobj(0, 'tag', 'ui4aligntimemin');
        hText_centerpositionaverage = findobj(0, 'tag', 'ui4centerpositionaverage');
        hText_centerxaverage = findobj(0, 'tag', 'ui4centerxaverage');
        hText_centeryaverage = findobj(0, 'tag', 'ui4centeryaverage');
        hText_notchpositionaverage = findobj(0, 'tag', 'ui4notchpositionaverage');
        hText_notchxaverage = findobj(0, 'tag', 'ui4notchxaverage');
        hText_notchyaverage = findobj(0, 'tag', 'ui4notchyaverage');
        switch get(hPopupMenu_display, 'value')
            case 1  %time
                set(hText_aligntime,'Visible','on');
                set(hText_aligntimeaverage,'Visible','on');
                set(hText_aligntimemax,'Visible','on');
                set(hText_aligntimemin,'Visible','on');
                set(hText_centerposition,'Visible','off');
                set(hText_centerx,'Visible','off');
                set(hText_centery,'Visible','off');
                set(hText_centerpositionaverage,'Visible','off');
                set(hText_centerxaverage,'Visible','off');
                set(hText_centeryaverage,'Visible','off');
                set(hText_notchposition,'Visible','off');
                set(hText_notchx,'Visible','off');
                set(hText_notchy,'Visible','off');
                set(hText_notchpositionaverage,'Visible','off');
                set(hText_notchxaverage,'Visible','off');
                set(hText_notchyaverage,'Visible','off');
            case 2  %center position
                set(hText_aligntime,'Visible','off');
                set(hText_aligntimeaverage,'Visible','off');
                set(hText_aligntimemax,'Visible','off');
                set(hText_aligntimemin,'Visible','off');
                set(hText_centerposition,'Visible','off');
                set(hText_centerx,'Visible','on');
                set(hText_centery,'Visible','on');
                set(hText_centerpositionaverage,'Visible','on');
                set(hText_centerxaverage,'Visible','on');
                set(hText_centeryaverage,'Visible','on');
                set(hText_notchposition,'Visible','off');
                set(hText_notchx,'Visible','off');
                set(hText_notchy,'Visible','off');
                set(hText_notchpositionaverage,'Visible','off');
                set(hText_notchxaverage,'Visible','off');
                set(hText_notchyaverage,'Visible','off');
            case 3  %notch position
                set(hText_aligntime,'Visible','off');
                set(hText_aligntimeaverage,'Visible','off');
                set(hText_aligntimemax,'Visible','off');
                set(hText_aligntimemin,'Visible','off');
                set(hText_centerposition,'Visible','off');
                set(hText_centerx,'Visible','off');
                set(hText_centery,'Visible','off');
                set(hText_centerpositionaverage,'Visible','off');
                set(hText_centerxaverage,'Visible','off');
                set(hText_centeryaverage,'Visible','off');
                set(hText_notchposition,'Visible','off');
                set(hText_notchx,'Visible','on');
                set(hText_notchy,'Visible','on');
                set(hText_notchpositionaverage,'Visible','on');
                set(hText_notchxaverage,'Visible','on');
                set(hText_notchyaverage,'Visible','on');
                
            otherwise
                disp('Unknown option');
                fclose(fid_log);
                return;
        end
        
    case 'setuserinterface'	% 第三個UI控制物件的callback。
        aligner_autotest_calibration('setdisplay');
        % 找出第三個UI控制物件的握把。
        hPopupMenu_user = findobj(0, 'tag', 'ui4user');
        %         hText_interfaceheader = findobj(0, 'tag', 'ui4interfaceheader');
        hPopupMenu_interface = findobj(0, 'tag', 'ui4interface');
        %         hText_imageprocessheader = findobj(0, 'tag', 'ui4imageprocessheader');
        %         hCheckBox_bwinverse = findobj(0, 'tag', 'ui4bwinverse');
        hText_thresholdgrayheader = findobj(0, 'tag', 'ui4thresholdgrayheader');
        hEdit_thresholdgray = findobj(0, 'tag', 'ui4thresholdgray');
        hText_thresholdfilterheader = findobj(0, 'tag', 'ui4thresholdfilterheader');
        hEdit_thresholdfilter = findobj(0, 'tag', 'ui4thresholdfilter');
        hText_ycutstartheader = findobj(0, 'tag', 'ui4ycutstartheader');
        hText_ycutstart = findobj(0, 'tag', 'ui4ycutstart');
        hText_ycutendheader = findobj(0, 'tag', 'ui4ycutendheader');
        hText_ycutend = findobj(0, 'tag', 'ui4ycutend');
        hText_cylinderportheader = findobj(0, 'tag', 'ui4cylinderportheader');
        hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
        hText_alignerportheader = findobj(0, 'tag', 'ui4alignerportheader');
        hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        hText_cameraportheader = findobj(0, 'tag', 'ui4cameraportheader');
        hText_cameraport = findobj(0, 'tag', 'ui4cameraport');
        %         hText_testmodeheader = findobj(0, 'tag', 'ui4testmodeheader');
        hPopupMenu_testmode = findobj(0, 'tag', 'ui4testmode');
        hText_offsetxheader = findobj(0, 'tag', 'ui4offsetxheader');
        hEdit_x = findobj(0, 'tag', 'ui4offsetx');
        hText_offsetyheader = findobj(0, 'tag', 'ui4offsetyheader');
        hEdit_y = findobj(0, 'tag', 'ui4offsety');
        hText_offsetthetaheader = findobj(0, 'tag', 'ui4offsetthetaheader');
        hEdit_theta = findobj(0, 'tag', 'ui4offsettheta');
        hToggleButtun_hold = findobj(0, 'tag', 'ui4hold');
        hToggleButtun_release = findobj(0, 'tag', 'ui4release');
        hToggleButtun_move0 = findobj(0, 'tag', 'ui4move0');
        hToggleButtun_move1 = findobj(0, 'tag', 'ui4move1');
        hPopupMenu_number = findobj(0, 'tag', 'ui4number');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hToggleButtun_calibrate = findobj(0, 'tag', 'ui4calibrate');
        hText_param193 = findobj(0, 'tag', 'ui4param193');
        hText_param194 = findobj(0, 'tag', 'ui4param194');
        hText_param195 = findobj(0, 'tag', 'ui4param195');
        hText_param196 = findobj(0, 'tag', 'ui4param196');
        hPopupMenu_alignertype = findobj(0, 'tag', 'ui4alignertype');
        hPopupMenu_wafertype = findobj(0, 'tag', 'ui4wafertype');
        hText_cameraarcportheader = findobj(0, 'tag', 'ui4cameraarcportheader');
        hEdit_cameraarcport = findobj(0, 'tag', 'ui4cameraarcport');
        switch get(hPopupMenu_user, 'value')
            case 1  %operator
                %                 set(hText_interfaceheader,'Visible','off');
                set(hPopupMenu_interface,'Visible','off');
                %                 set(hText_imageprocessheader,'Visible','off');
                %                 set(hCheckBox_bwinverse,'Visible','off');
                set(hText_thresholdgrayheader,'Visible','off');
                set(hEdit_thresholdgray,'Visible','off');
                set(hText_thresholdfilterheader,'Visible','off');
                set(hEdit_thresholdfilter,'Visible','off');
                set(hText_ycutstartheader,'Visible','off');
                set(hText_ycutstart,'Visible','off');
                set(hText_ycutendheader,'Visible','off');
                set(hText_ycutend,'Visible','off');
                set(hText_cylinderportheader,'Visible','off');
                set(hText_cylinderport,'Visible','off');
                set(hText_alignerportheader,'Visible','off');
                set(hText_alignerport,'Visible','off');
                set(hText_cameraportheader,'Visible','off');
                set(hText_cameraport,'Visible','off');
                %                 set(hText_testmodeheader,'Visible','off');
                set(hPopupMenu_testmode,'Visible','off');
                set(hText_offsetxheader,'Visible','off');
                set(hEdit_x,'Visible','off');
                set(hText_offsetyheader,'Visible','off');
                set(hEdit_y,'Visible','off');
                set(hText_offsetthetaheader,'Visible','off');
                set(hEdit_theta,'Visible','off');
                set(hToggleButtun_hold,'Visible','off');
                set(hToggleButtun_release,'Visible','off');
                set(hToggleButtun_move0,'Visible','off');
                set(hToggleButtun_move1,'Visible','off');
                set(hPopupMenu_number,'Visible','on');
                set(hToggleButtun_communicate,'Visible','off');
                set(hToggleButtun_calibrate,'Visible','on');
                set(hText_param193,'Visible','on');
                set(hText_param194,'Visible','on');
                set(hText_param195,'Visible','on');
                set(hText_param196,'Visible','on');
                set(hPopupMenu_alignertype,'Visible','on');
                set(hPopupMenu_wafertype,'Visible','on');
                set(hText_cameraarcportheader,'Visible','off');
                set(hEdit_cameraarcport,'Visible','off');
            case 2  %engineer
                %                 set(hText_interfaceheader,'Visible','on');
                set(hPopupMenu_interface,'Visible','on');
                set(hToggleButtun_calibrate,'Visible','off');
                set(hText_param193,'Visible','off');
                set(hText_param194,'Visible','off');
                set(hText_param195,'Visible','off');
                set(hText_param196,'Visible','off');
                set(hPopupMenu_alignertype,'Visible','off');
                set(hPopupMenu_wafertype,'Visible','off');
                switch get(hPopupMenu_interface, 'value')
                    case 1  %device port
                        %                         set(hText_imageprocessheader,'Visible','off');
                        %                         set(hCheckBox_bwinverse,'Visible','off');
                        set(hText_thresholdgrayheader,'Visible','off');
                        set(hEdit_thresholdgray,'Visible','off');
                        set(hText_thresholdfilterheader,'Visible','off');
                        set(hEdit_thresholdfilter,'Visible','off');
                        set(hText_ycutstartheader,'Visible','off');
                        set(hText_ycutstart,'Visible','off');
                        set(hText_ycutendheader,'Visible','off');
                        set(hText_ycutend,'Visible','off');
                        set(hText_cylinderportheader,'Visible','on');
                        set(hText_cylinderport,'Visible','on');
                        set(hText_alignerportheader,'Visible','on');
                        set(hText_alignerport,'Visible','on');
                        set(hText_cameraportheader,'Visible','on');
                        set(hText_cameraport,'Visible','on');
                        %                         set(hText_testmodeheader,'Visible','off');
                        set(hPopupMenu_testmode,'Visible','off');
                        set(hText_offsetxheader,'Visible','off');
                        set(hEdit_x,'Visible','off');
                        set(hText_offsetyheader,'Visible','off');
                        set(hEdit_y,'Visible','off');
                        set(hText_offsetthetaheader,'Visible','off');
                        set(hEdit_theta,'Visible','off');
                        set(hToggleButtun_hold,'Visible','off');
                        set(hToggleButtun_release,'Visible','off');
                        set(hToggleButtun_move0,'Visible','off');
                        set(hToggleButtun_move1,'Visible','off');
                        set(hPopupMenu_number,'Visible','off');
                        set(hToggleButtun_communicate,'Visible','on');
                        %                         if (get(hPopupMenu_wafertype,'value')-1)
                        %                             set(hText_cameraarcportheader,'Visible','on');
                        %                             set(hEdit_cameraarcport,'Visible','on');
                        %                         else
                        set(hText_cameraarcportheader,'Visible','off');
                        set(hEdit_cameraarcport,'Visible','off');
                        %                         end
                    case 2  %device command
                        %                         set(hText_imageprocessheader,'Visible','off');
                        %                         set(hCheckBox_bwinverse,'Visible','off');
                        set(hText_thresholdgrayheader,'Visible','off');
                        set(hEdit_thresholdgray,'Visible','off');
                        set(hText_thresholdfilterheader,'Visible','off');
                        set(hEdit_thresholdfilter,'Visible','off');
                        set(hText_ycutstartheader,'Visible','off');
                        set(hText_ycutstart,'Visible','off');
                        set(hText_ycutendheader,'Visible','off');
                        set(hText_ycutend,'Visible','off');
                        set(hText_cylinderportheader,'Visible','off');
                        set(hText_cylinderport,'Visible','off');
                        set(hText_alignerportheader,'Visible','off');
                        set(hText_alignerport,'Visible','off');
                        set(hText_cameraportheader,'Visible','off');
                        set(hText_cameraport,'Visible','off');
                        %                         set(hText_testmodeheader,'Visible','off');
                        set(hPopupMenu_testmode,'Visible','off');
                        set(hText_offsetxheader,'Visible','off');
                        set(hEdit_x,'Visible','off');
                        set(hText_offsetyheader,'Visible','off');
                        set(hEdit_y,'Visible','off');
                        set(hText_offsetthetaheader,'Visible','off');
                        set(hEdit_theta,'Visible','off');
                        set(hToggleButtun_hold,'Visible','on');
                        set(hToggleButtun_release,'Visible','on');
                        set(hToggleButtun_move0,'Visible','on');
                        set(hToggleButtun_move1,'Visible','on');
                        set(hPopupMenu_number,'Visible','off');
                        set(hToggleButtun_communicate,'Visible','off');
                        set(hText_cameraarcportheader,'Visible','off');
                        set(hEdit_cameraarcport,'Visible','off');
                    case 3  %image process
                        %                         set(hText_imageprocessheader,'Visible','on');
                        %                         set(hCheckBox_bwinverse,'Visible','on');
                        set(hText_thresholdgrayheader,'Visible','on');
                        set(hEdit_thresholdgray,'Visible','on');
                        set(hText_thresholdfilterheader,'Visible','on');
                        set(hEdit_thresholdfilter,'Visible','on');
                        set(hText_ycutstartheader,'Visible','on');
                        set(hText_ycutstart,'Visible','on');
                        set(hText_ycutendheader,'Visible','on');
                        set(hText_ycutend,'Visible','on');
                        set(hText_cylinderportheader,'Visible','off');
                        set(hText_cylinderport,'Visible','off');
                        set(hText_alignerportheader,'Visible','off');
                        set(hText_alignerport,'Visible','off');
                        set(hText_cameraportheader,'Visible','off');
                        set(hText_cameraport,'Visible','off');
                        %                         set(hText_testmodeheader,'Visible','off');
                        set(hPopupMenu_testmode,'Visible','off');
                        set(hText_offsetxheader,'Visible','off');
                        set(hEdit_x,'Visible','off');
                        set(hText_offsetyheader,'Visible','off');
                        set(hEdit_y,'Visible','off');
                        set(hText_offsetthetaheader,'Visible','off');
                        set(hEdit_theta,'Visible','off');
                        set(hToggleButtun_hold,'Visible','off');
                        set(hToggleButtun_release,'Visible','off');
                        set(hToggleButtun_move0,'Visible','off');
                        set(hToggleButtun_move1,'Visible','off');
                        set(hPopupMenu_number,'Visible','off');
                        set(hToggleButtun_communicate,'Visible','off');
                        set(hText_cameraarcportheader,'Visible','off');
                        set(hEdit_cameraarcport,'Visible','off');
                    case 4  %test mode
                        %                         set(hText_imageprocessheader,'Visible','off');
                        %                         set(hCheckBox_bwinverse,'Visible','off');
                        set(hText_thresholdgrayheader,'Visible','off');
                        set(hEdit_thresholdgray,'Visible','off');
                        set(hText_thresholdfilterheader,'Visible','off');
                        set(hEdit_thresholdfilter,'Visible','off');
                        set(hText_ycutstartheader,'Visible','off');
                        set(hText_ycutstart,'Visible','off');
                        set(hText_ycutendheader,'Visible','off');
                        set(hText_ycutend,'Visible','off');
                        set(hText_cylinderportheader,'Visible','off');
                        set(hText_cylinderport,'Visible','off');
                        set(hText_alignerportheader,'Visible','off');
                        set(hText_alignerport,'Visible','off');
                        set(hText_cameraportheader,'Visible','off');
                        set(hText_cameraport,'Visible','off');
                        %                         set(hText_testmodeheader,'Visible','on');
                        set(hPopupMenu_testmode,'Visible','on');
                        set(hText_offsetxheader,'Visible','on');
                        set(hEdit_x,'Visible','on');
                        set(hText_offsetyheader,'Visible','on');
                        set(hEdit_y,'Visible','on');
                        set(hText_offsetthetaheader,'Visible','on');
                        set(hEdit_theta,'Visible','on');
                        set(hToggleButtun_hold,'Visible','off');
                        set(hToggleButtun_release,'Visible','off');
                        set(hToggleButtun_move0,'Visible','off');
                        set(hToggleButtun_move1,'Visible','off');
                        set(hPopupMenu_number,'Visible','off');
                        set(hToggleButtun_communicate,'Visible','off');
                        set(hText_cameraarcportheader,'Visible','off');
                        set(hEdit_cameraarcport,'Visible','off');
                end
                %                 switch get(hPopupMenu_alignertype, 'value')
                %                     case 1 %vacuum
                %                         set(hToggleButtun_cylinderinitial,'Visible','on');
                %                     case 2  %clamp
                %                         set(hToggleButtun_cylinderinitial,'Visible','off');
                %                 end
            otherwise
                disp('Unknown option');
                fclose(fid_log);
                return;
        end
    case 'communicate'
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
        hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        hText_cameraport = findobj(0, 'tag', 'ui4cameraport');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hPopupMenu_wafertype = findobj(0, 'tag', 'ui4wafertype');
        hText_cameraarcport = findobj(0, 'tag', 'ui4cameraarcport');
        COM_cylinder = get(hText_cylinderport,'String');
        COM_aligner = get(hText_alignerport,'String');
        COM_camera = get(hText_cameraport,'String');
        COM_cameraarc = get(hText_cameraarcport,'String');
        
        s = instrfindall('Type','serial');
        if ~isempty(s)
            % Disconnect and clean up the server connection.
            fclose(s);
            delete(s);
            clear s;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            current_situation = 'stop communicate';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        [~,res]=system('mode');
        COM = regexp(res,'COM\d+','match');
        cylinder_check = 0;
        aligner_check = 0;
        camera_check = 0;
        cameraarc_check = 1;    %0;
        for n = 1:size(COM,2)
            if strncmp(COM(1,n),COM_cylinder,size(COM_cylinder,2))
                cylinder_check = 1;
            end
            if strncmp(COM(1,n),COM_aligner,size(COM_aligner,2))
                aligner_check = 1;
            end
            if strncmp(COM(1,n),COM_camera,size(COM_camera,2))
                camera_check = 1;
            end
            %             if strncmp(COM(1,n),COM_cameraarc,size(COM_cameraarc,2)) && (get(hPopupMenu_wafertype,'value')-1)
            %                 cameraarc_check = 1;
            %             elseif (get(hPopupMenu_wafertype,'value')-1) == 0
            %                 cameraarc_check = 1;
            %             end
        end
        if cylinder_check==0 || aligner_check==0 || camera_check==0 || cameraarc_check == 0
            set(hToggleButtun_communicate,'Value',0);
            current_situation = 'port error';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        % Create serial object 's'. Specify server machine and port number.
        s = serial(COM_cylinder,'BaudRate',38400,'DataBits',8);
        set(s, 'Timeout', 0.1);
        % Open connection to the server.
        fopen(s);
        % Create serial object 's'. Specify server machine and port number.
        s = serial(COM_aligner,'BaudRate',38400,'DataBits',8);
        set(s, 'Terminator', 'CR');
        %         set(s, 'Timeout', 1);
        % Open connection to the server.
        fopen(s);
        % Create serial object 's'. Specify server machine and port number.
        s = serial(COM_camera,'BaudRate',38400,'DataBits',8);
        set(s, 'Terminator', 'CR');
        set(s, 'Timeout', 3);
        % Open connection to the server.
        fopen(s);
        %         if (get(hPopupMenu_wafertype,'value')-1)
        %             % Create serial object 's'. Specify server machine and port number.
        %             s = serial(COM_cameraarc,'BaudRate',38400,'DataBits',8);
        %             set(s, 'Terminator', 'CR');
        %             set(s, 'Timeout', 3);
        %             % Open connection to the server.
        %             fopen(s);
        %         end
        
        current_situation = 'start communicate';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
    case 'cylinderinitial'
        hToggleButtun_cylinderinitial = findobj(0, 'tag', 'ui4cylinderinitial');
        hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        if get(hToggleButtun_cylinderinitial,'Value') == 0
            fclose(fid_log);
            return;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            set(hToggleButtun_cylinderinitial,'Value',0);
            current_situation = 'communication fail';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        %         selection = questdlg(['Initialize Cylinder?'],...
        %                      ['Initialize Cylinder...'],...
        %                      'Yes','No','No');
        %         if strcmp(selection,'Yes')
        COM_cylinder = get(hText_cylinderport,'String');
        
        current_situation = 'cylinder reset';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        [rslt,ack] = serial_z(5,COM_cylinder);
        
        current_situation = 'cylinder servo on';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        [rslt,ack] = serial_z(0,COM_cylinder);
        pause(5);
        
        current_situation = 'cylinder org';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        [rslt,ack] = serial_z(2,COM_cylinder);
        pause(2);
        
        %           [rslt,ack] = serial_z(3,COM_cylinder);
        %           pause(2);
        %           [rslt,ack] = serial_z(4,COM_cylinder);
        %           pause(2);
        
        %         end
        %         return;
        set(hToggleButtun_cylinderinitial,'Value',0);
        current_situation = 'cylinder initial finished';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
    case 'alignerinitial'
        hToggleButtun_alignerinitial = findobj(0, 'tag', 'ui4alignerinitial');
        hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
        hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        hEdit_waferradius = findobj(0, 'tag', 'ui4waferradius');
        hEdit_testspeed = findobj(0, 'tag', 'ui4testspeed');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hPopupMenu_alignertype = findobj(0, 'tag', 'ui4alignertype');
        if get(hToggleButtun_alignerinitial,'Value') == 0
            fclose(fid_log);
            return;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            set(hToggleButtun_alignerinitial,'Value',0);
            current_situation = 'communication fail';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        %         selection = questdlg(['Initialize Aligner?'],...
        %                      ['Initialize Aligner...'],...
        %                      'Yes','No','No');
        %         if strcmp(selection,'Yes')
        COM_cylinder = get(hText_cylinderport,'String');
        COM_aligner = get(hText_alignerport,'String');
        
        current_situation = 'aligner set reset';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        [rslt,ack] = serial_set('$1SET:RESET',COM_aligner); %RESET
        
        if get(hPopupMenu_alignertype,'Value') == 1
            current_situation = 'aligner set align wafer radius';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            pause(0.001);
            waferRadius = get(hEdit_waferradius,'String');
            if str2num(waferRadius) <= 0
                current_situation = 'wafer radius error';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                fclose(fid_log);
                return;
            end
            [rslt,ack] = serial_set(['$1SET:ALIGN:',waferRadius],COM_aligner); %WAFER SIZE
        end
        
        current_situation = 'aligner set speed';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        testSpeed = get(hEdit_testspeed,'String');
        if str2num(testSpeed) == 100
            testSpeed = '0';
        elseif str2num(testSpeed)<=0 || str2num(testSpeed)>100
            current_situation = 'test speed error';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        [rslt,ack] = serial_set(['$1SET:SP___:',testSpeed],COM_aligner); %SPEED
        
        if get(hPopupMenu_alignertype,'Value') == 1
            current_situation = 'aligner command release';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            pause(0.001);
            [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
            %           pause(1);
            current_situation = 'cylinder move up';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            pause(0.001);
            if rslt ~= 0
                [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                if rslt ~= 0
                    current_situation = 'wafer release fail';
                    set(hText_currentsituation,'String',current_situation);
                    clock_log = clock;
                    fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                    fclose(fid_log);
                    return;
                end
            end
            [rslt,ack] = serial_z(4,COM_cylinder);
            pause(2);
        end
        
        current_situation = 'aligner command org';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        [rslt,ack] = serial_command('$1CMD:ORG__',COM_aligner);
        
        current_situation = 'aligner command home';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        [rslt,ack] = serial_command('$1CMD:HOME_',COM_aligner);    %HOME
        
        %         end
        %         return;
        set(hToggleButtun_alignerinitial,'Value',0);
        current_situation = 'aligner initial finished';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
    case 'align'
        hToggleButtun_align = findobj(0, 'tag', 'ui4align');
        hEdit_waferradius = findobj(0, 'tag', 'ui4waferradius');
        hEdit_testspeed = findobj(0, 'tag', 'ui4testspeed');
        hEdit_anglenotch = findobj(0, 'tag', 'ui4anglenotch');
        hText_aligntime = findobj(0, 'tag', 'ui4aligntime');
        hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
        hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hPopupMenu_alignertype = findobj(0, 'tag', 'ui4alignertype');
        if get(hToggleButtun_align,'Value') == 0
            fclose(fid_log);
            return;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            set(hToggleButtun_align,'Value',0);
            current_situation = 'communication fail';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        %         selection = questdlg(['Align?'],...
        %                      ['Align...'],...
        %                      'Yes','No','No');
        %         if strcmp(selection,'Yes')
        COM_cylinder = get(hText_cylinderport,'String');
        COM_aligner = get(hText_alignerport,'String');
        
        if get(hPopupMenu_alignertype,'Value') == 1
            current_situation = 'aligner set align wafer radius';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            pause(0.001);
            waferRadius = get(hEdit_waferradius,'String');
            if str2num(waferRadius) <= 0
                current_situation = 'wafer radius error';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                fclose(fid_log);
                return;
            end
            [rslt,ack] = serial_set(['$1SET:ALIGN:',waferRadius],COM_aligner); %WAFER SIZE
        end
        
        current_situation = 'aligner set speed';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        testSpeed = get(hEdit_testspeed,'String');
        if str2num(testSpeed) == 100
            testSpeed = '0';
        elseif str2num(testSpeed)<=0 || str2num(testSpeed)>100
            current_situation = 'test speed error';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        [rslt,ack] = serial_set(['$1SET:SP___:',testSpeed],COM_aligner); %SPEED
        
        current_situation = 'aligner command home';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        [rslt,ack] = serial_command('$1CMD:HOME_',COM_aligner);    %HOME
        if get(hPopupMenu_alignertype,'Value') == 1
            current_situation = 'cylinder move down';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            pause(0.001);
            [rslt,ack] = serial_z(3,COM_cylinder);
            current_situation = 'aligner command hold';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            pause(0.001);
            [rslt,ack] = serial_command('$1CMD:WHLD_:1',COM_aligner); %HOLD WAFER
            pause(2);
        end
        
        
        current_situation = 'aligner command align';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        angleNotch = get(hEdit_anglenotch,'String');
        %             [rslt,ack,t] = serial_command(['$1CMD:ALIGN:',angleNotch,',1,2,00,00,00,9'],COM_aligner);
        if get(hPopupMenu_alignertype,'Value') == 1
            [rslt,ack,t] = serial_command(['$1CMD:ALIGN:',angleNotch],COM_aligner);
        else
            [rslt,ack,t] = serial_command(['$1CMD:ALIGN:',angleNotch,',1,2,1'],COM_aligner);
        end
        set(hText_aligntime,'String',['Time(s):',num2str(t)]);
        %         end
        %         return;
        set(hToggleButtun_align,'Userdata',{ack,num2str(t)});
        set(hToggleButtun_align,'Value',0);
        current_situation = 'align finished';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        if get(hPopupMenu_alignertype,'Value') == 1
            aligner_autotest_calibration('movexforward');
        end
    case 'hold'
        hToggleButtun_hold = findobj(0, 'tag', 'ui4hold');
        hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        if get(hToggleButtun_hold,'Value') == 0
            fclose(fid_log);
            return;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            set(hToggleButtun_hold,'Value',0);
            fclose(fid_log);
            return;
        end
        COM_aligner = get(hText_alignerport,'String');
        [rslt,ack] = serial_command('$1CMD:WHLD_:1',COM_aligner); %HOLD WAFER
        if strncmp(ack, '$1FIN:WHLD_:00000000', 20)
            current_situation = 'hold finished';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        else
            current_situation = 'hold fail';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        end
        set(hToggleButtun_hold,'Value',0);
    case 'release'
        hToggleButtun_release = findobj(0, 'tag', 'ui4release');
        hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        if get(hToggleButtun_release,'Value') == 0
            fclose(fid_log);
            return;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            set(hToggleButtun_release,'Value',0);
            fclose(fid_log);
            return;
        end
        COM_aligner = get(hText_alignerport,'String');
        [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
        if strncmp(ack, '$1FIN:WRLS_:00000000', 20)
            current_situation = 'release finished';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        else
            current_situation = 'release fail';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        end
        set(hToggleButtun_release,'Value',0);
    case 'move0'
        hToggleButtun_move0 = findobj(0, 'tag', 'ui4move0');
        hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        if get(hToggleButtun_move0,'Value') == 0
            fclose(fid_log);
            return;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            set(hToggleButtun_move0,'Value',0);
            fclose(fid_log);
            return;
        end
        COM_cylinder = get(hText_cylinderport,'String');
        [rslt,ack] = serial_z(3,COM_cylinder);
        pause(2);
        set(hToggleButtun_move0,'Value',0);
    case 'move1'
        hToggleButtun_move1 = findobj(0, 'tag', 'ui4move1');
        hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        if get(hToggleButtun_move1,'Value') == 0
            fclose(fid_log);
            return;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            set(hToggleButtun_move1,'Value',0);
            fclose(fid_log);
            return;
        end
        COM_cylinder = get(hText_cylinderport,'String');
        [rslt,ack] = serial_z(4,COM_cylinder);
        pause(2);
        set(hToggleButtun_move1,'Value',0);
    case 'movexforward'
        hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hEdit_xoffset = findobj(0, 'tag', 'ui4xoffset');
        if get(hToggleButtun_communicate,'Value') == 0
            fclose(fid_log);
            return;
        end
        COM_aligner = get(hText_alignerport,'String');
        xOffset = get(hEdit_xoffset,'String');
        [rslt,ack] = serial_command(['$1CMD:MOVED:1,2,' xOffset],COM_aligner);
        %         [rslt,ack] = serial_command(['$1CMD:MOVED:1,2,' num2str(-str2num(xOffset))],COM_aligner);
        if strncmp(ack, '$1FIN:MOVED:00000000', 20)
            current_situation = 'move x forward finished';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        end
    case 'movexbackward'
        hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hEdit_xoffset = findobj(0, 'tag', 'ui4xoffset');
        if get(hToggleButtun_communicate,'Value') == 0
            fclose(fid_log);
            return;
        end
        COM_aligner = get(hText_alignerport,'String');
        xOffset = get(hEdit_xoffset,'String');
        %         [rslt,ack] = serial_command(['$1CMD:MOVED:1,2,' xOffset],COM_aligner);
        [rslt,ack] = serial_command(['$1CMD:MOVED:1,2,' num2str(-str2num(xOffset))],COM_aligner);
        if strncmp(ack, '$1FIN:MOVED:00000000', 20)
            current_situation = 'move x backward finished';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        end
    case 'capture'
        pause(1);
        hToggleButtun_capture = findobj(0, 'tag', 'ui4capture');
        %         hCheckBox_bwinverse = findobj(0, 'tag', 'ui4bwinverse');
        hEdit_ycutstart = findobj(0, 'tag', 'ui4ycutstart');
        hEdit_ycutend = findobj(0, 'tag', 'ui4ycutend');
        hEdit_thresholdgray = findobj(0, 'tag', 'ui4thresholdgray');
        hEdit_thresholdfilter = findobj(0, 'tag', 'ui4thresholdfilter');
        hText_cameraport = findobj(0, 'tag', 'ui4cameraport');
        hAxes_plot = findobj('tag', 'ui4plot');
        hImage = findobj('tag', 'ui4image');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hPopupMenu_number = findobj(0, 'tag', 'ui4number');
        hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        hPopupMenu_wafertype = findobj(0, 'tag', 'ui4wafertype');
        hText_cameraarcport = findobj(0, 'tag', 'ui4cameraarcport');
        if get(hToggleButtun_capture,'Value') == 0
            fclose(fid_log);
            return;
        end
        if get(hToggleButtun_communicate,'Value') == 0
            set(hToggleButtun_capture,'Value',0);
            current_situation = 'communication fail';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        %         selection = questdlg(['Capture?'],...
        %                      ['Capture...'],...
        %                      'Yes','No','No');
        %         if strcmp(selection,'Yes')
        Num = get(hPopupMenu_number,'value')-1;
        %         if (get(hPopupMenu_wafertype,'value')-1)
        %             if Num == 0
        %                 current_situation = 'camera capture';
        %                 set(hText_currentsituation,'String',current_situation);
        %                 clock_log = clock;
        %                 fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        %                 pause(0.001);
        %                 COM_camera = get(hText_cameraport,'String');
        %             else
        %                 current_situation = 'camera capture_a';
        %                 set(hText_currentsituation,'String',current_situation);
        %                 clock_log = clock;
        %                 fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        %                 pause(0.001);
        %                 COM_camera = get(hText_cameraarcport,'String');
        %             end
        %         else
        current_situation = 'camera capture';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        COM_camera = get(hText_cameraport,'String');
        %         end
        rslt = serial_cam_capture(COM_camera,Num);    %20171124
        for n = 1:3
            if rslt ~= 0
                rslt = serial_cam_capture(COM_camera,Num);
            end
            pause(0.001);
            if get(hToggleButtun_capture,'Value') == 0
                fclose(fid_log);
                return;
            end
        end
        if rslt == 0
            current_situation = 'image process';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            pause(0.001);
            % 讀取
            try
                pic = imread(['img',num2str(Num),'\acc',num2str(Num),'.bmp']);
            catch
                aligner_autotest_calibration('capture');
                fclose(fid_log);
                return;
            end
            % 灰度化
            y_start = round(str2num(get(hEdit_ycutstart, 'string')));
            y_end = round(str2num(get(hEdit_ycutend, 'string')));
            %              %matlabpool local 4
            %              for j=size(pic,1)*y_start/12+1:size(pic,1)*y_end/12
            %                  for i= size(pic,2)*0/10+1:size(pic,2)*10/10
            %                      gray_pic(j-size(pic,1)*y_start/12,i-size(pic,2)*0/10) = pic(j,i,1);  % Get gray level picture
            %                  end
            %              end
            pic = pic(size(pic,1)*y_start/12+1:size(pic,1)*y_end/12,:,:);
            gray_pic = rgb2gray(pic);
            %matlabpool close
            clear pic;  %20171128
            % 二值化
            imagen=uint8(gray_pic);
            clear gray_pic;  %20171128
            
            threshold_gray = round(str2num(get(hEdit_thresholdgray, 'string')));    %threshold
            imagen(imagen>threshold_gray)=255 ;
            imagen(imagen<=threshold_gray)=0 ; % Bindary thresholds = 80
            % imshow(imagen) % see the result
            % 黑白邏輯化並反相
            %                 if get(hCheckBox_bwinverse, 'value')==1,
            %                     threshold_bw = graythresh(imagen);
            %                     imagen = im2bw(imagen,threshold_bw);
            %                 else
            %                     threshold_bw = graythresh(imagen);
            %                     imagen =~im2bw(imagen,threshold_bw);
            %                 end
            % 濾除小雜訊
            threshold_bw = graythresh(imagen);
            imagen = im2bw(imagen,threshold_bw);
            threshold_filter = round(str2num(get(hEdit_thresholdfilter, 'string')));    %pixels
            imagen = bwareaopen(imagen,threshold_filter);
            imagen = ~imagen;
            %                 threshold_filter = 100000;    %30 pixels
            imagen = bwareaopen(imagen,threshold_filter);
            %     clf;
            %             if imagen(size(imagen,1),size(imagen,2)) ~= 0
            if imagen(1,1) ~= 0
                imagen = ~imagen;
            end
            %         end
            %         return;
        else
            imagen = 0;
        end
        hImage = imshow(imagen); % see the result
        set(hImage,'Tag', 'ui4image');
        axis on;
        grid on;
        set(hToggleButtun_capture,'Userdata',imagen);
        set(hToggleButtun_capture,'Value',0);
        current_situation = 'capture finished';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
    case 'calculate'
        hToggleButtun_capture = findobj(0, 'tag', 'ui4capture');
        hToggleButtun_calculate = findobj(0, 'tag', 'ui4calculate');
        hEdit_waferradius = findobj(0, 'tag', 'ui4waferradius');
        hText_centerx = findobj(0, 'tag', 'ui4centerx');
        hText_centery = findobj(0, 'tag', 'ui4centery');
        hText_notchx = findobj(0, 'tag', 'ui4notchx');
        hText_notchy = findobj(0, 'tag', 'ui4notchy');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hPopupMenu_wafertype = findobj(0, 'tag', 'ui4wafertype');
        
        if get(hToggleButtun_calculate,'Value') == 0
            fclose(fid_log);
            return;
        end
        current_situation = 'calculate';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        imagen = get(hToggleButtun_capture,'Userdata');
        waferRadius = str2num(get(hEdit_waferradius,'String'))/1000;
        if waferRadius <= 0
            current_situation = 'wafer radius error';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        if size(imagen,2) == 0 || size(imagen,1) == 0
            current_situation = 'picture error';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        %         edge = zeros(imagen(1,:));
        edge = [];
        for i= 1:size(imagen,2)
            for j=1:size(imagen,1)
                %                if imagen(size(imagen,1)+1-j,i) == 1  %0
                %                    edge(i) = size(imagen,1)+1-j;
                if imagen(j,i) == 1  %0
                    edge(i) = j;
                    break;
                end
            end
        end
        if isempty(edge)
            current_situation = 'picture edge error';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            fclose(fid_log);
            return;
        end
        %         syms  x0 y0 y1 y2
        %         S=solve(['(1-x0)^2+(y1-y0)^2=(',num2str(waferRadius),'*300/1.67)^2'],['(3840-x0)^2+(y2-y0)^2=(',num2str(waferRadius),'*300/1.67)^2']);
        %         S=[S.x0 S.y0];
        %         S = subs(S,{'y1','y2'},[edge(1),edge(3840)]);
        %         if S(1,2) < 0
        %             x0 = S(1,1);
        %             y0 = S(1,2);
        %         else
        %             x0 = S(2,1);
        %             y0 = S(2,2);
        %         end
        
        if (get(hPopupMenu_wafertype,'value')-1)
            y_angle = size(imagen,1);
            cnt_y_angle = 0;
            for i= 1+5:size(imagen,2)-5
                edge_temp = 0;
                for j = -5:5
                    edge_temp = edge_temp+edge(i+j);
                end
                edge_temp = edge_temp/11;
                if edge_temp < y_angle
                    y_angle = edge_temp;
                    point(1) = i;
                    point(2) = edge_temp;
                    cnt_y_angle = 0;
                elseif edge_temp == y_angle
                    cnt_y_angle = cnt_y_angle+1;
                    point(1) = (i+cnt_y_angle*point(1))/(cnt_y_angle+1);
                end
            end
            point0 = point;
            point0(1) = round(point0(1));
            
            x1 = 1;
            x2 = point0(1);%size(imagen,2)/3;
            y1 = edge(x1);
            y2 = edge(x2);
            r = waferRadius*300/1.67;
            if y1~=y2
                k1 = (x1-x2)/(y1-y2);
                k2 = ((x1^2-x2^2)+(y1^2-y2^2))/(2*(y1-y2));
                a = 1+k1^2;
                b = -2*x1-2*k1*k2+2*k1*y1;
                c = x1^2+k2^2-2*k2*y1+y1^2-r^2;
                x0 = (-b+(b^2-4*a*c)^0.5)/(2*a);
                y0 = -k1*x0+k2;
                if y0 < 0
                    x0 = (-b-(b^2-4*a*c)^0.5)/(2*a);
                end
                y0 = -k1*x0+k2;
            else
                x0 = (x1+x2)/2;
                y0 = y1+(r^2-(x0-x1)^2)^0.5;
            end
            
            xa = 0;
            ya = 0;
            %             for i= size(imagen,2)/3*2+1:size(imagen,2)
            for i= point0(1):size(imagen,2)
                xa = xa+i;
                ya = ya+edge(i);
            end
            %             xa = xa/(size(imagen,2)/3);
            %             ya = ya/(size(imagen,2)/3);
            xa = xa/(size(imagen,2)-point0(1)+1);
            ya = ya/(size(imagen,2)-point0(1)+1);
            lxx = 0;
            lxy = 0;
            %             for i= size(imagen,2)/3*2+1:size(imagen,2)
            for i= point0(1):size(imagen,2)
                lxx = lxx+(i-xa)*(i-xa);
                lxy = lxy+(i-xa)*(edge(i)-ya);
            end
            b = lxy/lxx;
            a = ya;
            theta = atan(b)/pi*180;
            
            x1 = point0(1);%size(imagen,2)/3*2+1;
            x2 = size(imagen,2);
            y1 = edge(x1);
            y2 = edge(x2);
            theta1 = atan((y1-y2)/(x1-x2))/pi*180;
            
            %             ax+by+c=0
            a = y2-y1;
            b = -(x2-x1);
            c = -a*x1-b*y1;
            d_sq_temp = r^2;
            for i= 1:size(imagen,2)
                d1 = abs(a*i+b*edge(i)+c)/(a^2+b^2);
                d2 = abs(((i-x0)^2+(edge(i)-y0)^2)^0.5-r);
                d_sq = d1^2+d2^2;
                if d_sq < d_sq_temp
                    d_sq_temp = d_sq;
                    point(1) = i;
                    point(2) = edge(i);
                end
            end
            
            %             theta = 0;
            %             theta1 = 0;
            
            x_circle = 1:size(imagen,2)/5*2;
            y_circle = edge(1:size(imagen,2)/5*2);
            x_line = size(imagen,2)/5*3+1:size(imagen,2)/5*3+size(imagen,2)/5*2;
            y_line = edge(size(imagen,2)/5*3+1:size(imagen,2)/5*3+size(imagen,2)/5*2);
            p_circle = Circle_Fitting(x_circle,y_circle);
            x0 = p_circle(1);
            y0 = p_circle(2);
            p_line = polyfit(x_line,y_line,1);
            a = 1+p_line(1)^2;
            b = -2*p_circle(1)+2*p_line(1)*(p_line(2)-p_circle(2));
            c = p_circle(1)^2+(p_line(2)-p_circle(2))^2-p_circle(3)^2;
            point(1) = (-b+(b^2-4*a*c)^0.5)/(2*a);
            if point(1) > size(imagen,2)
                point(1) = (-b-(b^2-4*a*c)^0.5)/(2*a);
            end
            point(2) = p_line(1)*point(1)+p_line(2);
            
        else
            x1 = 1;
            x2 = size(imagen,2);
            y1 = edge(x1);
            y2 = edge(x2);
            r = waferRadius*300/1.67;
            if y1~=y2
                k1 = (x1-x2)/(y1-y2);
                k2 = ((x1^2-x2^2)+(y1^2-y2^2))/(2*(y1-y2));
                a = 1+k1^2;
                b = -2*x1-2*k1*k2+2*k1*y1;
                c = x1^2+k2^2-2*k2*y1+y1^2-r^2;
                x0 = (-b+(b^2-4*a*c)^0.5)/(2*a);
                y0 = -k1*x0+k2;
                if y0 < 0
                    x0 = (-b-(b^2-4*a*c)^0.5)/(2*a);
                end
                y0 = -k1*x0+k2;
            else
                x0 = (x1+x2)/2;
                y0 = y1+(r^2-(x0-x1)^2)^0.5;
            end
            
            radius_notch = waferRadius*300/1.67;
            for i= 1:size(imagen,2)
                if i>50 && i<= size(imagen,2)-50
                    if ((i-x0)^2+((edge(i+50)+edge(i-50))/2-y0)^2)^0.5 < radius_notch
                        point = [i,(edge(i+50)+edge(i-50))/2];
                        radius_notch = ((point(1)-x0)^2+(point(2)-y0)^2)^0.5;
                    end
                else
                    if ((i-x0)^2+(edge(i)-y0)^2)^0.5 < radius_notch
                        point = [i,edge(i)];
                        radius_notch = ((point(1)-x0)^2+(point(2)-y0)^2)^0.5;
                    end
                end
            end
            point = [x0,y0]+(point-[x0,y0])*waferRadius*300/1.67/radius_notch;
            point0 = point;
            
            point = [round(point(1)),edge(round(point(1)))];
            yi = point(1)-200;
            xi = (edge(point(1)-200+50)-edge(point(1)-200-50))/100;
            yi1 = point(1);
            xi1 = (edge(point(1)+50)-edge(point(1)-50))/100;
            yi2 = point(1)+200;
            xi2 = (edge(point(1)+200+50)-edge(point(1)+200-50))/100;
            x = (-1)/((point(2)-y0)/(point(1)-x0));
            y = ((yi*(x-xi1)*(x-xi2)*(xi1-xi)*(xi1-xi2)*(xi2-xi)*(xi2-xi1)+yi1*(x-xi)*(x-xi2)*(xi-xi1)*(xi-xi2)*(xi2-xi)*(xi2-xi1)+yi2*(x-xi)*(x-xi1)*(xi-xi1)*(xi-xi2)*(xi1-xi)*(xi1-xi2))/((xi-xi1)*(xi-xi2)*(xi1-xi)*(xi1-xi2)*(xi2-xi)*(xi2-xi1)));
            point = [round(y),edge(round(y))];
            radius_notch = ((point(1)-x0)^2+(point(2)-y0)^2)^0.5;
            point = [x0,y0]+(point-[x0,y0])*waferRadius*300/1.67/radius_notch;
            
            theta = 0;
            theta1 = 0;
        end
        
        set(hText_centerx,'String',['X(mm):',num2str(x0*1.67/300)]);
        set(hText_centery,'String',['Y(mm):',num2str(y0*1.67/300)]);
        set(hText_notchx,'String',['X(mm):',num2str(point(1)*1.67/300)]);
        set(hText_notchy,'String',['Y(mm):',num2str(point(2)*1.67/300)]);
        set(hToggleButtun_calculate,'Userdata',[point0(1),point0(2),x0,y0,point(1),point(2),theta,theta1]);
        set(hToggleButtun_calculate,'Value',0);
        current_situation = 'calculate finished';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
    case 'calibrate'
        hToggleButtun_calibrate = findobj(0, 'tag', 'ui4calibrate');
        hText_param193 = findobj(0, 'tag', 'ui4param193');
        hText_param194 = findobj(0, 'tag', 'ui4param194');
        hText_param195 = findobj(0, 'tag', 'ui4param195');
        hText_param196 = findobj(0, 'tag', 'ui4param196');
        %         hText_notchx = findobj(0, 'tag', 'ui4notchx');
        %         hText_notchy = findobj(0, 'tag', 'ui4notchy');
        hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        hEdit_path = findobj(0, 'tag', 'ui4path');
        hPopupMenu_wafertype = findobj(0, 'tag', 'ui4wafertype');
        
        if get(hToggleButtun_calibrate,'Value') == 0
            fclose(fid_log);
            return;
        end
        current_situation = 'calibrate';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        pause(0.001);
        %xlsFile = [get(hEdit_path, 'string'),'\',get(hEdit_path, 'string'),'.xls'];
        %sheetName = 'measure';
        measure = csvread([get(hEdit_path, 'string'),'\','measure_',get(hEdit_path, 'string'),'.csv'],2,0);%Read csv file without header
        try
            %n = xlsread(xlsFile,sheetName,'Q16');
            
            n = length(measure(:,1));
        catch exception
            current_situation = 'data read fail';
            set(hText_currentsituation,'String',current_situation);
            clock_log = clock;
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
            pause(0.001);
            set(hToggleButtun_calibrate,'Value',0);
            fclose(fid_log);
            return;
        end
        %         if n<40
        %             current_situation = 'data number fail';
        %             set(hText_currentsituation,'String',current_situation);
        %             clock_log = clock;
        %             fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        %             fclose(fid_log);
        %             return;
        %         end
        
        %         if (get(hPopupMenu_wafertype,'value')-1)
        %             %FLAT
        %             %sheetName = 'measure_a';
        %             measure_a = csvread([get(hEdit_path, 'string'),'\','measure_a','.csv'],2,0);%Read csv file without header
        %
        %             %data(:,1) = -xlsread(xlsFile,sheetName,['T2:T',num2str(n+2)]);    %flat angle
        %             data(:,1) = - measure_a(:,16); %flat angle  theta(deg)
        %             %data(:,2) = 90-xlsread(xlsFile,sheetName,['N2:N',num2str(n+2)]);    %offset angle
        %             data(:,2) = 90 - measure_a(:,14); %offset angle
        %             %data(:,3) = xlsread(xlsFile,sheetName,['O2:O',num2str(n+2)]);   %offset
        %             data(:,3) = measure_a(:,15);%offset
        %             %sheetName = 'measure';
        %         else
        %NOTCH
        %data(:,1) = 90-xlsread(xlsFile,sheetName,['M2:M',num2str(n+2)]);    %notch angle
        %             data(:,1) = 90 -  measure(:,13);%notch angle
        data(:,1) = measure(:,13);%notch angle
        %data(:,2) = 90-xlsread(xlsFile,sheetName,['N2:N',num2str(n+2)]);    %offset angle
        %             data(:,2) = 90 - measure(:,14);%offset angle
        data(:,2) = measure(:,10);%offset mm
        %data(:,3) = xlsread(xlsFile,sheetName,['O2:O',num2str(n+2)]);   %offset
        %             data(:,3) = measure(:,15);%offset
        data(:,3) = measure(:,11);%offset deg
        %         end
        
        %sheetName = 'data';
        SheetData = csvread([get(hEdit_path, 'string'),'\','data_',get(hEdit_path, 'string'),'.csv'],2,0);%Read csv file without header
        deg_Encoder = 360/40000;
        mm_CCD = 0.014;
        %data(:,4) = xlsread(xlsFile,sheetName,['B2:B',num2str(n+2)])*deg_Encoder;   %notch angle
        data(:,4) = SheetData(:,2)*deg_Encoder; %notch angle
        %data(:,5) = xlsread(xlsFile,sheetName,['D2:D',num2str(n+2)])*deg_Encoder;   %offset angle
        data(:,5) = SheetData(:,4)*deg_Encoder;%offset angle
        %data(:,6) = xlsread(xlsFile,sheetName,['E2:E',num2str(n+2)])*mm_CCD;    %offset
        data(:,6) = SheetData(:,5)*mm_CCD; %offset
        %sheetName = 'result';
        result = csvread([get(hEdit_path, 'string'),'\','result_',get(hEdit_path, 'string'),'.csv'],2,0);%Read csv file without header
        %data(:,7) = xlsread(xlsFile,sheetName,['E2:E',num2str(n+2)])/1000;  %x
        data(:,7) = result(:,5)/1000; %x
        %data(:,8) = xlsread(xlsFile,sheetName,['F2:F',num2str(n+2)])/1000;  %y
        data(:,8) =result(:,6)/1000; %y
        %data(:,9) = xlsread(xlsFile,sheetName,['G2:G',num2str(n+2)])/1000;  %theta
        data(:,9) =result(:,7)/1000;%theta
        
        angle_aligner_camera = mean(data(:,1),1)-180;
        %         data(:,10) = data(:,1)-angle_aligner_camera;
        data(:,10) = data(:,1)-mean(data(:,1),1);
        %         data(:,11) = data(:,2)-angle_aligner_camera;
        data(:,11) = data(:,5)-data(:,4);
        
        %         amplitude = mean(data(:,3),1);
        %         amplitude = min(max(data(:,2)),max(data(:,3)));
        %         for angle_offset = 0:359
        %             if angle_offset == 0
        % %                 delta_old = sum(abs(data(:,5)-data(:,9)+angle_offset-data(:,11)));
        %                 delta_old = sum(abs(data(:,5)-data(:,9)+angle_offset));
        %             else
        % %                 delta = sum(abs(data(:,5)-data(:,9)+angle_offset-data(:,11)));
        %                 delta = sum(abs(data(:,5)-data(:,9)+angle_offset));
        %                 if delta <= delta_old
        %                     delta_old = delta;
        %                 else
        %                     angle_offset = angle_offset-1;
        %                     break;
        %                 end
        %             end
        %         end
        
        %         amplitude = mean(abs(data(:,2)));
        amplitude = (sum(data(:,2).^2)/n)^0.5;
        for i = 0:359
            if i == 0
                delta_old = sum(abs(amplitude*sin((data(:,11)+i+90)*pi/180)-data(:,2)));
            else
                delta = sum(abs(amplitude*sin((data(:,11)+i+90)*pi/180)-data(:,2)));
                if delta <= delta_old
                    delta_old = delta;
                    angle_offset = i;
                end
            end
        end
        %         for i = 0:359
        %             if i == 0
        % %                 delta_old = sum(abs(data(:,5)-data(:,9)+angle_offset-data(:,11)));
        %                 delta_old = sum(abs(data(:,5)-data(:,9)+i+angle_aligner_camera));
        %             else
        % %                 delta = sum(abs(data(:,5)-data(:,9)+angle_offset-data(:,11)));
        %                 delta = sum(abs(data(:,5)-data(:,9)+i+angle_aligner_camera));
        %                 if delta <= delta_old
        %                     delta_old = delta;
        %                     angle_offset = i;
        %                 end
        %             end
        %         end
        param193 = angle_offset*1000;
        param194 = round(amplitude/mean(data(:,6),1)*5/mm_CCD);
        
        %         amplitude = mean(abs(data(:,10)-180),1);
        %         for angle_offset = 0:359
        %             if angle_offset == 0
        %                 delta_old = sum(abs(amplitude*sin((data(:,5)-data(:,9)+angle_offset)*pi/180)+180-data(:,10)));
        %             else
        %                 delta = sum(abs(amplitude*sin((data(:,5)-data(:,9)+angle_offset)*pi/180)+180-data(:,10)));
        %                 if delta <= delta_old
        %                     delta_old = delta;
        %                 else
        %                     angle_offset = angle_offset-1;
        %                     break;
        %                 end
        %             end
        %         end
        %         for i =0:5
        %             amplitude = amplitude+deg_Encoder;
        %             delta = sum(abs(amplitude*sin((data(:,5)-data(:,9)+angle_offset)*pi/180)+180-data(:,10)));
        %             if delta <= delta_old
        %                 delta_old = delta;
        %             else
        %                 amplitude = amplitude-deg_Encoder;
        %                 break;
        %             end
        %         end
        %         for i =0:5
        %             amplitude = amplitude-deg_Encoder;
        %             delta = sum(abs(amplitude*sin((data(:,5)-data(:,9)+angle_offset)*pi/180)+180-data(:,10)));
        %             if delta <= delta_old
        %                 delta_old = delta;
        %             else
        %                 amplitude = amplitude+deg_Encoder;
        %                 break;
        %             end
        %         end
        
        %         amplitude = mean(abs(data(:,10)));
        amplitude = (sum(data(:,10).^2)/n)^0.5;
        for i = 0:359
            if i == 0
                delta_old = sum(abs(amplitude*sin((data(:,11)+i+180)*pi/180)-data(:,10)));
            else
                delta = sum(abs(amplitude*sin((data(:,11)+i+180)*pi/180)-data(:,10)));
                if delta <= delta_old
                    delta_old = delta;
                    angle_offset = i;
                end
            end
        end
        param195 = angle_offset*1000;
        param196 = round(amplitude/mean(data(:,6),1)*5/deg_Encoder);
        
        set(hText_param193,'String',['26:',num2str(param193)]);
        set(hText_param194,'String',['27:',num2str(param194)]);
        set(hText_param195,'String',['28:',num2str(param195)]);
        set(hText_param196,'String',['29:',num2str(param196)]);
        %         set(hText_notchx,'String',['X(mm):',num2str(point(1)*1.67/300)]);
        %         set(hText_notchy,'String',['Y(mm):',num2str(point(2)*1.67/300)]);
        set(hToggleButtun_calibrate,'Userdata',[param193,param194]);
        set(hToggleButtun_calibrate,'Value',0);
        current_situation = 'calibrate finished';
        set(hText_currentsituation,'String',current_situation);
        clock_log = clock;
        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        %     case 'thetatest'
        %         hEdit_anglenotch = findobj(0, 'tag', 'ui4anglenotch');
        %         hToggleButtun_run = findobj(0, 'tag', 'ui4run');
        %         hToggleButtun_align = findobj(0, 'tag', 'ui4align');
        %         hToggleButtun_capture = findobj(0, 'tag', 'ui4capture');
        %         hToggleButtun_calculate = findobj(0, 'tag', 'ui4calculate');
        %         hEdit_testcount = findobj(0, 'tag', 'ui4testcount');
        %         hFigure = findobj(0, 'tag', 'ui4figure');
        %
        %         hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
        %         hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
        %
        %         hEdit_path = findobj(0, 'tag', 'ui4path');
        %
        %         hCheckBox_loaddata = findobj(0, 'tag', 'ui4loaddata');
        %         hPopupMenu_testmode = findobj(0, 'tag', 'ui4testmode');
        %         hEdit_x = findobj(0, 'tag', 'ui4offsetx');
        %         hEdit_y = findobj(0, 'tag', 'ui4offsety');
        %         hEdit_theta = findobj(0, 'tag', 'ui4offsettheta');
        %
        %         hText_aligntimeaverage = findobj(0, 'tag', 'ui4aligntimeaverage');
        %         hText_aligntimemax = findobj(0, 'tag', 'ui4aligntimemax');
        %         hText_aligntimemin = findobj(0, 'tag', 'ui4aligntimemin');
        %         hText_centerxaverage = findobj(0, 'tag', 'ui4centerxaverage');
        %         hText_centeryaverage = findobj(0, 'tag', 'ui4centeryaverage');
        %         hText_notchxaverage = findobj(0, 'tag', 'ui4notchxaverage');
        %         hText_notchyaverage = findobj(0, 'tag', 'ui4notchyaverage');
        %         hText_offsetmm = findobj(0, 'tag', 'ui4resultoffsetmm');
        %         hText_offsetdeg = findobj(0, 'tag', 'ui4resultoffsetdeg');
        %         hText_fqc = findobj(0, 'tag', 'ui4fqc');
        %         hText_fqc1 = findobj(0, 'tag', 'ui4fqc1');
        %         hText_fqc2 = findobj(0, 'tag', 'ui4fqc2');
        %         hText_fqc3 = findobj(0, 'tag', 'ui4fqc3');
        %         hText_fqc4 = findobj(0, 'tag', 'ui4fqc4');
        %         hText_fqc5 = findobj(0, 'tag', 'ui4fqc5');
        %         hText_fqc6 = findobj(0, 'tag', 'ui4fqc6');
        %
        %         hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        %         hPopupMenu_alignertype = findobj(0, 'tag', 'ui4alignertype');
        %         hPopupMenu_wafertype = findobj(0, 'tag', 'ui4wafertype');
        %         hPopupMenu_number = findobj(0, 'tag', 'ui4number');
        %
        %         hEdit_picturecount = findobj(0, 'tag', 'ui4picturecount');
        %         hText_testcountheader = findobj(0, 'tag', 'ui4testcountheader');
        %         testCount = round(str2num(get(hEdit_testcount, 'string')));
        %         picCount = round(str2num(get(hEdit_picturecount, 'string')));
        %
        %         COM_cylinder = get(hText_cylinderport,'String');
        %         COM_aligner = get(hText_alignerport,'String');
        %         hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
        %         MeasureUtility.Reset_All();
        %         Measure_aUtility.Reset_All();
        %         COM_aligner = get(hText_alignerport,'String');
        %         hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
        %         current_situation = 'theta test';
        %         set(hText_currentsituation,'String',current_situation);
        %         clock_log = clock;
        %         fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
        %         %init
        %         [rslt,ack,t] = serial_command(['$1CMD:ALIGN:85000,1,0,1'],COM_aligner);
        %         if get(hToggleButtun_capture,'Value') == 0
        %             set(hToggleButtun_capture,'Value',1);
        %         end
        %         aligner_autotest_calibration('capture');
        %         pause(1);
        %         [rslt,ack] = serial_command('$1CMD:MOVED:4,1,+00000000',COM_aligner);    %Z DOWN
        %         testcount=round(str2num(get(hEdit_testcount, 'string')))
        %         offsetTheta = get(hEdit_anglenotch,'String');
        %         for n = 0:testcount%120
        %             disp(strcat(current_situation,int2str(n)));
        %             %[rslt,ack] = serial_command(['$1CMD:MOVED:3,2,360000'],COM_aligner);
        %             [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(offsetTheta)],COM_aligner);
        %             pause(0.1);
        %             if get(hToggleButtun_capture,'Value') == 0
        %                 set(hToggleButtun_capture,'Value',1);
        %             end
        %             aligner_autotest_calibration('capture');
        %         end
        %         for n = 0:testcount%120
        %             disp(strcat(current_situation,int2str(n)));
        %             %[rslt,ack] = serial_command(['$1CMD:MOVED:3,2,360000'],COM_aligner);
        %             [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,-' num2str(offsetTheta)],COM_aligner);
        %             pause(0.1);
        %             if get(hToggleButtun_capture,'Value') == 0
        %                 set(hToggleButtun_capture,'Value',1);
        %             end
        %             aligner_autotest_calibration('capture');
        %         end
        %         disp('After test1');
        %         return;
    case 'run'
        try
            hToggleButtun_run = findobj(0, 'tag', 'ui4run');
            hToggleButtun_align = findobj(0, 'tag', 'ui4align');
            hToggleButtun_capture = findobj(0, 'tag', 'ui4capture');
            hToggleButtun_calculate = findobj(0, 'tag', 'ui4calculate');
            hEdit_testcount = findobj(0, 'tag', 'ui4testcount');
            hFigure = findobj(0, 'tag', 'ui4figure');
            
            hText_cylinderport = findobj(0, 'tag', 'ui4cylinderport');
            hText_alignerport = findobj(0, 'tag', 'ui4alignerport');
            
            hEdit_path = findobj(0, 'tag', 'ui4path');
            
            hCheckBox_loaddata = findobj(0, 'tag', 'ui4loaddata');
            hPopupMenu_testmode = findobj(0, 'tag', 'ui4testmode');
            hEdit_x = findobj(0, 'tag', 'ui4offsetx');
            hEdit_y = findobj(0, 'tag', 'ui4offsety');
            hEdit_theta = findobj(0, 'tag', 'ui4offsettheta');
            
            hText_aligntimeaverage = findobj(0, 'tag', 'ui4aligntimeaverage');
            hText_aligntimemax = findobj(0, 'tag', 'ui4aligntimemax');
            hText_aligntimemin = findobj(0, 'tag', 'ui4aligntimemin');
            hText_centerxaverage = findobj(0, 'tag', 'ui4centerxaverage');
            hText_centeryaverage = findobj(0, 'tag', 'ui4centeryaverage');
            hText_notchxaverage = findobj(0, 'tag', 'ui4notchxaverage');
            hText_notchyaverage = findobj(0, 'tag', 'ui4notchyaverage');
            hText_offsetmm = findobj(0, 'tag', 'ui4resultoffsetmm');
            hText_offsetdeg = findobj(0, 'tag', 'ui4resultoffsetdeg');
            hText_fqc = findobj(0, 'tag', 'ui4fqc');
            hText_fqc1 = findobj(0, 'tag', 'ui4fqc1');
            hText_fqc2 = findobj(0, 'tag', 'ui4fqc2');
            hText_fqc3 = findobj(0, 'tag', 'ui4fqc3');
            hText_fqc4 = findobj(0, 'tag', 'ui4fqc4');
            hText_fqc5 = findobj(0, 'tag', 'ui4fqc5');
            hText_fqc6 = findobj(0, 'tag', 'ui4fqc6');
            
            hText_currentsituation = findobj(0, 'tag', 'ui4currentsituation');
            hPopupMenu_alignertype = findobj(0, 'tag', 'ui4alignertype');
            hPopupMenu_wafertype = findobj(0, 'tag', 'ui4wafertype');
            hPopupMenu_number = findobj(0, 'tag', 'ui4number');
            
            hEdit_picturecount = findobj(0, 'tag', 'ui4picturecount');
            hText_testcountheader = findobj(0, 'tag', 'ui4testcountheader');
            testCount = round(str2num(get(hEdit_testcount, 'string')));
            picCount = round(str2num(get(hEdit_picturecount, 'string')));
            if testCount < 0
                current_situation = 'test count error';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                fclose(fid_log);
                return;
            end
            if picCount <= 0
                current_situation = 'picture count error';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                fclose(fid_log);
                return;
            end
            COM_cylinder = get(hText_cylinderport,'String');
            COM_aligner = get(hText_alignerport,'String');
            hToggleButtun_communicate = findobj(0, 'tag', 'ui4communicate');
            MeasureUtility.Reset_All();
            Measure_aUtility.Reset_All();
            ttlStart = tic;
            for n = 0:testCount
                MeasureUtility.Var_n(n); %把n存入記憶體
                tStart=tic;
                
                if get(hToggleButtun_run,'Value') == 0
                    fclose(fid_log);
                    return;
                end
                if get(hToggleButtun_communicate,'Value') == 0
                    set(hToggleButtun_run,'Value',0);
                    current_situation = 'communication fail';
                    set(hText_currentsituation,'String',current_situation);
                    clock_log = clock;
                    fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                    fclose(fid_log);
                    return;
                end
                
                %             aligner_autotest_calibration('movex');
                if get(hPopupMenu_testmode, 'value') ~= 4
                    if n~= 0
                        current_situation = 'move wafer to the position';
                        set(hText_currentsituation,'String',current_situation);
                        clock_log = clock;
                        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                        pause(0.001);
                        
                        t = get(hToggleButtun_align,'Userdata');
                        ack = t{1};
                        if strncmp(ack, '$1FIN:ALIGN:00000000', 20)
                            offsetX = round(str2num(get(hEdit_x, 'string')));
                            offsetY = round(str2num(get(hEdit_y, 'string')));
                            offsetTheta = round(str2num(get(hEdit_theta, 'string')));
                            if (get(hPopupMenu_testmode, 'value') ~= 2 && (offsetX > 8000 || offsetY > 8000)) || (get(hPopupMenu_testmode, 'value') == 2 && offsetX > 8000)
                                current_situation = 'test mode range error';
                                set(hText_currentsituation,'String',current_situation);
                                clock_log = clock;
                                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                                fclose(fid_log);
                                return;
                            end
                            
                            if get(hPopupMenu_alignertype,'Value') == 1
                                [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                                %           pause(1);
                                if rslt ~= 0
                                    [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                                    if rslt ~= 0
                                        current_situation = 'wafer release fail';
                                        set(hText_currentsituation,'String',current_situation);
                                        clock_log = clock;
                                        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                                        fclose(fid_log);
                                        return;
                                    end
                                end
                                [rslt,ack] = serial_z(4,COM_cylinder);
                                pause(2);
                            end
                            
                            [rslt,ack] = serial_command('$1CMD:HOME_',COM_aligner);    %HOME
                            
                            if get(hPopupMenu_alignertype,'Value') == 1
                                [rslt,ack] = serial_z(3,COM_cylinder);
                                [rslt,ack] = serial_command('$1CMD:WHLD_:1',COM_aligner); %HOLD WAFER
                                pause(2);
                            else
                                [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,10000,00',COM_aligner);    %X CLAMP
                                [rslt,ack] = serial_command('$1CMD:MOVED:4,1,+00000000',COM_aligner);    %Z DOWN
                            end
                            
                            switch get(hPopupMenu_testmode, 'value')
                                case 1  %fix
                                    if get(hPopupMenu_alignertype,'Value') == 1
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta,360000))],COM_aligner);
                                    else
                                        if (rem(rem(offsetTheta,360000),120000) < 30000 && rem(rem(offsetTheta,360000),120000) >= 0) || (rem(rem(offsetTheta,360000),120000) < -90000 && rem(rem(offsetTheta,360000),120000) < 0)
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta,360000)+30000)],COM_aligner);
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                            [rslt,ack] = serial_command('$1CMD:MOVED:5,2,+00002000',COM_aligner);    %X CLAMP
                                            [rslt,ack] = serial_command('$1CMD:MOVED:4,2,+00006000',COM_aligner);    %Z UP
                                            [rslt,ack] = serial_command('$1CMD:HOME_',COM_aligner);    %HOME
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,10000,00',COM_aligner);    %X CLAMP
                                            [rslt,ack] = serial_command('$1CMD:MOVED:4,1,+00000000',COM_aligner);    %Z DOWN
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(-30000)],COM_aligner);
                                        else
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta,360000))],COM_aligner);
                                        end
                                    end
                                    if get(hPopupMenu_alignertype,'Value') == 1
                                        [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                                        if rslt ~= 0
                                            [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                                            if rslt ~= 0
                                                current_situation = 'wafer release fail';
                                                set(hText_currentsituation,'String',current_situation);
                                                clock_log = clock;
                                                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                                                fclose(fid_log);
                                                return;
                                            end
                                        end
                                        [rslt,ack] = serial_z(4,COM_cylinder);
                                        pause(2);
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:1,2,' num2str(rem(offsetX,8000))],COM_aligner);
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:2,2,' num2str(rem(offsetY,8000))],COM_aligner);
                                    end
                                case 2  %step offset
                                    if get(hPopupMenu_alignertype,'Value') == 1
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta,360000))],COM_aligner);
                                    else
                                        if (rem(rem(offsetTheta,360000),120000) < 30000 && rem(rem(offsetTheta,360000),120000) >= 0) || (rem(rem(offsetTheta,360000),120000) < -90000 && rem(rem(offsetTheta,360000),120000) < 0)
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta,360000)+30000)],COM_aligner);
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                            [rslt,ack] = serial_command('$1CMD:MOVED:5,2,+00002000',COM_aligner);    %X CLAMP
                                            [rslt,ack] = serial_command('$1CMD:MOVED:4,2,+00006000',COM_aligner);    %Z UP
                                            [rslt,ack] = serial_command('$1CMD:HOME_',COM_aligner);    %HOME
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,10000,00',COM_aligner);    %X CLAMP
                                            [rslt,ack] = serial_command('$1CMD:MOVED:4,1,+00000000',COM_aligner);    %Z DOWN
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(-30000)],COM_aligner);
                                        else
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta,360000))],COM_aligner);
                                        end
                                    end
                                    if get(hPopupMenu_alignertype,'Value') == 1
                                        [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                                        if rslt ~= 0
                                            [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                                            if rslt ~= 0
                                                current_situation = 'wafer release fail';
                                                set(hText_currentsituation,'String',current_situation);
                                                clock_log = clock;
                                                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                                                fclose(fid_log);
                                                return;
                                            end
                                        end
                                        [rslt,ack] = serial_z(4,COM_cylinder);
                                        pause(2);
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:1,2,' num2str(round(rem(offsetX*cos(offsetY*n*pi/180000),8000)))],COM_aligner);
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:2,2,' num2str(round(rem(offsetX*sin(offsetY*n*pi/180000),8000)))],COM_aligner);
                                    end
                                case 3  %step notch
                                    if get(hPopupMenu_alignertype,'Value') == 1
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta*n,360000))],COM_aligner);
                                    else
                                        if (rem(rem(offsetTheta*n,360000),120000) < 30000 && rem(rem(offsetTheta*n,360000),120000) >= 0) || (rem(rem(offsetTheta*n,360000),120000) < -90000 && rem(rem(offsetTheta*n,360000),120000) < 0)
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta*n,360000)+30000)],COM_aligner);
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                            [rslt,ack] = serial_command('$1CMD:MOVED:5,2,+00002000',COM_aligner);    %X UnCLAMP
                                            [rslt,ack] = serial_command('$1CMD:MOVED:4,2,+00006000',COM_aligner);    %Z UP
                                            [rslt,ack] = serial_command('$1CMD:HOME_',COM_aligner);    %HOME
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                            [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,10000,00',COM_aligner);    %X CLAMP
                                            [rslt,ack] = serial_command('$1CMD:MOVED:4,1,+00000000',COM_aligner);    %Z DOWN
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(-30000)],COM_aligner);
                                        else
                                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(rem(offsetTheta*n,360000))],COM_aligner);
                                        end
                                    end
                                    if get(hPopupMenu_alignertype,'Value') == 1
                                        [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                                        if rslt ~= 0
                                            [rslt,ack] = serial_command('$1CMD:WRLS_:1',COM_aligner); %RELEASE WAFER
                                            if rslt ~= 0
                                                current_situation = 'wafer release fail';
                                                set(hText_currentsituation,'String',current_situation);
                                                clock_log = clock;
                                                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                                                fclose(fid_log);
                                                return;
                                            end
                                        end
                                        [rslt,ack] = serial_z(4,COM_cylinder);
                                        pause(2);
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:1,2,' num2str(rem(offsetX,8000))],COM_aligner);
                                        [rslt,ack] = serial_command(['$1CMD:MOVED:2,2,' num2str(rem(offsetY,8000))],COM_aligner);
                                    end
                                otherwise
                                    disp('Unknown option');
                                    fclose(fid_log);
                                    return;
                            end
                            
                            if get(hPopupMenu_alignertype,'Value') == 1
                                [rslt,ack] = serial_z(3,COM_cylinder);
                                [rslt,ack] = serial_command('$1CMD:WHLD_:1',COM_aligner); %HOLD WAFER
                                pause(2);
                            else
                                [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                [rslt,ack] = serial_command('$1CMD:MOVED:5,2,+00002000',COM_aligner);    %X CLAMP
                                [rslt,ack] = serial_command('$1CMD:MOVED:4,2,+00006000',COM_aligner);    %Z UP
                                [rslt,ack] = serial_command('$1CMD:HOME_',COM_aligner);    %HOME
                            end
                            
                        end
                    end
                    
                    if get(hToggleButtun_align,'Value') == 0
                        set(hToggleButtun_align,'Value',1);
                    end
                    pause(0.1);
                    %             pause(0.001);
                    aligner_autotest_calibration('align');
                    
                    [status, msg, msgID] = mkdir(get(hEdit_path, 'string'));
                    t = get(hToggleButtun_align,'Userdata');
                    ack = t{1};
                    if get(hCheckBox_loaddata,'Value') == 1 || ~strncmp(ack, '$1FIN:ALIGN:00000000', 20)
                        current_situation = 'download ccd & encoder data';
                        set(hText_currentsituation,'String',current_situation);
                        clock_log = clock;
                        fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                        pause(0.001);
                        [rslt,ack_get,data] = serial_get('$1GET:ALIGN:9',COM_aligner); % data read & save
                        data_save = str2num(data);
                        clear data; %20171128
                        csvwrite([get(hEdit_path, 'string'),'\n',num2str(n),'.csv'],data_save);
                        clear data_save;    %20171128
                        tmpReply = regexp(ack,':','split');
                        tmp = char(tmpReply(3));
                        AlignReply = regexprep(tmp,'[\n\r]+','');
                        if (hex2dec(AlignReply) < hex2dec('86800000') || hex2dec(AlignReply) > hex2dec('86900000')) && hex2dec(AlignReply) ~= hex2dec('96860000') && hex2dec(AlignReply) ~= hex2dec('00000000')
                            current_situation = ack;
                            set(hText_currentsituation,'String',current_situation);
                            break;
                        end
                    end
                    current_situation = 'save align data';
                    set(hText_currentsituation,'String',current_situation);
                    clock_log = clock;
                    fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                    pause(0.001);
                    [rslt,ackali] = serial_get('$1GET:ALIGN:0',COM_aligner);
                    %xlsFile = [get(hEdit_path, 'string'),'\',get(hEdit_path, 'string'),'.xls'];
                    %sheetName='data';
                    if n == 0
                        %                headers =  {'n','notch angle','offset angle','offset','encoder data abs','cpld count','ccd average','ccd max','num ccd max','encoder ccd max','ccd min','num ccd min','encoder ccd min','ccd per encoder max','num ccd per encoder max','encoder ccd per encoder max','count ccd per encoder max','ccd per encoder min','num ccd per encoder min','encoder ccd per encoder min','count ccd per encoder min','result','threshold','photo intensity','photo switch','photo sense 0','photo sense 1'};
                        headers =  {'n','encoder notch','encoder notch delta','encoder offset','ccd offset','encoder 2nd flat','encoder data abs','cpld count','ccd average','ccd max','num ccd max','encoder ccd max','ccd min','num ccd min','encoder ccd min','ccd per encoder max','num ccd per encoder max','encoder ccd per encoder max','count ccd per encoder max','ccd per encoder min','num ccd per encoder min','encoder ccd per encoder min','count ccd per encoder min','ccd per encoder max','num ccd per encoder max','encoder ccd per encoder max','count ccd per encoder max','ccd per encoder min','num ccd per encoder min','encoder ccd per encoder min','count ccd per encoder min','result','threshold','photo intensity','photo switch','photo sense 0','photo sense 1'};
                        %[status,msg] = xlswrite(xlsFile,headers,sheetName);
                        %fid = fopen('D:\Output\data.csv', 'w') ;
                        fid = fopen( [get(hEdit_path, 'string'),'\','data_',get(hEdit_path, 'string'),'.csv'], 'w') ;
                        
                        fprintf(fid, '%s,', headers{1,1:end-1}) ;
                        fprintf(fid, '%s\n', headers{1,end}) ;
                        fclose(fid) ;
                    end
                    %                 [status,msg] = xlswrite(xlsFile,n,sheetName,['A',num2str(n+2)]);
                    ackali_split = regexp(ackali,'\$1ACK\:ALIGN\:','split');
                    ackali_split = regexp(ackali_split{1,2},'\r','split');
                    ackali_split = regexp(ackali_split{1,1},',','split');
                    ackali_split = [num2str(n),ackali_split];
                    %                 [status,msg] = xlswrite(xlsFile,ackali_split,sheetName,['B',num2str(n+2)]);
                    %寫入資料至CSV，逗號分隔
                    fid = fopen([get(hEdit_path, 'string'),'\','data_',get(hEdit_path, 'string'),'.csv'], 'a') ;
                    fprintf(fid, '%s,', ackali_split{1,1:end-1}) ;
                    fprintf(fid, '%s\n', ackali_split{1,end}) ;
                    fclose(fid);
                    %[status,msg] = xlswrite(xlsFile,[n,ackali_split],sheetName,['A',num2str(n+2)]);
                    
                    t = get(hToggleButtun_align,'Userdata');
                    ack = t{1};
                    t = str2num(t{2});
                    if ~strncmp(ack, '$1FIN:ALIGN:00000000', 20)    %if fail don't capture
                        tElapsed=toc(tStart);
                        [rslt,ack] = serial_command('$1CMD:HOME_',COM_aligner);    %HOME
                        continue;
                    end
                else %Theta test
                    offsetTheta = round(str2num(get(hEdit_theta, 'string')));
                    if rem(offsetTheta,360000) == 0
                        if n == 0
                            if get(hToggleButtun_align,'Value') == 0
                                set(hToggleButtun_align,'Value',1);
                            end
                            pause(0.1);
                            aligner_autotest_calibration('align');
                            t = get(hToggleButtun_align,'Userdata');
                            ack = t{1};
                            tmpReply = regexp(ack,':','split');
                            tmp = char(tmpReply(3));
                            AlignReply = regexprep(tmp,'[\n\r]+','');
                            if (hex2dec(AlignReply) < hex2dec('86800000') || hex2dec(AlignReply) > hex2dec('86900000')) && hex2dec(AlignReply) ~= hex2dec('96860000') && hex2dec(AlignReply) ~= hex2dec('00000000')
                                current_situation = ack;
                                set(hText_currentsituation,'String',current_situation);
                                break;
                            end
                        else
%                             if n==1
                                [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                                [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,10000,00',COM_aligner);    %X CLAMP
                                [rslt,ack] = serial_command('$1CMD:MOVED:4,1,+00000000',COM_aligner);    %Z DOWN
%                             end
                            [rslt,ack] = serial_command(['$1CMD:MOVED:3,2,' num2str(offsetTheta)],COM_aligner);
                             [rslt,ack] = serial_command('$1CMD:MOVDP:1989 ,01000,00',COM_aligner);    %Z MID-DOWN
                             [rslt,ack] = serial_command('$1CMD:MOVED:5,2,+00002000',COM_aligner);    %X CLAMP
                             [rslt,ack] = serial_command('$1CMD:MOVED:4,2,+00006000',COM_aligner);    %Z UP
                            current_situation = 'save align data';
                            set(hText_currentsituation,'String',current_situation);
                            clock_log = clock;
                            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                            pause(0.001);
                            [rslt,ackali] = serial_get('$1GET:ALIGN:0',COM_aligner);
                            %xlsFile = [get(hEdit_path, 'string'),'\',get(hEdit_path, 'string'),'.xls'];
                            %sheetName='data';
                            if n == 0
                                %                headers =  {'n','notch angle','offset angle','offset','encoder data abs','cpld count','ccd average','ccd max','num ccd max','encoder ccd max','ccd min','num ccd min','encoder ccd min','ccd per encoder max','num ccd per encoder max','encoder ccd per encoder max','count ccd per encoder max','ccd per encoder min','num ccd per encoder min','encoder ccd per encoder min','count ccd per encoder min','result','threshold','photo intensity','photo switch','photo sense 0','photo sense 1'};
                                headers =  {'n','encoder notch','encoder notch delta','encoder offset','ccd offset','encoder 2nd flat','encoder data abs','cpld count','ccd average','ccd max','num ccd max','encoder ccd max','ccd min','num ccd min','encoder ccd min','ccd per encoder max','num ccd per encoder max','encoder ccd per encoder max','count ccd per encoder max','ccd per encoder min','num ccd per encoder min','encoder ccd per encoder min','count ccd per encoder min','ccd per encoder max','num ccd per encoder max','encoder ccd per encoder max','count ccd per encoder max','ccd per encoder min','num ccd per encoder min','encoder ccd per encoder min','count ccd per encoder min','result','threshold','photo intensity','photo switch','photo sense 0','photo sense 1'};
                                %[status,msg] = xlswrite(xlsFile,headers,sheetName);
                                %fid = fopen('D:\Output\data.csv', 'w') ;
                                fid = fopen( [get(hEdit_path, 'string'),'\','data_',get(hEdit_path, 'string'),'.csv'], 'w') ;
                                
                                fprintf(fid, '%s,', headers{1,1:end-1}) ;
                                fprintf(fid, '%s\n', headers{1,end}) ;
                                fclose(fid) ;
                            end
                            %                 [status,msg] = xlswrite(xlsFile,n,sheetName,['A',num2str(n+2)]);
                            ackali_split = regexp(ackali,'\$1ACK\:ALIGN\:','split');
                            ackali_split = regexp(ackali_split{1,2},'\r','split');
                            ackali_split = regexp(ackali_split{1,1},',','split');
                            ackali_split = [num2str(n),ackali_split];
                            %                 [status,msg] = xlswrite(xlsFile,ackali_split,sheetName,['B',num2str(n+2)]);
                            %寫入資料至CSV，逗號分隔
                            fid = fopen([get(hEdit_path, 'string'),'\','data_',get(hEdit_path, 'string'),'.csv'], 'a') ;
                            fprintf(fid, '%s,', ackali_split{1,1:end-1}) ;
                            fprintf(fid, '%s\n', ackali_split{1,end}) ;
                            fclose(fid);
                            
                        end
                    else
                        current_situation = 'offsetTheta invalid!';
                        set(hText_currentsituation,'String',current_situation);
                        break;
                    end
                end
                for i = 1:picCount
                    if get(hToggleButtun_run,'Value') == 0
                        fclose(fid_log);
                        return;
                    end
                    if get(hToggleButtun_capture,'Value') == 0
                        set(hToggleButtun_capture,'Value',1);
                    end
                    if i == 1
                        pause(2.0);
                        if n == 0
                            point0_old = [0 0 0 0 0 0 0 0];
                            x0_old = point0_old(3);
                            y0_old = point0_old(4);
                            point_old(1) = point0_old(5);
                            point_old(2) = point0_old(6);
                            theta_old = point0_old(7);
                            theta1_old = point0_old(8);
                        else
                            point0_old = point0;
                            x0_old = x0;
                            y0_old = y0;
                            point_old = point;
                            theta_old = theta;
                            theta1_old = theta1;
                        end
                    end
                    
                    pause(0.001);
                    aligner_autotest_calibration('capture');
                    
                    if get(hToggleButtun_run,'Value') == 0
                        fclose(fid_log);
                        return;
                    end
                    if get(hToggleButtun_calculate,'Value') == 0
                        set(hToggleButtun_calculate,'Value',1);
                    end
                    pause(0.001);
                    aligner_autotest_calibration('calculate');
                    point0_temp = get(hToggleButtun_calculate,'Userdata');
                    x0_temp = point0_temp(3);
                    y0_temp = point0_temp(4);
                    point_temp(1) = point0_temp(5);
                    point_temp(2) = point0_temp(6);
                    theta_temp = point0_temp(7);
                    theta1_temp = point0_temp(8);
                    diffpoint0_temp = (point0_temp(1) - point0_old(1))^2+(point0_temp(2) - point0_old(2))^2;
                    diff0_temp = (x0_temp - x0_old)^2+(y0_temp - y0_old)^2;
                    diffpoint_temp = sum((point_temp - point_old).^2);
                    difftheta_temp = (theta_temp - theta_old)^2;
                    difftheta1_temp = (theta1_temp - theta1_old)^2;
                    if n ~= 0
                        if i == 1
                            diffpoint0 = diffpoint0_temp;
                            diff0 = diff0_temp;
                            diffpoint = diffpoint_temp;
                            difftheta = difftheta_temp;
                            difftheta1 = difftheta1_temp;
                            point0 = point0_temp;
                            x0 = point0(3);
                            y0 = point0(4);
                            point(1) = point0(5);
                            point(2) = point0(6);
                            theta = point0(7);
                            theta1 = point0(8);
                        else
                            if diffpoint0_temp < diffpoint0
                                diffpoint0 = diffpoint0_temp;
                                point0 = point0_temp;
                            end
                            if diff0_temp < diff0
                                diff0 = diff0_temp;
                                x0 = x0_temp;
                                y0 = y0_temp;
                            end
                            if diffpoint_temp < diffpoint
                                diffpoint = diffpoint_temp;
                                point = point_temp;
                            end
                            if difftheta_temp < difftheta
                                difftheta = difftheta_temp;
                                theta = theta_temp;
                            end
                            if difftheta1_temp < difftheta1
                                difftheta1 = difftheta1_temp;
                                theta1 = theta1_temp;
                            end
                        end
                    else
                        if i == 1
                            point0 = get(hToggleButtun_calculate,'Userdata');
                        else
                            point0 = (point0*(i-1)+get(hToggleButtun_calculate,'Userdata'))/i;
                        end
                        x0 = point0(3);
                        y0 = point0(4);
                        point(1) = point0(5);
                        point(2) = point0(6);
                        theta = point0(7);
                        theta1 = point0(8);
                    end
                end
                
                current_situation = 'save measure data';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                pause(0.001);
                
                tElapsed=toc(tStart);
                if get(hPopupMenu_alignertype,'Value') == 1
                    aligner_autotest_calibration('movexbackward');
                end
                
                %title( [ strcat('Elapsed time:',num2str(roundn(toc, -3)),'(s)    n=') , num2str( n )] );
                
                %sheetName='measure';
                if n == 0
                    %                           A   B           C           D   E    F    G          H          I          J            K             L             M            N             O            P  Q  R  S  T            U           V             W
                    %headers =  {'n','point0(1)','point0(2)','t','x0','y0','point(1)','point(2)','tElapsed','offset(mm)','offset(deg)','notch0(deg)','notch(deg)','center(deg)','center(mm)','','','','','theta(deg)','flat(deg)','theta1(deg)','flat1(deg)'};
                    headers =  {'n','point0(1)','point0(2)','t','x0','y0','point(1)','point(2)','tElapsed','offset(mm)','offset(deg)','notch0(deg)','notch(deg)','center(deg)','center(mm)','theta(deg)','flat(deg)','theta1(deg)','flat1(deg)'};
                    %[status,msg] = xlswrite(xlsFile,headers,sheetName);
                    %寫入Header至CSV，逗號分隔
                    fid = fopen([get(hEdit_path, 'string'),'\','measure_',get(hEdit_path, 'string'),'.csv'], 'w') ;
                    fprintf(fid, '%s,', headers{1,1:end-1}) ;
                    fprintf(fid, '%s\n', headers{1,end}) ;
                    fclose(fid) ;
                    %                 if (get(hPopupMenu_wafertype,'value')-1)
                    %                     %FLAT
                    %                     MeasureUtility.WaferType('FLAT');%平邊模式
                    %                     %                   data = {'average(t)','=AVERAGE(D:D)';    %1
                    %                     %                        'max(t)','=MAX(D:D)';    %2
                    %                     %                        'min(t)','=MIN(D:D)'    %3
                    %                     %                        'average(x0)','=AVERAGE(E:E)';    %4
                    %                     %                        'average(y0)','=AVERAGE(F:F)';    %5
                    %                     %                        'average(point(1))','=AVERAGE(G:G)';    %6
                    %                     %                        'average(point(2))','=AVERAGE(H:H)';    %7
                    %                     %                        'r','=((Q6-Q4)^2+(Q7-Q5)^2)^0.5';    %8
                    %                     %                        'pixel/mm','=300/1.67';    %9
                    %                     %                        'max-min','';    %10
                    %                     %                        'offset(mm)','=Q15';    %11
                    %                     % %                        'offset(deg)','=MAX(U:U)-MIN(U:U)';    %12
                    %                     %                        'offset(deg)','=Q13';    %12
                    %                     %                        'notch(deg)','=MAX(W:W)-MIN(W:W)';    %13
                    %                     %                        'center(deg)','=MAX(N:N)-MIN(N:N)';    %14
                    %                     %                        'center(mm)','=MAX(O:O)';    %15
                    %                     %                        'n',num2str(n);    %16
                    %                     %                        'average(theta)','=AVERAGE(T:T)';   %17
                    %                     %                        'average(theta1)','=AVERAGE(V:V)'};   %18
                    %                 else
                    MeasureUtility.WaferType('NOTCH');%缺角模式
                    %NOTCH
                    %                    data = {'average(t)','=AVERAGE(D:D)';    %1
                    %                        'max(t)','=MAX(D:D)';    %2
                    %                        'min(t)','=MIN(D:D)'    %3
                    %                        'average(x0)','=AVERAGE(E:E)';    %4
                    %                        'average(y0)','=AVERAGE(F:F)';    %5
                    %                        'average(point(1))','=AVERAGE(G:G)';    %6
                    %                        'average(point(2))','=AVERAGE(H:H)';    %7
                    %                        'r','=((Q6-Q4)^2+(Q7-Q5)^2)^0.5';    %8
                    %                        'pixel/mm','=300/1.67';    %9
                    %                        'max-min','';    %10
                    %                        'offset(mm)','=MAX(J:J)-MIN(J:J)';    %11
                    %                        'offset(deg)','=MAX(K:K)-MIN(K:K)';    %12
                    %                        'notch(deg)','=MAX(M:M)-MIN(M:M)';    %13
                    %                        'center(deg)','=MAX(N:N)-MIN(N:N)';    %14
                    %                        'center(mm)','=MAX(O:O)';    %15
                    %                        'n',num2str(n);    %16
                    %                        'average(theta)','=AVERAGE(T:T)';   %17
                    %                        'average(theta1)','=AVERAGE(V:V)'};   %18
                    %                 end
                    %[status,msg] = xlswrite(xlsFile,data,sheetName,'P1');
                end
                %數值存入記憶體
                %begin
                if get(hPopupMenu_testmode, 'value') == 4
                    t = 0;
                end
                
                MeasureUtility.Var_average_t(t);
                MeasureUtility.Var_max_t(t);
                MeasureUtility.Var_min_t(t);
                MeasureUtility.Var_average_x0(x0);
                MeasureUtility.Var_average_y0(y0);
                MeasureUtility.Var_average_point_1(point(1));
                MeasureUtility.Var_average_point_2(point(2));
                %end
                %                 [status,msg] = xlswrite(xlsFile,[n, point0(1), point0(2), t, x0, y0, point(1), point(2), tElapsed],sheetName,['A',num2str(n+2)]);
                %                 data = {['=(((G',num2str(n+2),'-Q$4)^2+(H',num2str(n+2),'-Q$5)^2)^0.5-Q$8)/Q$9*(G',num2str(n+2),'-Q$4)/ABS(G',num2str(n+2),'-Q$4)']};
                %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['J',num2str(n+2)]);
                %                 data = {['=2*ASIN(((G',num2str(n+2),'-Q$6)^2+(H',num2str(n+2),'-Q$7)^2)^0.5/2/Q$8)*180/PI()*(G',num2str(n+2),'-Q$6)/ABS(G',num2str(n+2),'-Q$6)']};
                %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['K',num2str(n+2)]);
                %
                % %                 data = {['=ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI()']};
                %                 data = {['=IF(C',num2str(n+2),'-F',num2str(n+2),'>=0,ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI(),-ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI())']};
                %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['L',num2str(n+2)]);
                % %                 data = {['=ATAN((H',num2str(n+2),'-F',num2str(n+2),')/(G',num2str(n+2),'-E',num2str(n+2),'))*180/PI()']};
                % %                 data = {['=ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI()']};
                %                 data = {['=IF(H',num2str(n+2),'-F',num2str(n+2),'>=0,ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI(),-ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI())']};
                %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['M',num2str(n+2)]);
                %
                %                 data = {['=IF(F',num2str(n+2),'-Q$5>=0,ACOS((E',num2str(n+2),'-Q$4)/((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5)*180/PI(),-ACOS((E',num2str(n+2),'-Q$4)/((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5)*180/PI())']};
                %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['N',num2str(n+2)]);
                % %                 data = {['=((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5/Q$9*(E',num2str(n+2),'-Q$4)/ABS(E',num2str(n+2),'-Q$4)']};
                %                 data = {['=((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5/Q$9']};
                %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['O',num2str(n+2)]);
                try %O
                    center_mm= ((x0-MeasureUtility.Var_average_x0)^2+(y0-MeasureUtility.Var_average_y0)^2)^0.5/MeasureUtility.Var_pixel;
                    MeasureUtility.Var_center_mm(center_mm);
                catch exception
                    L.error('center_mm',exception.getReport);
                end
                try %J
                    %                 offset_mm = (((point(1)-MeasureUtility.Var_average_x0)^2 + (point(2)-MeasureUtility.Var_average_y0)^2)^0.5 - MeasureUtility.Var_r)/MeasureUtility.Var_pixel * (point(1)-MeasureUtility.Var_average_x0)/abs(point(1)-MeasureUtility.Var_average_x0);
                    offset_mm = (((point(1)-MeasureUtility.Var_average_x0)^2 + (point(2)-MeasureUtility.Var_average_y0)^2)^0.5 - MeasureUtility.Var_r)/MeasureUtility.Var_pixel;
                    MeasureUtility.Var_offset_mm(offset_mm);
                catch exception
                    L.error('offset_mm',exception.getReport);
                end
                try %K NaN problem
                    %                 offset_deg = 2*asin(((point(1)-MeasureUtility.Var_average_point_1)^2+(point(2)-MeasureUtility.Var_average_point_2)^2)^0.5/2/MeasureUtility.Var_r)*180/pi*(point(1)-MeasureUtility.Var_average_point_1)/abs(point(1)-MeasureUtility.Var_average_point_1);
                    offset_deg = acos((((point(1)-MeasureUtility.Var_average_x0)^2 + (point(2)-MeasureUtility.Var_average_y0)^2)+MeasureUtility.Var_r^2-((point(1)-MeasureUtility.Var_average_point_1)^2+(point(2)-MeasureUtility.Var_average_point_2)^2))/(2*((point(1)-MeasureUtility.Var_average_x0)^2 + (point(2)-MeasureUtility.Var_average_y0)^2)^0.5*MeasureUtility.Var_r))*180/pi*(point(1)-MeasureUtility.Var_average_point_1)/abs(point(1)-MeasureUtility.Var_average_point_1);
                    if ~isnan(offset_deg)
                        MeasureUtility.Var_offset_deg(offset_deg);
                    else
                        offset_deg = 0;
                        MeasureUtility.Var_offset_deg(offset_deg);
                    end
                catch exception
                    L.error('offset_deg',exception.getReport);
                end
                try %L
                    
                    if(point0(2)-y0>=0)
                        notch0_deg=acos((point0(1)-x0)/((point0(1)-x0)^2+(point0(2)-y0)^2)^0.5)*180/pi;
                    else
                        notch0_deg=-acos((point0(1)-x0)/((point0(1)-x0)^2+(point0(2)-y0)^2)^0.5)*180/pi;
                    end
                catch exception
                    L.error('notch0_deg',exception.getReport);
                end
                try %M
                    if(point(2)-y0>=0)
                        notch_deg = acos((point(1)-x0)/((point(1)-x0)^2+(point(2)-y0)^2)^0.5)*180/pi;
                    else
                        notch_deg = -acos((point(1)-x0)/((point(1)-x0)^2+(point(2)-y0)^2)^0.5)*180/pi;
                    end
                    if strcmp(MeasureUtility.WaferType, 'NOTCH')
                        MeasureUtility.Var_notch_deg(notch_deg);
                    end
                catch exception
                    L.error('notch_deg',exception.getReport);
                end
                try %N
                    if(y0-MeasureUtility.Var_average_y0>=0)
                        center_deg = acos((x0-MeasureUtility.Var_average_x0)/((x0-MeasureUtility.Var_average_x0)^2+(y0-MeasureUtility.Var_average_y0)^2)^0.5)*180/pi;
                    else
                        center_deg = -acos((x0-MeasureUtility.Var_average_x0)/((x0-MeasureUtility.Var_average_x0)^2+(y0-MeasureUtility.Var_average_y0)^2)^0.5)*180/pi;
                    end
                    %                 if ~isnan(center_deg)
                    MeasureUtility.Var_center_deg(center_deg);
                    %                 end
                catch exception
                    L.error('center_deg',exception.getReport);
                end
                
                %P Empty
                %Q Empty
                try %R
                    R_interval = double.empty(0);
                catch exception
                    L.error('R_interval',exception.getReport);
                end
                try %S
                    S_interval = double.empty(0);
                catch exception
                    L.error('S_interval',exception.getReport);
                end
                
                try %T
                    theta_deg = theta;
                    MeasureUtility.Var_average_theta(theta);
                catch exception
                    L.error('theta_deg',exception.getReport);
                end
                try %U
                    flat_deg = theta - MeasureUtility.Var_average_theta;
                catch exception
                    L.error('flat_deg',exception.getReport);
                end
                try %V
                    theta1_deg = theta1;
                    MeasureUtility.Var_average_theta1(theta1);
                catch exception
                    L.error('theta1_deg',exception.getReport);
                end
                try %W
                    flat1_deg = theta1 - MeasureUtility.Var_average_theta1;
                    if strcmp(MeasureUtility.WaferType, 'FLAT')
                        MeasureUtility.Var_notch_deg(flat1_deg);
                    end
                catch exception
                    L.error('flat1_deg',exception.getReport);
                end
                %             data = {n, point0(1), point0(2), t, x0, y0, point(1), point(2), tElapsed,...
                %                 ['=(((G',num2str(n+2),'-Q$4)^2+(H',num2str(n+2),'-Q$5)^2)^0.5-Q$8)/Q$9*(G',num2str(n+2),'-Q$4)/ABS(G',num2str(n+2),'-Q$4)'],...
                %                 ['=2*ASIN(((G',num2str(n+2),'-Q$6)^2+(H',num2str(n+2),'-Q$7)^2)^0.5/2/Q$8)*180/PI()*(G',num2str(n+2),'-Q$6)/ABS(G',num2str(n+2),'-Q$6)'],...
                %                 ['=IF(C',num2str(n+2),'-F',num2str(n+2),'>=0,ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI(),-ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI())'],...
                %                 ['=IF(H',num2str(n+2),'-F',num2str(n+2),'>=0,ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI(),-ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI())'],...
                %                 ['=IF(F',num2str(n+2),'-Q$5>=0,ACOS((E',num2str(n+2),'-Q$4)/((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5)*180/PI(),-ACOS((E',num2str(n+2),'-Q$4)/((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5)*180/PI())'],...
                %                 ['=((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5/Q$9']};
                %             [status,msg] = xlswrite(xlsFile,data,sheetName,['A',num2str(n+2)]);
                
                %                 [status,msg] = xlswrite(xlsFile,theta,sheetName,['T',num2str(n+2)]);
                %                 data = {['=T',num2str(n+2),'-Q$17']};
                %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['U',num2str(n+2)]);
                %                 [status,msg] = xlswrite(xlsFile,theta1,sheetName,['V',num2str(n+2)]);
                %                 data = {['=V',num2str(n+2),'-Q$18']};
                %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['W',num2str(n+2)]);
                %             data = {theta,['=T',num2str(n+2),'-Q$17'],theta1,['=V',num2str(n+2),'-Q$18']};
                %             [status,msg] = xlswrite(xlsFile,data,sheetName,['T',num2str(n+2)]);
                
                FQC = 720;
                if mod(n,FQC) == FQC-1 %720次區間資料
                    %                 if (get(hPopupMenu_wafertype,'value')-1)% FLAT
                    %                     MeasureUtility.Var_center_mm_interval(center_mm); %MAX(O:O)
                    %                     MeasureUtility.Var_notch_deg_interval(flat1_deg); %MAX(W:W)-MIN(W:W)
                    %                 else % NOTCH
                    MeasureUtility.Var_offset_mm_interval(offset_mm);%MAX(J:J)-MIN(J:J)
                    MeasureUtility.Var_offset_deg_interval(offset_deg);%MAX(K:K)-MIN(K:K)
                    MeasureUtility.Var_notch_deg_interval(notch_deg);
                    %                 end
                    %                 if (get(hPopupMenu_wafertype,'value')-1)
                    %                     % FLAT
                    %
                    %                     R_interval = MeasureUtility.Var_center_mm_interval;
                    %                     S_interval = MeasureUtility.Var_notch_deg_interval;
                    %                     MeasureUtility.Var_center_mm_interval('reset'); %MAX(O:O)
                    %                     MeasureUtility.Var_notch_deg_interval('reset'); %MAX(W:W)-MIN(W:W)
                    %
                    %                     %                         data = {['=MAX(O',num2str(n+2-FQC+1),':O',num2str(n+2),')-MIN(O',num2str(n+2-FQC+1),':O',num2str(n+2),')']};
                    %                     %                         [status,msg] = xlswrite(xlsFile,data,sheetName,['R',num2str(n+2)]);
                    %                     % %                         data = {['=MAX(U',num2str(n+2-FQC+1),':U',num2str(n+2),')-MIN(U',num2str(n+2-FQC+1),':U',num2str(n+2),')']};
                    %                     %                         data = {['=MAX(W',num2str(n+2-FQC+1),':W',num2str(n+2),')-MIN(W',num2str(n+2-FQC+1),':W',num2str(n+2),')']};
                    %                     %                         [status,msg] = xlswrite(xlsFile,data,sheetName,['S',num2str(n+2)]);
                    %                     %                     data = {['=MAX(O',num2str(n+2-FQC+1),':O',num2str(n+2),')'],...
                    %                     %                         ['=MAX(W',num2str(n+2-FQC+1),':W',num2str(n+2),')-MIN(W',num2str(n+2-FQC+1),':W',num2str(n+2),')']};
                    %                 else
                    % NOTCH
                    R_interval = MeasureUtility.Var_offset_mm_interval;
                    %S_interval = MeasureUtility.Var_offset_deg_interval;
                    S_interval = MeasureUtility.Var_notch_deg_interval;
                    MeasureUtility.Var_offset_mm_interval('reset');%MAX(J:J)-MIN(J:J)
                    MeasureUtility.Var_offset_deg_interval('reset'); %MAX(K:K)-MIN(K:K)
                    MeasureUtility.Var_notch_deg_interval('reset');
                    %                         data = {['=MAX(J',num2str(n+2-FQC+1),':J',num2str(n+2),')-MIN(J',num2str(n+2-FQC+1),':J',num2str(n+2),')']};
                    %                         [status,msg] = xlswrite(xlsFile,data,sheetName,['R',num2str(n+2)]);
                    %                         data = {['=MAX(K',num2str(n+2-FQC+1),':K',num2str(n+2),')-MIN(K',num2str(n+2-FQC+1),':K',num2str(n+2),')']};
                    %                         [status,msg] = xlswrite(xlsFile,data,sheetName,['S',num2str(n+2)]);
                    %                     data = {['=MAX(J',num2str(n+2-FQC+1),':J',num2str(n+2),')-MIN(J',num2str(n+2-FQC+1),':J',num2str(n+2),')'],...
                    %                         ['=MAX(K',num2str(n+2-FQC+1),':K',num2str(n+2),')-MIN(K',num2str(n+2-FQC+1),':K',num2str(n+2),')']};
                    %                 end
                    %                 [status,msg] =
                    %                 xlswrite(xlsFile,data,sheetName,['R',num2str(n+2)]);
                    MeasureUtility.Var_FQC(MeasureUtility.Var_FQC + 1);
                    %紀錄每次FQC值 後面要更新UI用
                    switch(mod(MeasureUtility.Var_FQC,6))
                        case 1
                            MeasureUtility.Var_R_interval_fqc1(R_interval);
                            MeasureUtility.Var_S_interval_fqc1(S_interval);
                        case 2
                            MeasureUtility.Var_R_interval_fqc2(R_interval);
                            MeasureUtility.Var_S_interval_fqc2(S_interval);
                        case 3
                            MeasureUtility.Var_R_interval_fqc3(R_interval);
                            MeasureUtility.Var_S_interval_fqc3(S_interval);
                        case 4
                            MeasureUtility.Var_R_interval_fqc4(R_interval);
                            MeasureUtility.Var_S_interval_fqc4(S_interval);
                        case 5
                            MeasureUtility.Var_R_interval_fqc5(R_interval);
                            MeasureUtility.Var_S_interval_fqc5(S_interval);
                        case 0
                            MeasureUtility.Var_R_interval_fqc6(R_interval);
                            MeasureUtility.Var_S_interval_fqc6(S_interval);
                    end
                else %紀錄區間
                    %                 if (get(hPopupMenu_wafertype,'value')-1)% FLAT
                    %                     MeasureUtility.Var_center_mm_interval(center_mm); %MAX(O:O)
                    %                     MeasureUtility.Var_notch_deg_interval(flat1_deg); %MAX(W:W)-MIN(W:W)
                    %                 else % NOTCH
                    MeasureUtility.Var_offset_mm_interval(offset_mm);%MAX(J:J)-MIN(J:J)
                    MeasureUtility.Var_offset_deg_interval(offset_deg);%MAX(K:K)-MIN(K:K)
                    MeasureUtility.Var_notch_deg_interval(notch_deg);
                    %                 end
                end
                %    A     B        C      D  E  F     G      H          I
                
                M = [n point0(1) point0(2) t x0 y0 point(1) point(2) tElapsed ...
                    offset_mm ...%J
                    offset_deg ...%K
                    notch0_deg ...%L
                    notch_deg ...%M
                    center_deg ...%N
                    center_mm ...%O
                    theta_deg ...%T
                    flat_deg ...%U
                    theta1_deg ...%V
                    flat1_deg ...%W
                    R_interval ...%R
                    S_interval ...%S
                    ];
                dlmwrite([get(hEdit_path, 'string'),'\','measure_',get(hEdit_path, 'string'),'.csv'],M,'delimiter',',','precision','%.4f','-append');%寫入全部資料
                if n == 0
                    headers =  {'n','average(t)','max(t)','min(t)','average(x0)','average(y0)','average(point(1))','average(point(2))','r','pixel/mm','offset(mm)','offset(deg)','notch(deg)','center(deg)','center(mm)','n','average(theta)','average(theta1)'};
                    %寫入Header至CSV，逗號分隔
                    fid = fopen([get(hEdit_path, 'string'),'\','MeasureUtility_',get(hEdit_path, 'string'),'.csv'], 'w') ;
                    fprintf(fid, '%s,', headers{1,1:end-1}) ;
                    fprintf(fid, '%s\n', headers{1,end}) ;
                    fclose(fid) ;
                end
                M = [n...
                    MeasureUtility.Var_average_t ...
                    MeasureUtility.Var_max_t ...
                    MeasureUtility.Var_min_t ...
                    MeasureUtility.Var_average_x0 ...
                    MeasureUtility.Var_average_y0 ...
                    MeasureUtility.Var_average_point_1 ...
                    MeasureUtility.Var_average_point_2 ...
                    MeasureUtility.Var_r ...
                    MeasureUtility.Var_pixel ...
                    MeasureUtility.Var_offset_mm ...
                    MeasureUtility.Var_offset_deg ...
                    MeasureUtility.Var_notch_deg ...
                    MeasureUtility.Var_center_deg ...
                    MeasureUtility.Var_center_mm ...
                    MeasureUtility.Var_n ...
                    MeasureUtility.Var_average_theta ...
                    MeasureUtility.Var_average_theta1 ...
                    ];
                dlmwrite([get(hEdit_path, 'string'),'\','MeasureUtility_',get(hEdit_path, 'string'),'.csv'],M,'delimiter',',','precision','%.4f','-append');%寫入全部資料
                
                %             if (get(hPopupMenu_wafertype,'value')-1)
                %                 % FLAT
                %
                %                 Measure_aUtility.Var_n(n);
                %                 current_situation = 'save picture';
                %                 set(hText_currentsituation,'String',current_situation);
                %                 clock_log = clock;
                %                 fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                %                 pause(0.001);
                %                 saveas( hFigure , [ get(hEdit_path, 'string') , '\n' , num2str( n ) , '.bmp' ] );
                %
                %                 if get(hToggleButtun_run,'Value') == 0
                %                     fclose(fid_log);
                %                     return;
                %                 end
                %                 if get(hToggleButtun_capture,'Value') == 0
                %                     set(hToggleButtun_capture,'Value',1);
                %                 end
                %
                %                 num_temp = get(hPopupMenu_number,'value');
                %                 set(hPopupMenu_number,'Value',2);
                %                 pause(0.001);
                %                 aligner_autotest_calibration('capture');
                %                 set(hPopupMenu_number,'Value',num_temp);
                %
                %                 title( [ 'n=' , num2str( n ),'_a' ] );
                %
                %                 if get(hToggleButtun_run,'Value') == 0
                %                     fclose(fid_log);
                %                     return;
                %                 end
                %                 if get(hToggleButtun_calculate,'Value') == 0
                %                     set(hToggleButtun_calculate,'Value',1);
                %                 end
                %                 pause(0.001);
                %                 aligner_autotest_calibration('calculate');
                %
                %                 current_situation = 'save measure data_a';
                %                 set(hText_currentsituation,'String',current_situation);
                %                 clock_log = clock;
                %                 fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                %                 pause(0.001);
                %                 point0 = get(hToggleButtun_calculate,'Userdata');
                %                 x0 = point0(3);
                %                 y0 = point0(4);
                %                 point(1) = point0(5);
                %                 point(2) = point0(6);
                %                 theta = point0(7);
                %
                %                 %數值存入記憶體
                %                 %begin
                %                 Measure_aUtility.Var_average_t(t);
                %                 Measure_aUtility.Var_max_t(t);
                %                 Measure_aUtility.Var_min_t(t);
                %                 Measure_aUtility.Var_average_x0(x0);
                %                 Measure_aUtility.Var_average_y0(y0);
                %                 Measure_aUtility.Var_average_point_1(point(1));
                %                 Measure_aUtility.Var_average_point_2(point(2));
                %                 %end
                %                 %sheetName='measure_a';
                %                 if n == 0
                %                     %                           A   B           C           D   E    F    G          H          I          J            K             L             M            N             O            P  Q  R  S  T            U           V             W
                %                     headers =  {'n','point0(1)','point0(2)','t','x0','y0','point(1)','point(2)','tElapsed','offset(mm)','offset(deg)','notch0(deg)','notch(deg)','center(deg)','center(mm)','theta(deg)','flat(deg)','theta1(deg)','flat1(deg)'};
                %                     %寫入Header至CSV，逗號分隔
                %                     fid = fopen([get(hEdit_path, 'string'),'\','measure_a','.csv'], 'w') ;
                %                     fprintf(fid, '%s,', headers{1,1:end-1}) ;
                %                     fprintf(fid, '%s\n', headers{1,end}) ;
                %                     fclose(fid) ;
                %                     %[status,msg] = xlswrite(xlsFile,headers,sheetName);
                %                     if (get(hPopupMenu_wafertype,'value')-1)
                %                         %FLAT
                %                         Measure_aUtility.WaferType('FLAT');%平邊模式
                %                         %                         data = {'average(t)','=AVERAGE(D:D)';    %1
                %                         %                             'max(t)','=MAX(D:D)';    %2
                %                         %                             'min(t)','=MIN(D:D)'    %3
                %                         %                             'average(x0)','=AVERAGE(E:E)';    %4
                %                         %                             'average(y0)','=AVERAGE(F:F)';    %5
                %                         %                             'average(point(1))','=AVERAGE(G:G)';    %6
                %                         %                             'average(point(2))','=AVERAGE(H:H)';    %7
                %                         %                             'r','=((Q6-Q4)^2+(Q7-Q5)^2)^0.5';    %8
                %                         %                             'pixel/mm','=300/1.67';    %9
                %                         %                             'max-min','';    %10
                %                         %                             'offset(mm)','=Q15';    %11
                %                         %                             %                            'offset(deg)','=MAX(U:U)-MIN(U:U)';    %12
                %                         %                             'offset(deg)','=Q13';    %12
                %                         %                             'notch(deg)','=MAX(W:W)-MIN(W:W)';    %13
                %                         %                             'center(deg)','=MAX(N:N)-MIN(N:N)';    %14
                %                         %                             'center(mm)','=MAX(O:O)';    %15
                %                         %                             'n',num2str(n);    %16
                %                         %                             'average(theta)','=AVERAGE(T:T)';   %17
                %                         %                             'average(theta1)','=AVERAGE(V:V)'};   %18
                %                     else
                %                         Measure_aUtility.WaferType('NOTCH');%缺角模式
                %                         %                         data = {'average(t)','=AVERAGE(D:D)';    %1
                %                         %                             'max(t)','=MAX(D:D)';    %2
                %                         %                             'min(t)','=MIN(D:D)'    %3
                %                         %                             'average(x0)','=AVERAGE(E:E)';    %4
                %                         %                             'average(y0)','=AVERAGE(F:F)';    %5
                %                         %                             'average(point(1))','=AVERAGE(G:G)';    %6
                %                         %                             'average(point(2))','=AVERAGE(H:H)';    %7
                %                         %                             'r','=((Q6-Q4)^2+(Q7-Q5)^2)^0.5';    %8
                %                         %                             'pixel/mm','=300/1.67';    %9
                %                         %                             'max-min','';    %10
                %                         %                             'offset(mm)','=MAX(J:J)-MIN(J:J)';    %11
                %                         %                             'offset(deg)','=MAX(K:K)-MIN(K:K)';    %12
                %                         %                             'notch(deg)','=MAX(M:M)-MIN(M:M)';    %13
                %                         %                             'center(deg)','=MAX(N:N)-MIN(N:N)';    %14
                %                         %                             'center(mm)','=MAX(O:O)';    %15
                %                         %                             'n',num2str(n);    %16
                %                         %                             'average(theta)','=AVERAGE(T:T)';   %17
                %                         %                             'average(theta1)','=AVERAGE(V:V)'};   %18
                %                     end
                %                     %[status,msg] = xlswrite(xlsFile,data,sheetName,'P1');
                %                 end
                %                 %                 [status,msg] = xlswrite(xlsFile,[n, point0(1), point0(2), t, x0, y0, point(1), point(2), tElapsed],sheetName,['A',num2str(n+2)]);
                %                 %                 data = {['=(((G',num2str(n+2),'-Q$4)^2+(H',num2str(n+2),'-Q$5)^2)^0.5-Q$8)/Q$9*(G',num2str(n+2),'-Q$4)/ABS(G',num2str(n+2),'-Q$4)']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['J',num2str(n+2)]);
                %                 %                 data = {['=2*ASIN(((G',num2str(n+2),'-Q$6)^2+(H',num2str(n+2),'-Q$7)^2)^0.5/2/Q$8)*180/PI()*(G',num2str(n+2),'-Q$6)/ABS(G',num2str(n+2),'-Q$6)']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['K',num2str(n+2)]);
                %                 %
                %                 % %                 data = {['=ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI()']};
                %                 %                 data = {['=IF(C',num2str(n+2),'-F',num2str(n+2),'>=0,ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI(),-ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI())']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['L',num2str(n+2)]);
                %                 % %                 data = {['=ATAN((H',num2str(n+2),'-F',num2str(n+2),')/(G',num2str(n+2),'-E',num2str(n+2),'))*180/PI()']};
                %                 % %                 data = {['=ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI()']};
                %                 %                 data = {['=IF(H',num2str(n+2),'-F',num2str(n+2),'>=0,ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI(),-ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI())']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['M',num2str(n+2)]);
                %                 %
                %                 %                 data = {['=IF(F',num2str(n+2),'-Q$5>=0,ACOS((E',num2str(n+2),'-Q$4)/((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5)*180/PI(),-ACOS((E',num2str(n+2),'-Q$4)/((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5)*180/PI())']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['N',num2str(n+2)]);
                %                 % %                 data = {['=((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5/Q$9*(E',num2str(n+2),'-Q$4)/ABS(E',num2str(n+2),'-Q$4)']};
                %                 %                 data = {['=((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5/Q$9']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['O',num2str(n+2)]);
                %                 try %J
                %                     offset_mm = (((point(1)-Measure_aUtility.Var_average_x0)^2 + (point(2)-Measure_aUtility.Var_average_y0)^2)^0.5 - Measure_aUtility.Var_r)/Measure_aUtility.Var_pixel * (point(1)-Measure_aUtility.Var_average_x0)/abs(point(1)-Measure_aUtility.Var_average_x0);
                %                     Measure_aUtility.Var_offset_mm(offset_mm);
                %                 catch exception
                %                     L.error('offset_mm',exception.getReport);
                %                 end
                %                 try %K
                %                     offset_deg = 2*asin(((point(1)-Measure_aUtility.Var_average_point_1)^2+(point(2)-Measure_aUtility.Var_average_point_2)^2)^0.5/2/Measure_aUtility.Var_r)*180/pi*(point(1)-Measure_aUtility.Var_average_point_1)/abs(point(1)-Measure_aUtility.Var_average_point_1);
                %                 catch exception
                %                     L.error('offset_deg',exception.getReport);
                %                 end
                %                 try %L
                %
                %                     if(point0(2)-y0>=0)
                %                         notch0_deg=acos((point0(1)-x0)/((point0(1)-x0)^2+(point0(2)-y0)^2)^0.5)*180/pi;
                %                     else
                %                         notch0_deg=-acos((point0(1)-x0)/((point0(1)-x0)^2+(point0(2)-y0)^2)^0.5)*180/pi;
                %                     end
                %                 catch exception
                %                     L.error('notch0_deg',exception.getReport);
                %                 end
                %                 try %M
                %                     if(point(2)-y0>=0)
                %                         notch_deg = acos((point(1)-x0)/((point(1)-x0)^2+(point(2)-y0)^2)^0.5)*180/pi;
                %                     else
                %                         notch_deg = -acos((point(1)-x0)/((point(1)-x0)^2+(point(2)-y0)^2)^0.5)*180/pi;
                %                     end
                % 					if strcmp(Measure_aUtility.WaferType, 'NOTCH')
                % 						Measure_aUtility.Var_notch_deg(notch_deg);
                % 					end
                %                 catch exception
                %                     L.error('notch_deg',exception.getReport);
                %                 end
                %                 try %N
                %                     if(y0-Measure_aUtility.Var_average_y0>=0)
                %                         center_deg = acos((x0-Measure_aUtility.Var_average_x0)/((x0-Measure_aUtility.Var_average_x0)^2+(y0-Measure_aUtility.Var_average_y0)^2)^0.5)*180/pi;
                %                     else
                %                         center_deg = -acos((x0-Measure_aUtility.Var_average_x0)/((x0-Measure_aUtility.Var_average_x0)^2+(y0-Measure_aUtility.Var_average_y0)^2)^0.5)*180/pi;
                %                     end
                % 					Measure_aUtility.Var_center_deg(center_deg);
                %                 catch exception
                %                     L.error('center_deg',exception.getReport);
                %                 end
                %                 try %O
                %                     center_mm= ((x0-Measure_aUtility.Var_average_x0)^2+(y0-Measure_aUtility.Var_average_y0)^2)^0.5/Measure_aUtility.Var_pixel;
                %                     Measure_aUtility.Var_center_mm(center_mm);
                %                 catch exception
                %                     L.error('center_mm',exception.getReport);
                %                 end
                %                 %P Empty
                %                 %Q Empty
                %                 try %R
                %                     R_interval = double.empty(0);
                %                 catch exception
                %                     L.error('R_interval',exception.getReport);
                %                 end
                %                 try %S
                %                     S_interval = double.empty(0);
                %                 catch exception
                %                     L.error('S_interval',exception.getReport);
                %                 end
                %
                %                 try %T
                %                     theta_deg = theta;
                %                     Measure_aUtility.Var_average_theta(theta);
                %                 catch exception
                %                     L.error('theta_deg',exception.getReport);
                %                 end
                %                 try %U
                %                     flat_deg = theta - Measure_aUtility.Var_average_theta;
                %                 catch exception
                %                     L.error('flat_deg',exception.getReport);
                %                 end
                %                 try %V
                %                     theta1_deg = theta1;
                %                     Measure_aUtility.Var_average_theta1(theta1);
                %                 catch exception
                %                     L.error('theta1_deg',exception.getReport);
                %                 end
                %                 try %W
                %                     flat1_deg = theta1 - Measure_aUtility.Var_average_theta1;
                % 					if strcmp(Measure_aUtility.WaferType, 'FLAT')
                % 						Measure_aUtility.Var_notch_deg(flat1_deg);
                % 					end
                %                 catch exception
                %                     L.error('flat1_deg',exception.getReport);
                %                 end
                %                 %                 data = {n, point0(1), point0(2), t, x0, y0, point(1), point(2), tElapsed,...
                %                 %                     ['=(((G',num2str(n+2),'-Q$4)^2+(H',num2str(n+2),'-Q$5)^2)^0.5-Q$8)/Q$9*(G',num2str(n+2),'-Q$4)/ABS(G',num2str(n+2),'-Q$4)'],...
                %                 %                     ['=2*ASIN(((G',num2str(n+2),'-Q$6)^2+(H',num2str(n+2),'-Q$7)^2)^0.5/2/Q$8)*180/PI()*(G',num2str(n+2),'-Q$6)/ABS(G',num2str(n+2),'-Q$6)'],...
                %                 %                     ['=IF(C',num2str(n+2),'-F',num2str(n+2),'>=0,ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI(),-ACOS((B',num2str(n+2),'-E',num2str(n+2),')/((B',num2str(n+2),'-E',num2str(n+2),')^2+(C',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI())'],...
                %                 %                     ['=IF(H',num2str(n+2),'-F',num2str(n+2),'>=0,ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI(),-ACOS((G',num2str(n+2),'-E',num2str(n+2),')/((G',num2str(n+2),'-E',num2str(n+2),')^2+(H',num2str(n+2),'-F',num2str(n+2),')^2)^0.5)*180/PI())'],...
                %                 %                     ['=IF(F',num2str(n+2),'-Q$5>=0,ACOS((E',num2str(n+2),'-Q$4)/((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5)*180/PI(),-ACOS((E',num2str(n+2),'-Q$4)/((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5)*180/PI())'],...
                %                 %                     ['=((E',num2str(n+2),'-Q$4)^2+(F',num2str(n+2),'-Q$5)^2)^0.5/Q$9']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['A',num2str(n+2)]);
                %
                %                 %                 [status,msg] = xlswrite(xlsFile,theta,sheetName,['T',num2str(n+2)]);
                %                 %                 data = {['=T',num2str(n+2),'-Q$17']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['U',num2str(n+2)]);
                %                 %                 [status,msg] = xlswrite(xlsFile,theta1,sheetName,['V',num2str(n+2)]);
                %                 %                 data = {['=V',num2str(n+2),'-Q$18']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['W',num2str(n+2)]);
                %                 %                 data = {theta,['=T',num2str(n+2),'-Q$17'],theta1,['=V',num2str(n+2),'-Q$18']};
                %                 %                 [status,msg] = xlswrite(xlsFile,data,sheetName,['T',num2str(n+2)]);
                %
                %                 FQC = 720;
                %                 if mod(n,FQC) == FQC-1%720次區間資料
                %                     if (get(hPopupMenu_wafertype,'value')-1)% FLAT
                %                         Measure_aUtility.Var_center_mm_interval(center_mm); %MAX(O:O)
                %                         Measure_aUtility.Var_notch_deg_interval(flat1_deg); %MAX(W:W)-MIN(W:W)
                %                     else % NOTCH
                %                         Measure_aUtility.Var_offset_mm_interval(offset_mm);%MAX(J:J)-MIN(J:J)
                %                         Measure_aUtility.Var_offset_deg_interval(offset_deg);%MAX(K:K)-MIN(K:K)
                %                     end
                %                     if (get(hPopupMenu_wafertype,'value')-1)
                %                         % FLAT
                %
                %                         R_interval = Measure_aUtility.Var_center_mm_interval;
                %                         S_interval = Measure_aUtility.Var_notch_deg_interval;
                %
                %                         Measure_aUtility.Var_center_mm_interval('reset'); %MAX(O:O)
                %                         Measure_aUtility.Var_notch_deg_interval('reset'); %MAX(W:W)-MIN(W:W)
                %                         %                         %                         data = {['=MAX(O',num2str(n+2-FQC+1),':O',num2str(n+2),')-MIN(O',num2str(n+2-FQC+1),':O',num2str(n+2),')']};
                %                         %                         %                         [status,msg] = xlswrite(xlsFile,data,sheetName,['R',num2str(n+2)]);
                %                         %                         % %                         data = {['=MAX(U',num2str(n+2-FQC+1),':U',num2str(n+2),')-MIN(U',num2str(n+2-FQC+1),':U',num2str(n+2),')']};
                %                         %                         %                         data = {['=MAX(W',num2str(n+2-FQC+1),':W',num2str(n+2),')-MIN(W',num2str(n+2-FQC+1),':W',num2str(n+2),')']};
                %                         %                         %                         [status,msg] = xlswrite(xlsFile,data,sheetName,['S',num2str(n+2)]);
                %                         %                         data = {['=MAX(O',num2str(n+2-FQC+1),':O',num2str(n+2),')'],...
                %                         %                             ['=MAX(W',num2str(n+2-FQC+1),':W',num2str(n+2),')-MIN(W',num2str(n+2-FQC+1),':W',num2str(n+2),')']};
                %                     else
                %                         % NOTCH
                %
                %                         R_interval = Measure_aUtility.Var_offset_mm_interval;
                %                         S_interval = Measure_aUtility.Var_offset_deg_interval;
                %                         Measure_aUtility.Var_offset_mm_interval('reset');%MAX(J:J)-MIN(J:J)
                %                         Measure_aUtility.Var_offset_deg_interval('reset'); %MAX(K:K)-MIN(K:K)
                %                         %                         data = {['=MAX(J',num2str(n+2-FQC+1),':J',num2str(n+2),')-MIN(J',num2str(n+2-FQC+1),':J',num2str(n+2),')']};
                %                         %                         [status,msg] = xlswrite(xlsFile,data,sheetName,['R',num2str(n+2)]);
                %                         %                         data = {['=MAX(K',num2str(n+2-FQC+1),':K',num2str(n+2),')-MIN(K',num2str(n+2-FQC+1),':K',num2str(n+2),')']};
                %                         %                         [status,msg] = xlswrite(xlsFile,data,sheetName,['S',num2str(n+2)]);
                %                         %                         data = {['=MAX(J',num2str(n+2-FQC+1),':J',num2str(n+2),')-MIN(J',num2str(n+2-FQC+1),':J',num2str(n+2),')'],...
                %                         %                             ['=MAX(W',num2str(n+2-FQC+1),':W',num2str(n+2),')-MIN(W',num2str(n+2-FQC+1),':W',num2str(n+2),')']};
                %                     end
                %                     %紀錄每次FQC值 後面要更新UI用
                %                     Measure_aUtility.Var_FQC(Measure_aUtility.Var_FQC + 1);
                %                     switch(Measure_aUtility.Var_FQC)
                %                         case 1
                %                             Measure_aUtility.Var_R_interval_fqc1(R_interval);
                %                             Measure_aUtility.Var_S_interval_fqc1(S_interval);
                %                         case 2
                %                             Measure_aUtility.Var_R_interval_fqc2(R_interval);
                %                             Measure_aUtility.Var_S_interval_fqc2(S_interval);
                %                         case 3
                %                             Measure_aUtility.Var_R_interval_fqc3(R_interval);
                %                             Measure_aUtility.Var_S_interval_fqc3(S_interval);
                %                         case 4
                %                             Measure_aUtility.Var_R_interval_fqc4(R_interval);
                %                             Measure_aUtility.Var_S_interval_fqc4(S_interval);
                %                         case 5
                %                             Measure_aUtility.Var_R_interval_fqc5(R_interval);
                %                             Measure_aUtility.Var_S_interval_fqc5(S_interval);
                %                         case 6
                %                             Measure_aUtility.Var_R_interval_fqc6(R_interval);
                %                             Measure_aUtility.Var_S_interval_fqc6(S_interval);
                %                     end
                %                     % [status,msg] = xlswrite(xlsFile,data,sheetName,['R',num2str(n+2)]);
                %                 else %紀錄區間
                %                     if (get(hPopupMenu_wafertype,'value')-1)% FLAT
                %                         Measure_aUtility.Var_center_mm_interval(center_mm); %MAX(O:O)
                %                         Measure_aUtility.Var_notch_deg_interval(flat1_deg); %MAX(W:W)-MIN(W:W)
                %                     else % NOTCH
                %                         Measure_aUtility.Var_offset_mm_interval(offset_mm);%MAX(J:J)-MIN(J:J)
                %                         Measure_aUtility.Var_offset_deg_interval(offset_deg);%MAX(K:K)-MIN(K:K)
                %                     end
                %                 end
                %
                %                 %    A     B        C      D  E  F     G      H          I
                %                 M = [n point0(1) point0(2) t x0 y0 point(1) point(2) tElapsed ...
                %                     offset_mm ...%J
                %                     offset_deg ...%K
                %                     notch0_deg ...%L
                %                     notch_deg ...%M
                %                     center_deg ...%N
                %                     center_mm ...%O
                %                     theta_deg ...%T
                %                     flat_deg ...%U
                %                     theta1_deg ...%V
                %                     flat1_deg ...%W
                %                     R_interval ...%R
                %                     S_interval ...%S
                %                     ];
                %                 dlmwrite([get(hEdit_path, 'string'),'\','measure_a','.csv'],M,'delimiter',',','precision','%.4f','-append');%寫入全部資料
                %                 if n == 0
                %                     headers =  {'average(t)','max(t)','min(t)','average(x0)','average(y0)','average(point(1))','average(point(2))','r','pixel/mm','offset(mm)','offset(deg)','notch(deg)','center(deg)','center(mm)','n','average(theta)','average(theta1)'};
                %                     %寫入Header至CSV，逗號分隔
                %                     fid = fopen([get(hEdit_path, 'string'),'\','Measure_aUtility','.csv'], 'w') ;
                %                     fprintf(fid, '%s,', headers{1,1:end-1}) ;
                %                     fprintf(fid, '%s\n', headers{1,end}) ;
                %                     fclose(fid) ;
                %                 end
                %                 M = [Measure_aUtility.Var_average_t ...
                %                     Measure_aUtility.Var_max_t ...
                %                     Measure_aUtility.Var_min_t ...
                %                     Measure_aUtility.Var_average_x0 ...
                %                     Measure_aUtility.Var_average_y0 ...
                %                     Measure_aUtility.Var_average_point_1 ...
                %                     Measure_aUtility.Var_average_point_2 ...
                %                     Measure_aUtility.Var_r ...
                %                     Measure_aUtility.Var_pixel ...
                %                     Measure_aUtility.Var_offset_mm ...
                %                     Measure_aUtility.Var_offset_deg ...
                %                     Measure_aUtility.Var_notch_deg ...
                %                     Measure_aUtility.Var_center_deg ...
                %                     Measure_aUtility.Var_center_mm ...
                %                     Measure_aUtility.Var_n ...
                %                     Measure_aUtility.Var_average_theta ...
                %                     Measure_aUtility.Var_average_theta1 ...
                %                     ];
                %                 dlmwrite([get(hEdit_path, 'string'),'\','Measure_aUtility','.csv'],M,'delimiter',',','precision','%.4f','-append');%寫入全部資料
                %
                %             end
                
                [rslt,ackpos] = serial_get('$1GET:POS__:1,1',COM_aligner);
                current_situation = 'save command data';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                pause(0.001);
                %sheetName='command';
                if n == 0
                    headers =  {'n','x','y','theta','reserved','reserved','reserved'};
                    %寫入Header至CSV，逗號分隔
                    fid = fopen([get(hEdit_path, 'string'),'\','command_',get(hEdit_path, 'string'),'.csv'], 'w') ;
                    fprintf(fid, '%s,', headers{1,1:end-1}) ;
                    fprintf(fid, '%s\n', headers{1,end}) ;
                    fclose(fid) ;
                    %[status,msg] = xlswrite(xlsFile,headers,sheetName);
                end
                %                 [status,msg] = xlswrite(xlsFile,n,sheetName,['A',num2str(n+2)]);
                ackpos_split = regexp(ackpos,'\$1ACK\:POS__\:','split');
                ackpos_split = regexp(ackpos_split{1,2},'\r','split');
                ackpos_split = regexp(ackpos_split{1,1},',','split');
                ackpos_split = [num2str(n),ackpos_split];
                %                 [status,msg] = xlswrite(xlsFile,ackpos_split,sheetName,['B',num2str(n+2)]);
                %寫入資料至CSV，逗號分隔
                fid = fopen([get(hEdit_path, 'string'),'\','command_',get(hEdit_path, 'string'),'.csv'], 'a') ;
                fprintf(fid, '%s,', ackpos_split{1,1:end-1}) ;
                fprintf(fid, '%s\n', ackpos_split{1,end}) ;
                fclose(fid);
                %[status,msg] = xlswrite(xlsFile,[n,ackpos_split],sheetName,['A',num2str(n+2)]);
                
                [rslt,ackpos1] = serial_get('$1GET:POS__:2,1',COM_aligner);
                current_situation = 'save encoder data';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                pause(0.001);
                %sheetName='encoder';
                if n == 0
                    headers =  {'n','x','y','theta','reserved','reserved','reserved'};
                    fid = fopen([get(hEdit_path, 'string'),'\','encoder_',get(hEdit_path, 'string'),'.csv'], 'w') ;
                    fprintf(fid, '%s,', headers{1,1:end-1}) ;
                    fprintf(fid, '%s\n', headers{1,end}) ;
                    fclose(fid) ;
                    %[status,msg] = xlswrite(xlsFile,headers,sheetName);
                end
                %                 [status,msg] = xlswrite(xlsFile,n,sheetName,['A',num2str(n+2)]);
                ackpos1_split = regexp(ackpos1,'\$1ACK\:POS\_\_\:','split');
                ackpos1_split = regexp(ackpos1_split{1,2},'\r','split');
                ackpos1_split = regexp(ackpos1_split{1,1},',','split');
                ackpos1_split = [num2str(n),ackpos1_split];
                %寫入資料至CSV，逗號分隔
                fid = fopen([get(hEdit_path, 'string'),'\','encoder_',get(hEdit_path, 'string'),'.csv'], 'a') ;
                fprintf(fid, '%s,', ackpos1_split{1,1:end-1}) ;
                fprintf(fid, '%s\n', ackpos1_split{1,end}) ;
                fclose(fid);
                %                 [status,msg] = xlswrite(xlsFile,ackpos1_split,sheetName,['B',num2str(n+2)]);
                %[status,msg] = xlswrite(xlsFile,[n,ackpos1_split],sheetName,['A',num2str(n+2)]);
                
                [rslt,ackrslt] = serial_get('$1GET:ALIGN:1',COM_aligner);
                current_situation = 'save result data';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                pause(0.001);
                %sheetName='result';
                if n == 0
                    headers =  {'n','aligner type','wafer radius','notch angle','offset x','offset y','theta angle','distance2','theta2','result'};
                    fid = fopen([get(hEdit_path, 'string'),'\','result_',get(hEdit_path, 'string'),'.csv'], 'w') ;
                    fprintf(fid, '%s,', headers{1,1:end-1}) ;
                    fprintf(fid, '%s\n', headers{1,end}) ;
                    fclose(fid);
                    %[status,msg] = xlswrite(xlsFile,headers,sheetName);
                end
                %                 [status,msg] = xlswrite(xlsFile,n,sheetName,['A',num2str(n+2)]);
                ackrslt_split = regexp(ackrslt,'\$1ACK\:ALIGN\:','split');
                ackrslt_split = regexp(ackrslt_split{1,2},'\r','split');
                ackrslt_split = regexp(ackrslt_split{1,1},',','split');
                ackrslt_split = [num2str(n),ackrslt_split];
                %寫入資料至CSV，逗號分隔
                fid = fopen([get(hEdit_path, 'string'),'\','result_',get(hEdit_path, 'string'),'.csv'], 'a') ;
                fprintf(fid, '%s,', ackrslt_split{1,1:end-1}) ;
                fprintf(fid, '%s\n', ackrslt_split{1,end}) ;
                fclose(fid);
                %                 [status,msg] = xlswrite(xlsFile,ackrslt_split,sheetName,['B',num2str(n+2)]);
                %[status,msg] = xlswrite(xlsFile,[n,ackrslt_split],sheetName,['A',num2str(n+2)]);
                current_situation = 'display measure data';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                pause(0.001);
                %sheetName='measure';
                if n~= 0
                    
                    %                 if (get(hPopupMenu_wafertype,'value')-1)
                    %                     %FLAT
                    %                     %                 sheetName='measure_a';
                    %                     %                 data = xlsread(xlsFile,sheetName,'Q1:Q17');
                    %                     %set(hText_offsetmm,'String',['Offset(mm): ',num2str(data(11),3)]);
                    %                     %data = xlsread(xlsFile,sheetName,'Q1:Q17');
                    %                     %set(hText_aligntimeaverage,'String',['Average(s): ',num2str(data(1))]);
                    %                     set(hText_aligntimeaverage,'String',['Average(s): ',num2str(Measure_aUtility.Var_average_t)]);
                    %                     %set(hText_aligntimemax,'String',['Max(s): ',num2str(data(2))]);
                    %                     set(hText_aligntimemax,'String',['Max(s): ',num2str(Measure_aUtility.Var_max_t)]);
                    %                     %set(hText_aligntimemin,'String',['Min(s): ',num2str(data(3))]);
                    %                     set(hText_aligntimemin,'String',['Min(s): ',num2str(Measure_aUtility.Var_min_t)]);
                    %                     %set(hText_centerxaverage,'String',['X(mm): ',num2str(data(4)*1.67/300)]);
                    %                     set(hText_centerxaverage,'String',['X(mm): ',num2str(Measure_aUtility.Var_average_x0*1.67/300)]);
                    %                     %set(hText_centeryaverage,'String',['Y(mm): ',num2str(data(5)*1.67/300)]);
                    %                     set(hText_centeryaverage,'String',['Y(mm): ',num2str(Measure_aUtility.Var_average_y0*1.67/300)]);
                    %                     %set(hText_notchxaverage,'String',['X(mm): ',num2str(data(6)*1.67/300)]);
                    %                     set(hText_notchxaverage,'String',['X(mm): ',num2str(Measure_aUtility.Var_average_point_1*1.67/300)]);
                    %                     %set(hText_notchyaverage,'String',['Y(mm): ',num2str(data(7)*1.67/300)]);
                    %                     set(hText_notchyaverage,'String',['Y(mm): ',num2str(Measure_aUtility.Var_average_point_2*1.67/300)]);
                    %                     %set(hText_offsetdeg,'String',['Offset(deg): ',num2str(data(12),3)]);
                    %                     set(hText_offsetdeg,'String',['Offset(deg): ',num2str(MeasureUtility.Var_offset_deg,3)]);
                    %                     set(hText_offsetmm,'String',['Offset(mm): ',num2str(Measure_aUtility.Var_offset_mm,3)]);
                    %
                    %                     if ~isempty(Measure_aUtility.Var_R_interval_fqc1) || ~isempty(MeasureUtility.Var_S_interval_fqc1)
                    %                         set(hText_fqc1,'String',['1: ',num2str(Measure_aUtility.Var_R_interval_fqc1,3),', ',num2str(MeasureUtility.Var_S_interval_fqc1,3)]);
                    %                     end
                    %                     if ~isempty(Measure_aUtility.Var_R_interval_fqc2) || ~isempty(MeasureUtility.Var_S_interval_fqc2)
                    %                         set(hText_fqc2,'String',['2: ',num2str(Measure_aUtility.Var_R_interval_fqc2,3),', ',num2str(MeasureUtility.Var_S_interval_fqc2,3)]);
                    %                     end
                    %                     %data = xlsread(xlsFile,sheetName,['R',num2str(3*FQC-1+2),':S',num2str(3*FQC-1+2)]);
                    %                     if ~isempty(Measure_aUtility.Var_R_interval_fqc3) || ~isempty(MeasureUtility.Var_S_interval_fqc3)
                    %                         set(hText_fqc3,'String',['3: ',num2str(Measure_aUtility.Var_R_interval_fqc3,3),', ',num2str(MeasureUtility.Var_S_interval_fqc3,3)]);
                    %                     end
                    %                     %data = xlsread(xlsFile,sheetName,['R',num2str(4*FQC-1+2),':S',num2str(4*FQC-1+2)]);
                    %                     if ~isempty(Measure_aUtility.Var_R_interval_fqc4) || ~isempty(MeasureUtility.Var_S_interval_fqc4)
                    %                         set(hText_fqc4,'String',['4: ',num2str(Measure_aUtility.Var_R_interval_fqc4,3),', ',num2str(MeasureUtility.Var_S_interval_fqc4,3)]);
                    %                     end
                    %                     %data = xlsread(xlsFile,sheetName,['R',num2str(5*FQC-1+2),':S',num2str(5*FQC-1+2)]);
                    %                     if ~isempty(Measure_aUtility.Var_R_interval_fqc5) || ~isempty(MeasureUtility.Var_S_interval_fqc5)
                    %                         set(hText_fqc5,'String',['5: ',num2str(Measure_aUtility.Var_R_interval_fqc5,3),', ',num2str(MeasureUtility.Var_S_interval_fqc5,3)]);
                    %                     end
                    %                     %data = xlsread(xlsFile,sheetName,['R',num2str(6*FQC-1+2),':S',num2str(6*FQC-1+2)]);
                    %                     if ~isempty(Measure_aUtility.Var_R_interval_fqc6) || ~isempty(MeasureUtility.Var_S_interval_fqc6)
                    %                         set(hText_fqc6,'String',['6: ',num2str(Measure_aUtility.Var_R_interval_fqc6,3),', ',num2str(MeasureUtility.Var_S_interval_fqc6,3)]);
                    %                     end
                    %                     sheetName='measure';
                    %                 else
                    %NOTCH
                    %set(hText_offsetmm,'String',['Offset(mm): ',num2str(data(11),3)]);
                    %data = xlsread(xlsFile,sheetName,'Q1:Q17');
                    %set(hText_aligntimeaverage,'String',['Average(s): ',num2str(data(1))]);
                    set(hText_aligntimeaverage,'String',['Average(s): ',num2str(MeasureUtility.Var_average_t)]);
                    %set(hText_aligntimemax,'String',['Max(s): ',num2str(data(2))]);
                    set(hText_aligntimemax,'String',['Max(s): ',num2str(MeasureUtility.Var_max_t)]);
                    %set(hText_aligntimemin,'String',['Min(s): ',num2str(data(3))]);
                    set(hText_aligntimemin,'String',['Min(s): ',num2str(MeasureUtility.Var_min_t)]);
                    %set(hText_centerxaverage,'String',['X(mm): ',num2str(data(4)*1.67/300)]);
                    set(hText_centerxaverage,'String',['X(mm): ',num2str(MeasureUtility.Var_average_x0*1.67/300)]);
                    %set(hText_centeryaverage,'String',['Y(mm): ',num2str(data(5)*1.67/300)]);
                    set(hText_centeryaverage,'String',['Y(mm): ',num2str(MeasureUtility.Var_average_y0*1.67/300)]);
                    %set(hText_notchxaverage,'String',['X(mm): ',num2str(data(6)*1.67/300)]);
                    set(hText_notchxaverage,'String',['X(mm): ',num2str(MeasureUtility.Var_average_point_1*1.67/300)]);
                    %set(hText_notchyaverage,'String',['Y(mm): ',num2str(data(7)*1.67/300)]);
                    set(hText_notchyaverage,'String',['Y(mm): ',num2str(MeasureUtility.Var_average_point_2*1.67/300)]);
                    %set(hText_offsetdeg,'String',['Offset(deg): ',num2str(data(12),3)]);
                    %                     set(hText_offsetdeg,'String',['Offset(deg): ',num2str(MeasureUtility.Var_offset_deg,3)]);
                    set(hText_offsetdeg,'String',['Offset(deg): ',num2str(MeasureUtility.Var_notch_deg,3)]);
                    set(hText_offsetmm,'String',['Offset(mm): ',num2str(MeasureUtility.Var_offset_mm,3)]);
                    if(MeasureUtility.Var_FQC < 7)
                        if ~isempty(MeasureUtility.Var_R_interval_fqc1) || ~isempty(MeasureUtility.Var_S_interval_fqc1)
                            set(hText_fqc1,'String',['1: ',num2str(MeasureUtility.Var_R_interval_fqc1,3),', ',num2str(MeasureUtility.Var_S_interval_fqc1,3)]);
                        end
                        if ~isempty(MeasureUtility.Var_R_interval_fqc2) || ~isempty(MeasureUtility.Var_S_interval_fqc2)
                            set(hText_fqc2,'String',['2: ',num2str(MeasureUtility.Var_R_interval_fqc2,3),', ',num2str(MeasureUtility.Var_S_interval_fqc2,3)]);
                        end
                        if ~isempty(MeasureUtility.Var_R_interval_fqc3) || ~isempty(MeasureUtility.Var_S_interval_fqc3)
                            set(hText_fqc3,'String',['3: ',num2str(MeasureUtility.Var_R_interval_fqc3,3),', ',num2str(MeasureUtility.Var_S_interval_fqc3,3)]);
                        end
                        if ~isempty(MeasureUtility.Var_R_interval_fqc4) || ~isempty(MeasureUtility.Var_S_interval_fqc4)
                            set(hText_fqc4,'String',['4: ',num2str(MeasureUtility.Var_R_interval_fqc4,3),', ',num2str(MeasureUtility.Var_S_interval_fqc4,3)]);
                        end
                        if ~isempty(MeasureUtility.Var_R_interval_fqc5) || ~isempty(MeasureUtility.Var_S_interval_fqc5)
                            set(hText_fqc5,'String',['5: ',num2str(MeasureUtility.Var_R_interval_fqc5,3),', ',num2str(MeasureUtility.Var_S_interval_fqc5,3)]);
                        end
                        if ~isempty(MeasureUtility.Var_R_interval_fqc6) || ~isempty(MeasureUtility.Var_S_interval_fqc6)
                            set(hText_fqc6,'String',['6: ',num2str(MeasureUtility.Var_R_interval_fqc6,3),', ',num2str(MeasureUtility.Var_S_interval_fqc6,3)]);
                        end
                    else
                        switch(mod(MeasureUtility.Var_FQC,6))
                            case 1
                                set(hText_fqc1,'String',[num2str(MeasureUtility.Var_FQC-5),': ',num2str(MeasureUtility.Var_R_interval_fqc2,3),', ',num2str(MeasureUtility.Var_S_interval_fqc2,3)]);
                                set(hText_fqc2,'String',[num2str(MeasureUtility.Var_FQC-4),': ',num2str(MeasureUtility.Var_R_interval_fqc3,3),', ',num2str(MeasureUtility.Var_S_interval_fqc3,3)]);
                                set(hText_fqc3,'String',[num2str(MeasureUtility.Var_FQC-3),': ',num2str(MeasureUtility.Var_R_interval_fqc4,3),', ',num2str(MeasureUtility.Var_S_interval_fqc4,3)]);
                                set(hText_fqc4,'String',[num2str(MeasureUtility.Var_FQC-2),': ',num2str(MeasureUtility.Var_R_interval_fqc5,3),', ',num2str(MeasureUtility.Var_S_interval_fqc5,3)]);
                                set(hText_fqc5,'String',[num2str(MeasureUtility.Var_FQC-1),': ',num2str(MeasureUtility.Var_R_interval_fqc6,3),', ',num2str(MeasureUtility.Var_S_interval_fqc6,3)]);
                                set(hText_fqc6,'String',[num2str(MeasureUtility.Var_FQC),6,': ',num2str(MeasureUtility.Var_R_interval_fqc1,3),', ',num2str(MeasureUtility.Var_S_interval_fqc1,3)]);
                            case 2
                                set(hText_fqc1,'String',[num2str(MeasureUtility.Var_FQC-5),': ',num2str(MeasureUtility.Var_R_interval_fqc3,3),', ',num2str(MeasureUtility.Var_S_interval_fqc3,3)]);
                                set(hText_fqc2,'String',[num2str(MeasureUtility.Var_FQC-4),': ',num2str(MeasureUtility.Var_R_interval_fqc4,3),', ',num2str(MeasureUtility.Var_S_interval_fqc4,3)]);
                                set(hText_fqc3,'String',[num2str(MeasureUtility.Var_FQC-3),': ',num2str(MeasureUtility.Var_R_interval_fqc5,3),', ',num2str(MeasureUtility.Var_S_interval_fqc5,3)]);
                                set(hText_fqc4,'String',[num2str(MeasureUtility.Var_FQC-2),': ',num2str(MeasureUtility.Var_R_interval_fqc6,3),', ',num2str(MeasureUtility.Var_S_interval_fqc6,3)]);
                                set(hText_fqc5,'String',[num2str(MeasureUtility.Var_FQC-1),': ',num2str(MeasureUtility.Var_R_interval_fqc1,3),', ',num2str(MeasureUtility.Var_S_interval_fqc1,3)]);
                                set(hText_fqc6,'String',[num2str(MeasureUtility.Var_FQC),6,': ',num2str(MeasureUtility.Var_R_interval_fqc2,3),', ',num2str(MeasureUtility.Var_S_interval_fqc2,3)]);
                            case 3
                                set(hText_fqc1,'String',[num2str(MeasureUtility.Var_FQC-5),': ',num2str(MeasureUtility.Var_R_interval_fqc4,3),', ',num2str(MeasureUtility.Var_S_interval_fqc4,3)]);
                                set(hText_fqc2,'String',[num2str(MeasureUtility.Var_FQC-4),': ',num2str(MeasureUtility.Var_R_interval_fqc5,3),', ',num2str(MeasureUtility.Var_S_interval_fqc5,3)]);
                                set(hText_fqc3,'String',[num2str(MeasureUtility.Var_FQC-3),': ',num2str(MeasureUtility.Var_R_interval_fqc6,3),', ',num2str(MeasureUtility.Var_S_interval_fqc6,3)]);
                                set(hText_fqc4,'String',[num2str(MeasureUtility.Var_FQC-2),': ',num2str(MeasureUtility.Var_R_interval_fqc1,3),', ',num2str(MeasureUtility.Var_S_interval_fqc1,3)]);
                                set(hText_fqc5,'String',[num2str(MeasureUtility.Var_FQC-1),': ',num2str(MeasureUtility.Var_R_interval_fqc2,3),', ',num2str(MeasureUtility.Var_S_interval_fqc2,3)]);
                                set(hText_fqc6,'String',[num2str(MeasureUtility.Var_FQC),6,': ',num2str(MeasureUtility.Var_R_interval_fqc3,3),', ',num2str(MeasureUtility.Var_S_interval_fqc3,3)]);
                            case 4
                                set(hText_fqc1,'String',[num2str(MeasureUtility.Var_FQC-5),': ',num2str(MeasureUtility.Var_R_interval_fqc5,3),', ',num2str(MeasureUtility.Var_S_interval_fqc5,3)]);
                                set(hText_fqc2,'String',[num2str(MeasureUtility.Var_FQC-4),': ',num2str(MeasureUtility.Var_R_interval_fqc6,3),', ',num2str(MeasureUtility.Var_S_interval_fqc6,3)]);
                                set(hText_fqc3,'String',[num2str(MeasureUtility.Var_FQC-3),': ',num2str(MeasureUtility.Var_R_interval_fqc1,3),', ',num2str(MeasureUtility.Var_S_interval_fqc1,3)]);
                                set(hText_fqc4,'String',[num2str(MeasureUtility.Var_FQC-2),': ',num2str(MeasureUtility.Var_R_interval_fqc2,3),', ',num2str(MeasureUtility.Var_S_interval_fqc2,3)]);
                                set(hText_fqc5,'String',[num2str(MeasureUtility.Var_FQC-1),': ',num2str(MeasureUtility.Var_R_interval_fqc3,3),', ',num2str(MeasureUtility.Var_S_interval_fqc3,3)]);
                                set(hText_fqc6,'String',[num2str(MeasureUtility.Var_FQC),6,': ',num2str(MeasureUtility.Var_R_interval_fqc4,3),', ',num2str(MeasureUtility.Var_S_interval_fqc4,3)]);
                            case 5
                                set(hText_fqc1,'String',[num2str(MeasureUtility.Var_FQC-5),': ',num2str(MeasureUtility.Var_R_interval_fqc6,3),', ',num2str(MeasureUtility.Var_S_interval_fqc6,3)]);
                                set(hText_fqc2,'String',[num2str(MeasureUtility.Var_FQC-4),': ',num2str(MeasureUtility.Var_R_interval_fqc1,3),', ',num2str(MeasureUtility.Var_S_interval_fqc1,3)]);
                                set(hText_fqc3,'String',[num2str(MeasureUtility.Var_FQC-3),': ',num2str(MeasureUtility.Var_R_interval_fqc2,3),', ',num2str(MeasureUtility.Var_S_interval_fqc2,3)]);
                                set(hText_fqc4,'String',[num2str(MeasureUtility.Var_FQC-2),': ',num2str(MeasureUtility.Var_R_interval_fqc3,3),', ',num2str(MeasureUtility.Var_S_interval_fqc3,3)]);
                                set(hText_fqc5,'String',[num2str(MeasureUtility.Var_FQC-1),': ',num2str(MeasureUtility.Var_R_interval_fqc4,3),', ',num2str(MeasureUtility.Var_S_interval_fqc4,3)]);
                                set(hText_fqc6,'String',[num2str(MeasureUtility.Var_FQC),6,': ',num2str(MeasureUtility.Var_R_interval_fqc5,3),', ',num2str(MeasureUtility.Var_S_interval_fqc5,3)]);
                            case 0
                                set(hText_fqc1,'String',[num2str(MeasureUtility.Var_FQC-5),': ',num2str(MeasureUtility.Var_R_interval_fqc1,3),', ',num2str(MeasureUtility.Var_S_interval_fqc1,3)]);
                                set(hText_fqc2,'String',[num2str(MeasureUtility.Var_FQC-4),': ',num2str(MeasureUtility.Var_R_interval_fqc2,3),', ',num2str(MeasureUtility.Var_S_interval_fqc2,3)]);
                                set(hText_fqc3,'String',[num2str(MeasureUtility.Var_FQC-3),': ',num2str(MeasureUtility.Var_R_interval_fqc3,3),', ',num2str(MeasureUtility.Var_S_interval_fqc3,3)]);
                                set(hText_fqc4,'String',[num2str(MeasureUtility.Var_FQC-2),': ',num2str(MeasureUtility.Var_R_interval_fqc4,3),', ',num2str(MeasureUtility.Var_S_interval_fqc4,3)]);
                                set(hText_fqc5,'String',[num2str(MeasureUtility.Var_FQC-1),': ',num2str(MeasureUtility.Var_R_interval_fqc5,3),', ',num2str(MeasureUtility.Var_S_interval_fqc5,3)]);
                                set(hText_fqc6,'String',[num2str(MeasureUtility.Var_FQC),6,': ',num2str(MeasureUtility.Var_R_interval_fqc6,3),', ',num2str(MeasureUtility.Var_S_interval_fqc6,3)]);
                        end
                    end
                    
                    %                 end
                    
                    set(hText_fqc,'String','n: (mm), (deg)');
                    %data = xlsread(xlsFile,sheetName,['R',num2str(FQC-1+2),':S',num2str(FQC-1+2)]);
                    
                else
                    set(hText_aligntimeaverage,'String','Average(s):');
                    set(hText_aligntimemax,'String','Max(s):');
                    set(hText_aligntimemin,'String','Min(s):');
                    set(hText_centerxaverage,'String','X(mm):');
                    set(hText_centeryaverage,'String','Y(mm):');
                    set(hText_notchxaverage,'String','X(mm):');
                    set(hText_notchyaverage,'String','Y(mm):');
                    set(hText_offsetmm,'String','Offset(mm):');
                    set(hText_offsetdeg,'String','Offset(deg):');
                    
                    set(hText_fqc,'String','');
                    set(hText_fqc1,'String','');
                    set(hText_fqc2,'String','');
                    set(hText_fqc3,'String','');
                    set(hText_fqc4,'String','');
                    set(hText_fqc5,'String','');
                    set(hText_fqc6,'String','');
                end
                
                %             if (get(hPopupMenu_wafertype,'value')-1)
                %                 current_situation = 'save picture_a';
                %                 set(hText_currentsituation,'String',current_situation);
                %                 clock_log = clock;
                %                 fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                %                 pause(0.001);
                %                 saveas( hFigure , [ get(hEdit_path, 'string') , '\n' , num2str( n ) , '_a.bmp' ] );
                %             else
                current_situation = 'save picture';
                set(hText_currentsituation,'String',current_situation);
                clock_log = clock;
                fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock_log);
                pause(0.001);
                title( [ strcat('Elapsed time:',num2str(roundn(toc(ttlStart), -3)),'(s)    n=') , num2str( n )] );
                saveas( hFigure , [ get(hEdit_path, 'string') , '\n' , num2str( n ) , '.bmp' ] );
                %             end
                
                %set(hText_testcountheader,'String',strcat('Test Cnt',num2str(n+1) ,'/',num2str(testCount)));
                
            end
            %         dos(['start ' xlsFile]);
            set(hToggleButtun_run,'Value',0);
            current_situation = 'auto test finished';
            set(hText_currentsituation,'String',current_situation);
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ',current_situation,'\r\n'], clock);
        catch e %e is an MException struct
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ','The identifier was:\n%s',e.identifier,'\r\n'], clock);
            fprintf(fid_log, ['%4d/%02d/%02d %02d:%02d:%05.2f ','There was an error! The message was:\n%s',e.message,'\r\n'], clock);
        end
    otherwise
        error('Unknown action string!');
end
fclose(fid_log);