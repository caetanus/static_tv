org 0x100

mov ax, 0xA000 
mov es, ax
mov ax,0x13
int 0x10
call set_gray_pallete

while: ; not kbhit
    xor di, di
    mov cx, 0xFA00
    call random_ax
    looping:
        mov BYTE [es:di],al
        call random_ax
        inc di
    loop looping
    call random_ax
    mov ax, 0x0100
    int 0x16
    jz while; not kbhit

mov ax,0x02
int 0x10
int 0x20




m_z  dw 1531
m_w  dw 4795

set_gray_pallete:
    mov cx, 0xFFFF
    xor ax,ax ; palete id
    pallete:
        mov dx,0x3C8
        out dx, al
        inc dx; 0x3C9
        out dx, al ; red
        out dx, al ; green
        out dx, al ; blue
        inc ax
    loop pallete
    ret

random_ax:
    mov ax,[m_z]
    shr ax, 3 
    mov bx, 12343
    mul bx
    push ax
    mov ax,[m_w]
    shr ax, 7
    mov bx, 32001
    mul bx
    mov bx, ax
    pop ax
    shl bx, 2
    mov [m_z], ax
    mov [m_w], bx
    add ax,bx
    ret
