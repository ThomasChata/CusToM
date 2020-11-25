function out1 = RFHD_Position(in1,in2,in3)
%RFHD_POSITION
%    OUT1 = RFHD_POSITION(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    24-Nov-2020 16:16:27

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
q20 = in1(20,:);
q21 = in1(21,:);
q22 = in1(22,:);
t2 = cos(q7);
t3 = cos(q20);
t4 = cos(q21);
t5 = cos(q22);
t6 = sin(q7);
t7 = sin(q20);
t8 = sin(q21);
t9 = sin(q22);
t10 = R2cut1_1.*t2;
t11 = R2cut1_3.*t2;
t12 = R2cut2_1.*t2;
t13 = R2cut2_3.*t2;
t14 = R2cut1_2.*t3;
t15 = R2cut3_1.*t2;
t16 = R2cut3_3.*t2;
t17 = R2cut2_2.*t3;
t18 = R2cut3_2.*t3;
t19 = R2cut1_1.*t6;
t20 = R2cut1_3.*t6;
t21 = R2cut2_1.*t6;
t22 = R2cut2_3.*t6;
t23 = R2cut1_2.*t7;
t24 = R2cut3_1.*t6;
t25 = R2cut3_3.*t6;
t26 = R2cut2_2.*t7;
t27 = R2cut3_2.*t7;
t28 = -t20;
t29 = -t22;
t30 = -t25;
t31 = t11+t19;
t32 = t13+t21;
t33 = t16+t24;
t34 = t10+t28;
t35 = t12+t29;
t36 = t15+t30;
t37 = t4.*t31;
t38 = t4.*t32;
t39 = t4.*t33;
t40 = t3.*t34;
t41 = t3.*t35;
t42 = t3.*t36;
t43 = t7.*t34;
t44 = t7.*t35;
t45 = t7.*t36;
t46 = -t43;
t47 = -t44;
t48 = -t45;
t49 = t23+t40;
t50 = t26+t41;
t51 = t27+t42;
t52 = t14+t46;
t53 = t17+t47;
t54 = t18+t48;
t55 = t8.*t52;
t56 = t8.*t53;
t57 = t8.*t54;
t58 = -t55;
t59 = -t56;
t60 = -t57;
t61 = t37+t58;
t62 = t38+t59;
t63 = t39+t60;
out1 = [R2cut1_2.*4.608666666666667e-1+p2cut1+t10.*4.133333333333333e-3-t20.*4.133333333333333e-3+t8.*t31.*9.816666666666667e-2+t5.*t49.*(9.3e+1./1.0e+3)+t4.*t52.*9.816666666666667e-2+t9.*t49.*6.716666666666667e-2+t5.*t61.*6.716666666666667e-2-t9.*t61.*(9.3e+1./1.0e+3);R2cut2_2.*4.608666666666667e-1+p2cut2+t12.*4.133333333333333e-3-t22.*4.133333333333333e-3+t8.*t32.*9.816666666666667e-2+t5.*t50.*(9.3e+1./1.0e+3)+t4.*t53.*9.816666666666667e-2+t9.*t50.*6.716666666666667e-2+t5.*t62.*6.716666666666667e-2-t9.*t62.*(9.3e+1./1.0e+3);R2cut3_2.*4.608666666666667e-1+p2cut3+t15.*4.133333333333333e-3-t25.*4.133333333333333e-3+t8.*t33.*9.816666666666667e-2+t5.*t51.*(9.3e+1./1.0e+3)+t4.*t54.*9.816666666666667e-2+t9.*t51.*6.716666666666667e-2+t5.*t63.*6.716666666666667e-2-t9.*t63.*(9.3e+1./1.0e+3)];
