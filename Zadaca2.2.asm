/*
Zbroji brojeve 3A72104B(16) i  002CFE31(16)

• Prvi broj spremi u memoriju u na mjesto registara. Po?ni s registrom R16.
• Drugi broj spremi tako?er u memoriju na mjesto registra. Po?ni s registrom R20. 

Rezultate spremi na adrese od 38H, 39H, 3AH,3BH
*/
ldi R16, 0x3A
ldi R17, 0x72
ldi R18, 0x10
ldi R19, 0x4B

ldi R20, 0x00
ldi R21, 0x2C
ldi R22, 0xFE
ldi R23, 0x31

add R16, R20
adc R17, R21
adc R18, R22
adc R19, R23

sts 0x38, R16
sts 0x39, R17
sts 0x3A, R18
sts 0x3B, R19