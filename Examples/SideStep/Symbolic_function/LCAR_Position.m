function out1 = LCAR_Position(in1,in2,in3,in4,in5,in6)
%LCAR_POSITION
%    OUT1 = LCAR_POSITION(IN1,IN2,IN3,IN4,IN5,IN6)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    17-Nov-2021 17:55:55

R6cut1_1 = in6(46);
R6cut1_2 = in6(49);
R6cut1_3 = in6(52);
R6cut2_1 = in6(47);
R6cut2_2 = in6(50);
R6cut2_3 = in6(53);
R6cut3_1 = in6(48);
R6cut3_2 = in6(51);
R6cut3_3 = in6(54);
k_sym21 = in4(21,:);
k_sym22 = in4(22,:);
p6cut1 = in5(16);
p6cut2 = in5(17);
p6cut3 = in5(18);
q60 = in3(54,:);
q61 = in3(55,:);
q62 = in3(56,:);
t2 = cos(q60);
t3 = cos(q61);
t4 = cos(q62);
t5 = sin(q60);
t6 = sin(q61);
t7 = sin(q62);
t17 = k_sym22.*3.888888888888889e-3;
t21 = k_sym21.*5.11e-2;
t22 = k_sym22.*1.901666666666667e-2;
t8 = R6cut1_1.*t2;
t9 = R6cut2_1.*t2;
t10 = R6cut3_1.*t2;
t11 = R6cut1_3.*t5;
t12 = R6cut2_3.*t5;
t13 = R6cut3_3.*t5;
t23 = t17+7.0./3.6e+2;
t24 = t21+2.555e-1;
t25 = t22+9.508333333333333e-2;
t14 = -t11;
t15 = -t12;
t16 = -t13;
t18 = t8+t14;
t19 = t9+t15;
t20 = t10+t16;
out1 = [p6cut1-R6cut1_2.*t24-t25.*(t7.*(R6cut1_3.*t2+R6cut1_1.*t5)+t4.*(R6cut1_2.*t3-t6.*t18))-t23.*(R6cut1_2.*t6+t3.*t18);p6cut2-R6cut2_2.*t24-t25.*(t7.*(R6cut2_3.*t2+R6cut2_1.*t5)+t4.*(R6cut2_2.*t3-t6.*t19))-t23.*(R6cut2_2.*t6+t3.*t19);p6cut3-R6cut3_2.*t24-t25.*(t7.*(R6cut3_3.*t2+R6cut3_1.*t5)+t4.*(R6cut3_2.*t3-t6.*t20))-t23.*(R6cut3_2.*t6+t3.*t20)];
