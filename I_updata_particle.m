function m_dag = I_updata_particle(m_dag,m_pbest,m_gbest)

m = length(m_pbest);

for i = 1 :m
    for j = 1 :m
        if m_dag(i,j)==0&&m_gbest(i,j)==0&&m_pbest(i,j)==0
            if rand<0.9
                m_dag(i,j) = 0;
            else
                m_dag(i,j) = 1;
            end
        end
        if m_dag(i,j)==0&&m_gbest(i,j)==0&&m_pbest(i,j)==1
            if rand<0.7
                m_dag(i,j) = 0;
            else
                m_dag(i,j) = 1;
            end
        end
        if m_dag(i,j)==0&&m_gbest(i,j)==1&&m_pbest(i,j)==0
            if rand<0.3
                m_dag(i,j) = 0;
            else
                m_dag(i,j) = 1;
            end
        end
          if  m_dag(i,j)==0&&m_gbest(i,j)==1&&m_pbest(i,j)==1
            if rand<0.3
                m_dag(i,j) = 0;
            else
                m_dag(i,j) = 1;
            end
          end
        if  m_dag(i,j)==1&&m_gbest(i,j)==0&&m_pbest(i,j)==0
            if rand<0.7
                m_dag(i,j) = 0;
            else
                m_dag(i,j) = 1;
            end
        end
        if  m_dag(i,j)==1&&m_gbest(i,j)==0&&m_pbest(i,j)==1
            if rand<0.3
                m_dag(i,j) = 0;
            else
                m_dag(i,j) = 1;
            end
        end
      if  m_dag(i,j)==1&&m_gbest(i,j)==1&&m_pbest(i,j)==0
            if rand<0.3
                m_dag(i,j) = 0;
            else
                m_dag(i,j) = 1;
            end
      end
      if  m_dag(i,j)==1&&m_gbest(i,j)==1&&m_pbest(i,j)==1
            if rand<0.1
                m_dag(i,j) = 0;
            else
                m_dag(i,j) = 1;
            end
        end
    end
end
