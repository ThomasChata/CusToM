function [R5cut,p5cut] = f5cut(in1,in2,in3,in4,in5,in6)
%F5CUT
%    [R5CUT,P5CUT] = F5CUT(IN1,IN2,IN3,IN4,IN5,IN6)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    17-Nov-2021 17:56:00

R4cut1_1 = in6(28);
R4cut1_2 = in6(31);
R4cut1_3 = in6(34);
R4cut2_1 = in6(29);
R4cut2_2 = in6(32);
R4cut2_3 = in6(35);
R4cut3_1 = in6(30);
R4cut3_2 = in6(33);
R4cut3_3 = in6(36);
k_sym3 = in4(3,:);
p4cut1 = in5(10);
p4cut2 = in5(11);
p4cut3 = in5(12);
q7 = in3(7,:);
q30 = in3(24,:);
q31 = in3(25,:);
radius4 = in4(71,:);
radius5 = in4(72,:);
radius6 = in4(73,:);
t2 = cos(q7);
t3 = cos(q30);
t4 = cos(q31);
t5 = sin(q7);
t6 = sin(q30);
t7 = sin(q31);
t26 = radius5.*(7.0./2.4e+2);
t30 = radius4.*1.361111111111111e-2;
t38 = k_sym3.*1.499166666666667e-2;
t42 = k_sym3.*5.450277777777778e-2;
t49 = radius6.*1.544460784313725e-2;
t50 = k_sym3.*1.343680882352941e-2;
t8 = R4cut1_1.*t2;
t9 = R4cut1_3.*t2;
t10 = R4cut2_1.*t2;
t11 = R4cut2_3.*t2;
t12 = R4cut3_1.*t2;
t13 = R4cut3_3.*t2;
t14 = R4cut1_1.*t5;
t15 = R4cut1_3.*t5;
t16 = R4cut2_1.*t5;
t17 = R4cut2_3.*t5;
t18 = R4cut3_1.*t5;
t19 = R4cut3_3.*t5;
t20 = R4cut1_2.*t6;
t21 = R4cut2_2.*t6;
t22 = R4cut3_2.*t6;
t34 = t26+7.0./4.8e+1;
t43 = t30+4.9e+1./7.2e+2;
t48 = t42+2.725138888888889e-1;
t52 = t49+7.722303921568626e-2;
t53 = t50+6.718404411764706e-2;
t23 = -t15;
t24 = -t17;
t25 = -t19;
t27 = t9+t14;
t28 = t11+t16;
t29 = t13+t18;
t47 = t7.*t43;
t31 = t8+t23;
t32 = t10+t24;
t33 = t12+t25;
t35 = t3.*t27;
t36 = t3.*t28;
t37 = t3.*t29;
t51 = t38+t47+7.495833333333333e-2;
t39 = -t35;
t40 = -t36;
t41 = -t37;
t44 = t20+t39;
t45 = t21+t40;
t46 = t22+t41;
R5cut = reshape([t4.*t31+t7.*t44,t4.*t32+t7.*t45,t4.*t33+t7.*t46,R4cut1_2.*t3+t6.*t27,R4cut2_2.*t3+t6.*t28,R4cut3_2.*t3+t6.*t29,t7.*t31-t4.*t44,t7.*t32-t4.*t45,t7.*t33-t4.*t46],[3,3]);
if nargout > 1
    p5cut = [p4cut1+R4cut1_2.*t48-t27.*t53+t31.*t51-t4.*t20.*t34+t4.*t39.*t52;p4cut2+R4cut2_2.*t48-t28.*t53+t32.*t51-t4.*t21.*t34+t4.*t40.*t52;p4cut3+R4cut3_2.*t48-t29.*t53+t33.*t51-t4.*t22.*t34+t4.*t41.*t52];
end
