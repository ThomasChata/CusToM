function [R2cut,p2cut] = f2cut(in1,in2,in3,in4,in5,in6)
%F2CUT
%    [R2CUT,P2CUT] = F2CUT(IN1,IN2,IN3,IN4,IN5,IN6)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    17-Nov-2021 17:56:01

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
q1 = in3(1,:);
q43 = in3(37,:);
q44 = in3(38,:);
q45 = in3(39,:);
q46 = in3(40,:);
q47 = in3(41,:);
t2 = cos(q1);
t3 = cos(q43);
t4 = cos(q44);
t5 = cos(q45);
t6 = cos(q46);
t7 = cos(q47);
t8 = sin(q1);
t9 = sin(q43);
t10 = sin(q44);
t11 = sin(q45);
t12 = sin(q46);
t13 = sin(q47);
t38 = k_sym1.*(7.0./4.5e+2);
t39 = k_sym1.*(7.0./7.2e+2);
t40 = k_sym12.*4.861111111111111e-3;
t41 = k_sym12.*1.944444444444444e-3;
t42 = k_sym1.*1.555555555555556e-3;
t46 = k_sym13.*8.944444444444444e-2;
t50 = k_sym12.*8.847222222222222e-2;
t14 = R1cut1_1.*t2;
t15 = R1cut1_2.*t2;
t16 = R1cut2_1.*t2;
t17 = R1cut2_2.*t2;
t18 = R1cut3_1.*t2;
t19 = R1cut3_2.*t2;
t20 = R1cut1_3.*t4;
t21 = R1cut2_3.*t4;
t22 = R1cut3_3.*t4;
t23 = R1cut1_1.*t8;
t24 = R1cut1_2.*t8;
t25 = R1cut2_1.*t8;
t26 = R1cut2_2.*t8;
t27 = R1cut3_1.*t8;
t28 = R1cut3_2.*t8;
t29 = R1cut1_3.*t10;
t30 = R1cut2_3.*t10;
t31 = R1cut3_3.*t10;
t57 = t38+7.0./9.0e+1;
t58 = t39+7.0./1.44e+2;
t59 = t40+7.0./2.88e+2;
t69 = t41+7.0./7.2e+2;
t70 = t42+7.0./9.0e+2;
t71 = t46+1.61e+2./3.6e+2;
t72 = t50+4.423611111111111e-1;
t32 = -t20;
t33 = -t21;
t34 = -t22;
t35 = -t23;
t36 = -t25;
t37 = -t27;
t43 = t14+t24;
t44 = t16+t26;
t45 = t18+t28;
t47 = t15+t35;
t48 = t17+t36;
t49 = t19+t37;
t51 = t3.*t43;
t52 = t3.*t44;
t53 = t3.*t45;
t54 = t9.*t43;
t55 = t9.*t44;
t56 = t9.*t45;
t60 = t3.*t47;
t61 = t3.*t48;
t62 = t3.*t49;
t63 = t9.*t47;
t64 = -t54;
t65 = t9.*t48;
t66 = -t55;
t67 = t9.*t49;
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
t88 = -t10.*(t54-t60);
t89 = -t10.*(t55-t61);
t90 = -t10.*(t56-t62);
t103 = -t5.*(t20+t10.*(t54-t60));
t104 = -t5.*(t21+t10.*(t55-t61));
t105 = -t5.*(t22+t10.*(t56-t62));
t106 = -t11.*(t20+t10.*(t54-t60));
t107 = -t11.*(t21+t10.*(t55-t61));
t108 = -t11.*(t22+t10.*(t56-t62));
t109 = t5.*(t20+t10.*(t54-t60));
t110 = t5.*(t21+t10.*(t55-t61));
t111 = t5.*(t22+t10.*(t56-t62));
t79 = t5.*t73;
t80 = t5.*t74;
t81 = t5.*t75;
t82 = t11.*t73;
t83 = t11.*t74;
t84 = t11.*t75;
t91 = t29+t85;
t92 = t30+t86;
t93 = t31+t87;
t94 = t32+t88;
t95 = t33+t89;
t96 = t34+t90;
t97 = t6.*t91;
t98 = t6.*t92;
t99 = t6.*t93;
t100 = t12.*t91;
t101 = t12.*t92;
t102 = t12.*t93;
t112 = t79+t106;
t113 = t80+t107;
t114 = t81+t108;
t115 = t82+t109;
t116 = t83+t110;
t117 = t84+t111;
t118 = t6.*t112;
t119 = t6.*t113;
t120 = t6.*t114;
t121 = t12.*t112;
t122 = t12.*t113;
t123 = t12.*t114;
t124 = -t121;
t125 = -t122;
t126 = -t123;
t127 = t100+t118;
t128 = t101+t119;
t129 = t102+t120;
t130 = t97+t124;
t131 = t98+t125;
t132 = t99+t126;
R2cut = reshape([t7.*t127+t13.*t130,t7.*t128+t13.*t131,t7.*t129+t13.*t132,t7.*t130-t13.*t127,t7.*t131-t13.*t128,t7.*t132-t13.*t129,t115,t116,t117],[3,3]);
if nargout > 1
    p2cut = [p1cut1-R1cut1_3.*t57-t47.*t58-t43.*t70-t72.*t91-t59.*t112-t69.*t115-t71.*t130;p1cut2-R1cut2_3.*t57-t48.*t58-t44.*t70-t72.*t92-t59.*t113-t69.*t116-t71.*t131;p1cut3-R1cut3_3.*t57-t49.*t58-t45.*t70-t72.*t93-t59.*t114-t69.*t117-t71.*t132];
end
