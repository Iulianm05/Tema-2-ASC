extern printf
section .data
	n1 dq -5.0
	n2 dq 1.0
	b dq 4.0
	form db "%s %lf",10, 0
	fmt db "x= ", 0
	imp dq 2.0
	zero dq 0.0
section .bss
	x0 resq 1
	s1 resq 1
	s2 resq 1
	s3 resq 1
	SOL resq 1
	SOL2 resq 1

section .text
	global main
main:
	push rbp
	mov rbp,rsp
	;x0=(n1+n2)/2
	movsd xmm0, [n1]
	addsd xmm0, [n2]
	divsd xmm0, [imp]
	movsd [x0], xmm0
	mov rbx, 3
	
	jloop:
		;calcul n1^3+ 4*n1^2+4*n1= f(n1)
		movsd xmm0, [n1]
		mulsd xmm0, [n1]
		mulsd xmm0, [n1]
		movsd [s1], xmm0
		movsd xmm0, [n1]
		mulsd xmm0,[n1]
		mulsd xmm0, [b]
		movsd [s2], xmm0
		movsd xmm0, [n1]
		mulsd xmm0, [b]
		movsd [s3], xmm0
		movsd xmm0, [s1]
		addsd xmm0, [s2]
		addsd xmm0, [s3]
		movsd [SOL], xmm0
		
		
		;calcul x0^3+ 4*x0^2+4*x0 = f(x0)
		movsd xmm0, [x0]
		mulsd xmm0, [x0]
		mulsd xmm0, [x0]
		movsd [s1], xmm0
		movsd xmm0, [x0]
		mulsd xmm0,[x0]
		mulsd xmm0, [b]
		movsd [s2], xmm0
		movsd xmm0, [x0]
		mulsd xmm0, [b]
		movsd [s3], xmm0
		movsd xmm0, [s1]
		addsd xmm0, [s2]
		addsd xmm0, [s3]
		movsd [SOL2], xmm0
		
		
		; calcul f(n1)*f(x0)
		movsd xmm0,[SOL]
		mulsd xmm0, [SOL2]
		
		;comparare f(n1)*f(x0) cu 0
		ucomisd xmm0, [zero]
		jae greater
		; n2=x0; x0=(n1+n2)/2
		movsd xmm0,[x0]
		movsd [n2],xmm0
		movsd xmm0, [n1]
		addsd xmm0, [n2]
		divsd xmm0, [imp]
		movsd [x0], xmm0
		; afisare valoare x0 intermediara
		mov rdi, form
		mov rsi, fmt
		mov rdx, [x0]
		mov rax,1
		call printf
		jmp loop_dec
		
		greater:
			;n1=x0; x0=(n1+n2)/2
			movsd xmm0, [x0]
			movsd [n1], xmm0
			movsd xmm0, [n1]
			addsd xmm0, [n2]
			divsd xmm0, [imp]
			movsd [x0], xmm0
			; afisare x0 intermediar
			mov rdi, form
			mov rsi, fmt
			mov rdx, [x0]
			mov rax,1
			call printf
			jmp loop_dec
			
			
		loop_dec:   ;decrementare rbx
			dec rbx
			jnz jloop
	;Afisare x0
	afisare:
	mov rdi, form
	mov rsi, fmt
	mov rdx, [x0]
	mov rax,1
	call printf
	jmp exit;
	
exit:		
mov rsp, rbp
pop rbp
ret
	
