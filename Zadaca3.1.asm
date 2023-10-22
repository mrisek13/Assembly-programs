/*
	Zadatak 1. 
	• Napiši program koji izvršava sljede?e jednadžbe
	??1 = varA + varB
	??2 = varA + varC
	??3 = varB + varC
	Rezutate sprema na sljede?e adrese u memoriji
	Y1=64, Y2=65, Y3=66
	Za provjeru koristite sljede?e vrijednosti
	• varA =125, varB=35, varC=-33
 */ 

.equ varA = 125
.equ varB = 35
.equ varC = -33
.equ Y1 = 0x40	; 64(10) = 0x40(16)
.equ Y2 = 0x41	; 65(10) = 0x41(16)
.equ Y3 = 0x42	; 66(10) = 0x42(16)

ldi r16,varA
ldi r17,varB
ldi r18,varC

add r16,r17	; varA + varB
sts Y1, r16	; upiši rezultat u Y1 = 64
ldi r16,varA
add r16,r18	; varA + varC
sts Y2, r16	; upiši rezultat u Y2 = 65
add r17,r18	; varB + varC
sts Y3, r17	; upiši rezultat u Y3 = 66