
INCLUDE Irvine32.inc		;		Including Irvine Library
.data
j equ 30
k equ 40
n = 20
arrayd sdword n dup(?)
pressKeyPrompt1 BYTE "Player 1: ", 0
pressKeyPrompt2 BYTE "Player 2: ", 0

; Changing console title
titleStr	BYTE	"Ticketing Game - Welcome to the Show", 0

; Messages
gotTicket BYTE " You've got a ticket", 0

playerTicketMessage BYTE "Player ", 0
totalTickets BYTE " got ", 0
finalTicketMessage BYTE " tickets", 0

testString BYTE "Test Here", 0

; Tickets
ticketPl1 BYTE 0
ticketPl2 BYTE 0

.code
main proc
	INVOKE SetConsoleTitle, ADDR titleStr		;	Changing console title
    jmp mainProgLabel

    ; Comparison of speeed
    
    ; Player 1 ticket check
    ticketCheck1:


        cmp eax, 35
        ja doNotGiveTicket1
        giveTicket1:
            mov edx, OFFSET gotTicket
            call writestring
            inc ticketPl1
            jmp afterChecked1
        doNotGiveTicket1:
            cmp eax, 74
            ja giveTicket1
    jmp afterChecked1
    
    ; Player 2 ticket check
    ticketCheck2:


        cmp eax, 35
        ja doNotGiveTicket2
        giveTicket2:
            mov edx, OFFSET gotTicket
            call writestring
            inc ticketPl2
            jmp afterChecked2
        doNotGiveTicket2:
            cmp eax, 74
            ja giveTicket2
    jmp afterChecked2


    mainProgLabel:

    call randomize ;activate the seed
    mov ecx,n
    mov esi,0
    L1:           ;the trick is the 3 instruction lines shown below
       mov eax,k+j
       call randomrange
       add eax, j
       mov arrayd[esi*4],eax
       inc esi
       loop L1

       mov ecx,10
       mov esi,0
    L2:
        ; Player 1
			mov  eax,red+(black*16)
			call SetTextColor
			mov eax, 0
            mov edx, OFFSET pressKeyPrompt1
            call writestring
        labie1:
            call ReadKey
            jz labie1
            jnz labie2
        labie2:
        mov eax,arrayd[esi*4]

        call writeDec
    jmp ticketCheck1

    afterChecked1:
        call crlf
        inc esi

        ; Player 2
		mov  eax,green+(black*16)
		call SetTextColor
		mov eax, 0
        mov edx, OFFSET pressKeyPrompt2
            call writestring
        labie1a:
			mov eax, 100
			call delay
            call ReadKey
            jz labie1a
            jnz labie2a
        labie2a:
        mov eax,arrayd[esi*4]

        call writeDec
    jmp ticketCheck2

    afterChecked2:
        call crlf
        inc esi


        loop L2

        ; Player one score
        mov edx, OFFSET playerTicketMessage
        call writestring
        mov eax, 1
        call writedec
        mov edx, OFFSET totalTickets
        call writestring
        movzx eax, ticketPl1
        call writedec
        mov edx, OFFSET finalTicketMessage
        call writestring
        call crlf

        ; Player two score
        mov edx, OFFSET playerTicketMessage
        call writestring
        mov eax, 2
        call writedec
        mov edx, OFFSET totalTickets
        call writestring
        movzx eax, ticketPl2
        call writedec
        mov edx, OFFSET finalTicketMessage
        call writestring
		mov  eax,yellow+(black*16)
		call SetTextColor

    exit
main endp
end main

