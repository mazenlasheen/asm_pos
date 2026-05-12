; ============================================================
; Point of Sale (POS) System
; Architecture: x86 (32-bit), Assembler: NASM
; OS: Linux (int 0x80 syscalls)
; ============================================================

section .data
    msg_welcome       db "==============================", 10
                      db "   Welcome to POS      ", 10
                      db "==============================", 10, 0

    msg_main_menu     db 10, "==============================", 10
                      db "         SELECT CATEGORY       ", 10
                      db "==============================", 10
                      db "1. Coffee", 10
                      db "2. Food", 10
                      db "3. Juice", 10
                      db "4. Water", 10
                      db "0. Done / View Receipt", 10
                      db "Select (0-4): ", 0

    msg_coffee_menu   db 10, "--- Coffee ---", 10
                      db "1. Espresso      RM  4.00", 10
                      db "2. Latte         RM  6.00", 10
                      db "0. Back", 10
                      db "Select item (0-2): ", 0

    msg_espresso_add  db 10, "--- Espresso Add-ons ---", 10
                      db "1. Extra Shot    +RM 2.00", 10
                      db "2. Sugar         +RM 0.50", 10
                      db "3. Whipped Cream +RM 1.00", 10
                      db "0. Done", 10
                      db "Select add-on (0-3): ", 0

    msg_latte_add     db 10, "--- Latte Add-ons ---", 10
                      db "1. Whipped Cream +RM 1.00", 10
                      db "2. Caramel Syrup +RM 1.00", 10
                      db "3. Extra Shot    +RM 2.00", 10
                      db "0. Done", 10
                      db "Select add-on (0-3): ", 0

    msg_food_menu     db 10, "--- Food ---", 10
                      db "1. Sandwich      RM 10.00", 10
                      db "2. Cake          RM 12.00", 10
                      db "0. Back", 10
                      db "Select item (0-2): ", 0

    msg_sandwich_add  db 10, "--- Sandwich Add-ons ---", 10
                      db "1. Add Cheese    +RM 1.00", 10
                      db "2. Toasted       +RM 0.50", 10
                      db "0. Done", 10
                      db "Select add-on (0-2): ", 0

    msg_cake_add      db 10, "--- Cake Add-ons ---", 10
                      db "1. Whipped Cream +RM 1.00", 10
                      db "2. Ice Cream     +RM 2.00", 10
                      db "0. Done", 10
                      db "Select add-on (0-2): ", 0

    msg_juice_menu    db 10, "--- Juice ---", 10
                      db "1. Orange Juice  RM 6.00", 10
                      db "2. Mango Juice   RM 8.00", 10
                      db "0. Back", 10
                      db "Select item (0-2): ", 0

    msg_orange_add    db 10, "--- Orange Juice Add-ons ---", 10
                      db "1. Add Ice       +RM 0.50", 10
                      db "2. Large Size    +RM 2.00", 10
                      db "0. Done", 10
                      db "Select add-on (0-2): ", 0

    msg_mango_add     db 10, "--- Mango Juice Add-ons ---", 10
                      db "1. Add Ice       +RM 0.50", 10
                      db "2. Add Sago      +RM 1.00", 10
                      db "3. Large Size    +RM 2.00", 10
                      db "0. Done", 10
                      db "Select add-on (0-3): ", 0

    msg_water_menu    db 10, "--- Water ---", 10
                      db "1. Mineral       RM 2.00", 10
                      db "2. Sparkling     RM 3.00", 10
                      db "0. Back", 10
                      db "Select item (0-2): ", 0

    msg_mineral_add   db 10, "--- Mineral Water Add-ons ---", 10
                      db "1. Large Size    +RM 1.00", 10
                      db "2. Add Lemon     +RM 0.50", 10
                      db "0. Done", 10
                      db "Select add-on (0-2): ", 0

    msg_sparkling_add db 10, "--- Sparkling Water Add-ons ---", 10
                      db "1. Add Lime      +RM 0.50", 10
                      db "2. Large Size    +RM 1.00", 10
                      db "0. Done", 10
                      db "Select add-on (0-2): ", 0

    msg_qty           db "Enter quantity   : ", 0
    msg_item_hdr1     db 10, "--- Item ", 0
    msg_item_hdr2     db " of ", 0
    msg_item_hdr3     db " ---", 10, 0
    msg_added         db "Item added.", 10, 0
    msg_invalid       db "Invalid input. Try again.", 10, 0
    msg_duplicate_addon db "Add-on already selected for this item. Choose another.", 10, 0
    msg_empty_order   db "No items added. Please order something first.", 10, 0

    msg_receipt       db 10, "==============================", 10
                      db "           RECEIPT            ", 10
                      db "==============================", 10, 0
    msg_subtotal      db "Subtotal : RM ", 0
    msg_discount      db "Discount : RM ", 0
    msg_coupon_hdr    db "Coupon   : RM ", 0
    msg_total         db "Total    : RM ", 0
    msg_newline       db 10, 0
    msg_disc_note     db "(10% discount applied!)", 10, 0
    msg_thankyou      db "==============================", 10
                      db "  Thank you for your purchase! ", 10
                      db "==============================", 10, 0
    msg_dot           db ".", 0

    msg_coupon_q      db 10, "Do you have a coupon? (y/n): ", 0
    msg_coupon_ent    db "Enter coupon code: ", 0
    msg_coupon_inv    db "Invalid coupon. No discount applied.", 10, 0
    msg_save10_note   db "(SAVE10 - 10% off!)", 10, 0
    msg_flat5_note    db "(FLAT5  - RM5.00 off!)", 10, 0
    msg_vip20_note    db "(VIP20  - 20% off!)", 10, 0
    code_save10       db "SAVE10", 0
    code_flat5        db "FLAT5",  0
    code_vip20        db "VIP20",  0
    msg_new_order     db 10, "==============================", 10, 0
    msg_continue      db "Start new order? (y/n): ", 0

    coffee_prices     dd 400, 600
    food_prices       dd 1000, 1200
    juice_prices      dd 600, 800
    water_prices      dd 200, 300

    espresso_addons   dd 200, 50, 100
    latte_addons      dd 100, 100, 200
    sandwich_addons   dd 100, 50
    cake_addons       dd 100, 200
    orange_addons     dd 50, 200
    mango_addons      dd 50, 100, 200
    mineral_addons    dd 100, 50
    sparkling_addons  dd 50, 100

section .bss
    input_buf    resb 32
    coupon_buf   resb 16
    char_buf     resb 4
    total_sen    resd 1
    discount_sen resd 1
    coupon_sen   resd 1
    payable_sen  resd 1
    num_buf      resb 16
    saved_choice resd 1
    saved_qty    resd 1
    item_counter resd 1
    coupon_type  resd 1
    addon_mask   resb 1

section .text
    global _start

%macro print_str 1
    mov  esi, %1
    call _strlen
    mov  eax, 4
    mov  ebx, 1
    mov  ecx, %1
    int  0x80
%endmacro

; ============================================================
; print_item_hdr: prints "--- Item X of Y ---"
; ============================================================
print_item_hdr:
    print_str msg_item_hdr1
    mov  eax, [saved_qty]
    sub  eax, [item_counter]
    inc  eax
    call itoa_print
    print_str msg_item_hdr2
    mov  eax, [saved_qty]
    call itoa_print
    print_str msg_item_hdr3
    ret

; ============================================================
_start:
    mov  dword [total_sen],    0
    mov  dword [coupon_type],  0
    mov  dword [discount_sen], 0
    mov  dword [coupon_sen],   0
    print_str msg_welcome

; ============================================================
; MAIN LOOP
; ============================================================
main_loop:
    print_str msg_main_menu
    call read_line
    call atoi
    cmp  eax, 0
    je   show_receipt
    cmp  eax, 1
    je   coffee_section
    cmp  eax, 2
    je   food_section
    cmp  eax, 3
    je   juice_section
    cmp  eax, 4
    je   water_section
    print_str msg_invalid
    jmp  main_loop

; ============================================================
; COFFEE SECTION
; ============================================================
coffee_section:
    print_str msg_coffee_menu
    call read_line
    call atoi
    cmp  eax, 0
    je   main_loop
    cmp  eax, 1
    jl   coffee_inv
    cmp  eax, 2
    jg   coffee_inv
    mov  [saved_choice], eax
    print_str msg_qty
    call read_line
    call atoi
    cmp  eax, 0
    jle  coffee_inv
    mov  [saved_qty], eax
    mov  [item_counter], eax
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [coffee_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    mov  eax, [saved_choice]
    cmp  eax, 1
    je   espresso_addon_start
    jmp  latte_addon_start
coffee_inv:
    print_str msg_invalid
    jmp  coffee_section

; --- Espresso ---
espresso_addon_start:
    mov  byte [addon_mask], 0
    call print_item_hdr
espresso_addon_loop:
    print_str msg_espresso_add
    call read_line
    call atoi
    cmp  eax, 0
    je   espresso_done
    cmp  eax, 1
    jl   espresso_inv
    cmp  eax, 3
    jg   espresso_inv
    mov  ecx, eax
    dec  ecx
    movzx ebx, byte [addon_mask]
    mov  edx, 1
    shl  edx, cl
    test ebx, edx
    jnz  espresso_duplicate
    or   byte [addon_mask], dl
    mov  eax, [espresso_addons + ecx*4]
    add  [total_sen], eax
    jmp  espresso_addon_loop
espresso_duplicate:
    print_str msg_duplicate_addon
    jmp  espresso_addon_loop
espresso_done:
    mov  eax, [item_counter]
    dec  eax
    mov  [item_counter], eax
    cmp  eax, 0
    je   main_loop
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [coffee_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    jmp  espresso_addon_start
espresso_inv:
    print_str msg_invalid
    jmp  espresso_addon_loop

; --- Latte ---
latte_addon_start:
    mov  byte [addon_mask], 0
    call print_item_hdr
latte_addon_loop:
    print_str msg_latte_add
    call read_line
    call atoi
    cmp  eax, 0
    je   latte_done
    cmp  eax, 1
    jl   latte_inv
    cmp  eax, 3
    jg   latte_inv
    mov  ecx, eax
    dec  ecx
    movzx ebx, byte [addon_mask]
    mov  edx, 1
    shl  edx, cl
    test ebx, edx
    jnz  latte_duplicate
    or   byte [addon_mask], dl
    mov  eax, [latte_addons + ecx*4]
    add  [total_sen], eax
    jmp  latte_addon_loop
latte_duplicate:
    print_str msg_duplicate_addon
    jmp  latte_addon_loop
latte_done:
    mov  eax, [item_counter]
    dec  eax
    mov  [item_counter], eax
    cmp  eax, 0
    je   main_loop
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [coffee_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    jmp  latte_addon_start
latte_inv:
    print_str msg_invalid
    jmp  latte_addon_loop

; ============================================================
; FOOD SECTION
; ============================================================
food_section:
    print_str msg_food_menu
    call read_line
    call atoi
    cmp  eax, 0
    je   main_loop
    cmp  eax, 1
    jl   food_inv
    cmp  eax, 2
    jg   food_inv
    mov  [saved_choice], eax
    print_str msg_qty
    call read_line
    call atoi
    cmp  eax, 0
    jle  food_inv
    mov  [saved_qty], eax
    mov  [item_counter], eax
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [food_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    mov  eax, [saved_choice]
    cmp  eax, 1
    je   sandwich_addon_start
    jmp  cake_addon_start
food_inv:
    print_str msg_invalid
    jmp  food_section

; --- Sandwich ---
sandwich_addon_start:
    mov  byte [addon_mask], 0
    call print_item_hdr
sandwich_addon_loop:
    print_str msg_sandwich_add
    call read_line
    call atoi
    cmp  eax, 0
    je   sandwich_done
    cmp  eax, 1
    jl   sandwich_inv
    cmp  eax, 2
    jg   sandwich_inv
    mov  ecx, eax
    dec  ecx
    movzx ebx, byte [addon_mask]
    mov  edx, 1
    shl  edx, cl
    test ebx, edx
    jnz  sandwich_duplicate
    or   byte [addon_mask], dl
    mov  eax, [sandwich_addons + ecx*4]
    add  [total_sen], eax
    jmp  sandwich_addon_loop
sandwich_duplicate:
    print_str msg_duplicate_addon
    jmp  sandwich_addon_loop
sandwich_done:
    mov  eax, [item_counter]
    dec  eax
    mov  [item_counter], eax
    cmp  eax, 0
    je   main_loop
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [food_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    jmp  sandwich_addon_start
sandwich_inv:
    print_str msg_invalid
    jmp  sandwich_addon_loop

; --- Cake ---
cake_addon_start:
    mov  byte [addon_mask], 0
    call print_item_hdr
cake_addon_loop:
    print_str msg_cake_add
    call read_line
    call atoi
    cmp  eax, 0
    je   cake_done
    cmp  eax, 1
    jl   cake_inv
    cmp  eax, 2
    jg   cake_inv
    mov  ecx, eax
    dec  ecx
    movzx ebx, byte [addon_mask]
    mov  edx, 1
    shl  edx, cl
    test ebx, edx
    jnz  cake_duplicate
    or   byte [addon_mask], dl
    mov  eax, [cake_addons + ecx*4]
    add  [total_sen], eax
    jmp  cake_addon_loop
cake_duplicate:
    print_str msg_duplicate_addon
    jmp  cake_addon_loop
cake_done:
    mov  eax, [item_counter]
    dec  eax
    mov  [item_counter], eax
    cmp  eax, 0
    je   main_loop
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [food_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    jmp  cake_addon_start
cake_inv:
    print_str msg_invalid
    jmp  cake_addon_loop

; ============================================================
; JUICE SECTION
; ============================================================
juice_section:
    print_str msg_juice_menu
    call read_line
    call atoi
    cmp  eax, 0
    je   main_loop
    cmp  eax, 1
    jl   juice_inv
    cmp  eax, 2
    jg   juice_inv
    mov  [saved_choice], eax
    print_str msg_qty
    call read_line
    call atoi
    cmp  eax, 0
    jle  juice_inv
    mov  [saved_qty], eax
    mov  [item_counter], eax
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [juice_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    mov  eax, [saved_choice]
    cmp  eax, 1
    je   orange_addon_start
    jmp  mango_addon_start
juice_inv:
    print_str msg_invalid
    jmp  juice_section

; --- Orange Juice ---
orange_addon_start:
    mov  byte [addon_mask], 0
    call print_item_hdr
orange_addon_loop:
    print_str msg_orange_add
    call read_line
    call atoi
    cmp  eax, 0
    je   orange_done
    cmp  eax, 1
    jl   orange_inv
    cmp  eax, 2
    jg   orange_inv
    mov  ecx, eax
    dec  ecx
    movzx ebx, byte [addon_mask]
    mov  edx, 1
    shl  edx, cl
    test ebx, edx
    jnz  orange_duplicate
    or   byte [addon_mask], dl
    mov  eax, [orange_addons + ecx*4]
    add  [total_sen], eax
    jmp  orange_addon_loop
orange_duplicate:
    print_str msg_duplicate_addon
    jmp  orange_addon_loop
orange_done:
    mov  eax, [item_counter]
    dec  eax
    mov  [item_counter], eax
    cmp  eax, 0
    je   main_loop
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [juice_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    jmp  orange_addon_start
orange_inv:
    print_str msg_invalid
    jmp  orange_addon_loop

; --- Mango Juice ---
mango_addon_start:
    mov  byte [addon_mask], 0
    call print_item_hdr
mango_addon_loop:
    print_str msg_mango_add
    call read_line
    call atoi
    cmp  eax, 0
    je   mango_done
    cmp  eax, 1
    jl   mango_inv
    cmp  eax, 3
    jg   mango_inv
    mov  ecx, eax
    dec  ecx
    movzx ebx, byte [addon_mask]
    mov  edx, 1
    shl  edx, cl
    test ebx, edx
    jnz  mango_duplicate
    or   byte [addon_mask], dl
    mov  eax, [mango_addons + ecx*4]
    add  [total_sen], eax
    jmp  mango_addon_loop
mango_duplicate:
    print_str msg_duplicate_addon
    jmp  mango_addon_loop
mango_done:
    mov  eax, [item_counter]
    dec  eax
    mov  [item_counter], eax
    cmp  eax, 0
    je   main_loop
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [juice_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    jmp  mango_addon_start
mango_inv:
    print_str msg_invalid
    jmp  mango_addon_loop

; ============================================================
; WATER SECTION
; ============================================================
water_section:
    print_str msg_water_menu
    call read_line
    call atoi
    cmp  eax, 0
    je   main_loop
    cmp  eax, 1
    jl   water_inv
    cmp  eax, 2
    jg   water_inv
    mov  [saved_choice], eax
    print_str msg_qty
    call read_line
    call atoi
    cmp  eax, 0
    jle  water_inv
    mov  [saved_qty], eax
    mov  [item_counter], eax
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [water_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    mov  eax, [saved_choice]
    cmp  eax, 1
    je   mineral_addon_start
    jmp  sparkling_addon_start
water_inv:
    print_str msg_invalid
    jmp  water_section

; --- Mineral Water ---
mineral_addon_start:
    mov  byte [addon_mask], 0
    call print_item_hdr
mineral_addon_loop:
    print_str msg_mineral_add
    call read_line
    call atoi
    cmp  eax, 0
    je   mineral_done
    cmp  eax, 1
    jl   mineral_inv
    cmp  eax, 2
    jg   mineral_inv
    mov  ecx, eax
    dec  ecx
    movzx ebx, byte [addon_mask]
    mov  edx, 1
    shl  edx, cl
    test ebx, edx
    jnz  mineral_duplicate
    or   byte [addon_mask], dl
    mov  eax, [mineral_addons + ecx*4]
    add  [total_sen], eax
    jmp  mineral_addon_loop
mineral_duplicate:
    print_str msg_duplicate_addon
    jmp  mineral_addon_loop
mineral_done:
    mov  eax, [item_counter]
    dec  eax
    mov  [item_counter], eax
    cmp  eax, 0
    je   main_loop
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [water_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    jmp  mineral_addon_start
mineral_inv:
    print_str msg_invalid
    jmp  mineral_addon_loop

; --- Sparkling Water ---
sparkling_addon_start:
    mov  byte [addon_mask], 0
    call print_item_hdr
sparkling_addon_loop:
    print_str msg_sparkling_add
    call read_line
    call atoi
    cmp  eax, 0
    je   sparkling_done
    cmp  eax, 1
    jl   sparkling_inv
    cmp  eax, 2
    jg   sparkling_inv
    mov  ecx, eax
    dec  ecx
    movzx ebx, byte [addon_mask]
    mov  edx, 1
    shl  edx, cl
    test ebx, edx
    jnz  sparkling_duplicate
    or   byte [addon_mask], dl
    mov  eax, [sparkling_addons + ecx*4]
    add  [total_sen], eax
    jmp  sparkling_addon_loop
sparkling_duplicate:
    print_str msg_duplicate_addon
    jmp  sparkling_addon_loop
sparkling_done:
    mov  eax, [item_counter]
    dec  eax
    mov  [item_counter], eax
    cmp  eax, 0
    je   main_loop
    mov  ecx, [saved_choice]
    dec  ecx
    mov  eax, [water_prices + ecx*4]
    add  [total_sen], eax
    print_str msg_added
    jmp  sparkling_addon_start
sparkling_inv:
    print_str msg_invalid
    jmp  sparkling_addon_loop

; ============================================================
; EMPTY ORDER CHECK -> COUPON CHECK
; ============================================================
show_receipt:
    mov  eax, [total_sen]
    cmp  eax, 0
    jne  coupon_check
    print_str msg_empty_order
    jmp  main_loop

; ============================================================
; COUPON CHECK
; ============================================================
coupon_check:
    print_str msg_coupon_q
    call read_line
    movzx eax, byte [input_buf]
    cmp  al, 'y'
    je   ask_coupon_code
    cmp  al, 'Y'
    je   ask_coupon_code
    mov  dword [coupon_type], 0
    jmp  do_receipt

ask_coupon_code:
    print_str msg_coupon_ent
    call read_line
    mov  esi, input_buf
    mov  edi, coupon_buf
    mov  ecx, 16
    rep  movsb
    ; try SAVE10
    mov  esi, code_save10
    mov  edi, coupon_buf
    mov  ecx, 6
    repe cmpsb
    jne  try_flat5
    cmp  byte [coupon_buf + 6], 0
    jne  try_flat5
    mov  dword [coupon_type], 1
    jmp  do_receipt
try_flat5:
    mov  esi, code_flat5
    mov  edi, coupon_buf
    mov  ecx, 5
    repe cmpsb
    jne  try_vip20
    cmp  byte [coupon_buf + 5], 0
    jne  try_vip20
    mov  dword [coupon_type], 2
    jmp  do_receipt
try_vip20:
    mov  esi, code_vip20
    mov  edi, coupon_buf
    mov  ecx, 5
    repe cmpsb
    jne  coupon_invalid
    cmp  byte [coupon_buf + 5], 0
    jne  coupon_invalid
    mov  dword [coupon_type], 3
    jmp  do_receipt
coupon_invalid:
    print_str msg_coupon_inv
    mov  dword [coupon_type], 0

; ============================================================
; RECEIPT
; ============================================================
do_receipt:
    print_str msg_receipt
    print_str msg_subtotal
    mov  eax, [total_sen]
    call print_rm
    ; auto-discount: 10% if subtotal >= RM100
    mov  eax, [total_sen]
    cmp  eax, 10000
    jl   no_auto_discount
    mov  edx, 0
    mov  ecx, 10
    div  ecx
    mov  [discount_sen], eax
    print_str msg_disc_note
    print_str msg_discount
    mov  eax, [discount_sen]
    call print_rm
    jmp  check_coupon
no_auto_discount:
    mov  dword [discount_sen], 0
check_coupon:
    mov  eax, [coupon_type]
    cmp  eax, 1
    je   apply_save10
    cmp  eax, 2
    je   apply_flat5
    cmp  eax, 3
    je   apply_vip20
    mov  dword [coupon_sen], 0
    jmp  print_total
apply_save10:
    print_str msg_save10_note
    mov  eax, [total_sen]
    mov  edx, 0
    mov  ecx, 10
    div  ecx
    mov  [coupon_sen], eax
    print_str msg_coupon_hdr
    mov  eax, [coupon_sen]
    call print_rm
    jmp  print_total
apply_flat5:
    print_str msg_flat5_note
    mov  dword [coupon_sen], 500
    print_str msg_coupon_hdr
    mov  eax, [coupon_sen]
    call print_rm
    jmp  print_total
apply_vip20:
    print_str msg_vip20_note
    mov  eax, [total_sen]
    mov  edx, 0
    mov  ecx, 5
    div  ecx
    mov  [coupon_sen], eax
    print_str msg_coupon_hdr
    mov  eax, [coupon_sen]
    call print_rm
print_total:
    print_str msg_total
    mov eax, [total_sen]
    sub eax, [discount_sen]
    sub eax, [coupon_sen]
    mov [payable_sen], eax
    mov eax, [payable_sen]
    call print_rm
    print_str msg_thankyou
    print_str msg_new_order
    print_str msg_continue

    call read_line
    movzx eax, byte [input_buf]
    cmp al, 'n'
    je exit_program
    cmp al, 'N'
    je exit_program

    ; Reset all values for new order
    mov dword [total_sen], 0
    mov dword [coupon_type], 0
    mov dword [discount_sen], 0
    mov dword [coupon_sen], 0

    jmp main_loop

; ============================================================
; _strlen: IN ESI=string  OUT EDX=length
; ============================================================
_strlen:
    xor  edx, edx
.lp:
    cmp  byte [esi+edx], 0
    je   .done
    inc  edx
    jmp  .lp
.done:
    ret

; ============================================================
; read_line: reads one char at a time into input_buf
; ============================================================
read_line:
    xor  ecx, ecx
.loop:
    mov  eax, 3
    mov  ebx, 0
    mov  edx, 1
    lea  edi, [char_buf]
    push ecx
    mov  ecx, edi
    int  0x80
    pop  ecx
    cmp  eax, 0
    jle  .done
    movzx eax, byte [char_buf]
    cmp  al, 10
    je   .done
    cmp  al, 13
    je   .loop
    cmp  al, 0
    je   .done
    mov  [input_buf + ecx], al
    inc  ecx
    cmp  ecx, 30
    jl   .loop
.done:
    mov  byte [input_buf + ecx], 0
    ret

; ============================================================
; atoi: input_buf -> EAX integer
; ============================================================
atoi:
    xor  eax, eax
    xor  ecx, ecx
.lp:
    movzx edx, byte [input_buf + ecx]
    cmp  dl, 0
    je   .done
    cmp  dl, '0'
    jl   .done
    cmp  dl, '9'
    jg   .done
    sub  dl, '0'
    imul eax, eax, 10
    add  eax, edx
    inc  ecx
    jmp  .lp
.done:
    ret

; ============================================================
; print_rm: IN EAX=sen  Prints "X.XX\n"
; ============================================================
print_rm:
    push ebx
    mov  ecx, 100
    xor  edx, edx
    div  ecx
    push edx
    call itoa_print
    mov  eax, 4
    mov  ebx, 1
    mov  ecx, msg_dot
    mov  edx, 1
    int  0x80
    pop  eax
    call print_2digit
    mov  eax, 4
    mov  ebx, 1
    mov  ecx, msg_newline
    mov  edx, 1
    int  0x80
    pop  ebx
    ret

; ============================================================
; itoa_print: print EAX as unsigned decimal
; ============================================================
itoa_print:
    lea  esi, [num_buf + 12]
    mov  byte [esi], 0
    mov  ecx, 10
.lp:
    xor  edx, edx
    div  ecx
    add  dl, '0'
    dec  esi
    mov  [esi], dl
    test eax, eax
    jnz  .lp
    lea  edx, [num_buf + 12]
    sub  edx, esi
    mov  eax, 4
    mov  ebx, 1
    mov  ecx, esi
    int  0x80
    ret

; ============================================================
; print_2digit: print EAX as 2-digit zero-padded decimal
; ============================================================
print_2digit:
    mov  ecx, 10
    xor  edx, edx
    div  ecx
    add  al, '0'
    add  dl, '0'
    mov  [num_buf], al
    mov  [num_buf+1], dl
    mov  eax, 4
    mov  ebx, 1
    mov  ecx, num_buf
    mov  edx, 2
    int  0x80
    ret
exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80