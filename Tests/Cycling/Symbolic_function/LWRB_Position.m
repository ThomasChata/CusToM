function out1 = LWRB_Position(in1,in2,in3)
%LWRB_POSITION
%    OUT1 = LWRB_POSITION(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    21-Feb-2021 15:37:09

R5cut1_1 = in3(37);
R5cut1_2 = in3(40);
R5cut1_3 = in3(43);
R5cut2_1 = in3(38);
R5cut2_2 = in3(41);
R5cut2_3 = in3(44);
R5cut3_1 = in3(39);
R5cut3_2 = in3(42);
R5cut3_3 = in3(45);
p5cut1 = in2(13);
p5cut2 = in2(14);
p5cut3 = in2(15);
q38 = in1(38,:);
q39 = in1(39,:);
q40 = in1(40,:);
t2 = cos(q38);
t3 = cos(q39);
t4 = cos(q40);
t5 = sin(q38);
t6 = sin(q39);
t7 = sin(q40);
t8 = R5cut1_1.*t2;
t9 = R5cut2_1.*t2;
t10 = R5cut3_1.*t2;
t11 = R5cut1_3.*t5;
t12 = R5cut2_3.*t5;
t13 = R5cut3_3.*t5;
t14 = -t11;
t15 = -t12;
t16 = -t13;
t17 = t8+t14;
t18 = t9+t15;
t19 = t10+t16;
out1 = [R5cut1_2.*(-3.333342798044145e-1)+p5cut1-R5cut1_2.*t3.*2.809551351182273e-1+t6.*t17.*2.809551351182273e-1+t4.*(R5cut1_3.*t2+R5cut1_1.*t5).*3.197309480620986e-2+t7.*(R5cut1_2.*t6+t3.*t17).*3.197309480620986e-2;R5cut2_2.*(-3.333342798044145e-1)+p5cut2-R5cut2_2.*t3.*2.809551351182273e-1+t6.*t18.*2.809551351182273e-1+t4.*(R5cut2_3.*t2+R5cut2_1.*t5).*3.197309480620986e-2+t7.*(R5cut2_2.*t6+t3.*t18).*3.197309480620986e-2;R5cut3_2.*(-3.333342798044145e-1)+p5cut3-R5cut3_2.*t3.*2.809551351182273e-1+t6.*t19.*2.809551351182273e-1+t4.*(R5cut3_3.*t2+R5cut3_1.*t5).*3.197309480620986e-2+t7.*(R5cut3_2.*t6+t3.*t19).*3.197309480620986e-2];
