/*
Napiši program koji izvršava sljedecu jednadžbu Y = (A * B + B) * C
Rezutat sprema u memoriji pocevši s adresom 0x102.
Varijable A i B imaju 8 bitnu vrijednost dok varijabla C može imati 16 bitnu vrijednost. 
Za potrebe simulacije odaberi vlastite vrijednosti A, B i C varijabli.
Navedi te vrijednosti te rezultat u komentaru u ASM datoteci.
 */ 

ldi R16, 0x02	; Postavi vrijednost 2 u varijablu A
ldi R17, 0x03	; Postavi vrijednost 3 u varijablu B
ldi R18, 0x05	; Postavi vrijednost 5 u varijablu C

mul R16, R17	; Pomnoži A * B
add R0, R17		; Pribroji B rješenju A * B
mul R0, R18		; Pomnoži (A * B + B) sa varijablom C
sts 0x102, R0	; Rješenje Y = (A * B + B) * C
sts 0x103, R1	; Rješenje Y = (6 + 3) * 5

; Y = 45

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MEV primjer

.equ varA = 3
.equ varB = 5
.equ varC =-7

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

rjmp start



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Binary hardware multiplication in AVR Assembler
http://www.avr-asm-tutorial.net/avr_en/calc/HARDMULT.html#mult16by8

Introduction to binary numbers and binary math
http://www.avr-asm-tutorial.net/avr_en/binary/binary.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.equ Number = 4294000000	; Number 4 294 000 000(2) => 11111111 11110001 00111101 10000000(2) => 255 241 61 128(10)
	ldi R16,Byte1(Number)	; Byte1: the lowest 8 bits into R16 register: 10000000(2) => 128(10)
	ldi R17,Byte2(Number)	; Byte2: Bits 9 to 16 into R17 register: 00111101(2) => 61(16)
	ldi R18,Byte3(Number)	; Byte3: Bits 17 to 24 into R18 register: 11110001(2) => 241(10)
	ldi R19,Byte4(Number)	; Byte4: Bits 25 to 32 into R19 register: 11111111(2) => 255(10)

.equ Number2 = 255			; Number 255(2) => 11111111(2) => 255(10)
	ldi R20,Byte1(Number2)	; Byte1: The lowest and only 8 bits into R20 register: 11111111(2) => 255(10)

.equ Number3 = 256			; Number 256(2) => 00000001 00000000(2) => 1 0(10)
	ldi R21,Byte1(Number3)	; Byte1: The lowest 8 bits into R21 register: 00000000(2) => 0(10)
	ldi R22,Byte2(Number3)	; Byte2: Bits 9 to 16 into R22 register: 00000001(2) => 1(10)

.equ Number4 = 10000000		; Number 10 000 000(2) => 10011000 10010110 10000000(2) => 128 1 0(10)
	ldi R23,Byte1(Number4)	; Byte1: The lowest 8 bits into R23 register: 10000000(2) => 128(10)
	ldi R24,Byte2(Number4)	; Byte2: Bits 9 to 16 into R24 register: 10010110(2) => 150(10)
	ldi R25,Byte3(Number4)	; Byte3: Bits 17 to 24 into R25 register: 10011000(2) => 152(10)

.equ Number5 = -2			; Number -2(2) => 10011000 10010110 10000000(2) => 128 1 0(10)
	ldi R26,Byte1(Number5)	; Byte1: The lowest 8 bits into R26 register: 10000000(2) => 128(10)
	ldi R27,Byte2(Number5)	; Byte2: Bits 9 to 16 into R27 register: 10010110(2) => 150(10)
	
	
;;;;; MULTIPLICATION OF 16-bit AND 8-bit HEXADECIMAL NUMBERS ;;;;;;;

	; Numbers in R1:R0 and R3
	ldi R16,0x26 ; 0x2614(16) = 9748(10) to R1:R0
	mov R1,R16
	ldi R16,0x14
	mov R0,R16
	clr R2 ; R2 is needed to shift the number left, zero at start
	ldi R16,0x8F ; 0x8F(16) = 143(10) to R3
	mov R3,R16
	; Clear result in R6:R5:R4
	clr R6
	clr R5
	clr R4
MultLoop:
	lsr R3 ; shift least significant bit to carry
	brcc MultWoAdd ; if clear skip adding
	add R4,R0 ; Add number to result, lowest byte
	adc R5,R1 ; Add number with carry to result, second byte
	adc R6,R2 ; Add number with carry to result, third byte
MultWoAdd:
	lsl R0 ; Shift number left, bit 0 = 0, bit 7 to carry
	rol R1 ; Roll left, bit 0 = carry, bit 7 to carry
	rol R2 ; Roll left, bit 0 = carry, bit 7 to carry
	tst R3 ; Multiplication complete?
	brne MultLoop ; No, repeat

	; Result is in R6:R5:R4, done
	; R6 - 21(10) = 15(16)
	; R5 - 69(10) = 45(16)
	; R4 - 44(10) = 2C(16) 

	; HEXADECIMAL RESULT = 15452C(16) = 1393964(10)


	;	DECIMAL   9,748 * 143 = 1,393,964


;;;;;;;;;;;;;;;;; Primjer 2

	; Numbers in R1:R0 and R3
	ldi R16,0x22 ; 0x2256(16) = 8790(10) to R1:R0
	mov R1,R16
	ldi R16,0x56
	mov R0,R16
	clr R2 ; R2 is needed to shift the number left, zero at start
	ldi R16,0x6F ; 0x6F(16) = 111(10) to R3
	mov R3,R16
	; Clear result in R6:R5:R4
	clr R6
	clr R5
	clr R4
MultLoop:	; petlja za množenje
	lsr R3 ; shift least significant bit to carry
	brcc MultWoAdd ; if clear skip adding
	add R4,R0 ; Add number to result, lowest byte
	adc R5,R1 ; Add number with carry to result, second byte
	adc R6,R2 ; Add number with carry to result, third byte
MultWoAdd:	; petlja za množenje bez zbrajanja
	lsl R0 ; Shift number left, bit 0 = 0, bit 7 to carry
	rol R1 ; Roll left, bit 0 = carry, bit 7 to carry
	rol R2 ; Roll left, bit 0 = carry, bit 7 to carry
	tst R3 ; Multiplication complete?
	brne MultLoop ; No, repeat

	; Result is in R6:R5:R4, done
	; R6 - 14(10) = E(16)
	; R5 - 227(10) = E3(16)
	; R4 - 74(10) = 4A(16)


	;	DECIMAL   8790*111=975690(10) = EE34A(16)
	
	
	
; Evo objašnjenja naredbi za programiranje mikrokontrolera Atmel u assembly jeziku:

1. ldi (Load Immediate):
   - `ldi Rd, K`: Ucitava neposrednu vrijednost (K) u registar (Rd). Koristi se za postavljanje vrijednosti u registar.

2. mov (Move):
   - `mov Rd, Rr`: Kopira sadržaj jednog registra (Rr) u drugi registar (Rd).

3. clr (Clear):
   - `clr Rd`: Postavlja sadržaj registra (Rd) na 0, tj. briše ga.

4. lsr (Logical Shift Right):
   - `lsr Rd`: Vrši logicki desni pomak registra (Rd) za jedno mjesto. Najniži bit se postavlja na 0, a najviši se briše.

5. brcc (Branch if Carry Clear):
   - `brcc oznaka`: Ako se CF (Carry Flag) postavi na 0, skoci na navedenu oznaku.

6. add (Addition):
   - `add Rd, Rr`: Zbraja vrijednosti dva registra (Rd i Rr) i sprema rezultat u odredišni registar (Rd).

7. adc (Addition with Carry):
   - `adc Rd, Rr`: Zbraja vrijednosti dva registra (Rd i Rr) uzimajuci u obzir Carry flag i sprema rezultat u odredišni registar (Rd).

8. lsl (Logical Shift Left):
   - `lsl Rd`: Vrši logicki lijevi pomak registra (Rd) za jedno mjesto. Najviši bit postaje Carry flag, a najniži se postavlja na 0.

9. rol (Rotate Left through Carry):
   - `rol Rd`: Rotira vrijednost registra (Rd) ulijevo kroz Carry flag.

10. tst (Test):
    - `tst Rd`: Postavlja odgovarajuce statuse i zastave na temelju vrijednosti u registru (Rd), ali ne mijenja vrijednost registra.

11. brne (Branch if Not Equal):
    - `brne oznaka`: Ako se Z (Zero Flag) postavi na 0, skoci na navedenu oznaku.
	
	
	


