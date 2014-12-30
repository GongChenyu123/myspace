NAME    T3            
PORT    EQU   0CFA0H       
CSEG    AT    0000H
        LJMP  START
CSEG    AT    4100H
START:  MOV    A,#11H     
        ACALL  DISP		   
        ACALL  DE3S        
LLL:    MOV    A,#12H      
        ACALL  DISP
        MOV    A,#10H      
        ACALL  DISP
        MOV    R2,#05H     
TTT:    MOV    A,#14H      
        ACALL  DISP
        ACALL  DE02S       
        MOV    A,#10H      
        ACALL  DISP
        ACALL  DE02S       
        DJNZ   R2,TTT      
        MOV    A,#11H         
        ACALL  DISP
        ACALL  DE02S           
        MOV    A,#21H      
        ACALL  DISP
        ACALL  DE10S        
        MOV    A,#01H      
        ACALL  DISP
        MOV    R2,#05H     
GGG:    MOV    A,#41H     
        ACALL  DISP
        ACALL  DE02S      
        MOV    A,#01H      
        ACALL  DISP
        ACALL  DE02S       
        DJNZ   R2,GGG      
        MOV    A,#03H     
        ACALL  DISP
        ACALL  DE02S       
        JMP    LLL        
DE10S:  MOV    R5,#100     
        JMP    DE1
DE3S:   MOV    R5,#30     
        JMP    DE1
DE02S:  MOV    R5,#02     
DE1:    MOV    R6,#200
DE2:    MOV    R7,#126
DE3:    DJNZ   R7,DE3
        DJNZ   R6,DE2
        DJNZ   R5,DE1
        RET
DISP:   MOV    DPTR,#PORT  
		CPL    A
		MOVX   @DPTR,A
		RET
        END
