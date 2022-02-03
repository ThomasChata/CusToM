function out1 = LANE_Position(in1,in2,in3,in4,in5,in6)
%LANE_POSITION
%    OUT1 = LANE_POSITION(IN1,IN2,IN3,IN4,IN5,IN6)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    17-Nov-2021 17:55:45

R1cut1_1 = in6(1);
R1cut1_2 = in6(4);
R1cut1_3 = in6(7);
R1cut2_1 = in6(2);
R1cut2_2 = in6(5);
R1cut2_3 = in6(8);
R1cut3_1 = in6(3);
R1cut3_2 = in6(6);
R1cut3_3 = in6(9);
k_sym1 = in4(1,:);
k_sym12 = in4(12,:);
k_sym13 = in4(13,:);
p1cut1 = in5(1);
p1cut2 = in5(2);
p1cut3 = in5(3);
p_adapt_sym32 = in4(54,:);
q1 = in3(1,:);
q43 = in3(37,:);
q44 = in3(38,:);
q45 = in3(39,:);
q46 = in3(40,:);
t2 = cos(q1);
t3 = cos(q43);
t4 = cos(q44);
t5 = cos(q45);
t6 = cos(q46);
t7 = sin(q1);
t8 = sin(q43);
t9 = sin(q44);
t10 = sin(q45);
t11 = sin(q46);
t30 = k_sym13./5.0;
t37 = p_adapt_sym32./2.0e+1;
t39 = k_sym1.*(7.0./4.5e+2);
t40 = k_sym1.*(7.0./7.2e+2);
t41 = k_sym12.*4.861111111111111e-3;
t42 = k_sym12.*1.944444444444444e-3;
t43 = k_sym1.*1.555555555555556e-3;
t50 = k_sym12.*8.847222222222222e-2;
t91 = k_sym13.*8.066916666666667e-3;
t12 = R1cut1_1.*t2;
t13 = R1cut1_2.*t2;
t14 = R1cut2_1.*t2;
t15 = R1cut2_2.*t2;
t16 = R1cut3_1.*t2;
t17 = R1cut3_2.*t2;
t18 = R1cut1_3.*t4;
t19 = R1cut2_3.*t4;
t20 = R1cut3_3.*t4;
t21 = R1cut1_1.*t7;
t22 = R1cut1_2.*t7;
t23 = R1cut2_1.*t7;
t24 = R1cut2_2.*t7;
t25 = R1cut3_1.*t7;
t26 = R1cut3_2.*t7;
t27 = R1cut1_3.*t9;
t28 = R1cut2_3.*t9;
t29 = R1cut3_3.*t9;
t38 = t30+1.0;
t57 = t39+7.0./9.0e+1;
t58 = t40+7.0./1.44e+2;
t59 = t41+7.0./2.88e+2;
t69 = t42+7.0./7.2e+2;
t70 = t43+7.0./9.0e+2;
t71 = t37-4.561666666666667e-1;
t72 = t50+4.423611111111111e-1;
t107 = t91+4.033458333333333e-2;
t31 = -t18;
t32 = -t19;
t33 = -t20;
t34 = -t21;
t35 = -t23;
t36 = -t25;
t44 = t12+t22;
t45 = t14+t24;
t46 = t16+t26;
t47 = t13+t34;
t48 = t15+t35;
t49 = t17+t36;
t51 = t3.*t44;
t52 = t3.*t45;
t53 = t3.*t46;
t54 = t8.*t44;
t55 = t8.*t45;
t56 = t8.*t46;
t60 = t3.*t47;
t61 = t3.*t48;
t62 = t3.*t49;
t63 = t8.*t47;
t64 = -t54;
t65 = t8.*t48;
t66 = -t55;
t67 = t8.*t49;
t68 = -t56;
t73 = t51+t63;
t74 = t52+t65;
t75 = t53+t67;
t76 = t60+t64;
t77 = t61+t66;
t78 = t62+t68;
t85 = -t4.*(t54-t60);
t86 = -t4.*(t55-t61);
t87 = -t4.*(t56-t62);
t88 = -t9.*(t54-t60);
t89 = -t9.*(t55-t61);
t90 = -t9.*(t56-t62);
t98 = -t5.*(t18+t9.*(t54-t60));
t99 = -t5.*(t19+t9.*(t55-t61));
t100 = -t5.*(t20+t9.*(t56-t62));
t101 = -t10.*(t18+t9.*(t54-t60));
t102 = -t10.*(t19+t9.*(t55-t61));
t103 = -t10.*(t20+t9.*(t56-t62));
t104 = t5.*(t18+t9.*(t54-t60));
t105 = t5.*(t19+t9.*(t55-t61));
t106 = t5.*(t20+t9.*(t56-t62));
t79 = t5.*t73;
t80 = t5.*t74;
t81 = t5.*t75;
t82 = t10.*t73;
t83 = t10.*t74;
t84 = t10.*t75;
t92 = t27+t85;
t93 = t28+t86;
t94 = t29+t87;
t95 = t31+t88;
t96 = t32+t89;
t97 = t33+t90;
t108 = t79+t101;
t109 = t80+t102;
t110 = t81+t103;
t111 = t82+t104;
t112 = t83+t105;
t113 = t84+t106;
out1 = [p1cut1-R1cut1_3.*t57-t47.*t58-t44.*t70-t72.*t92-t59.*t108-t69.*t111-t107.*t111+t38.*t71.*(t6.*t92-t11.*t108);p1cut2-R1cut2_3.*t57-t48.*t58-t45.*t70-t72.*t93-t59.*t109-t69.*t112-t107.*t112+t38.*t71.*(t6.*t93-t11.*t109);p1cut3-R1cut3_3.*t57-t49.*t58-t46.*t70-t72.*t94-t59.*t110-t69.*t113-t107.*t113+t38.*t71.*(t6.*t94-t11.*t110)];