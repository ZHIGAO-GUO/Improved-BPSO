function Haming_Distance = Comupute_Haming_Distance(dag,stard_dag)
 [m,n] = size(stard_dag);
 m_dag = dag;
 m_stard_dag = stard_dag;
 num1 = 0;  %多余的边
 num2 = 0;  %反转的边
 num3 = 0;  %丢失的边
 for i = 1 : m
     for j = 1 : n
         if m_stard_dag(i,j)==0&&m_dag(i,j)==1&&m_stard_dag(j,i)==0
             num1 = num1 + 1;
         end
         if m_stard_dag(i,j)==0&&m_dag(i,j)==1&&m_stard_dag(j,i)==1
             num2 = num2 + 1;
         end
         if m_stard_dag(i,j)==1&&m_dag(i,j)==0
             num3 = num3 + 1;
         end
     end
 end
 Haming_Distance = num1 + num2 + num3;