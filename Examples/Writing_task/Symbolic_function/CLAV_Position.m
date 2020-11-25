function out1 = CLAV_Position(in1,in2,in3)
%CLAV_POSITION
%    OUT1 = CLAV_POSITION(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    24-Nov-2020 16:16:19

R2cut1_1 = in3(10);
R2cut1_2 = in3(13);
R2cut1_3 = in3(16);
R2cut2_1 = in3(11);
R2cut2_2 = in3(14);
R2cut2_3 = in3(17);
R2cut3_1 = in3(12);
R2cut3_2 = in3(15);
R2cut3_3 = in3(18);
p2cut1 = in2(4);
p2cut2 = in2(5);
p2cut3 = in2(6);
q7 = in1(7,:);
t2 = cos(q7);
t3 = sin(q7);
out1 = [R2cut1_2.*2.883e-1+p2cut1+R2cut1_1.*t2.*(3.1e+1./6.25e+2)-R2cut1_3.*t3.*(3.1e+1./6.25e+2);R2cut2_2.*2.883e-1+p2cut2+R2cut2_1.*t2.*(3.1e+1./6.25e+2)-R2cut2_3.*t3.*(3.1e+1./6.25e+2);R2cut3_2.*2.883e-1+p2cut3+R2cut3_1.*t2.*(3.1e+1./6.25e+2)-R2cut3_3.*t3.*(3.1e+1./6.25e+2)];
