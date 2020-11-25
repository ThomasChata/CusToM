function out1 = LBWT_Position(in1,in2,in3)
%LBWT_POSITION
%    OUT1 = LBWT_POSITION(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    24-Nov-2020 16:16:26

R1cut1_1 = in3(1);
R1cut1_2 = in3(4);
R1cut1_3 = in3(7);
R1cut2_1 = in3(2);
R1cut2_2 = in3(5);
R1cut2_3 = in3(8);
R1cut3_1 = in3(3);
R1cut3_2 = in3(6);
R1cut3_3 = in3(9);
p1cut1 = in2(1);
p1cut2 = in2(2);
p1cut3 = in2(3);
q1 = in1(1,:);
t2 = cos(q1);
t3 = sin(q1);
out1 = [R1cut1_3.*(-3.1e+1./7.5e+2)+p1cut1-R1cut1_1.*t2.*(9.3e+1./1.0e+3)-R1cut1_1.*t3.*2.066666666666667e-2+R1cut1_2.*t2.*2.066666666666667e-2-R1cut1_2.*t3.*(9.3e+1./1.0e+3);R1cut2_3.*(-3.1e+1./7.5e+2)+p1cut2-R1cut2_1.*t2.*(9.3e+1./1.0e+3)-R1cut2_1.*t3.*2.066666666666667e-2+R1cut2_2.*t2.*2.066666666666667e-2-R1cut2_2.*t3.*(9.3e+1./1.0e+3);R1cut3_3.*(-3.1e+1./7.5e+2)+p1cut3-R1cut3_1.*t2.*(9.3e+1./1.0e+3)-R1cut3_1.*t3.*2.066666666666667e-2+R1cut3_2.*t2.*2.066666666666667e-2-R1cut3_2.*t3.*(9.3e+1./1.0e+3)];
