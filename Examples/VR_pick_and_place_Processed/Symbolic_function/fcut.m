function [Rcut,pcut] = fcut(in1)
%FCUT
%    [RCUT,PCUT] = FCUT(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    01-Feb-2022 10:16:19

q1 = in1(1,:);
q2 = in1(2,:);
q3 = in1(3,:);
q4 = in1(4,:);
q5 = in1(5,:);
q6 = in1(6,:);
q7 = in1(7,:);
q8 = in1(8,:);
q9 = in1(9,:);
q10 = in1(10,:);
q17 = in1(17,:);
q18 = in1(18,:);
q25 = in1(24,:);
q26 = in1(25,:);
q27 = in1(26,:);
q28 = in1(27,:);
q29 = in1(28,:);
t2 = cos(q1);
t3 = cos(q2);
t4 = cos(q3);
t5 = cos(q4);
t6 = cos(q5);
t7 = cos(q6);
t8 = cos(q7);
t9 = cos(q8);
t10 = cos(q9);
t11 = cos(q10);
t12 = cos(q17);
t13 = cos(q18);
t14 = cos(q28);
t15 = cos(q29);
t16 = sin(q1);
t17 = sin(q2);
t18 = sin(q3);
t19 = sin(q4);
t20 = sin(q5);
t21 = sin(q6);
t22 = sin(q7);
t23 = sin(q8);
t24 = sin(q9);
t25 = sin(q10);
t26 = sin(q17);
t27 = sin(q18);
t28 = sin(q28);
t29 = sin(q29);
t30 = t2.*t14;
t31 = t2.*t28;
t32 = t14.*t16;
t33 = t4.*t29;
t34 = t16.*t28;
t35 = t18.*t29;
t37 = t2.*t3.*t15;
t38 = t4.*t14.*t15;
t39 = t2.*t15.*t17;
t40 = t3.*t15.*t16;
t42 = t4.*t15.*t28;
t43 = t14.*t15.*t18;
t44 = t15.*t16.*t17;
t47 = t15.*t18.*t28;
t94 = t15.*t16.*4.542669902201527e-2;
t97 = t2.*t15.*5.047411002446134e-3;
t36 = t29.*t34;
t41 = t29.*t30;
t45 = t29.*t31;
t46 = t29.*t32;
t49 = -t38;
t51 = -t44;
t52 = -t47;
t55 = t39+t40;
t89 = t35.*1.359172446111289e-1;
t92 = t30.*4.542669902201527e-2;
t93 = t31.*4.542669902201527e-2;
t98 = t32.*5.047411002446134e-3;
t99 = -t94;
t100 = t34.*5.047411002446134e-3;
t101 = t43.*1.359172446111289e-1;
t102 = t47.*1.359172446111289e-1;
t48 = -t36;
t50 = -t41;
t53 = t31+t46;
t54 = t32+t45;
t62 = t37+t51;
t63 = t4.*t55;
t64 = t18.*t55;
t103 = t46.*4.542669902201527e-2;
t104 = t36.*4.542669902201527e-2;
t105 = -t102;
t106 = t45.*5.047411002446134e-3;
t108 = t41.*5.047411002446134e-3;
t56 = t30+t48;
t57 = t34+t50;
t58 = t3.*t53;
t59 = t3.*t54;
t60 = t17.*t53;
t61 = t17.*t54;
t70 = -t63;
t71 = t5.*t62;
t72 = t19.*t62;
t75 = t33+t64;
t107 = -t104;
t109 = -t108;
t122 = t63.*1.359172446111289e-1;
t65 = t3.*t56;
t66 = t3.*t57;
t67 = t17.*t56;
t68 = t17.*t57;
t69 = -t61;
t74 = -t71;
t76 = t35+t70;
t77 = t5.*t75;
t78 = t19.*t75;
t132 = -t122;
t133 = t71.*1.795133419392268e-2;
t73 = -t68;
t79 = t6.*t76;
t80 = t20.*t76;
t81 = t59+t67;
t82 = t60+t66;
t84 = t65+t69;
t91 = -t18.*(t61-t65);
t96 = -t4.*(t61-t65);
t110 = t72+t77;
t113 = t74+t78;
t123 = -t6.*(t71-t78);
t125 = -t20.*(t71-t78);
t130 = -t6.*(t47+t4.*(t61-t65));
t131 = -t20.*(t47+t4.*(t61-t65));
t134 = t6.*(t71-t78);
t136 = t6.*(t47+t4.*(t61-t65));
t137 = -t133;
t138 = t78.*1.795133419392268e-2;
t142 = t4.*(t61-t65).*(-1.359172446111289e-1);
t83 = t58+t73;
t85 = t19.*t81;
t86 = t19.*t82;
t87 = t5.*t81;
t88 = t5.*t82;
t112 = t42+t91;
t115 = t52+t96;
t116 = t7.*t110;
t117 = t21.*t110;
t145 = t79+t125;
t146 = t80+t134;
t90 = t18.*t83;
t95 = t4.*t83;
t119 = t5.*t112;
t121 = t19.*t112;
t124 = -t116;
t139 = t87.*1.795133419392268e-2;
t140 = t88.*1.795133419392268e-2;
t147 = t7.*t145;
t148 = t21.*t145;
t151 = t8.*t146;
t152 = t22.*t146;
t111 = t43+t95;
t114 = t49+t90;
t126 = -t5.*(t38-t90);
t128 = -t19.*(t38-t90);
t129 = -t119;
t135 = t5.*(t38-t90);
t141 = t95.*1.359172446111289e-1;
t143 = -t139;
t144 = -t140;
t149 = t121.*1.795133419392268e-2;
t153 = t19.*(t38-t90).*(-1.795133419392268e-2);
t154 = t19.*(t38-t90).*1.795133419392268e-2;
t155 = t87+t121;
t167 = t117+t147;
t168 = t124+t148;
t171 = -t8.*(t116-t148);
t173 = -t22.*(t116-t148);
t174 = t8.*(t116-t148);
t118 = t6.*t111;
t120 = t20.*t111;
t150 = -t149;
t156 = t88+t128;
t157 = t85+t129;
t158 = t6.*t155;
t159 = t20.*t155;
t160 = t86+t135;
t169 = t9.*t167;
t170 = t23.*t167;
t190 = t151+t173;
t191 = t152+t174;
t127 = -t118;
t161 = t6.*t156;
t162 = t20.*t156;
t163 = t7.*t157;
t164 = t21.*t157;
t165 = t7.*t160;
t166 = t21.*t160;
t172 = -t169;
t175 = t131+t158;
t177 = t136+t159;
t192 = t9.*t190;
t193 = t23.*t190;
t194 = t10.*t191;
t195 = t24.*t191;
t176 = t120+t161;
t178 = t127+t162;
t181 = t8.*t175;
t182 = t22.*t175;
t183 = -t7.*(t118-t162);
t184 = -t21.*(t118-t162);
t185 = t7.*t177;
t187 = t21.*t177;
t188 = t7.*(t118-t162);
t196 = -t195;
t211 = t170+t192;
t212 = t172+t193;
t215 = -t10.*(t169-t193);
t216 = -t24.*(t169-t193);
t179 = t8.*t176;
t180 = t22.*t176;
t186 = -t181;
t189 = -t185;
t197 = t163+t187;
t198 = t165+t184;
t202 = t166+t188;
t213 = t11.*t211;
t214 = t25.*t211;
t232 = t194+t216;
t233 = t196+t215;
t199 = t164+t189;
t200 = t8.*t197;
t201 = t22.*t197;
t205 = t8.*t198;
t206 = t22.*t198;
t207 = t9.*t202;
t209 = t23.*t202;
t234 = t11.*t232;
t235 = t25.*t232;
t203 = t9.*t199;
t204 = t23.*t199;
t208 = -t206;
t210 = -t207;
t217 = t182+t200;
t218 = t180+t205;
t219 = t186+t201;
t225 = -t9.*(t181-t201);
t227 = -t23.*(t181-t201);
t231 = t9.*(t181-t201);
t236 = -t235;
t250 = t214+t234;
t220 = t10.*t217;
t221 = t24.*t217;
t222 = t179+t208;
t223 = t10.*t218;
t224 = t24.*t218;
t237 = t203+t227;
t238 = t204+t231;
t251 = t213+t236;
t252 = t12.*t250;
t226 = -t220;
t228 = t9.*t222;
t229 = t23.*t222;
t230 = -t224;
t239 = t10.*t237;
t240 = t24.*t237;
t242 = t11.*t238;
t243 = t25.*t238;
t253 = t26.*t251;
t241 = t209+t228;
t244 = t210+t229;
t247 = -t243;
t248 = -t10.*(t207-t229);
t249 = -t24.*(t207-t229);
t254 = t221+t239;
t255 = t226+t240;
t256 = -t11.*(t220-t240);
t257 = -t25.*(t220-t240);
t266 = -t12.*(t243+t11.*(t220-t240));
t272 = t252+t253;
t245 = t11.*t241;
t246 = t25.*t241;
t258 = t223+t249;
t259 = t230+t248;
t263 = t242+t257;
t264 = t247+t256;
t260 = t11.*t258;
t261 = t25.*t258;
t265 = t26.*t263;
t262 = -t261;
t267 = -t265;
t268 = t246+t260;
t269 = t245+t262;
t270 = t12.*t268;
t273 = t266+t267;
t271 = t26.*t269;
t274 = t270+t271;
Rcut = reshape([t15,t28.*t29,-t14.*t29,0.0,t14,t28,t29,-t15.*t28,t14.*t15,t146,t175,t176,t167,t199,t202,t116-t148,t197,t198,t12.*t251-t26.*t250,-t26.*(t243+t11.*(t220-t240))+t12.*t263,t12.*t269-t26.*t268,t13.*(t195+t10.*(t169-t193))+t27.*t272,t13.*t254+t27.*(t265+t12.*(t243+t11.*(t220-t240))),t13.*(t224+t10.*(t207-t229))+t27.*t274,-t27.*(t195+t10.*(t169-t193))+t13.*t272,-t27.*t254+t13.*(t265+t12.*(t243+t11.*(t220-t240))),-t27.*(t224+t10.*(t207-t229))+t13.*t274],[3,3,3]);
if nargout > 1
    et1 = q25+t89+t97+t99+t117.*2.735665544252918e-1+t132+t137+t138+t147.*2.735665544252918e-1+t151.*3.908093634647025e-2+t152.*2.074295852235728e-2+t174.*2.074295852235728e-2;
    et2 = t195.*(-1.412926160209451e-2)-t213.*4.188674716081925e-2+t214.*1.725573650979204e-1+t234.*1.725573650979204e-1+t235.*4.188674716081925e-2;
    et3 = t22.*(t116-t148).*(-3.908093634647025e-2)-t10.*(t169-t193).*1.412926160209451e-2;
    et4 = q26+t92+t98+t105+t106+t107+t142+t143+t150+t164.*2.735665544252918e-1+t181.*3.908093634647025e-2+t182.*2.074295852235728e-2-t185.*2.735665544252918e-1+t200.*2.074295852235728e-2;
    et5 = t201.*(-3.908093634647025e-2)-t221.*1.412926160209451e-2-t239.*1.412926160209451e-2-t242.*4.188674716081925e-2+t243.*1.725573650979204e-1;
    et6 = t11.*(t220-t240).*1.725573650979204e-1+t25.*(t220-t240).*4.188674716081925e-2;
    et7 = q27+t93+t100+t101+t103+t109+t141+t144+t154+t166.*2.735665544252918e-1+t179.*3.908093634647025e-2+t180.*2.074295852235728e-2+t188.*2.735665544252918e-1+t205.*2.074295852235728e-2;
    et8 = t206.*(-3.908093634647025e-2)-t224.*1.412926160209451e-2-t245.*4.188674716081925e-2+t246.*1.725573650979204e-1+t260.*1.725573650979204e-1;
    et9 = t261.*4.188674716081925e-2-t10.*(t207-t229).*1.412926160209451e-2;
    pcut = reshape([q25,q26,q27,q25+t89+t97+t99+t132+t137+t138,q26+t92+t98+t105+t106+t107+t142+t143+t150,q27+t93+t100+t101+t103+t109+t141+t144+t154,et1+et2+et3,et4+et5+et6,et7+et8+et9],[3,1,3]);
end