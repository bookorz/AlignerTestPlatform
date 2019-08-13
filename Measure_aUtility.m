classdef Measure_aUtility < handle
    
    methods (Static)
        function func_WaferType = WaferType(newval)
            persistent currentval;
            if(isempty(currentval))
                currentval = '';
            end
            if nargin >= 1
                currentval = newval;
                
            end
            func_WaferType = currentval;
        end
        
        function Reset_All()
            Measure_aUtility.Var_average_t('reset');
                Measure_aUtility.Var_max_t('reset');
                Measure_aUtility.Var_min_t('reset'); 
                Measure_aUtility.Var_average_x0('reset'); 
                Measure_aUtility.Var_average_y0('reset'); 
                Measure_aUtility.Var_average_point_1('reset'); 
                Measure_aUtility.Var_average_point_2('reset'); 
                %Measure_aUtility.Var_r('reset'); 
                %Measure_aUtility.Var_pixel('reset'); 
                Measure_aUtility.Var_offset_mm('reset'); 
                Measure_aUtility.Var_offset_deg('reset'); 
                Measure_aUtility.Var_notch_deg('reset'); 
                Measure_aUtility.Var_center_deg('reset'); 
                Measure_aUtility.Var_center_mm('reset'); 
                Measure_aUtility.Var_n('reset'); 
                Measure_aUtility.Var_average_theta('reset'); 
                Measure_aUtility.Var_average_theta1('reset');  
                Measure_aUtility.Var_R_interval_fqc1(double.empty(0));
                Measure_aUtility.Var_R_interval_fqc2(double.empty(0));
                Measure_aUtility.Var_R_interval_fqc3(double.empty(0));
                Measure_aUtility.Var_R_interval_fqc4(double.empty(0));
                Measure_aUtility.Var_R_interval_fqc5(double.empty(0));
                Measure_aUtility.Var_R_interval_fqc6(double.empty(0));
                Measure_aUtility.Var_S_interval_fqc1(double.empty(0));
                Measure_aUtility.Var_S_interval_fqc2(double.empty(0));
                Measure_aUtility.Var_S_interval_fqc3(double.empty(0));
                Measure_aUtility.Var_S_interval_fqc4(double.empty(0));
                Measure_aUtility.Var_S_interval_fqc5(double.empty(0));
                Measure_aUtility.Var_S_interval_fqc6(double.empty(0));
                Measure_aUtility.Var_FQC(0);
                 Measure_aUtility.Var_offset_mm_interval('reset');
                Measure_aUtility. Var_offset_deg_interval('reset');
                Measure_aUtility. Var_notch_deg_interval('reset');
                Measure_aUtility. Var_center_mm_interval('reset');
        end
        
        function func_FQC = Var_FQC(newval)
            persistent currentval;
            if(isempty(currentval))
                currentval = 0;
            end
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = 0;
                else
                    currentval = newval;
                end
            end
            func_FQC = currentval;
        end        
        
        %average(t)逆    ''average(t)','=AVERAGE(D:D)';    %1
        function func_average_t = Var_average_t(newval)
            persistent currentval;  %瞷
            persistent numerator;%だ
            persistent denominator;%だダ
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    numerator = double.empty(0);
                    denominator = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = newval;
                        numerator = newval;
                        denominator = 1;
                    else
                        denominator = denominator + 1;
                        numerator = numerator + newval;
                        currentval = numerator/denominator;
                    end
                end
            end
            func_average_t = currentval;
        end
        
        %max逆    'max(t)','=MAX(D:D)';    %2
        function func_max_t = Var_max_t(newval)
            persistent currentval;
            
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);%﹍て跑计
                else
                    if(isempty(currentval))
                        currentval = newval;
                    elseif newval > currentval
                        currentval = newval;
                    end
                end
            end
            func_max_t = currentval;
        end
        
        %min逆    'min(t)','=MIN(D:D)'    %3
        function func_min_t = Var_min_t(newval)
            persistent currentval;
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);;
                else
                    if(isempty(currentval))
                        currentval = newval;
                    elseif newval < currentval
                        currentval = newval;
                    end
                end
            end
            func_min_t = currentval;
        end
        
        %average(x0)逆    'average(x0)','=AVERAGE(E:E)';    %4
        function func_average_x0 = Var_average_x0(newval)
            persistent currentval;  %瞷
            persistent numerator;%だ
            persistent denominator;%だダ
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    numerator = double.empty(0);
                    denominator = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = newval;
                        numerator = newval;
                        denominator = 1;
                    else
                        denominator = denominator + 1;
                        numerator = numerator + newval;
                        currentval = numerator/denominator;
                    end
                end
            end
            func_average_x0 = currentval;
        end
        
        %average(y0)逆    'average(y0)','=AVERAGE(F:F)';    %5
        function func_average_y0 = Var_average_y0(newval)
            persistent currentval;  %瞷
            persistent numerator;%だ
            persistent denominator;%だダ
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    numerator = double.empty(0);
                    denominator = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = newval;
                        numerator = newval;
                        denominator = 1;
                    else
                        denominator = denominator + 1;
                        numerator = numerator + newval;
                        currentval = numerator/denominator;
                    end
                end
            end
            func_average_y0 = currentval;
        end
        
        %average(point(1))逆    'average(point(1))','=AVERAGE(G:G)';    %6
        function func_average_point_1 = Var_average_point_1(newval)
            persistent currentval;  %瞷
            persistent numerator;%だ
            persistent denominator;%だダ
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    numerator = double.empty(0);
                    denominator = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = newval;
                        numerator = newval;
                        denominator = 1;
                    else
                        denominator = denominator + 1;
                        numerator = numerator + newval;
                        currentval = numerator/denominator;
                    end
                end
            end
            func_average_point_1 = currentval;
        end
        
        %average(point(2))逆    'average(point(2))','=AVERAGE(H:H)';    %7
        function func_average_point_2 = Var_average_point_2(newval)
            persistent currentval;  %瞷
            persistent numerator;%だ
            persistent denominator;%だダ
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    numerator = double.empty(0);
                    denominator = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = newval;
                        numerator = newval;
                        denominator = 1;
                    else
                        denominator = denominator + 1;
                        numerator = numerator + newval;
                        currentval = numerator/denominator;
                    end
                end
            end
            func_average_point_2 = currentval;
        end
        
        % r 逆    'r','=((Q6-Q4)^2+(Q7-Q5)^2)^0.5';    %8
        function func_r = Var_r()
            func_r = ((Measure_aUtility.Var_average_point_1 - Measure_aUtility.Var_average_x0)^2 + (Measure_aUtility.Var_average_point_2-Measure_aUtility.Var_average_y0)^2)^0.5;
        end
        
        % pixel/mm 逆    'pixel/mm','=300/1.67';    %9
        function func_pixel = Var_pixel()
            func_pixel = 300/1.67;
        end
        
        % offset(mm) 逆     FLAT:'offset(mm)','=Q15';    %11  NOTCH:'offset(mm)','=MAX(J:J)-MIN(J:J)';    %11
        function func_offset_mm = Var_offset_mm(newval)
            persistent currentval;  %瞷(程搭程)
            persistent max;%程
            persistent min;%程
            if strcmp(Measure_aUtility.WaferType , 'NOTCH')
                if nargin >= 1
                    if newval == 'reset'%﹍て跑计
                        currentval = double.empty(0);
                        max = double.empty(0);
                        min = double.empty(0);
                    else
                        if(isempty(currentval))
                            currentval = 0;
                            max = newval;
                            min = newval;
                        else
                            if newval > max
                                max = newval;
                            end
                            if newval < min
                                min = newval;
                            end
                            currentval = max-min;
                        end
                    end
                end
                func_offset_mm = currentval;
            elseif strcmp(Measure_aUtility.WaferType ,'FLAT')
                func_offset_mm = Measure_aUtility.Var_center_mm;
            end
        end
        
        % offset(deg) 逆     FLAT:'offset(deg)','=Q13';    %12  NOTCH:'offset(deg)','=MAX(K:K)-MIN(K:K)';    %12
        function func_offset_deg = Var_offset_deg(newval)
            persistent currentval1;  %瞷(程搭程)NOTCH
            persistent currentval2;  %瞷(程搭程)FLAT
            persistent max1;%程
            persistent min1;%程
            persistent max2;%程
            persistent min2;%程
            
            if strcmp(Measure_aUtility.WaferType ,'NOTCH')
                if nargin >= 1
                    if newval == 'reset'%﹍て跑计
                        currentval1 = double.empty(0);
                        currentval2 = double.empty(0);
                        max1 = double.empty(0);
                        min1 = double.empty(0);
                        max2 = double.empty(0);
                        min2 = double.empty(0);
                    else
                        if(isempty(currentval1))
                            currentval1 = 0;
                            max1 = newval;
                            min1 = newval;
                        else
                            if newval > max1
                                max1 = newval;
                            end
                            if newval < min1
                                min1 = newval;
                            end
                            currentval1 = max1-min1;
                        end
                    end
                end
                func_offset_deg = currentval1;
            elseif strcmp(Measure_aUtility.WaferType,'FLAT')
                
                func_offset_deg = Measure_aUtility.Var_notch_deg;
            end
        end
        
        
        % notch(deg) 逆      FLAT:'notch(deg)','=MAX(W:W)-MIN(W:W)';    %13
        %   NOTCH:'notch(deg)','=MAX(M:M)-MIN(M:M)';    %13
        function func_notch_deg = Var_notch_deg(newval)
            persistent currentval1;  %瞷(程搭程)NOTCH
            persistent currentval2;  %瞷(程搭程)FLAT
            persistent max1;%程
            persistent min1;%程
            persistent max2;%程
            persistent min2;%程
            
            if strcmp(Measure_aUtility.WaferType,'NOTCH')
                if nargin >= 1
                    if newval == 'reset'%﹍て跑计
                        currentval1 = double.empty(0);
                        currentval2 = double.empty(0);
                        max1 = double.empty(0);
                        min1 = double.empty(0);
                        max2 = double.empty(0);
                        min2 = double.empty(0);
                    else
                        if(isempty(currentval1))
                            currentval1 = 0;
                            max1 = newval;
                            min1 = newval;
                        else
                            if newval > max1
                                max1 = newval;
                            end
                            if newval < min1
                                min1 = newval;
                            end
                            currentval1 = max1-min1;
                        end
                    end
                end
                func_notch_deg = currentval1;
            elseif strcmp(Measure_aUtility.WaferType,'FLAT')
                if nargin >= 1
                    if newval == 'reset'%﹍て跑计
                        currentval1 = double.empty(0);
                        currentval2 = double.empty(0);
                        max1 = double.empty(0);
                        min1 = double.empty(0);
                        max2 = double.empty(0);
                        min2 = double.empty(0);
                    else
                        if(isempty(currentval2))
                            currentval2 = 0;
                            max2 = newval;
                            min2 = newval;
                        else
                            if newval > max2
                                max2 = newval;
                            end
                            if newval < min2
                                min2 = newval;
                            end
                            currentval2 = max2-min2;
                        end
                    end
                end
                func_notch_deg = currentval2;
            end
            
        end
        
        % center(deg) 逆       'center(deg)','=MAX(N:N)-MIN(N:N)';    %14
        function func_center_deg = Var_center_deg(newval)
            persistent currentval;  %瞷(程搭程)
            persistent max;%程
            persistent min;%程
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    max = double.empty(0);
                    min = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = 0;
                        max = newval;
                        min = newval;
                    else
                        if newval > max
                            max = newval;
                        end
                        if newval < min
                            min = newval;
                        end
                        currentval = max-min;
                    end
                end
            end
            func_center_deg = currentval;
        end
        
        %max逆    'center(mm)','=MAX(O:O)';    %15
        function func_center_mm = Var_center_mm(newval)
            persistent currentval;
            
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);%﹍て跑计
                else
                    if(isempty(currentval))
                        currentval = newval;
                    elseif newval > currentval
                        currentval = newval;
                    end
                end
            end
            func_center_mm = currentval;
        end
        
        % n腹逆     'n',num2str(n);    %16
        function func_n = Var_n(newval)
            persistent currentval;
            if(isempty(currentval))
                currentval = 0;
            end
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = 0;
                else
                    currentval = newval;
                end
            end
            func_n = currentval;
        end
        
        %average(theta)逆    'average(theta)','=AVERAGE(T:T)';   %17
        function func_average_theta = Var_average_theta(newval)
            persistent currentval;  %瞷
            persistent numerator;%だ
            persistent denominator;%だダ
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    numerator = double.empty(0);
                    denominator = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = newval;
                        numerator = newval;
                        denominator = 1;
                    else
                        denominator = denominator + 1;
                        numerator = numerator + newval;
                        currentval = numerator/denominator;
                    end
                end
            end
            func_average_theta = currentval;
        end
        
        %average(theta1)逆    'average(theta1)','=AVERAGE(V:V)'};   %18
        function func_average_theta1 = Var_average_theta1(newval)
            persistent currentval;  %瞷
            persistent numerator;%だ
            persistent denominator;%だダ
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    numerator = double.empty(0);
                    denominator = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = newval;
                        numerator = newval;
                        denominator = 1;
                    else
                        denominator = denominator + 1;
                        numerator = numerator + newval;
                        currentval = numerator/denominator;
                    end
                end
            end
            func_average_theta1 = currentval;
        end
        
        %center(mm)跋丁逆    MAX(O:O)
        function func_center_mm_interval = Var_center_mm_interval(newval)
            persistent currentval;
            
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);%﹍て跑计
                else
                    if(isempty(currentval))
                        currentval = newval;
                    elseif newval > currentval
                        currentval = newval;
                    end
                end
            end
            func_center_mm_interval = currentval;
        end
        
        % notch(deg) 跋丁逆      FLAT:'notch(deg)','=MAX(W:W)-MIN(W:W)';    %13
     
        function func_notch_deg_interval = Var_notch_deg_interval(newval)         
            persistent currentval2;  %瞷(程搭程)FLAT          
            persistent max2;%程
            persistent min2;%程

                if nargin >= 1
                    if newval == 'reset'%﹍て跑计
                       
                        currentval2 = double.empty(0);
                     
                        max2 = double.empty(0);
                        min2 = double.empty(0);
                    else
                        if(isempty(currentval2))
                            currentval2 = 0;
                            max2 = newval;
                            min2 = newval;
                        else
                            if newval > max2
                                max2 = newval;
                            end
                            if newval < min2
                                min2 = newval;
                            end
                            currentval2 = max2-min2;
                        end
                    end
                end
                func_notch_deg_interval = currentval2;            
        end
        
        
        % offset(mm) 跋丁逆      NOTCH:'offset(mm)','=MAX(J:J)-MIN(J:J)';    %11
        function func_offset_mm_interval = Var_offset_mm_interval(newval)
            persistent currentval;  %瞷(程搭程)
            persistent max;%程
            persistent min;%程
            
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval = double.empty(0);
                    max = double.empty(0);
                    min = double.empty(0);
                else
                    if(isempty(currentval))
                        currentval = 0;
                        max = newval;
                        min = newval;
                    else
                        if newval > max
                            max = newval;
                        end
                        if newval < min
                            min = newval;
                        end
                        currentval = max-min;
                    end
                end
            end
            func_offset_mm_interval = currentval;
            
        end
        
        % offset(deg) 跋丁逆     NOTCH:'offset(deg)','=MAX(K:K)-MIN(K:K)';    %12
        function func_offset_deg_interval = Var_offset_deg_interval(newval)
            persistent currentval1;  %瞷(程搭程)NOTCH
            persistent max1;%程
            persistent min1;%程
            
            if nargin >= 1
                if newval == 'reset'%﹍て跑计
                    currentval1 = double.empty(0);
                    max1 = double.empty(0);
                    min1 = double.empty(0);
                else
                    if(isempty(currentval1))
                        currentval1 = 0;
                        max1 = newval;
                        min1 = newval;
                    else
                        if newval > max1
                            max1 = newval;
                        end
                        if newval < min1
                            min1 = newval;
                        end
                        currentval1 = max1-min1;
                    end
                end
            end
            func_offset_deg_interval = currentval1;
            
        end
        
        function func_R_interval_fqc1 = Var_R_interval_fqc1(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_R_interval_fqc1 = currentval;
        end
        
        function func_R_interval_fqc2 = Var_R_interval_fqc2(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_R_interval_fqc2 = currentval;
        end
        
        function func_R_interval_fqc3 = Var_R_interval_fqc3(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_R_interval_fqc3 = currentval;
        end
        
        function func_R_interval_fqc4 = Var_R_interval_fqc4(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_R_interval_fqc4 = currentval;
        end
        
        function func_R_interval_fqc5 = Var_R_interval_fqc5(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_R_interval_fqc5 = currentval;
        end
        
        function func_R_interval_fqc6 = Var_R_interval_fqc6(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_R_interval_fqc6 = currentval;
        end
        
        function func_S_interval_fqc1 = Var_S_interval_fqc1(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_S_interval_fqc1 = currentval;
        end
        
        function func_S_interval_fqc2 = Var_S_interval_fqc2(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_S_interval_fqc2 = currentval;
        end
        function func_S_interval_fqc3 = Var_S_interval_fqc3(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_S_interval_fqc3 = currentval;
        end
        function func_S_interval_fqc4 = Var_S_interval_fqc4(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_S_interval_fqc4 = currentval;
        end
        function func_S_interval_fqc5 = Var_S_interval_fqc5(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_S_interval_fqc5 = currentval;
        end
        function func_S_interval_fqc6 = Var_S_interval_fqc6(newval)
            persistent currentval; 
            if nargin >= 1
                currentval = newval;
            end
            func_S_interval_fqc6 = currentval;
        end
    end
end

