.data
.align 3
.align 0
.globl ___stginit_Main
___stginit_Main:
.const
.align 3
.align 0
_c2Go_str:
	.byte	109
	.byte	97
	.byte	105
	.byte	110
	.byte	0
.data
.align 3
.align 0
_r2EH_closure:
	.quad	_ghczmprim_GHCziTypes_TrNameS_static_info
	.quad	_c2Go_str
.const
.align 3
.align 0
_c2Gs_str:
	.byte	77
	.byte	97
	.byte	105
	.byte	110
	.byte	0
.data
.align 3
.align 0
_r2Fb_closure:
	.quad	_ghczmprim_GHCziTypes_TrNameS_static_info
	.quad	_c2Gs_str
.data
.align 3
.align 0
.globl _Main_zdtrModule_closure
_Main_zdtrModule_closure:
	.quad	_ghczmprim_GHCziTypes_Module_static_info
	.quad	_r2EH_closure+1
	.quad	_r2Fb_closure+1
	.quad	3
.data
.align 3
.align 0
_rNg_closure:
	.quad	_rNg_info
	.quad	0
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Fy_info)+0
	.quad	2
	.quad	4294967315
_s2Fy_info:
Lc2H4:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2H5
Lc2H6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _base_GHCziFloat_zdfNumFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziNum_zm_info
Lc2H5:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FA_info)+0
	.quad	2
	.quad	12884901907
_s2FA_info:
Lc2H7:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2H8
Lc2H9:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Hb
Lc2Ha:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_Fzh_con_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movss Ln2Iy(%rip),%xmm0
	movss %xmm0,-32(%r12)
	leaq -39(%r12),%rcx
	leaq _s2Fy_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	leaq _base_GHCziFloat_zdfFractionalFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rcx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziReal_zs_info
Lc2Hb:
	movq $48,904(%r13)
Lc2H8:
	jmp *-16(%r13)
.const
.align 3
.align 2
Ln2Iy:
	.byte	0
	.byte	0
	.byte	0
	.byte	64
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Fv_info)+0
	.quad	2
	.quad	4294967315
_s2Fv_info:
Lc2Hl:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Hm
Lc2Hn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _base_GHCziFloat_zdfNumFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziNum_zp_info
Lc2Hm:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Fx_info)+0
	.quad	2
	.quad	12884901907
_s2Fx_info:
Lc2Ho:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Hp
Lc2Hq:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Hs
Lc2Hr:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_Fzh_con_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movss Ln2IM(%rip),%xmm0
	movss %xmm0,-32(%r12)
	leaq -39(%r12),%rcx
	leaq _s2Fv_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	leaq _base_GHCziFloat_zdfFractionalFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rcx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziReal_zs_info
Lc2Hs:
	movq $48,904(%r13)
Lc2Hp:
	jmp *-16(%r13)
.const
.align 3
.align 2
Ln2IM:
	.byte	0
	.byte	0
	.byte	0
	.byte	64
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FB_info)+0
	.quad	4
	.quad	12884901904
_s2FB_info:
Lc2Ht:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Hu
Lc2Hv:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc2Hx
Lc2Hw:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rdx
	movq 40(%rbx),%rbx
	leaq _s2FA_info(%rip),%rsi
	movq %rsi,-56(%r12)
	movq %rax,-40(%r12)
	movq %rdx,-32(%r12)
	leaq -56(%r12),%rax
	leaq _s2Fx_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rcx,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rbx
	leaq _base_GHCziFloat_zdfNumFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziNum_zp_info
Lc2Hx:
	movq $64,904(%r13)
Lc2Hu:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Fr_info)+0
	.quad	2
	.quad	4294967315
_s2Fr_info:
Lc2HL:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2HM
Lc2HN:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _base_GHCziFloat_zdfNumFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziNum_zm_info
Lc2HM:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Ft_info)+0
	.quad	2
	.quad	12884901907
_s2Ft_info:
Lc2HO:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2HP
Lc2HQ:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2HS
Lc2HR:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_Fzh_con_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movss Ln2J7(%rip),%xmm0
	movss %xmm0,-32(%r12)
	leaq -39(%r12),%rcx
	leaq _s2Fr_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	leaq _base_GHCziFloat_zdfFractionalFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rcx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziReal_zs_info
Lc2HS:
	movq $48,904(%r13)
Lc2HP:
	jmp *-16(%r13)
.const
.align 3
.align 2
Ln2J7:
	.byte	0
	.byte	0
	.byte	0
	.byte	64
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Fo_info)+0
	.quad	2
	.quad	4294967315
_s2Fo_info:
Lc2I2:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2I3
Lc2I4:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _base_GHCziFloat_zdfNumFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziNum_zp_info
Lc2I3:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Fq_info)+0
	.quad	2
	.quad	12884901907
_s2Fq_info:
Lc2I5:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2I6
Lc2I7:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2I9
Lc2I8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_Fzh_con_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movss Ln2Jl(%rip),%xmm0
	movss %xmm0,-32(%r12)
	leaq -39(%r12),%rcx
	leaq _s2Fo_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	leaq _base_GHCziFloat_zdfFractionalFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rcx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziReal_zs_info
Lc2I9:
	movq $48,904(%r13)
Lc2I6:
	jmp *-16(%r13)
.const
.align 3
.align 2
Ln2Jl:
	.byte	0
	.byte	0
	.byte	0
	.byte	64
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Fu_info)+0
	.quad	4
	.quad	12884901904
_s2Fu_info:
Lc2Ia:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ib
Lc2Ic:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ie
Lc2Id:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rdx
	movq 40(%rbx),%rbx
	leaq _s2Ft_info(%rip),%rsi
	movq %rsi,-56(%r12)
	movq %rcx,-40(%r12)
	movq %rbx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s2Fq_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rdx,(%r12)
	leaq -24(%r12),%rax
	leaq _base_GHCziFloat_zdfNumFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziNum_zp_info
Lc2Ie:
	movq $64,904(%r13)
Lc2Ib:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_rNg_info)+0
	.quad	8589934607
	.quad	0
	.quad	30064771087
_rNg_info:
Lc2If:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ih
Lc2Ii:
	leaq _c2GH_info(%rip),%rax
	movq %rax,-16(%rbp)
	movq %r14,%rbx
	movq %rsi,-8(%rbp)
	addq $-16,%rbp
	testb $7,%bl
	jne Lc2GH
Lc2GI:
	jmp *(%rbx)
.align 3
	.quad	_S2In_srt-(_c2GH_info)+0
	.quad	1
	.quad	12884901920
_c2GH_info:
Lc2GH:
	movq 8(%rbp),%rax
	movq 7(%rbx),%rcx
	movq 15(%rbx),%rbx
	leaq _c2GM_info(%rip),%rdx
	movq %rdx,-8(%rbp)
	movq %rbx,%rdx
	movq %rax,%rbx
	movq %rdx,(%rbp)
	movq %rcx,8(%rbp)
	addq $-8,%rbp
	testb $7,%bl
	jne Lc2GM
Lc2GN:
	jmp *(%rbx)
.align 3
	.quad	_S2In_srt-(_c2GM_info)+0
	.quad	2
	.quad	12884901920
_c2GM_info:
Lc2GM:
	movq 16(%rbp),%rax
	movq 8(%rbp),%rcx
	addq $120,%r12
	cmpq 856(%r13),%r12
	ja Lc2Im
Lc2Il:
	movq 7(%rbx),%rdx
	movq 15(%rbx),%rbx
	leaq _s2FB_info(%rip),%rsi
	movq %rsi,-112(%r12)
	movq %rax,-96(%r12)
	movq %rcx,-88(%r12)
	movq %rdx,-80(%r12)
	movq %rbx,-72(%r12)
	leaq -112(%r12),%rsi
	leaq _s2Fu_info(%rip),%rdi
	movq %rdi,-64(%r12)
	movq %rax,-48(%r12)
	movq %rcx,-40(%r12)
	movq %rdx,-32(%r12)
	movq %rbx,-24(%r12)
	leaq -64(%r12),%rax
	leaq _ghczmprim_GHCziTuple_Z2T_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,-8(%r12)
	movq %rsi,(%r12)
	leaq -15(%r12),%rax
	movq %rax,%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2Ih:
	leaq _rNg_closure(%rip),%rbx
	jmp *-8(%r13)
Lc2Im:
	movq $120,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
.data
.align 3
.align 0
_rNh_closure:
	.quad	_rNh_info
	.quad	0
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FM_info)+24
	.quad	1
	.quad	4294967313
_s2FM_info:
Lc2Ko:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Kp
Lc2Kq:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ks
Lc2Kr:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Ks:
	movq $24,904(%r13)
Lc2Kp:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FN_info)+24
	.quad	1
	.quad	12884901905
_s2FN_info:
Lc2Kt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ku
Lc2Kv:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Kx
Lc2Kw:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2FM_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	addq $-16,%rbp
	jmp _rNh_info
Lc2Kx:
	movq $24,904(%r13)
Lc2Ku:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FK_info)+16
	.quad	2
	.quad	4294967315
_s2FK_info:
Lc2KC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2KD
Lc2KE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	addq $-16,%rbp
	jmp _rNg_info
Lc2KD:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FU_info)+24
	.quad	2
	.quad	4294967315
_s2FU_info:
Lc2KQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2KR
Lc2KS:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2KU
Lc2KT:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2KU:
	movq $24,904(%r13)
Lc2KR:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FV_info)+24
	.quad	2
	.quad	12884901907
_s2FV_info:
Lc2KV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2KW
Lc2KX:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2KZ
Lc2KY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2FU_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	addq $-16,%rbp
	jmp _rNh_info
Lc2KZ:
	movq $32,904(%r13)
Lc2KW:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FS_info)+16
	.quad	2
	.quad	4294967315
_s2FS_info:
Lc2L4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2L5
Lc2L6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	addq $-16,%rbp
	jmp _rNg_info
Lc2L5:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FR_info)+16
	.quad	2
	.quad	4294967315
_s2FR_info:
Lc2Ld:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Le
Lc2Lf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	addq $-16,%rbp
	jmp _rNg_info
Lc2Le:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_rNh_info)+16
	.quad	4294967301
	.quad	0
	.quad	30064771087
_rNh_info:
Lc2Lk:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ll
Lc2Lm:
	leaq _c2JY_info(%rip),%rax
	movq %rax,-8(%rbp)
	movq %r14,%rbx
	addq $-8,%rbp
	testb $7,%bl
	jne Lc2JY
Lc2JZ:
	jmp *(%rbx)
.align 3
	.quad	_S2In_srt-(_c2JY_info)+16
	.quad	0
	.quad	30064771104
_c2JY_info:
Lc2JY:
	movq %rbx,%rax
	andl $7,%eax
	cmpq $1,%rax
	jne Lc2Li
Lc2Lh:
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2Li:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _c2K4_info(%rip),%rcx
	movq %rcx,-8(%rbp)
	movq %rax,(%rbp)
	addq $-8,%rbp
	testb $7,%bl
	jne Lc2K4
Lc2K5:
	jmp *(%rbx)
.align 3
	.quad	_S2In_srt-(_c2K4_info)+16
	.quad	1
	.quad	30064771104
_c2K4_info:
Lc2K4:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andl $7,%ecx
	cmpq $1,%rcx
	jne Lc2Ly
Lc2Lt:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Lw
Lc2Lv:
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2Ly:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _c2Ka_info(%rip),%rcx
	movq %rcx,-8(%rbp)
	movq %rax,(%rbp)
	addq $-8,%rbp
	testb $7,%bl
	jne Lc2Ka
Lc2Kb:
	jmp *(%rbx)
.align 3
	.quad	_S2In_srt-(_c2Ka_info)+16
	.quad	2
	.quad	30064771104
_c2Ka_info:
Lc2Ka:
	movq 16(%rbp),%rax
	movq 8(%rbp),%rcx
	movq %rbx,%rdx
	andl $7,%edx
	cmpq $1,%rdx
	jne Lc2LI
Lc2LC:
	addq $104,%r12
	cmpq 856(%r13),%r12
	ja Lc2LF
Lc2LE:
	leaq _s2FN_info(%rip),%rbx
	movq %rbx,-96(%r12)
	movq %rcx,-80(%r12)
	leaq -96(%r12),%rbx
	leaq _s2FK_info(%rip),%rdx
	movq %rdx,-72(%r12)
	movq %rax,-56(%r12)
	movq %rcx,-48(%r12)
	leaq -72(%r12),%rcx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-40(%r12)
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	leaq -38(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2Ll:
	leaq _rNh_closure(%rip),%rbx
	jmp *-8(%r13)
Lc2Lw:
	movq $24,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2LF:
	movq $104,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2LI:
	addq $192,%r12
	cmpq 856(%r13),%r12
	ja Lc2LL
Lc2LK:
	movq 6(%rbx),%rdx
	movq 14(%rbx),%rbx
	leaq _s2FV_info(%rip),%rsi
	movq %rsi,-184(%r12)
	movq %rdx,-168(%r12)
	movq %rbx,-160(%r12)
	leaq -184(%r12),%rbx
	leaq _s2FS_info(%rip),%rsi
	movq %rsi,-152(%r12)
	movq %rcx,-136(%r12)
	movq %rdx,-128(%r12)
	leaq -152(%r12),%rdx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rsi
	movq %rsi,-120(%r12)
	movq %rdx,-112(%r12)
	movq %rbx,-104(%r12)
	leaq -118(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-96(%r12)
	movq %rcx,-88(%r12)
	movq %rbx,-80(%r12)
	leaq -94(%r12),%rbx
	leaq _s2FR_info(%rip),%rdx
	movq %rdx,-72(%r12)
	movq %rax,-56(%r12)
	movq %rcx,-48(%r12)
	leaq -72(%r12),%rcx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-40(%r12)
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	leaq -38(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2LL:
	movq $192,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
.data
.align 3
.align 0
_s2G7_closure:
	.quad	_ghczmprim_GHCziTypes_Fzh_static_info
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.long	0
.data
.align 3
.align 0
_s2G8_closure:
	.quad	_ghczmprim_GHCziTypes_Fzh_static_info
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.long	0
.data
.align 3
.align 0
_s2G9_closure:
	.quad	_ghczmprim_GHCziTuple_Z2T_static_info
	.quad	_s2G7_closure+1
	.quad	_s2G8_closure+1
	.quad	0
.data
.align 3
.align 0
_s2Ga_closure:
	.quad	_ghczmprim_GHCziTypes_Fzh_static_info
	.byte	0
	.byte	0
	.byte	250
	.byte	67
	.long	0
.data
.align 3
.align 0
_s2Gb_closure:
	.quad	_ghczmprim_GHCziTypes_Fzh_static_info
	.byte	0
	.byte	0
	.byte	225
	.byte	67
	.long	0
.data
.align 3
.align 0
_s2Gc_closure:
	.quad	_ghczmprim_GHCziTuple_Z2T_static_info
	.quad	_s2Ga_closure+1
	.quad	_s2Gb_closure+1
	.quad	0
.data
.align 3
.align 0
_s2Gm_closure:
	.quad	_s2Gm_info
	.quad	0
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Gi_info)+40
	.quad	1
	.quad	12884901905
_s2Gi_info:
Lc2Nd:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ne
Lc2Nf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _base_GHCziFloat_zdfRealFracFloat_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _base_GHCziReal_zdfIntegralInt_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziReal_round_info
Lc2Ne:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Gk_info)+40
	.quad	1
	.quad	12884901905
_s2Gk_info:
Lc2Ng:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Nh
Lc2Ni:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2Nk
Lc2Nj:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _ghczmprim_GHCziTypes_Izh_con_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq $20,-24(%r12)
	leaq -31(%r12),%rbx
	leaq _s2Gi_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	leaq _base_GHCziReal_zdfIntegralInt_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziReal_mod_info
Lc2Nk:
	movq $40,904(%r13)
Lc2Nh:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Gg_info)+24
	.quad	0
	.quad	210453397520
_s2Gg_info:
Lc2Nv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Nw
Lc2Nx:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Nz
Lc2Ny:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-40(%r12)
	leaq _s2Gc_closure+1(%rip),%rax
	movq %rax,-32(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-24(%r12)
	leaq -38(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	leaq _s2G9_closure+1(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	movq %rbx,(%r12)
	leaq -14(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Nz:
	movq $48,904(%r13)
Lc2Nw:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Gh_info)+24
	.quad	0
	.quad	493921239056
_s2Gh_info:
Lc2NA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NB
Lc2NC:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2NE
Lc2ND:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Gg_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _rNh_closure+1(%rip),%r14
	leaq _base_GHCziList_iterate_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2NE:
	movq $16,904(%r13)
Lc2NB:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Gl_info)+24
	.quad	1
	.quad	1095216660497
_s2Gl_info:
Lc2NF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NG
Lc2NH:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2NJ
Lc2NI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2Gk_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2Gh_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_znzn_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2NJ:
	movq $40,904(%r13)
Lc2NG:
	jmp *-16(%r13)
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2Gm_info)+24
	.quad	4294967301
	.quad	0
	.quad	2194728288271
_s2Gm_info:
Lc2NL:
Lc2NN:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2NP
Lc2NO:
	leaq _s2Gl_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _glosszmrenderingzm1zi10zi3zi5zm6GXKOQNNkikIktmr9VqIPX_GraphicsziGlossziInternalsziDataziPicture_Line_con_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -7(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2NP:
	movq $40,904(%r13)
Lc2NM:
	leaq _s2Gm_closure(%rip),%rbx
	jmp *-8(%r13)
.data
.align 3
.align 0
_s2G4_closure:
	.quad	_ghczmprim_GHCziTypes_Izh_static_info
	.quad	0
.data
.align 3
.align 0
_s2G3_closure:
	.quad	_ghczmprim_GHCziTypes_Izh_static_info
	.quad	0
.data
.align 3
.align 0
_s2G5_closure:
	.quad	_ghczmprim_GHCziTuple_Z2T_static_info
	.quad	_s2G3_closure+1
	.quad	_s2G4_closure+1
	.quad	0
.data
.align 3
.align 0
_s2G1_closure:
	.quad	_ghczmprim_GHCziTypes_Izh_static_info
	.quad	500
.data
.align 3
.align 0
_s2G0_closure:
	.quad	_ghczmprim_GHCziTypes_Izh_static_info
	.quad	500
.data
.align 3
.align 0
_s2G2_closure:
	.quad	_ghczmprim_GHCziTuple_Z2T_static_info
	.quad	_s2G0_closure+1
	.quad	_s2G1_closure+1
	.quad	0
.data
.align 3
.align 0
_s2FZ_closure:
	.quad	_s2FZ_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2OM_str:
	.byte	68
	.byte	114
	.byte	97
	.byte	103
	.byte	111
	.byte	110
	.byte	0
.text
.align 3
.align 3
	.quad	_S2In_srt-(_s2FZ_info)+96
	.quad	0
	.quad	4294967318
_s2FZ_info:
Lc2ON:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OO
Lc2OP:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	xorl %eax,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2OL
Lc2OK:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2OM_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2OL:
	jmp *(%rbx)
Lc2OO:
	jmp *-16(%r13)
.data
.align 3
.align 0
_s2G6_closure:
	.quad	_glosszm1zi10zi2zi5zm8EffqMeSoypCgBTkhVfaVN_GraphicsziGlossziDataziDisplay_InWindow_static_info
	.quad	_s2FZ_closure
	.quad	_s2G2_closure+1
	.quad	_s2G5_closure+1
	.quad	0
.data
.align 3
.align 0
.globl _Main_main_closure
_Main_main_closure:
	.quad	_Main_main_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
.align 3
	.quad	_S2In_srt-(_Main_main_info)+88
	.quad	0
	.quad	124554051606
.globl _Main_main_info
_Main_main_info:
Lc2P5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2P6
Lc2P7:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	xorl %eax,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2P4
Lc2P3:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Gm_closure+1(%rip),%rdi
	leaq _glosszm1zi10zi2zi5zm8EffqMeSoypCgBTkhVfaVN_GraphicsziGlossziDataziColor_white_closure(%rip),%rsi
	leaq _s2G6_closure+1(%rip),%r14
	leaq _glosszm1zi10zi2zi5zm8EffqMeSoypCgBTkhVfaVN_GraphicsziGlossziInterfaceziPureziAnimate_animate_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_ppp_fast
Lc2P4:
	jmp *(%rbx)
Lc2P6:
	jmp *-16(%r13)
.data
.align 3
.align 0
.globl _ZCMain_main_closure
_ZCMain_main_closure:
	.quad	_ZCMain_main_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
.align 3
	.quad	_S2In_srt-(_ZCMain_main_info)+128
	.quad	0
	.quad	12884901910
.globl _ZCMain_main_info
_ZCMain_main_info:
Lc2Pk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pl
Lc2Pm:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	xorl %eax,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Pj
Lc2Pi:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _Main_main_closure(%rip),%r14
	leaq _base_GHCziTopHandler_runMainIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Pj:
	jmp *(%rbx)
Lc2Pl:
	jmp *-16(%r13)
.const_data
.align 3
.align 0
_S2In_srt:
	.quad	_base_GHCziFloat_zdfNumFloat_closure
	.quad	_base_GHCziFloat_zdfFractionalFloat_closure
	.quad	_rNg_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_rNh_closure
	.quad	_base_GHCziReal_zdfIntegralInt_closure
	.quad	_base_GHCziFloat_zdfRealFracFloat_closure
	.quad	_s2G9_closure
	.quad	_s2Gc_closure
	.quad	_base_GHCziList_iterate_closure
	.quad	_base_GHCziList_znzn_closure
	.quad	_s2Gm_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_glosszm1zi10zi2zi5zm8EffqMeSoypCgBTkhVfaVN_GraphicsziGlossziInterfaceziPureziAnimate_animate_closure
	.quad	_glosszm1zi10zi2zi5zm8EffqMeSoypCgBTkhVfaVN_GraphicsziGlossziDataziColor_white_closure
	.quad	_s2G6_closure
	.quad	_base_GHCziTopHandler_runMainIO_closure
	.quad	_Main_main_closure

