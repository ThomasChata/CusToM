function out1 = RTARI_Position(in1,in2,in3)
%RTARI_POSITION
%    OUT1 = RTARI_POSITION(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.1.
%    25-Oct-2018 19:00:51

R3cut1_1 = in3(19);
R3cut1_2 = in3(22);
R3cut1_3 = in3(25);
R3cut2_1 = in3(20);
R3cut2_2 = in3(23);
R3cut2_3 = in3(26);
R3cut3_1 = in3(21);
R3cut3_2 = in3(24);
R3cut3_3 = in3(27);
p3cut1 = in2(7);
p3cut2 = in2(8);
p3cut3 = in2(9);
q22 = in1(22,:);
t2 = cos(q22);
t3 = sin(q22);
out1 = [R3cut1_1.*1.398808188675316e-1+p3cut1-R3cut1_2.*t2.*4.972042405751907e-2+R3cut1_2.*t3.*3.011501254723441e-2-R3cut1_3.*t2.*3.011501254723441e-2-R3cut1_3.*t3.*4.972042405751907e-2;R3cut2_1.*1.398808188675316e-1+p3cut2-R3cut2_2.*t2.*4.972042405751907e-2+R3cut2_2.*t3.*3.011501254723441e-2-R3cut2_3.*t2.*3.011501254723441e-2-R3cut2_3.*t3.*4.972042405751907e-2;R3cut3_1.*1.398808188675316e-1+p3cut3-R3cut3_2.*t2.*4.972042405751907e-2+R3cut3_2.*t3.*3.011501254723441e-2-R3cut3_3.*t2.*3.011501254723441e-2-R3cut3_3.*t3.*4.972042405751907e-2];
