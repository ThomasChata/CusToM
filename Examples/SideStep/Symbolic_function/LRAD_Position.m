function out1 = LRAD_Position(in1,in2,in3,in4,in5,in6)
%LRAD_POSITION
%    OUT1 = LRAD_POSITION(IN1,IN2,IN3,IN4,IN5,IN6)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    17-Nov-2021 17:55:54

R5cut1_1 = in6(37);
R5cut1_2 = in6(40);
R5cut1_3 = in6(43);
R5cut2_1 = in6(38);
R5cut2_2 = in6(41);
R5cut2_3 = in6(44);
R5cut3_1 = in6(39);
R5cut3_2 = in6(42);
R5cut3_3 = in6(45);
k_sym7 = in4(7,:);
k_sym19 = in4(19,:);
k_sym20 = in4(20,:);
p5cut1 = in5(13);
p5cut2 = in5(14);
p5cut3 = in5(15);
p_adapt_sym43 = in4(65,:);
p_adapt_sym44 = in4(66,:);
q32 = in3(26,:);
q33 = in3(27,:);
q56 = in3(50,:);
q57 = in3(51,:);
q58 = in3(52,:);
q59 = in3(53,:);
t2 = cos(q32);
t3 = cos(q33);
t4 = cos(q56);
t5 = cos(q57);
t6 = cos(q58);
t7 = cos(q59);
t8 = sin(q32);
t9 = sin(q33);
t10 = sin(q56);
t11 = sin(q57);
t12 = sin(q58);
t13 = sin(q59);
t32 = k_sym20./5.0;
t36 = p_adapt_sym44./2.0e+1;
t38 = k_sym20.*(7.0./9.0e+2);
t42 = k_sym7.*9.8e-4;
t52 = k_sym19.*6.51e-2;
t90 = k_sym7.*1.434142156862745e-2;
t91 = k_sym7.*9.774722222222222e-3;
t14 = R5cut1_1.*t2;
t15 = R5cut1_2.*t2;
t16 = R5cut1_3.*t3;
t17 = R5cut2_1.*t2;
t18 = R5cut2_2.*t2;
t19 = R5cut2_3.*t3;
t20 = R5cut3_1.*t2;
t21 = R5cut3_2.*t2;
t22 = R5cut3_3.*t3;
t23 = R5cut1_1.*t8;
t24 = R5cut1_2.*t8;
t25 = R5cut1_3.*t9;
t26 = R5cut2_1.*t8;
t27 = R5cut2_2.*t8;
t28 = R5cut2_3.*t9;
t29 = R5cut3_1.*t8;
t30 = R5cut3_2.*t8;
t31 = R5cut3_3.*t9;
t37 = t32+1.0;
t53 = t38+7.0./1.8e+2;
t69 = t36-1.963888888888889e-2;
t70 = t42+4.9e-3;
t80 = t52+3.255e-1;
t116 = t90+7.170710784313725e-2;
t117 = t91+4.887361111111111e-2;
t33 = -t23;
t34 = -t26;
t35 = -t29;
t39 = t14+t24;
t40 = t17+t27;
t41 = t20+t30;
t43 = t15+t33;
t44 = t18+t34;
t45 = t21+t35;
t46 = t3.*t39;
t47 = t3.*t40;
t48 = t3.*t41;
t49 = t9.*t39;
t50 = t9.*t40;
t51 = t9.*t41;
t54 = -t46;
t55 = -t47;
t56 = t5.*t43;
t57 = -t48;
t58 = t5.*t44;
t59 = t5.*t45;
t60 = t11.*t43;
t61 = t11.*t44;
t62 = t11.*t45;
t66 = t16+t49;
t67 = t19+t50;
t68 = t22+t51;
t63 = -t60;
t64 = -t61;
t65 = -t62;
t71 = t25+t54;
t72 = t28+t55;
t73 = t31+t57;
t74 = t4.*t66;
t75 = t4.*t67;
t76 = t4.*t68;
t77 = t10.*t66;
t78 = t10.*t67;
t79 = t10.*t68;
t81 = t4.*t71;
t82 = t4.*t72;
t83 = t4.*t73;
t84 = t10.*t71;
t85 = t10.*t72;
t86 = t10.*t73;
t87 = -t84;
t88 = -t85;
t89 = -t86;
t92 = t77+t81;
t93 = t78+t82;
t94 = t79+t83;
t95 = t74+t87;
t96 = t75+t88;
t97 = t76+t89;
t98 = t6.*t92;
t99 = t6.*t93;
t100 = t6.*t94;
t101 = t5.*t95;
t102 = t5.*t96;
t103 = t5.*t97;
t104 = t11.*t95;
t105 = t11.*t96;
t106 = t11.*t97;
t107 = t56+t104;
t108 = t58+t105;
t109 = t59+t106;
t110 = t63+t101;
t111 = t64+t102;
t112 = t65+t103;
t113 = -t12.*(t60-t101);
t114 = -t12.*(t61-t102);
t115 = -t12.*(t62-t103);
t118 = t98+t113;
t119 = t99+t114;
t120 = t100+t115;
out1 = [p5cut1+t43.*t70-t66.*t116-t80.*t107-t71.*t117+t53.*(t12.*t92+t6.*(t60-t101))+(p_adapt_sym43.*t37.*(t13.*t107-t7.*t118))./2.0e+1+t37.*t69.*(t7.*t107+t13.*t118);p5cut2+t44.*t70-t67.*t116-t80.*t108-t72.*t117+t53.*(t12.*t93+t6.*(t61-t102))+(p_adapt_sym43.*t37.*(t13.*t108-t7.*t119))./2.0e+1+t37.*t69.*(t7.*t108+t13.*t119);p5cut3+t45.*t70-t68.*t116-t80.*t109-t73.*t117+t53.*(t12.*t94+t6.*(t62-t103))+(p_adapt_sym43.*t37.*(t13.*t109-t7.*t120))./2.0e+1+t37.*t69.*(t7.*t109+t13.*t120)];
