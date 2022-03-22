function Nc = Compute_Nc(sample_number)
number_1_1_1 = 0;number_1_1_2 = 0;number_1_1_3 = 0;                        %number_1_1_2,number_2_2_1Îª²»ºÏ·¨½á¹¹
number_1_2_1 = 0;number_1_2_2 = 0;number_1_2_3 = 0;
number_1_3_1 = 0;number_1_3_2 = 0;number_1_3_3 = 0;

number_2_1_1 = 0;number_2_1_2 = 0;number_2_1_3 = 0;
number_2_2_1 = 0;number_2_2_2 = 0;number_2_2_3 = 0;
number_2_3_1 = 0;number_2_3_2 = 0;number_2_3_3 = 0;

number_3_1_1 = 0;number_3_1_2 = 0;number_3_1_3 = 0;
number_3_2_1 = 0;number_3_2_2 = 0;number_3_2_3 = 0;
number_3_3_1 = 0;number_3_3_2 = 0;number_3_3_3 = 0;
n = sample_number;
for i = 1 : n
    dag = randint(8);
    if dag(2,4)==1&&dag(4,6)==1&&dag(2,6)==1&&dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==0
        number_1_1_1 = number_1_1_1 + 1;
    end
    if dag(2,4)==1&&dag(4,6)==1&&dag(2,6)==0&&dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==1
        number_1_1_2 = number_1_1_2 + 1;
    end
    if dag(2,4)==1&&dag(4,6)==1&&dag(2,6)==0&&dag(6,2)==0&&dag(4,2)==0&&dag(6,4)==0
        number_1_1_3 = number_1_1_3 + 1;
    end
    if dag(2,4)==1&&dag(6,4)==1&&dag(2,6)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(6,2)==0
        number_1_2_1 = number_1_2_1 + 1;
    end
    if dag(2,4)==1&&dag(6,4)==1&&dag(6,2)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
        number_1_2_2 = number_1_2_2 + 1;
    end
    if dag(2,4)==1&&dag(6,4)==1&&dag(6,2)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
        number_1_2_2 = number_1_2_2 + 1;
    end
    if dag(2,4)==1&&dag(6,4)==1&&dag(6,2)==0&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
        number_1_2_3 = number_1_2_3 + 1;
    end
    if dag(2,4)==1&&dag(6,4)==0&&dag(2,6)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(6,2)==0
        number_1_3_1 = number_1_3_1 + 1;
    end
    if dag(2,4)==1&&dag(6,4)==0&&dag(6,2)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
        number_1_3_2 = number_1_3_2 + 1;
    end
    if dag(2,4)==1&&dag(6,4)==0&&dag(6,2)==0&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
        number_1_3_3 = number_1_3_3 + 1;
    end
    
     if dag(4,2)==1&&dag(4,6)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(6,2)==0
        number_2_1_1 = number_2_1_1 + 1;
     end
     if dag(4,2)==1&&dag(4,6)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
        number_2_1_2 = number_2_1_2 + 1;
     end
     if dag(4,2)==1&&dag(4,6)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
        number_2_1_3 = number_2_1_3 + 1;
     end
     if dag(4,2)==1&&dag(6,4)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==1
        number_2_2_1 = number_2_2_1 + 1;
     end
     if dag(4,2)==1&&dag(6,4)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        number_2_2_2 = number_2_2_2 + 1;
     end
     if dag(4,2)==1&&dag(6,4)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        number_2_2_3 = number_2_2_3 + 1;
     end
     if dag(4,2)==1&&dag(6,4)==0&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
        number_2_3_1 = number_2_3_1 + 1;
     end
     if dag(4,2)==1&&dag(6,4)==0&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        number_2_3_2 = number_2_3_2 + 1;
     end
     if dag(4,2)==1&&dag(6,4)==0&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        number_2_3_3 = number_2_3_3 + 1;
     end
     
     if dag(4,2)==0&&dag(4,6)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(6,2)==0
        number_3_1_1 = number_3_1_1 + 1;
     end
     if dag(4,2)==0&&dag(4,6)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
        number_3_1_2 = number_3_1_2 + 1;
     end
     if dag(4,2)==0&&dag(4,6)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
        number_3_1_3 = number_3_1_3 + 1;
     end
     if dag(4,2)==0&&dag(6,4)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
        number_3_2_1 = number_3_2_1 + 1;
     end
      if dag(4,2)==0&&dag(6,4)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        number_3_2_2 = number_3_2_2 + 1;
      end
      if dag(4,2)==0&&dag(6,4)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        number_3_2_3 = number_3_2_3 + 1;
      end
      if dag(4,2)==0&&dag(6,4)==0&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
        number_3_3_1 = number_3_3_1 + 1;
      end
      if dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        number_3_3_2 = number_3_3_2 + 1;
      end
      if dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        number_3_3_3 = number_3_3_3 + 1;
     end
end
Nc(1) = number_1_1_1 ;Nc(2) = number_1_1_2 ;Nc(3) = number_1_1_3 ;
Nc(4) = number_1_2_1 ;Nc(5) = number_1_2_2 ;Nc(6) = number_1_2_3 ;
Nc(7) = number_1_3_1 ;Nc(8) = number_1_3_2 ;Nc(9) = number_1_3_3 ;

Nc(10) = number_2_1_1 ;Nc(11) = number_2_1_2 ;Nc(12) = number_2_1_3 ;
Nc(13) = number_2_2_1 ;Nc(14) = number_2_2_2 ;Nc(15) = number_2_2_3 ;
Nc(16) = number_2_3_1 ;Nc(17) = number_2_3_2 ;Nc(18) = number_2_3_3 ;

Nc(19) = number_3_1_1 ;Nc(20) = number_3_1_2 ;Nc(21) = number_3_1_3 ;
Nc(22) = number_3_2_1 ;Nc(23) = number_3_2_2 ;Nc(24) = number_3_2_3 ;
Nc(25) = number_3_3_1 ;Nc(26) = number_3_3_2 ;Nc(27) = number_3_3_3 ;
N_all = sum(Nc);
Nc = Nc/N_all;
Nc = Nc*3781503;  %  3781503  7.8370e+011


