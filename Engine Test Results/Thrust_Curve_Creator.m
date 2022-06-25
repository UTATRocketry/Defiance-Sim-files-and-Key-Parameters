%Create Thrust Curves from Test Data
clear
clc
close all

%Sim Results
sim_path = "C:\Users\David\Documents\GitHub\DefianceSim\Saved Results\Last Run";
sim_results = "workspace variables.mat";
load(sim_path+"\"+sim_results,"cg_fuel","cg_engine")

test_path = "C:\Users\David\Documents\GitHub\Defiance-Sim-files-and-Key-Parameters\Engine Test Results\June-05-22";

%% Write to File
% Create .rse file for Open Rocket
eng_file = fopen([pwd strcat('/Saved Results/Last Run/defiance_test_',test_date,'.rse')], 'wt' );
fprintf(eng_file,'<engine-database>\n');
fprintf(eng_file,'  <engine-list>\n');
fprintf(eng_file,'    <engine FDiv="10" FFix="1" FStep="-1." Isp="%.1f" Itot="%.0f" Type="hybrid" auto-calc-cg="0" auto-calc-mass="0"\n', Isp_avg, Total_Impulse);
fprintf(eng_file,'    avgThrust="%.2f" burn-time="%.2f" cgDiv="10" cgFix="1" cgStep="-1." code="%s" delays="1000" dia="%.1f" exitDia="0." initWt="%.3f" \n',mean(F(1:burn_step)),t(burn_step),"Test:"+date, diam*1000,1000*(m_ox(1)+m_f(1)));
fprintf(eng_file,'    len="%.1f" mDiv="10" mFix="1" mStep="-1." massFrac="%.2f" mfg="UTAT" peakThrust="%.2f" propWt="%.3f" tDiv="10" tFix="1"\n',length_motor,(m_ox(1)+m_f(1)+m_engine_dry)/m_engine_dry, max(F),m_ox(1)+m_f(1));
fprintf(eng_file,'    tStep="-1." throatDia="%.1f">\n',sqrt(A_t/pi()*4)*1000);
fprintf(eng_file,'      <data>\n');
for i = 2:(burn_step+1)
    fprintf(eng_file,'        <eng-data cg="%.3f" f="%.3f" m="%.3f" t="%.3f"/>\n',(cg_engine(i)*(m_engine_dry+m_ox(i)+m_f(i))-m_engine_dry*cg_engine_dry)/(m_ox(i)+m_f(i)),F(i),1000*(m_ox(i)+m_f(i)),t(i));
end
fprintf(eng_file,'      </data>\n');
fprintf(eng_file,'    </engine>\n');
fprintf(eng_file,'  </engine-list>\n');
fprintf(eng_file,'</engine-database>\n');
fclose(eng_file);