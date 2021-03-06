%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%changed by  wong %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%email:takeshineshiro"126.com%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%% hv_switch module%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%this   module  for  gen  mif   of  hv_switch  for  altera%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;

clear ;

clear all ;


hv_width  =  128;              %% width 
    
hv_depth  =  256;              %% depth


TX=[1,17,33,49,65,81,97,113,
    2,18,34,50,66,82,98,114,
    3,19,35,51,67,83,99,115,
    4,20,36,52,68,84,100,116,
    5,21,37,53,69,85,101,117,
    6,22,38,54,70,86,102,118,
    7,23,39,55,71,87,103,119,
    8,24,40,56,72,88,104,120,
    9,25,41,57,73,89,105,121,
    10,26,42,58,74,90,106,122,
    11,27,43,59,75,91,107,123,
    12,28,44,60,76,92,108,124,
    13,29,45,61,77,93,109,125,
    14,30,46,62,78,94,110,126,
    15,31,47,63,79,95,111,127,
    16,32,48,64,80,96,112,128];

    TX=TX';


    fid = fopen('hv_sw_linear_128.mif','wt');  
    
    fprintf(fid , 'WIDTH= %d;\n',hv_width); 
    
    fprintf(fid, 'DEPTH= %d;\n',hv_depth);
    
    fprintf(fid, 'ADDRESS_RADIX= UNS;\n');  
    
    fprintf(fid, 'DATA_RADIX=BIN;\n');  
    
    fprintf(fid,'CONTENT BEGIN\n');  
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%innner 16 channels %%%%%%%%%%%%%%
    %%%%%%%%%%%%%%% 128 scanner lines %%%%%%%%%%%%%%
    %%%%%%among 256 lines even,odd line use the same channel%%%%
    %%%%%%% for  tranmit %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=-7:1:120                                   % 128 scanner lines
    
    SW_PHY  = [i:1:i+15];                        %  inner  16  channels 
    
    SW_VIR  =  zeros(1,128);
    
    for j=1:1:128                                %  initial value                 
       for k=1:1:16
            if(SW_PHY(k)== TX(j)) 
                SW_VIR(j)= 1;
            end
       end
       fprintf(fid,'%d',SW_VIR(j));
    end
    fprintf(fid,';\r\n');
end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%outside 16 channels %%%%%%%%%%%%%%
    %%%%%%%%%%%%%%% 128 scanner lines %%%%%%%%%%%%%%%
    %%%%%%among 256 lines even,odd line use the same channel%%%%
    %%%%%%% for  tranmit %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



for i=-7:1:120                                 %  128 scanner  lines 
    
    SW_PHY  =  [i-8:1:i-1,i+16:1:i+23];        %  outside 16  channel
    
    SW_VIR  =  zeros(1,128);
    
    for j=1:1:128
        
       for k=1:1:16
           
            if(SW_PHY(k)== TX(j)) 
                SW_VIR(j)=1;
            end
       end
       fprintf(fid,'%d',SW_VIR(j));
    end
    fprintf(fid,';\r\n');
end


  fprintf(fid, 'END;');  

  
  fclose(fid);



ss  =[];
