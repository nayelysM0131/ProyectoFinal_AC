include 'emu8086.inc'

datos segment
    
    arreglo db 64 dup(?) 
    unidad db ?

 
    x db 2
    y db 2
datos ends

pila segment
    db 64 dup(0)
pila ends

codigo segment
    main proc far
        assume ss:pila,ds:datos,cs:codigo
        
        push ds
        mov ax,0
        push ax
        
        mov ax,datos
        mov ds,ax
        mov es,ax  
        
        call clear_screen
        gotoxy x,y
        
        mov si,0
        mov di,1 
        mov cx,0
        mov bp,0
        mov arreglo[si],0
        mov arreglo[di],1
        
        
        call pthis
        db "Introduzca un puto numero: ",0
          
          
        ;------------------------
        
         mov ah,01h
         int 21h
         sub al,30h
         mov dl,al
         mov al,0      
         
         entrada:
         
         mov ah,01h
         int 21h
         cmp al,013
         je goto
         
         mov ah,0
         mov bl,10
         mov bh,al
         sub bh,30h
         mov al,dl
         mul bl
         mov bl,0
         add al,bh
         mov dl,al
         mov ax,0
         mov bx,0
         
         jmp entrada
         
        
        goto:
        mov al,dl
        mov cl,al       
        mov y,4      
        gotoxy x,y
        
        
        ciclo:
            cmp al,0
            je terminar_ciclo 
            mov bl,arreglo[di]
            add bl,arreglo[si]
            inc si
            inc di 
            mov arreglo[di],bl
            dec al
            
        jmp ciclo
                   
        terminar_ciclo:  
        
              cmp cl,0
              je game_over
              
              mov al,arreglo[bp]
              cmp ax,144d
              jge imprimir_3_digitos
              
              imprimir_2_digitos:
              
              aam
              mov bx,ax
              add bx,3030h
                 
              mov ah,02h 
              mov dl,bh
              int 21h 
              
              mov ah,02h 
              mov dl,bl
              int 21h 
              
              mov ah,02h
              mov dl,' '
              int 21h            
                          
              jmp avanza   
              
              
              imprimir_3_digitos:
              aam
              
              add al,30h
              mov unidad,al
              
              mov al,ah
              mov ah,0
              
              aam
              
              mov bx,ax
              add bx,3030h
                             
               mov ah,02h 
              mov dl,bh
              int 21h 
              
              mov ah,02h 
              mov dl,bl
              int 21h  
              
              mov ah,02h
              mov dl,unidad
              int 21h
              
              mov ah,02h
              mov dl,' '
              int 21h  
              
              avanza:
              
              inc bp 
              dec cl              
              
              
        jmp terminar_ciclo  
        
        
        
        
                              
              game_over:       
              mov ah,4ch
              int 21h       
            
                  
       
        
        


ret       

main endp
    codigo ends

define_pthis    
define_clear_screen

end main



