/*
	Zadatak 2. 
	• Napiši program koji izvršava sljede?u jednadžbu
	?? = ( A ? B + C ? A ? (C ? A))*(B*A+C-B)
	Rezutat sprema na sljede?u adresu u memoriji
	adresa 64
	Za provjeru koristite sljede?e vrijednosti
	• A =3, B=5, C=-7.
	Varijable, me?urezultati i rezultati stanu u 8-bitni registar
 */ 

.equ varA = 3
.equ varB = 5
.equ varC = -7
.equ Y = 0x40	; 64(10) = 0x40(16)

ldi r16,varA
ldi r17,varB
ldi r18,varc

mul r16,r17
add r0,r18
mul r0,r16
mov r19,r0

clr r0
mulsu r18,r16
sub r19,r0

clr r0

mul r16,r17
mov r20,r0
sub r18,r17
add r20,r18
clr r0
mul r19,r20
sts Y,r0	; 87(16) = 135(10)
