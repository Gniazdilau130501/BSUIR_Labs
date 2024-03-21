code segment
assume cs:code, ds:data, es:Pictures

mov ah, 0fh										; Запоминаем предыдущий
int 10h											; режим, в
push ax											; котором работали

mov ax, data									; Устанавливаем сегмент data
mov es, ax										; в регистры
mov ds, ax										; es и ds

mov ax, 0013h									; Переходим в видеорежим
int 10h											; 320x200 (16 цветов)
jmp Menu_start									; Переходим по адресу Menu

Exit_game:
	pop ax										; Вынимаем номер предыдущего режима работы
	mov ah, 0									; и восстанавливаем
	int 10h										; этот режим
	mov ax, 4c00h								; Используем 4ch функцию 21h прерывания
	int 21h										; для выхода из программы

Menu_start:
	mov Exit_flag, 0							; Зануляем флаг выхода из игры
	mov Menu_lines, 5							; Количество пунктов в текущем окне
	mov Menu_flag, 0							; Очищаем флажек текущего меню
	call Clear_background						; Очищаем экран
	mov korx, 0									; Задаем координату начала вывода картинки по x
	mov kory, 0									; Задаем координату начала вывода картинки по y
	mov dlin, 320								; Задаем длину нашей картинки по x
	mov kol_array, 8366							; Задаем длину массива
	mov offset_array, offset Menu_picture		; Задаем в ячейку offset_array смещение массива Menu_picture
	call Print									; Вызываем метод рисования картинки по массиву
	call Menu									; Заполняем экран главного меню
	mov Center_of_pointer_x, 114				; Задаем положение по x
	mov Center_of_pointer_y, 149				; и y
	mov ax, Center_of_pointer_y					; Текущее положение указателя
	mov Current_pointer_y, ax					; по y
	call Menu									; Заполняем экран главного меню
	Insert_menu:
		call Selection							; Выбор действия относительно нажатой клавиши
		cmp Menu_flag, 1						; Если наш флажек равен 1, то
		je Controls_start						; переходим по адресу Controls_start
		cmp Menu_flag, 2						; Если наш флажек равен 2, то
		je Settings_start_1						; переходим по адресу Settings_start
		cmp Menu_flag, 3						; Если наш флажек равен 3, то
		je Credits_start_1						; переходим по адресу Credits_start
		cmp Menu_flag, 4						; Если наш флажек равен 4, то
		je Exit_game							; переходим по адресу Exit_game
		jmp New_game_start						; Если наш флажек равен 0, то переходим по адресу New_game_start
	Settings_start_1:
		jmp Settings_start
	Credits_start_1:
		jmp Credits_start
	
Controls_start:
	mov Menu_lines, 7							; Количество пунктов в текущем окне
	mov Menu_flag, 0							; чищаем флажек текущего меню
	call Clear_background						; Очищаем экран
	mov kol_array, 6218							; Задаем длину массива
	mov offset_array, offset Controls_picture	; Задаем в ячейку offset_array смещение массива Menu_picture
	call Print									; Вызываем метод рисования картинки по массиву
	call Controls_buttons						; аполняем экран меню
	mov Center_of_pointer_x, 114				; Задаем положение по x
	mov Center_of_pointer_y, 100				; и y
	mov ax, Center_of_pointer_y					; Текущее положение указателя
	mov Current_pointer_y, ax					; по y
	Insert_controls:
		call Selection							; Выбор действия относительно нажатой клавиши
		cmp Menu_flag, 1						; Если наш флажек равен 1, то
		je Down_button_change					; переходим по адресу Down_button_change
		cmp Menu_flag, 2						; Если наш флажек равен 2, то
		je Left_button_change					; переходим по адресу Left_button_change
		cmp Menu_flag, 3						; Если наш флажек равен 3, то
		je Right_button_change_1				; переходим по адресу Right_button_change
		cmp Menu_flag, 4						; Если наш флажек равен 4, то
		je Jump_button_change_1					; переходим по адресу Jump_button_change
		cmp Menu_flag, 5						; Если наш флажек равен 5, то
		je Accept_button_change_1				; переходим по адресу Accept_button_change
		cmp Menu_flag, 0						; Если наш флажек равен 0, то
		je Up_button_change_1					; переходим по адресу Up_button_change
		jmp Menu_start							; Если наш флажек равен 6, то переходим по адресу Menu_start
	Right_button_change_1:
		jmp Right_button_change
	Jump_button_change_1:
		jmp Jump_button_change
	Accept_button_change_1:
		jmp Accept_button_change
	Up_button_change_1:
		jmp Up_button_change

Down_button_change:
	call Clear_background						; Очищаем фон
	call Press_change_button					; заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_button							; Сравниваем её уже с введенными
	cmp Current_key, 20							; Если не нажали Esc,
	jne Down_change								; то меняем клавишу,
	jmp Controls_start							; иначе выходим в Controls_start
	Down_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем нашу
		 mov Down, al							; клавишу
		 pop ax									; Вынимаем ax из стека
		 jmp Controls_start						; Выходим в Controls_start


Left_button_change:
	call Clear_background						; Очищаем фон
	call Press_change_button					; заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_button							; Сравниваем её уже с введенными
	cmp Current_key, 1							; Если не нажали Esc,
	jne Left_change								; то меняем клавишу,
	jmp Controls_start							; иначе выходим в Controls_start
	Left_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем нашу
		 mov Left, al							; клавишу
		 pop ax									; Вынимаем ax из стека
		 jmp Controls_start						; Выходим в Controls_start

Right_button_change:
	call Clear_background						; Очищаем фон
	call Press_change_button					; заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_button							; Сравниваем её уже с введенными
	cmp Current_key, 1							; Если не нажали Esc,
	jne Right_change							; то меняем клавишу,
	jmp Controls_start							; иначе выходим в Controls_start
	Right_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем нашу
		 mov Right, al							; клавишу
		 pop ax									; Вынимаем ax из стека
		 jmp Controls_start						; Выходим в Controls_start

Jump_button_change:
	call Clear_background						; Очищаем фон
	call Press_change_button					; заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_button							; Сравниваем её уже с введенными
	cmp Current_key, 1							; Если не нажали Esc,
	jne Jump_change								; то меняем клавишу,
	jmp Controls_start							; иначе выходим в Controls_start
	Jump_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем нашу
		 mov Action_1, al						; клавишу
		 pop ax									; Вынимаем ax из стека
		 jmp Controls_start						; Выходим в Controls_start

Accept_button_change:
	call Clear_background						; Очищаем фон
	call Press_change_button					; заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_button							; Сравниваем её уже с введенными
	cmp Current_key, 1							; Если не нажали Esc,
	jne Accept_change							; то меняем клавишу,
	jmp Controls_start							; иначе выходим в Controls_start
	Accept_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем нашу
		 mov Action_2, al						; клавишу
		 pop ax									; Вынимаем ax из стека
		 jmp Controls_start						; Выходим в Controls_start

Up_button_change:
	call Clear_background						; Очищаем фон
	call Press_change_button					; заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_button							; Сравниваем её уже с введенными
	cmp Current_key, 1							; Если не нажали Esc,
	jne Up_change								; то меняем клавишу,
	jmp Controls_start							; иначе выходим в Controls_start
	Up_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем нашу
		 mov Up, al								; клавишу
		 pop ax									; Вынимаем ax из стека
		 jmp Controls_start						; Выходим в Controls_start		

Settings_start:
	mov Menu_lines, 4							; Количество пунктов в текущем окне
	mov Menu_flag, 0							; чищаем флажек текущего меню
	call Clear_background						; Очищаем экран
	mov kol_array, 5844							; Задаем длину массива
	mov offset_array, offset Settings_picture	; Задаем в ячейку offset_array смещение массива Menu_picture
	call Print									; Вызываем метод рисования картинки по массиву
	call Settings_buttons						; Заполняем экран меню
	mov Center_of_pointer_x, 114				; Задаем положение по x
	mov Center_of_pointer_y, 100				; и y
	mov ax, Center_of_pointer_y					; Текущее положение указателя
	mov Current_pointer_y, ax					; по y
	Insert_settings:
		call Selection							; Выбор действия относительно нажатой клавиши
		cmp Menu_flag, 1						; Если наш флажек равен 1, то
		je Font_color_change					; переходим по адресу Font_color_change
		cmp Menu_flag, 2						; Если наш флажек равен 2, то
		je Pointer_color_change					; переходим по адресу Pointer_color_change
		cmp Menu_flag, 0						; Если наш флажек равен 0, то
		je Background_color_change				; переходим по адресу Background_color_change
		jmp Menu_start							; Если наш флажек равен 3, то переходим по адресу Menu_start

Font_color_change:
	call Clear_background						; Очищаем фон
	call Press_change_color						; Заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_color							; Сравниваем цвет с текущим
	cmp Current_key, 20							; Если удовлетворили условиям,
	jne Font_change								; то меняем цвет,
	jmp Settings_start							; иначе выходим в Settings_start
	Font_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем наш
		 mov Font_color, al						; цвет
		 pop ax									; Вынимаем ax из стека
		 jmp Settings_start						; Выходим в Settings_start

Pointer_color_change:
	call Clear_background						; Очищаем фон
	call Press_change_color						; Заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_color							; Сравниваем цвет с текущим
	cmp Current_key, 20							; Если удовлетворили условиям,
	jne Pointer_change							; то меняем цвет,
	jmp Settings_start							; иначе выходим в Settings_start
	Pointer_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем наш
		 mov Pointer_color, al					; цвет
		 pop ax									; Вынимаем ax из стека
		 jmp Settings_start						; Выходим в Settings_start

Background_color_change:
	call Clear_background						; Очищаем фон
	call Press_change_color						; Заполняем экран ввода
	call Scan_code								; Вводим клавишу
	call Change_color							; Сравниваем цвет с текущим
	cmp Current_key, 20							; Если удовлетворили условиям,
	jne Background_change						; то меняем цвет,
	jmp Settings_start							; иначе выходим в Settings_start
	Background_change:
		 push ax								; Запоминаем регистр ax в стек 
		 mov al, Current_key					; Переприсваиваем наш
		 mov Background_color, al				; цвет
		 pop ax									; Вынимаем ax из стека
		 jmp Settings_start						; Выходим в Settings_start

Credits_start:
	call Clear_background						; Очищаем фон
	mov kol_array, 5068							; Задаем длину массива
	mov offset_array, offset Credits_picture	; Задаем в ячейку offset_array смещение массива Menu_picture
	call Print									; Вызываем метод рисования картинки по массиву
	call Credits_list							; Заполняем экран Credits
	Credits_again:
		call Scan_code							; Вводим клавишу
		cmp Current_key, 1						; Если ввели Esc,
		jne Credits_again						; то меняем цвет,
		jmp Menu_start							; иначе выходим в Settings_start

New_game_start:
	call Clear_background						; Очищаем фон
	jmp far ptr Rulez							; Прыгаем в другой сегмент по адресу Rulez
Rulez_end label far
	call Scan_code								; Ожидаем нажатие клавиши
	call Clear_background						; Очищаем фон
	mov kol_array, 10617						; Задаем длину массива
	mov offset_array, offset Arena				; Задаем в ячейку offset_array смещение массива Arena
	call Print									; Вызываем метод рисования картинки по массиву
	push es										; Запоминаем в стек значение регистра es (сегмент data)
	push ds										; Запоминаем в стек значение регистра ds (сегмент data)
	mov ax, 351ch								; Используем 35h функцию (номер прерывания 1ch) для получение адреса вектора прерывания из ТВП
	int 21h										; с помощью 21h прерывания
	mov word ptr Old_int1ch, bx					; Записываем адрес смещения прерывания 1ch в младшие 2 байта ячейки памяти Old_int1ch
	mov word ptr Old_int1ch+2, es				; Записываем адрес сегмента прерывания 1ch в старшие 2 байта ячейки памяти Old_int1ch
	mov ax, 251ch								; Используем 25h функцию (номер прерывания 1ch) для записи нового адреса вектора прерывания в ТВП
	mov dx, seg New_int1ch						; Записываем адрес сегмента прерывания 1ch
	mov ds, dx									; в регистр ds
	mov dx, offset New_int1ch					; Записываем адрес смещения прерывания 1ch в регистр dx
	int 21h										; С помощью 21h прерывания записываем адрес ТВП
	pop ds										; Вынимаем из стека значение в регистр ds (сегмент data)
	pop es										; Вынимаем из стека значение в регистр es (сегмент data)
	mov Score, 0								; Зануляем значение ячейки памяти Score (зануляем счет)
	mov Start_coord_y, 15						; Устанавливаем начальную координату квадрата фигуры на 15 по оси y
	mov Start_coord_x, 150						; Устанавливаем начальную координату квадрата фигуры на 150 по оси x
	call Random									; Вызываем процедуру Random (в ячейку Figure_number записывается номер фигуры)
	mov Rotate, 0								; Зануляем флаг поворота
	mov Figure_rotate, 0						; Начальное положение фигуры

Game:
	call scan_code								; Вызываем процедуру scan_code
	cmp Exit_flag, 1							; Если флаг выхода поднят, (нажат esc)
		jae Menu_game_1							; то переходим по метке Menu_game_1
	call Rotate_figure							; Вызываем процедуру поворота фигуры (нажат space)
	call New_speed								; Вызываем процедуру изменения скорости (нажаты up или down)
	call Move_x									; Вызываем процедуру перемещения фигуры по оси x (нажаты right ли left)
jmp Game
	
Menu_game_1:
	push ds										; Запоминаем в стек значение регистра ds (сегмент data)
	mov ax, 251ch								; Используем 25h функцию (номер прерывания 1ch) для записи нового адреса вектора прерывания в ТВП
	mov dx, word ptr Old_int1ch					; Записываем старый адрес смещения прерывания 1ch из младших 2-х байт ячейки Old_int1ch в регистр dx
	mov bx, word ptr Old_int1ch+2				; Записываем старый адрес сегмента прерывания 1ch из старших 2-х байт ячейки Old_int1ch в регистр bx
	mov ds, bx									; Записываем значение регистра bx в регистр ds
	int 21h										; С помощью 21h прерывания записываем адрес ТВП
	pop ds										; Вынимаем из стека значение в регистр ds (сегмент data)
	call Clear_background						; Очищаем фон
	cmp Score, 10000							; Если Score меньше 10000, то
		jb Lose									; переходим по адресу Lose,
		jmp Win									; иначе переходим по адресу Win
		
Lose:
	mov kol_array, 10982						; Задаем длину массива
	mov offset_array, offset Smorc				; Задаем в ячейку offset_array смещение массива Smorc
	call Print									; Вызываем метод рисования картинки по массиву
	call Write_score							; Вызываем метод вывода счета
Again_lose:	
	call scan_code								; Вводим клавишу
	push ax										; апоминаем регистр ax в стек
	mov al, Action_2							; Присваиваем регистру al значение ячейки памяти Action_2 (Enter)
	pop ax										; Вынимаем значение из стека в регистр ax
	cmp Current_key, al							; Если ввели не Enter, то
		jne Again_lose							; переходим по метке Again_win (ожидаем ввод клавиши),
		jmp Menu_start							; иначе переходим по адресу Menu_start
	
Win:
	mov kol_array, 7750							; Задаем длину массива
	mov offset_array, offset Kappa				; Задаем в ячейку offset_array смещение массива Kappa
	call Print									; Вызываем метод рисования картинки по массиву
	call Write_score							; Вызываем метод вывода счета
Again_win:	
	call scan_code								; Вводим клавишу
	push ax										; Запоминаем регистр ax в стек
	mov al, Action_2							; Присваиваем регистру al значение ячейки памяти Action_2 (Enter)
	pop ax										; Вынимаем значение из стека в регистр ax
	cmp Current_key, al							; Если ввели не Enter, то
		jne Again_win							; переходим по метке Again_win (ожидаем ввод клавиши),
		jmp Menu_start							; иначе переходим по адресу Menu_start
	
New_int1ch proc
	call Timer_1ch								; Вызываем процедуру Timer_1ch (таймер через тики)
	cmp Timer_flag, 0							; Если флаг Timer_flag поднят,
		ja Animation							; то переходим по адресу Animation
Exit_new_int1ch:
iret											; Вынимаем регистры ip, cs, flags и возвращаемся к выполнению остальной программы по адресу ip
Animation:
	cmp Exit_flag, 1							; Если флаг выхода поднят, то
		jae Exit_new_int1ch						; переходим по адресу Exit_new_int1ch
	mov Timer_flag, 0							; Зануляем флаг таймера Timer_flag
	cmp Figure_number, 1						; Если анимируется 1-я фигура, то
		je Figure_1_proc						; переходим по адресу Figure_1_proc
	cmp Figure_number, 2						; Если анимируется 2-я фигура, то
		je Figure_2_proc						; переходим по адресу Figure_2_proc
	cmp Figure_number, 3						; Если анимируется 3-я фигура, то
		je Figure_3_proc						; переходим по адресу Figure_3_proc
	cmp Figure_number, 4						; Если анимируется 4-я фигура, то
		je Figure_4_proc						; переходим по адресу Figure_4_proc
	cmp Figure_number, 5						; Если анимируется 5-я фигура, то
		je Figure_5_proc						; переходим по адресу Figure_5_proc
	cmp Figure_number, 6						; Если анимируется 6-я фигура, то
		je Figure_6_proc						; переходим по адресу Figure_6_proc,
		jmp Figure_7_proc						; иначе переходим по адресу Figure_7_proc
Editing_figure_position:
	add Start_coord_y, 10						; Увеличиваем координату по оси y на 10 (одна игровая единица)
	cmp Start_coord_y, 185						; Если наша координата находится за пределами игровой зоны, то
		jae New_figure							; переходим по адресу New_figure,
		jmp Exit_new_int1ch						; иначе переходим по адресу Exit_new_int1ch
New_figure:
	mov Figure_rotate, 0						; Зануляем флаг положения фигуры
	mov Start_coord_y, 15						; Устанавливаем стартовую координату фигуры по оси y
	mov Start_coord_x, 150						; Устанавливаем стартовую координату фигуры по оси x
	call Check_line								; Вызываем процедуру проверки линии на заполненность квадратиками
	call Random									; Вызываем процедуру генерации новой фигуры
	mov Rotate, 0								; Зануляем флаг поворота
	mov Timer_flag, 0							; Зануляем флаг таймера
	jmp Exit_new_int1ch							; Переходим по адресу Exit_new_int1ch
Figure_1_proc:
	call Figure_1								; Вызываем метод Figure_1 (вывод и обработка 1-й фигуры)
	jmp Editing_figure_position					; Переходим по адресу Editing_figure_position
Figure_2_proc:
	call Figure_2								; Вызываем метод Figure_2 (вывод и обработка 2-й фигуры)
	jmp Editing_figure_position					; Переходим по адресу Editing_figure_position
Figure_3_proc:
	call Figure_3								; Вызываем метод Figure_3 (вывод и обработка 3-й фигуры)
	jmp Editing_figure_position					; Переходим по адресу Editing_figure_position
Figure_4_proc:
	call Figure_4								; Вызываем метод Figure_4 (вывод и обработка 4-й фигуры)
	jmp Editing_figure_position					; Переходим по адресу Editing_figure_position
Figure_5_proc:
	call Figure_5								; Вызываем метод Figure_5 (вывод и обработка 5-й фигуры)
	jmp Editing_figure_position					; Переходим по адресу Editing_figure_position
Figure_6_proc:
	call Figure_6								; Вызываем метод Figure_6 (вывод и обработка 6-й фигуры)
	jmp Editing_figure_position					; Переходим по адресу Editing_figure_position
Figure_7_proc:
	call Figure_7								; Вызываем метод Figure_7 (вывод и обработка 7-й фигуры)
	jmp Editing_figure_position					; Переходим по адресу Editing_figure_position
New_int1ch endp	

Timer_1ch proc
	inc Timer									; Увеличиваем значение ячейки памяти Timer на 1
	mov Timer_flag, 0							; Зануляем флаг таймера
	jmp Speed									; Прыгаем по адресу Speed
End_timer_1ch:		
ret												; Вынимаем из стека регистр ip и передаем ему управление
Speed:
	push dx										; Ложим регистры, с которыми мы будем работать
	push ax										; в метке в стек
	xor dx, dx									; Зануляем регистр dx
	mov ax, Timer								; Ложим значение ячейки памяти Timer в регистр ax
	div Speed_figure							; Делим значение таймера на значение ячейки Speed_figure
	cmp dx, 0									; Если остаток от деления в регистре dx равен 0, то
		je Exit_1_timer_1ch						; прыгаем по метке Exit_1_timer_1ch,
		jmp Exit_0_timer_1ch					; иначе прыгаем по метке Exit_0_timer_1ch
Exit_1_timer_1ch:
	push ax										; Ложим в стек регистр ax
	mov ax, Start_coord_y						; Присваиваем ячейке памяти Old_coord_y значение
	mov Old_coord_y, ax							; переменной Start_coord_y (предыдущий квадратик)
	pop ax										; Забираем из стека регистр ax
	mov Timer, 0								; Зануляем ячейку Timer
	inc Timer_flag								; Увеличиваем значение флага таймера на 1
Exit_0_timer_1ch:	
	pop ax										; Вынимаем из стека регистры,
	pop dx										; с которыми работали в метке
	jmp End_timer_1ch							; Прыгаем по адресу End_timer_1ch
Timer_1ch endp

New_speed proc
	push ax										; Ложим регистр ax в стек, т.к. с ним работаем
	mov al, Down								; Сравниваем, что ввели
	cmp Current_key, al							; в ячейку Current_key, если кнопку Down,
		je Increase_speed						; то переходим по адресу Increase_speed (увеличиваем скорость)
	mov al, Up									; Сравниваем, что ввели
	cmp Current_key, al							; в ячейку Current_key, если кнопку Up,
		je Decrease_speed						; то переходим по адресу Decrease_speed (уменьшаем скорость)
	cmp Current_key, 1							; Сравниваем, что ввели в ячейку Current_key, если не кнопку Esc,
		jne Exit_new_speed						; то переходим по адресу Exit_new_speed, 
	inc Exit_flag								; иначе увеличиваем значение ячейки Exit_flag на 1
Exit_new_speed:
	pop ax										; Вынимаем регистр ax, из стека
ret												; Вынимаем из стека регистр ip и передаем ему управление
Decrease_speed:
	cmp Speed_figure, 32768						; Если Speed_figure равно 32768,
		je Exit_new_speed						; то переходим по адресу Exit_new_speed
	push ax										; Ложим регистр ax в стек
	mov ax, 2									; Присваиваем регистру ax значение 2
	mul Speed_figure							; Умножаем значение ячейки Speed_figure на 2 (увеличиваем скорость движения фигуры в 2 раза)
	xchg ax, Speed_figure						; Меняем местами значение регистра ax и ячейки памяти Speed_figure
	pop ax										; Вынимаем значение из стека в регистр ax
	jmp Exit_new_speed							; Переходим по адресу Exit_new_speed
Increase_speed:	
	cmp Speed_figure, 1							; Если Speed_figure равно 1,
		je Exit_new_speed						; то переходим по адресу Exit_new_speed
	push ax										; Ложим регистр ax в стек
	xor dx, dx									; Зануляем значение регистра dx
	mov ax, 2									; Присваиваем регистру ax значение 2
	xchg ax, Speed_figure						; Меняем местами значение регистра ax и ячейки памяти Speed_figure
	div Speed_figure							; Делим значение регистра ax на 2 (уменьшаем скорость движения фигуры в 2 раза)
	xchg ax, Speed_figure						; Меняем местами значение регистра ax и ячейки памяти Speed_figure
	pop ax										; Вынимаем значение из стека в регистр ax
	jmp Exit_new_speed							; Переходим по адресу Exit_new_speed
New_speed endp

Move_x proc
	push cx										; Ложим регистр cx в стек, т.к. с ним работаем
	push dx										; Ложим регистр dx в стек, т.к. с ним работаем
	push bp										; Ложим регистр bp в стек, т.к. с ним работаем
	push bx										; Ложим регистр bx в стек, т.к. с ним работаем
	push ax										; Ложим регистр ax в стек, т.к. с ним работаем
	xor cx, cx									; Зануляем cx
	xor dx, dx									; Зануляем dx
	xor bx, bx									; Зануляем bx
	xor bp, bp									; Зануляем bp
	mov Third_figure_right, 0					; Зануляем Third_figure_right
	mov Third_figure_left, 0					; Зануляем Third_figure_left
	mov Third_figure_left_up, 0					; Зануляем Third_figure_left_up
	mov Third_figure_right_up, 0				; Зануляем Third_figure_right_up
	mov Forth_figure_left, 0					; Зануляем Forth_figure_left
	mov Forth_figure_right, 0					; Зануляем Forth_figure_righ
	mov Forth_figure_left_up, 0					; Зануляем Forth_figure_left_up
	mov Forth_figure_right_up, 0				; Зануляем Forth_figure_right_up
	mov Fifth_figure_both, 0					; Зануляем Fifth_figure_both
	mov Fifth_figure_right, 0					; Зануляем Fifth_figure_right
	mov Fifth_figure_down, 0					; Зануляем Fifth_figure_down
	mov Fifth_figure_left, 0					; Зануляем Fifth_figure_left
	mov Sixth_figure_both, 0					; Зануляем Sixth_figure_both
	mov Sixth_figure_both_up, 0					; Зануляем Sixth_figure_both_up
	mov Seventh_figure_both, 0					; Зануляем Seventh_figure_both
	mov Seventh_figure_both_up, 0				; Зануляем Seventh_figure_both_up
	cmp Figure_number, 1						; Если работаем с первой фигурой, 
		je Mov_cx_dx_3_5						; то переходим по адресу Mov_cx_dx_3
	cmp Figure_number, 2						; Если работаем со второй фигурой, 
		je Mov_cx_dx_1_5						; то переходим по адресу Mov_cx_dx_1
	cmp Figure_number, 3						; Если работаем с третьей фигурой, 
		je Mov_cx_dx_2_5						; то переходим по адресу Mov_cx_dx_2
	cmp Figure_number, 4						; Если работаем с четвертой фигурой, 
		je Mov_cx_dx_4_5						; то переходим по адресу Mov_cx_dx_4
	cmp Figure_number, 5						; Если работаем с пятой фигурой, 
		je Mov_cx_dx_5_5						; то переходим по адресу Mov_cx_dx_5
	cmp Figure_number, 6						; Если работаем с шестой фигурой, 
		je Mov_cx_dx_6_5						; то переходим по адресу Mov_cx_dx_6
	cmp Figure_number, 7						; Если работаем с седьмой фигурой, 
		je Mov_cx_dx_7_5						; то переходим по адресу Mov_cx_dx_7
Mov_cx_dx_3_5:
	jmp Mov_cx_dx_3
Mov_cx_dx_1_5:
	jmp Mov_cx_dx_1
Mov_cx_dx_2_5:
	jmp Mov_cx_dx_2
Mov_cx_dx_4_5:
	jmp Mov_cx_dx_4
Mov_cx_dx_5_5:
	jmp Mov_cx_dx_5
Mov_cx_dx_6_5:
	jmp Mov_cx_dx_6
Mov_cx_dx_7_5:		
	jmp Mov_cx_dx_7
Again_move_x:
	add Start_coord_x, cx
	mov al, Right								; Сравниваем, что ввели
	cmp Current_key, al							; в ячейку Current_key, если кнопку Right,
		je Move_right_x_1							; то переходим по адресу Move_right_x (передвигаем фигуру вправо)
	mov al, Left								; Сравниваем, что ввели
	cmp Current_key, al							; в ячейку Current_key, если кнопку Up,
		je Move_left_x_1							; то переходим по адресу Move_left_x (передвигаем фигуру влево)
	cmp Current_key, 1							; Сравниваем, что ввели в ячейку Current_key, если не кнопку Esc,
		jne Exit_move_x							; то переходим по адресу Exit_move_x, 
	inc Exit_flag								; иначе увеличиваем значение ячейки Exit_flag на 1
Move_left_x_1:
	jmp Move_left_x
Move_right_x_1:
	jmp Move_right_x
Exit_move_x:
	sub Start_coord_x, cx
	pop ax										; Вынимаем регистр ax, из стека
	pop bx										; Вынимаем регистр bx, из стека
	pop bp										; Вынимаем регистр bp, из стека
	pop dx										; Ложим регистр dx в стек, т.к. с ним работаем
	pop cx										; Вынимаем регистр cx, из стека
ret												; Вынимаем из стека регистр ip и передаем ему управление
Mov_cx_dx_3:
	cmp Figure_rotate, 0						; Смотрим положение нашей фигуры, если оно равно 0, то
		je Mov_cx_dx_3_1						; переходим по адресу Mov_cx_dx_3_1,
		jmp Mov_cx_dx_3_2						; иначе переходим по адресу Mov_cx_dx_3_2
Mov_cx_dx_3_1:
	mov dx, 3200								; Присваиваем регистру dx значение 3200 (количество квадратов сверху)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov bp, 3200								; Присваиваем регистру bp значение 3200 (количество квадратов сверху)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_3_2:
	mov cx, 30									; Присваиваем регистру cx значение 30 (количество квадратов справа)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_1:
	mov cx, 10									; Присваиваем регистру cx значение 10 (количество квадратов справа)
	mov dx, 3200								; Присваиваем регистру dx значение 3200 (количество квадратов сверху)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_2:
	cmp Figure_rotate, 0						; Смотрим положение нашей фигуры, если оно равно 0, то
		je Mov_cx_dx_2_1						; переходим по адресу Mov_cx_dx_2_1,
	cmp Figure_rotate, 2						; иначе, если оно меньше 2, то
		jb Mov_cx_dx_2_2						; переходим по адресу Mov_cx_dx_2_2,
		je Mov_cx_dx_2_3						; если оно равно 2, то переходим по адресу Mov_cx_dx_2_3,
		jmp Mov_cx_dx_2_4						; иначе переходим по адресу Mov_cx_dx_2_4
Mov_cx_dx_2_1:
	mov cx, 20									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov Third_figure_right, 20					; Присваиваем ячейке Third_figure_right значение 20 (количество квадратов не обрабатываемых справа)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_2_2:
	mov cx, 10									; Присваиваем регистру cx значение 10 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3200 (количество квадратов сверху)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov Third_figure_left_up, 10				; Присваиваем ячейке Third_figure_left_up значение 10 (количество квадратов не обрабатываемых слева сверху)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_2_3:
	mov cx, 20									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov Third_figure_left, 20					; Присваиваем ячейке Third_figure_left значение 20 (количество квадратов не обрабатываемых слева)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_2_4:
	mov cx, 10									; Присваиваем регистру cx значение 10 (количество квадратов справа)
	mov dx, 3200								; Присваиваем регистру dx значение 3210 (количество квадратов сверху)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov Third_figure_right_up, 10				; Присваиваем ячейке Third_figure_right_up значение 10 (количество квадратов не обрабатываемых справа сверху)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_4:
	cmp Figure_rotate, 0						; Смотрим положение нашей фигуры, если оно равно 0, то
		je Mov_cx_dx_4_1						; переходим по адресу Mov_cx_dx_4_1,
	cmp Figure_rotate, 2						; иначе, если оно меньше 2, то
		jb Mov_cx_dx_4_2						; переходим по адресу Mov_cx_dx_4_2,
		je Mov_cx_dx_4_3						; если оно равно 2, то переходим по адресу Mov_cx_dx_4_3,
		jmp Mov_cx_dx_4_4						; иначе переходим по адресу Mov_cx_dx_4_4
Mov_cx_dx_4_1:
	mov cx, 20									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov Forth_figure_left, 20					; Присваиваем ячейке Forth_figure_left значение 20 (количество квадратов не обрабатываемых справа)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_4_2:
	mov cx, 10									; Присваиваем регистру cx значение 10 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov Forth_figure_right_up, 10				; Присваиваем ячейке Forth_figure_right_up значение 10 (количество квадратов не обрабатываемых справа)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_4_3:
	mov cx, 20									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov Forth_figure_right, 20					; Присваиваем ячейке Forth_figure_right значение 20 (количество квадратов не обрабатываемых справа)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_4_4:
	mov cx, 10									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov Forth_figure_left_up, 10				; Присваиваем ячейке Forth_figure_left_up значение 20 (количество квадратов не обрабатываемых справа)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_5:
	cmp Figure_rotate, 0						; Смотрим положение нашей фигуры, если оно равно 0, то
		je Mov_cx_dx_5_1						; переходим по адресу Mov_cx_dx_5_1,
	cmp Figure_rotate, 2						; иначе, если оно меньше 2, то
		jb Mov_cx_dx_5_2						; переходим по адресу Mov_cx_dx_5_2,
		je Mov_cx_dx_5_3						; если оно равно 2, то переходим по адресу Mov_cx_dx_5_3,
		jmp Mov_cx_dx_5_4						; иначе переходим по адресу Mov_cx_dx_5_4
Mov_cx_dx_5_1:	
	mov cx, 20									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov Fifth_figure_both, 10					; Присваиваем ячейке Fifth_figure_both значение 10 (количество квадратов не обрабатываемых с обеих сторон)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_5_2:
	mov cx, 10									; Присваиваем регистру cx значение 10 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov Fifth_figure_left, 10					; Присваиваем ячейке Fifth_figure_left значение 10 (количество квадратов не обрабатываемых с обеих сторон)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_5_3:
	mov cx, 20									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov Fifth_figure_down, 10					; Присваиваем ячейке Fifth_figure_down значение 10 (количество квадратов не обрабатываемых с обеих сторон)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_5_4:
	mov cx, 10									; Присваиваем регистру cx значение 10 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov Fifth_figure_right, 10					; Присваиваем ячейке Fifth_figure_right значение 10 (количество квадратов не обрабатываемых с обеих сторон)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_6:
	cmp Figure_rotate, 0						; Смотрим положение нашей фигуры, если оно равно 0, то
		je Mov_cx_dx_6_1						; переходим по адресу Mov_cx_dx_6_1,
		jmp Mov_cx_dx_6_2						; иначе переходим по адресу Mov_cx_dx_6_2
Mov_cx_dx_6_1:
	mov cx, 20									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov Sixth_figure_both, 10					; Присваиваем ячейке Sixth_figure_both значение 10 (количество квадратов не обрабатываемых с обеих сторон)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_6_2:
	mov cx, 10									; Присваиваем регистру cx значение 10 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов сверху)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov Sixth_figure_both_up, 10				; Присваиваем ячейке Sixth_figure_both_up значение 10 (количество квадратов не обрабатываемых с обеих сторон)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_7:
	cmp Figure_rotate, 0						; Смотрим положение нашей фигуры, если оно равно 0, то
		je Mov_cx_dx_7_1						; переходим по адресу Mov_cx_dx_7_1,
		jmp Mov_cx_dx_7_2						; иначе переходим по адресу Mov_cx_dx_7_2
Mov_cx_dx_7_1:
	mov cx, 20									; Присваиваем регистру cx значение 20 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов снизу)
	mov Seventh_figure_both, 10					; Присваиваем ячейке Seventh_figure_both значение 10 (количество квадратов не обрабатываемых с обеих сторон)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Mov_cx_dx_7_2:
	mov cx, 10									; Присваиваем регистру cx значение 10 (количество квадратов справа)
	mov dx, 3520								; Присваиваем регистру dx значение 3520 (количество квадратов снизу)
	mov bx, 3200								; Присваиваем регистру bx значение 3200 (количество квадратов сверху)
	mov Seventh_figure_both_up, 10				; Присваиваем ячейке Seventh_figure_both_up значение 10 (количество квадратов не обрабатываемых с обеих сторон)
	jmp Again_move_x							; Переходим по адресу Again_move_x
Exit_move_x_3:
	jmp Exit_move_x								; Переходим по адресу Exit_move_x
Move_right_x:
	cmp Start_coord_x, 210						; Если Start_coord_x равно 210,
		je Exit_move_x_3						; то переходим по адресу Exit_move_x
	push es										; Ложим регистры,
	push dx										; которые будем использовать
	push si										; при работе с видеопамятью
	push di										; в стек
	mov ax, 0A000h								; Устанавливаем сегмент видеопамяти
	mov es, ax									; в регистр es
	mov di, Start_coord_y						; Присваиваем регистру di координату квадрата по оси y
	mov si, Start_coord_x						; Присваиваем регистру si координату квадрата по оси x
	add si, 10									; Увеличиваем координату по оси x на 10 (ставим каретку на пиксель правее квадратика)
	push ax										; Ложим в стек регистр ax
	mov ax, 320									; Присваиваем регистру ax значение 320
	push dx										; Ложим значение регистра dx в стек, чтобы не изменилось при умножении
	mul di										; Умножаем координату по y на 320, чтобы каретка установилась на первый пиксель в этой строке
	xchg ax, di									; Меняем значения регистров ax и di местами
	pop dx										; Вынимаем значение из стека в регистр dx
	pop ax										; Вынимаем значение из стека в регистр ax
	add di, si									; Прибавляем регистру di значение регистра si (переставляем каретку в нашей строке на следующий за квадратом пиксель)
	push di										; Ложим значение регистра di в стек (текущее положение каретки)
	sub di, Sixth_figure_both					; Пропускаем необрабатываемые квадратики
	sub di, Forth_figure_right					; Пропускаем необрабатываемые квадратики
	sub di, Fifth_figure_down					; Пропускаем необрабатываемые квадратики
	sub di, Fifth_figure_right					; Пропускаем необрабатываемые квадратики
	sub di, Seventh_figure_both_up				; Пропускаем необрабатываемые квадратики
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение не равно 0 (черный цвет) (достигли конца игровой области или другой фигуры),
	pop di										; Вынимаем значение из стека в регистр di (Предыдущее положение каретки)
		jne Stop_right_x						; то переходим по адресу Exit_move_x (сначала по адресу Stop_right_x)
	sub di, dx									; Смотрим квардрат сверху, если он есть
	sub di, Forth_figure_left_up				; Пропускаем необрабатываемые квадратики
	sub di, Third_figure_right_up				; Пропускаем необрабатываемые квадратики
	sub di, Third_figure_right					; Пропускаем необрабатываемые квадратики
	sub di, Fifth_figure_both					; Пропускаем необрабатываемые квадратики
	sub di, Seventh_figure_both					; Пропускаем необрабатываемые квадратики
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение не равно 0 (черный цвет) (достигли конца игровой области или другой фигуры),
		jne Stop_right_x						; то переходим по адресу Exit_move_x (сначала по адресу Stop_right_x)
	sub di, bx									; Смотрим квардрат сверху, если он есть
	sub di, Fifth_figure_right					; Пропускаем необрабатываемые квадратики
	sub di, Sixth_figure_both_up				; Пропускаем необрабатываемые квадратики
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение не равно 0 (черный цвет) (достигли конца игровой области или другой фигуры),
		jne Stop_right_x						; то переходим по адресу Exit_move_x (сначала по адресу Stop_right_x)
	sub di, bp									; Смотрим квардрат сверху, если он есть
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение не равно 0 (черный цвет) (достигли конца игровой области или другой фигуры),
Stop_right_x:	
	pop di										; Вынимаем значения из стека,
	pop si										; обратно в регистры,
	pop dx										; которые использовали
	pop es										; при работе с видеопамятью
		jne Exit_move_x_2						; то переходим по адресу Exit_move_x
	add Start_coord_x, 10						; Увеличиваем координату квадрата по оси x на 10
Exit_move_x_2:
	jmp Exit_move_x								; Переходим по адресу Exit_move_x
Move_left_x:
	push Start_coord_x							; Запоминаем значение ячейки Start_coord_x в стек
	sub Start_coord_x, cx						; Вычитаем из ячейки Start_coord_x значение регистра cx (Переходим в крайнее левое положение)
	push cx										; Ложим в стек значение регистра cx
	mov cx, Seventh_figure_both					; Пропускаем квадратики,
	sub Start_coord_x, cx						; которые надо обработать
	pop cx										; Вынимаем значение из стека в регистр cx
	cmp Start_coord_x, 100						; Если Start_coord_x равно 100,
	pop Start_coord_x							; Вынимаем из стека значение в ячейку Start_coord_x
		je Exit_move_x_2						; то переходим по адресу Exit_move_x
	push Start_coord_x							; Запоминаем значение ячейки Start_coord_x в стек
	push es										; Ложим регистры,
	push dx										; которые будем использовать
	push si										; при работе с видеопамятью
	push di										; в стек
	mov ax, 0A000h								; Устанавливаем сегмент видеопамяти
	mov es, ax									; в регистр es
	sub Start_coord_x, cx						; Вычитаем из ячейки Start_coord_x значение регистра cx (Переходим в крайнее левое положение)
	dec Start_coord_x							; Переходим на крайний левый пиксель фигуры
	mov di, Start_coord_y						; Присваиваем регистру di координату квадрата по оси y
	mov si, Start_coord_x						; Присваиваем регистру si координату квадрата по оси x
	dec si										; Уменьшаем координату по оси x на 1 (ставим каретку на пиксель левее квадратика)
	push ax										; Ложим в стек регистр ax
	mov ax, 320									; Присваиваем регистру ax значение 320
	push dx										; Ложим значение регистра dx в стек, чтобы не изменилось при умножении
	mul di										; Умножаем координату по y на 320, чтобы каретка установилась на первый пиксель в этой строке
	xchg ax, di									; Меняем значения регистров ax и di местами
	pop dx										; Вынимаем значение из стека в регистр dx
	pop ax										; Вынимаем значение из стека в регистр ax
	add di, si									; Прибавляем регистру di значение регистра si (переставляем каретку в нашей строке на идущий перед квадратом пиксель)
	push di										; Ложим в стек значение регистра di
	add di, Forth_figure_right_up				; Пропускаем необрабатываемые квадратики
	add di, Fifth_figure_left					; Пропускаем необрабатываемые квадратики
	add di, Fifth_figure_down					; Пропускаем необрабатываемые квадратики
	add di, Sixth_figure_both_up				; Пропускаем необрабатываемые квадратики
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение не равно 0 (черный цвет) (достигли конца игровой области или другой фигуры),
	pop di										; Вынимаем из стека значение в регистр di
		jne Stop_left_x							; то переходим по адресу Exit_move_x (сначала по адресу Stop_left_x)
	sub di, dx									; Смотрим квардрат сверху, если он есть
	add di, Forth_figure_right_up				; Пропускаем необрабатываемые квадратики
	add di, Third_figure_left_up				; Пропускаем необрабатываемые квадратики
	add di, Forth_figure_left					; Пропускаем необрабатываемые квадратики
	add di, Fifth_figure_both					; Пропускаем необрабатываемые квадратики
	add di, Sixth_figure_both					; Пропускаем необрабатываемые квадратики
	sub di, Seventh_figure_both					; Пропускаем необрабатываемые квадратики
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение не равно 0 (черный цвет) (достигли конца игровой области или другой фигуры),
		jne Stop_left_x							; то переходим по адресу Exit_move_x (сначала по адресу Stop_left_x)
	sub di, bx									; Смотрим квардрат сверху, если он есть
	sub di, Forth_figure_right_up				; Пропускаем необрабатываемые квадратики
	add di, Fifth_figure_left					; Пропускаем необрабатываемые квадратики
	add di, Seventh_figure_both_up				; Пропускаем необрабатываемые квадратики
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение не равно 0 (черный цвет) (достигли конца игровой области или другой фигуры),
		jne Stop_left_x							; то переходим по адресу Exit_move_x (сначала по адресу Stop_left_x)
	sub di, bp									; Смотрим квардрат сверху, если он есть
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение не равно 0 (черный цвет) (достигли конца игровой области или другой фигуры),
Stop_left_x:
	pop di										; Вынимаем значения из стека,
	pop si										; обратно в регистры,
	pop dx										; которые использовали
	pop es										; при работе с видеопамятью
	pop Start_coord_x							; Вынимаем из стека значение в ячейку Start_coord_x
		jne Exit_move_x_1						; то переходим по адресу Exit_move_x
	sub Start_coord_x, 10						; Уменьшаем координату квадрата по оси x на 10
Exit_move_x_1:
	jmp Exit_move_x								; Переходим по адресу Exit_move_x
Move_x endp

Delete_figure proc
	push ax										; Ложим регистры, с которыми мы будем работать
	push di										; в процедуре в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax значение ячейки памяти Start_coord_y (значение координаты угла квадрата по оси y)
	cmp ax, 15									; Если значение в ax меньше, либо равно 15,
		jbe Exit_delete_figure					; то переходим по адресу Exit_delete_figure,
		jmp Not_exit_delete_figure				; иначе переходим по адресу Not_exit_delete_figure
Not_exit_delete_figure:
	mov di, Start_coord_y						; Присваиваем регистру di значение ячейки памяти Start_coord_y (координата верхней левой точки квадрата по оси y)
	sub di, 1									; Вычитаем 1 из регистра di (пиксель на нижней части верхнего квадрата)
	mov Lower_right_y, di 						; Присваиваем значение регистра di ячейке памяти Lower_right_y
	sub di, 9									; Вычитаем 9 из регистра di (пиксель на верхней части верхнего квадрата)
	mov Upper_left_y, di						; Присваиваем значение регистра di ячейке памяти Upper_left_y
	push ax										; Ложим в стек регистр ax
	mov ax, Old_coord_x							; Присваиваем регистру ax значение ячейки Old_coord_x (значение самого левого пикселя квадрата на строке выши по оси x)
	mov Upper_left_x, ax						; Присваиваем значение регистра ax ячейке памяти Upper_left_x
	add ax, 9									; Прибавляем 9 регистру ax (значение самого правого пикселя квадрата на строке выше по оси x)
	mov Lower_right_x, ax						; Присваиваем значение регистра ax ячейке памяти Lower_right_x
	pop ax										; Вынимаем значение из стека в регистр ax
		mov al, Black_color						; Присваиваем регистру al значение регистра Black_color (черный цвет - 0)
		call Rectangle							; Вызываем процедуру рисования примоугольника по координатам
Exit_delete_figure:
	pop di										; Вынимаем из стека регистры,
	pop ax										; с которыми работали в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Delete_figure endp

Check_position proc
	push ax										; Ложим регистры,
	push es										; с которыми
	push dx										; будем работать
	push si										; в процедуре
	push di										; в стек
	mov ax, 0A000h								; Устанавливаем сегмент видеопамяти
	mov es, ax									; в регистр es
	mov di, Start_coord_y						; Присваиваем регистру di координату квадрата по оси y
	add di, 10									; Прибавляем 10 значению в регистре di (устанавливаем каретку на верхнюю точку нижнего квадратика)
	mov si, Start_coord_x						; Присваиваем регистру si координату квадрата по оси x
	push ax										; Ложим в стек регистр ax
	mov ax, 320									; Присваиваем регистру ax значение 320
	mul di										; Умножаем координату по y на 320, чтобы каретка установилась на первый пиксель в этой строке
	xchg ax, di									; Меняем значения регистров ax и di местами
	pop ax										; Вынимаем значение из стека в регистр ax
	add di, si									; Прибавляем регистру di значение регистра si (переставляем каретку в нашей строке на идущий ниже квадрата пиксель)
	mov ax, es:[di] 							; Считываем значение интересующего нас пикселя
	cmp ax, 0									; Если значение равно 0 (черный цвет) (не достигли другого квадратика),
		je Exit_check_position					; то переходим по адресу Exit_check_position
	push ax										; Ложим значения регистров
	push dx										; ax и dx в стек
	mov ax, 320									; Присваиваем регистру ax значение 320
	xchg ax, di									; Меняем значения регистров ax и di местами
	div di										; Делим смещение пикселя в сегменте es на 320, чтобы в ax оказался номер строки (координата y), а в dx - номер столбца (координата x)
	cmp ax, 25									; Если координата по y равна 25 (окончание игровой области),
	pop dx										; Вынимаем из стека значения
	pop ax										; в регистры dx и ax
		je End_game								; то переходим по адресу End_game,
	mov Start_coord_y, 175						; иначе присваиваем ячейке Start_coord_y значение 175
Exit_check_position:	
	pop di										; Вынимаем из стека
	pop si										; значения в
	pop dx										; регистры,
	pop es										; с которыми
	pop ax										; работали в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
End_game:
	inc Exit_flag								; Увеличиваем значение в ячейке памяти Exit_flag на 1 (флажек выхода из игры)
	jmp Exit_check_position						; Переходим по метке Exit_check_position
Check_position endp

Check_line proc
	push ax										; Ложим 
	push bp										; регистры,
	push es										; с 
	push Old_coord_y							; которыми
	push dx										; будем
	push si										; работать
	push di										; в процедуре
	push cx										; в стек
	mov ax, 0A000h								; Устанавливаем сегмент видеопамяти
	mov es, ax									; в регистр es
	mov bp, 4									; Ложим 4 в регистр bp (количество проверяемых строк)
	add Old_coord_y, 10							; Увеличиваем значение в ячейке Old_coord_y на 10 (чтобы в начале вычесть 10)
Check_line_previous:
	sub Old_coord_y, 10							; Вычитаем из ячейки Old_coord_y 10 (переходим на строчку сверху)
	cmp Old_coord_y, 15							; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jl Exit_check_line						; если да, то переходим по адресу Exit_check_line
	mov di, Old_coord_y							; Присваиваем регистру di координату предыдущего квадрата по оси y
	mov si, 105									; Присваиваем регистру si значение 105 (пиксель внутри первого слева квадрата)
	push ax										; Ложим в стек регистр ax
	mov ax, 320									; Присваиваем регистру ax значение 320
	mul di										; Умножаем координату по y на 320, чтобы каретка установилась на первый пиксель в этой строке
	xchg ax, di									; Меняем значения регистров ax и di местами
	pop ax										; Вынимаем значение из стека в регистр ax
	add di, si									; Прибавляем регистру di значение регистра si (переставляем каретку в нашей строке на пиксель внутри квадрата)
	mov cx, 12									; Присваиваем регистру cx значение 12 (количество квадратов в строке)
	Check_line_again:
		mov ax, es:[di] 						; Считываем значение интересующего нас пикселя
		cmp ax, 0								; Если значение равно 0 (черный цвет) (нет квадратика),
			je Exit_check_line					; то переходим по адресу Exit_check_line,
		add di, 10								; иначе прибавляем регистру di 10
	loop Check_line_again						; Зацикливаем метку Check_line_again 12 раз (cx = 12)
		dec bp									; Уменьшаем значение регистра bp на 1 (уменьшаем количество непросмотренных слов)
		jmp Clean_line							; Если строка полностью заполнена квадратами, то переходим по адресу Clean_line
Exit_check_line:
	dec bp										; Уменьшаем значение регистра bp на 1 (уменьшаем количество непросмотренных слов)
	cmp bp, 0									; Если значение в регистре bp больше 0 (есть непроверенные строки),
		jg Check_line_previous					; то переходим по адресу Check_line_previous (проверяем строку повыше)
Exit_check_line_again:
	pop cx										; Вынимаем значения
	pop di										; из стека
	pop si										; в 
	pop dx										; регистры,
	pop Old_coord_y								; c
	pop es										; которыми
	pop bp										; работали
	pop ax										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Clean_line:
	mov di, Old_coord_y							; Присваиваем регистру di координату предыдущего квадрата по оси y
	sub di, 1									; Вычитаем 1 из регистра di (ставим каретку на пиксель выше старого квадрата)
	mov si, 100									; Присваиваем регистру si значение 100 (самое крайнее левое положение игрового поля)
	push ax										; Ложим в стек регистр ax
	mov ax, 320									; Присваиваем регистру ax значение 320
	mul di										; Умножаем координату по y на 320, чтобы каретка установилась на первый пиксель в этой строке
	xchg ax, di									; Меняем значения регистров ax и di местами
	pop ax										; Вынимаем значение из стека в регистр ax
	add di, si									; Прибавляем регистру di значение регистра si (переставляем каретку в на первый пиксель в строке над предыдущим квадратом)
	push Old_coord_y							; Запоминаем старую координату квадратика по y в стек
	sub Old_coord_y, 15							; Вычитаем из ячейки Old_coord_y 15 (считаем количество строк пикселей, которые нужно перерисовать)
	mov cx, Old_coord_y							; Присваиваем регистру cx значение ячейки памяти Old_coord_y
	pop Old_coord_y								; Вынимаем из стека координату квадратика по y в ячейку Old_coord_y
	Copy_area:
		push cx									; Ложим в стек значение регистра cx (количество проходов внешнего цикла)
		mov cx, 120								; Присваиваем регистру cx значение 120 (количество пикселей в игровом поле)
		Copy_line:
			mov ax, es:[di]						; Считываем значение интересующего нас пикселя
			add di, 3200						; Прибавляем 3200 регистру di (переводим каретку на 10 строк ниже (320x10))
			mov es:[di], ax						; Записываем считанное значение пикселя из ax по адресу es:[di] (копируем строки выше)
			sub di, 3199						; Вычитаем 3199 из регистра di (переводим каретку на следующий пиксель, копируемой строки (-320x10 + 1))
		loop Copy_line							; Зацикливаем метку Copy_line 120 раз (cx = 120)
		sub di, 440								; Вычитаем из регистра di 440 (Переводим каретку на следующую строку копируемых пикселей (-320x1 - 120)
Exit_copy_area:
		pop cx									; Вынимаем из стека значение в регистр cx (количество повторов внешнего цикла)
	loop Copy_area								; Зацикливаем метку Copy_area столько раз, сколько лежит в ячейке Old_coord_y (cx = Old_coord_y)
	inc Score									; Увеличиваем значение ячейки Score на 1 (ведем счет)
	add Old_coord_y, 10							; Прибавляем к ячейке Old_coord_y 10 (чтобы вернутся на эту строку)
	jmp Check_line_previous						; Переходим по адресу Check_line_previous (снова проверяем на запоненность линии)	
Check_line endp

Figure_1 proc
	push ax										; Ложим значение регистра ax в стек
	mov al, Turquoise_color						; Присваиваем регситру al (младший байт ax) значение ячейки Turquoise_color (бирюзовый цвет)
	mov Figure_color, al						; Ложим значение регистра al в ячейку Figure_color (присваиваем фигуре цвет)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_figure_1_rotate					; Вызываем метод проверки положения 1-й фигуры
	cmp Figure_rotate, 0						; Если положение первой фигуры равно 0, то
		je Figure_11							; переходим по адресу Figure_11,
		jmp Figure_12							; иначе переходим по адресу Figure_12
Exit_figure_1_1:
	jmp Exit_figure_1							; Переходим по адресу Exit_figure_1
Figure_11:
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	push ax										; Ложим значение регистра ax в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_1						; если да, то переходим по адресу Next_figure_1
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_1						; если да, то переходим по адресу Next_figure_1
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_1						; если да, то переходим по адресу Next_figure_1
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_1:
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop ax										; Вынимаем значение из стека в регистр ax
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
Exit_figure_1_2:
	jmp Exit_figure_1							; Переходим по адресу Exit_figure_1
Figure_12:
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	push Start_coord_x							; Ложим значение ячейки Start_coord_y в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 30							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим в стек значение ячейки Start_coord_x
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем из стека значение в ячейку Start_coord_x
Exit_figure_1:
	pop ax										; Вынимаем значение из стека в регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_1 endp

Check_figure_1_rotate proc
	push es										; Ложим все 
	push ax										; регистры,
	push di										; с которыми
	push si										; будем работать
	push dx										; в процедуре
	push cx										; в
	push bp										; стек
	mov ax, Rotate								; Присваиваем регистру ax значение ячейки Rotate
	mov Old_rotate, ax							; Присваиваем ячейке Old_rotate значение регистра ax (в Old_rotate значение Rotate)
	xor cx, cx									; Зунуляем регистр cx
	xor dx, dx									; Зануляем регистр dx
	xor bp, bp									; Зануляем регистр bp
	mov ax, 0A000h								; Установливаем сегмент
	mov es, ax									; видеопамяти в регистр es
	mov di, Start_coord_y						; Присваиваем начальное положение фигуры по оси y в регистр di
	mov si, Start_coord_x						; Присваиваем начальное положение фигуры по оси x в регистр si
	mov ax, 320									; Присваиваем регистру ax значение 320
	mul di										; Умножаем значение регистра di на 320 (переходим к нужной строке на экране)
	mov di, ax									; Ложим полученное значение в регистр di
	add di, si									; Прибавляем к данному значению значение регистра si (переставляем каретку на интересующий нас пиксель в строке)
	mov si, di									; Присваиваем регистру si значение из регистра di
	cmp Rotate, 0								; Если в ячейке Rotate лежит значение 0, то
		je Figure_11_check						; переходим по адресу Figure_11_check
	cmp Rotate, 1								; Если в ячейке Rotate лежит значение 1, то
		je Figure_12_check						; переходим по адресу Figure_12_check
	cmp Rotate, 2								; Если в ячейке Rotate лежит значение 2, то
		je Figure_11_check						; переходим по адресу Figure_11_check
	cmp Rotate, 3								; Если в ячейке Rotate лежит значение 3, то
		je Figure_12_check						; переходим по адресу Figure_12_check
Exit_check_figure_1_rotate_1:
	jmp Exit_check_figure_1_rotate
Figure_11_check:
	cmp Figure_rotate, 0						; Если значение ячейки Figure_rotate равно 0 (фигура уже в этом положении), то
		je Exit_check_figure_1_rotate_1			; переходим по адресу Exit_check_figure_1_rotate
	mov cx, 4									; Присваиваем регистру cx значение 4 (количество проверок квадратов)
	sub di, 3200								; Вычитаем из регистра di 3200 (переставляем каретку на 1 игровую единицу выше)
	Figure_11_rotate:
		sub di, 3200							; Вычитаем из регистра di 3200 (переставляем каретку на 1 игровую единицу выше)
		mov ax, es:[di]							; Присваиваем значение цвета пикселя по адресу es:[di] в регистр ax
		cmp ax, 0								; Если значение не равно 0 (черный цвет), то
			jne Figure_11_rotate_next			; переходим по адресу Figure_11_rotate_next
		sub di, 3200							; Вычитаем из регистра di 3200 (переставляем каретку на 1 игровую единицу выше)
		mov ax, es:[di]							; Присваиваем значение цвета пикселя по адресу es:[di] в регистр ax
		cmp ax, 0								; Если значение не равно 0 (черный цвет), то
			jne Figure_11_rotate_next			; переходим по адресу Figure_11_rotate_next
		sub di, 3200							; Вычитаем из регистра di 3200 (переставляем каретку на 1 игровую единицу выше)
		mov ax, es:[di]							; Присваиваем значение цвета пикселя по адресу es:[di] в регистр ax
		cmp ax, 0								; Если значение не равно 0 (черный цвет), то
			jne Figure_11_rotate_next			; переходим по адресу Figure_11_rotate_next,
			jmp Figure_11_rotate_yes			; иначе переходим по адресу Figure_11_rotate_yes
		Figure_11_rotate_next:
			add si, 10							; Увеличиваем значение регистра si на 1 игровую единицу (смещаем каретку на 10 пикселей вправо)
			mov di, si							; Присваиваем регистру di значение регистра si
			add Start_coord_x, 10				; Увеличиваем значение ячейки Start_coord_x на 1 игровую единицу (задаем координату фигуры на 10 пикселей правее)
	loop Figure_11_rotate						; Зацикливаем метку Figure_11_rotate 4 раза (cx=4)
	jmp Figure_11_rotate_no						; Переходим по адресу Figure_11_rotate_no	
Figure_12_check:
	cmp Figure_rotate, 1						; Если значение ячейки Figure_rotate равно 1 (фигура уже в этом положении), то
		je Exit_check_figure_1_rotate			; переходим по адресу Exit_check_figure_1_rotate
	mov cx, 3									; Присваиваем регистру cx значение 3 (количество проверок квадратов)
	Figure_12_check_right:
		add di, 10								; Увеличиваем значение регистра di на 1 игровую единицу (перемещаем каретку на 10 пикселей вправо)
		mov ax, es:[di]							; Присваиваем значение цвета пикселя по адресу es:[di] в регистр ax
		cmp ax, 0								; Если значение не равно 0 (черный цвет), то
			jne Figure_12_rotate_left			; переходим по адресу Figure_12_rotate_left,
		inc dx									; Увеличиваем значение регистра dx на 1
	loop Figure_12_check_right					; Зацикливаем метку Figure_12_check_right 3 раза (cx=3)
		jmp Figure_12_rotate_yes				; Переходим по адресу Figure_12_rotate_yes
	Figure_12_rotate_left:
		mov di, si								; Присваиваем значение регистра si регистру di
		mov cx, 3								; Присваиваем регистру cx значение 3 (количество проверок квадратов)
		dec di									; Уменьшаем значение регистра di на 1
		sub cx, dx								; Вычитаем из регистра cx значение регистра dx (определяем количество квадратов, которые еще требуют проверки)
		Figure_12_check_left:	
			mov ax, es:[di]						; Присваиваем значение цвета пикселя по адресу es:[di] в регистр ax
			cmp ax, 0							; Если значение не равно 0 (черный цвет), то
				jne Figure_12_rotate_no_1		; переходим по адресу Figure_12_rotate_no_1
			sub di, 10							; Уменьшаем значение регистра di на 1 игровую единицу (перемещаем каретку на 10 пикселей влево)
			sub Start_coord_x, 10				; Уменьшаем значение ячейки Start_coord_x на 1 игровую единицу (задаем координату фигуры на 10 пикселей левее)
			cmp Start_coord_x, 100				; Если значение ячейки Start_coord_x меньше 100 (Выход за игровую зону), то 
				jb Figure_12_rotate_no_1		; переходим по адресу Figure_12_rotate_no
			sub Old_coord_x, 10					; Вычитаем из ячейки Old_coord_x 1 игровую единицу (премещаем каретку на 10 пикселей левее)
			inc bp								; Увеличиваем значение регистра bp на 1
		loop Figure_12_check_left				; Зацикливаем метку Figure_12_check_left 3-dx раз (cx=3-dx)
		jmp Figure_12_rotate_yes				; Переходим по адресу Figure_12_rotate_yes
Figure_12_rotate_no_1:
	jmp Figure_12_rotate_no
Exit_check_figure_1_rotate:
	pop bp										; Вынимаем из стека
	pop cx										; значение в
	pop dx										; регистры,
	pop si										; с которыми
	pop di										; работали
	pop ax										; в
	pop es										; процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_11_rotate_yes:
	mov Figure_rotate, 0						; Присваиваем ячейке Figure_rotate значение 0 (фигура принимает начальное положение)
	push Old_coord_x							; Ложим в стек значение ячейки Old_coord_x
	call Delete_figure							; Вызываем процедуру Delete_figure
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	mov Old_coord_x, 305						; Присваиваем регистру Old_coord_x значение 305 (так надо)
	jmp Exit_check_figure_1_rotate				; Переходим по адресу Exit_check_figure_1_rotate
Figure_11_rotate_no:
	mov ax, Rotate								; Присваиваем регистру ax значение ячейки Rotate
	mov Old_rotate, ax							; Присваиваем ячейке Old_rotate значение регистра ax (в Old_rotate значение Rotate)
	sub Start_coord_x, 40						; Вычитаем из ячейки Start_coord_x 40 (ставим каретку на 40 пикселей левее)
	jmp Exit_check_figure_1_rotate				; Переходим по адресу Exit_check_figure_1_rotate
Figure_12_rotate_yes:
	mov ax, 10									; Ложим в регистр ax значение 10
	xor dx, dx									; Зануляем старший регистр пары DX:AX
	mul bp										; Умножаем значение регистра bp на значение регистра ax (Перевод координаты в массиве)
	add Old_coord_x, ax							; Прибавляем данное количество пикселей ячейке Old_coord_x (переводим старую каретку в начальное положение)
	mov Figure_rotate, 1						; Присваиваем ячейке Figure_rotate значение 1 (фигура принимает второе положение)
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	call Delete_figure							; Вызываем процедуру Delete_figure
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 1 игровую единицу (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим, меньше ли наше значение, чем 15 (выход за игровую зону), если да, то
		jb Figure_12_rotate_yes_next			; переходим по адресу Figure_12_rotate_yes_next
	call Delete_figure							; Вызываем процедуру Delete_figure
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 1 игровую единицу (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим, меньше ли наше значение, чем 15 (выход за игровую зону), если да, то
		jb Figure_12_rotate_yes_next			; переходим по адресу Figure_12_rotate_yes_next
	call Delete_figure							; Вызываем процедуру Delete_figure
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 1 игровую единицу (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим, меньше ли наше значение, чем 15 (выход за игровую зону), если да, то
		jb Figure_12_rotate_yes_next			; переходим по адресу Figure_12_rotate_yes_next
	call Delete_figure							; Вызываем процедуру Delete_figure
Figure_12_rotate_yes_next:
	pop Start_coord_y							; Вынимаем из стека значение в ячейку Start_coord_y
	sub Old_coord_x, ax							; Вычитаем из ячеки Old_coord_x значение регистра ax (Возвращаем старую каретку в новое положение)
	mov Old_coord_x, 305						; Присваиваем регистру Old_coord_x значение 305 (так надо)
	jmp Exit_check_figure_1_rotate				; Переходим по адресу Exit_check_figure_1_rotate
Figure_12_rotate_no:
	mov ax, Rotate								; Присваиваем регистру ax значение ячейки Rotate
	mov Old_rotate, ax							; Присваиваем ячейке Old_rotate значение регистра ax (в Old_rotate значение Rotate)
	mov ax, 10									; Ложим в регистр ax значение 10
	xor dx, dx									; Зануляем старший регистр пары DX:AX
	mul bp										; Умножаем значение регистра bp на значение регистра ax (Перевод координаты в массиве)
	add Start_coord_x, ax						; Прибавляем данное количество пикселей ячейке Start_coord_x (переводим каретку в начальное положение)
	add Old_coord_x, ax							; Прибавляем данное количество пикселей ячейке Old_coord_x (переводим старую каретку в начальное положение)
	jmp Exit_check_figure_1_rotate				; Переходим по адресу Exit_check_figure_1_rotate
Check_figure_1_rotate endp

Figure_2 proc
	push ax										; Ложим значение регистра ax в стек
	push ax										; Ложим значение регистра ax в стек
	mov al, White_color							; Присваиваем регситру al (младший байт ax) значение ячейки White_color (светло-серый цвет)
	mov Figure_color, al						; Ложим значение регистра al в ячейку Figure_color (присваиваем фигуре цвет)
	pop ax										; Вынимаем значение из стека в регистр ax
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_2						; если да, то переходим по адресу Next_figure_2
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_2:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop ax										; Вынимаем значение из стека в регистр ax
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
Exit_figure_2:	
	pop ax										; Вынимаем значение из стека в регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_2 endp

Figure_3 proc
	push ax										; Ложим значение регистра ax в стек
	push ax										; Ложим значение регистра ax в стек
	mov al, Blue_color							; Присваиваем регситру al (младший байт ax) значение ячейки Blue_color (синий цвет)
	mov Figure_color, al						; Ложим значение регистра al в ячейку Figure_color (присваиваем фигуре цвет)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_figure_3_rotate					; Вызываем метод проверки положения 3-й фигуры
	cmp Figure_rotate, 0						; Если положение третьей фигуры равно 0, то
		je Figure_31							; переходим по адресу Figure_31
	cmp Figure_rotate, 1						; Если положение третьей фигуры равно 1, то
		je Figure_32_1							; переходим по адресу Figure_32
	cmp Figure_rotate, 2						; Если положение третьей фигуры равно 2, то
		je Figure_33_1							; переходим по адресу Figure_33
		jmp Figure_34							; Переходим по адресу Figure_34
Figure_32_1:
	jmp Figure_32
Figure_33_1:
	jmp Figure_33
Figure_31:
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	push ax										; Ложим значение регистра ax в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_31						; если да, то переходим по адресу Next_figure_31
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_31:
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop ax										; Вынимаем значение из стека в регистр ax
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	jmp Exit_figure_3							; Переходим по адресу Exit_figure_3
Figure_32:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Прибавляем к ячейке Start_coord_ 10 (перемещаем каретку на квадратик вверх)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_32						; если да, то переходим по адресу Next_figure_32
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Прибавляем к ячейке Start_coord_ 10 (перемещаем каретку на квадратик вверх)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_32						; если да, то переходим по адресу Next_figure_32
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_32:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	jmp Exit_figure_3							; Переходим по адресу Exit_figure_3
Figure_33:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 20						; Прибавляем к ячейке Start_coord_x 20 (перемещаем каретку на 2 квадратика вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Прибавляем к ячейке Start_coord_ 10 (перемещаем каретку на квадратик вверх)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_33						; если да, то переходим по адресу Next_figure_33
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_x, 10						; Вычитаем из ячейки Start_coord_x 10 (перемещаем каретку на квадратик влево)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_x, 10						; Вычитаем из ячейки Start_coord_x 10 (перемещаем каретку на квадратик влево)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_33:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 20						; Прибавляем к ячейке Start_coord_x 20 (перемещаем каретку на 2 квадратика вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_33						; если да, то переходим по адресу Exit_figure_33
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
Exit_figure_33:
	add Start_coord_y, 10						; Прибавляем к ячейке Start_coord_y 10 (перемещаем каретку на квадратик пониже)
	jmp Exit_figure_3							; Переходим по адресу Exit_figure_3
Figure_34:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Прибавляем к ячейке Start_coord_ 10 (перемещаем каретку на квадратик вверх)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_34						; если да, то переходим по адресу Next_figure_34
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Прибавляем к ячейке Start_coord_ 10 (перемещаем каретку на квадратик вверх)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_34						; если да, то переходим по адресу Next_figure_34
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_34:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	sub Start_coord_y, 20						; Вычитаем из ячейки Start_coord_y 20 (перемещаем каретку на 2 квадратика повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_33						; если да, то переходим по адресу Exit_figure_33
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
Exit_figure_34:
	add Start_coord_y, 20						; Прибавляем к ячейке Start_coord_y 20 (перемещаем каретку на 2 квадратика пониже)
Exit_figure_3:	
	pop ax										; Вынимаем значение из стека в регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_3 endp

Check_figure_3_rotate proc
	push es										; Ложим все 
	push ax										; регистры,
	push di										; с которыми
	push si										; будем работать
	push dx										; в процедуре
	push cx										; в
	push bp										; стек
	mov ax, Rotate								; Присваиваем регистру ax значение ячейки Rotate
	mov Old_rotate, ax							; Присваиваем ячейке Old_rotate значение регистра ax (в Old_rotate значение Rotate)
	xor cx, cx									; Зунуляем регистр cx
	xor dx, dx									; Зануляем регистр dx
	xor bp, bp									; Зануляем регистр bp
	mov ax, 0A000h								; Установливаем сегмент
	mov es, ax									; видеопамяти в регистр es
	mov di, Start_coord_y						; Присваиваем начальное положение фигуры по оси y в регистр di
	mov si, Start_coord_x						; Присваиваем начальное положение фигуры по оси x в регистр si
	mov ax, 320									; Присваиваем регистру ax значение 320
	mul di										; Умножаем значение регистра di на 320 (переходим к нужной строке на экране)
	mov di, ax									; Ложим полученное значение в регистр di
	add di, si									; Прибавляем к данному значению значение регистра si (переставляем каретку на интересующий нас пиксель в строке)
	mov si, di									; Присваиваем регистру si значение из регистра di
	cmp Rotate, 0								; Если в ячейке Rotate лежит значение 0, то
		je Figure_31_check						; переходим по адресу Figure_31_check
	cmp Rotate, 1								; Если в ячейке Rotate лежит значение 1, то
		je Figure_32_check_1					; переходим по адресу Figure_32_check
	cmp Rotate, 2								; 
		je Figure_33_check_1					; переходим по адресу Figure_32_check
		jmp Figure_34_check_1					; Переходим по адресу Figure_32_check
Figure_32_check_1:
	jmp Figure_32_check
Figure_33_check_1:
	jmp Figure_33_check
Figure_34_check_1:
	jmp Figure_34_check
Exit_check_figure_3_rotate_1:
	jmp Exit_check_figure_3_rotate
Figure_31_check:
	cmp Figure_rotate, 0						
		je Exit_check_figure_3_rotate_1			
	mov cx, 2									
	Figure_31_check_right:
		add di, 10								
		mov ax, es:[di]							
		cmp ax, 0								
			jne Figure_31_rotate_left			
		inc dx									
	loop Figure_31_check_right					
		jmp Figure_31_rotate_yes_1			
Figure_31_rotate_yes_1:
	jmp Figure_31_rotate_yes
	Figure_31_rotate_left:
		mov di, si								
		mov cx, 2								
		dec di									
		sub cx, dx								
		Figure_31_check_left:
			sub di, 10							
			mov ax, es:[di]						
			cmp ax, 0							
				jne Figure_31_rotate_no_1		
			sub Start_coord_x, 10				
			cmp Start_coord_x, 100				
				jb Figure_31_rotate_no_1	 
			sub Old_coord_x, 10				 
			inc bp								 
		loop Figure_31_check_left				 
		jmp Figure_31_rotate_yes_1				 
Figure_31_rotate_no_1:
	jmp Figure_31_rotate_no
Figure_32_check:
	cmp Figure_rotate, 1						 
		je Exit_check_figure_3_rotate_1			 
	mov cx, 2									 
	Figure_32_check_right:
		mov ax, es:[di]							 
		cmp ax, 0								 
			jne Figure_32_rotate_left			 
		add di, 10								 
		inc dx									 
	loop Figure_32_check_right					 
	sub di, 1585								 
	mov cx, 2									 
	Figure_32_check_up_right:
		mov ax, es:[di]
		mov dl, Figure_color
		xor dh, dh
		cmp ax, dx
			ja Figure_32_rotate_no_1
		cmp ax, 0
			jne Figure_32_rotate_no_1
		sub di, 3200
	loop Figure_32_check_up_right
	jmp Figure_32_rotate_yes
	Figure_32_rotate_left:
		mov di, si
		mov cx, 2
		dec di
		sub cx, dx
		Figure_32_check_left:
			mov ax, es:[di]
			cmp ax, 0
				jne Figure_32_rotate_no_1
			sub di, 10
			sub Start_coord_x, 10
			cmp Start_coord_x, 100
				jb Figure_32_rotate_no_1
			sub Old_coord_x, 10
			inc bp
		loop Figure_32_check_left
		sub di, 1585
		mov cx, 2
		Figure_32_check_up_left:
			mov ax, es:[di]
			mov dl, Figure_color
			xor dh, dh
			cmp ax, dx
				ja Figure_32_rotate_no_1
			cmp ax, 0
				jne Figure_32_rotate_no_1
			sub di, 3200
		loop Figure_32_check_up_left
		jmp Figure_32_rotate_yes
Figure_32_rotate_no_1:
	jmp Figure_32_rotate_no
Exit_check_figure_3_rotate_2:
	jmp Exit_check_figure_3_rotate
Figure_33_check:
	cmp Figure_rotate, 2
		je Exit_check_figure_3_rotate_2
	sub di, 3200
	add di, 20
	mov cx, 1
	Figure_33_check_right:
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_33_rotate_left
		inc dx
	loop Figure_33_check_right
	add di, 3200
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_33_rotate_no_1
	jmp Figure_33_rotate_yes_5
Figure_33_rotate_yes_5:
	jmp Figure_33_rotate_yes
	Figure_33_rotate_left:
		mov di, si
		sub di, 3200
		mov cx, 1
		dec di
		sub cx, dx
		Figure_33_check_left:
			sub di, 10
			mov ax, es:[di]
			cmp ax, 0
				jne Figure_33_rotate_no_1
			sub Start_coord_x, 10
			sub Old_coord_x, 10
			cmp Start_coord_x, 100
				jb Figure_33_rotate_no_1
			inc bp
		loop Figure_33_check_left
		mov di, si
		add di, 3210
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_33_rotate_no_1
		jmp Figure_33_rotate_yes_5
Figure_33_rotate_no_1:
	jmp Figure_33_rotate_no
Exit_check_figure_3_rotate_3:
	jmp Exit_check_figure_3_rotate	
Figure_34_check:
	cmp Figure_rotate, 3
		je Exit_check_figure_3_rotate_3
	sub di, 3200
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_34_rotate_no_1
	mov di, si
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_34_rotate_no_1
	jmp Figure_34_rotate_yes
Figure_34_rotate_no_1:
	jmp Figure_34_rotate_no
Exit_check_figure_3_rotate:
	pop bp										; Вынимаем из стека
	pop cx										; значение в
	pop dx										; регистры,
	pop si										; с которыми
	pop di										; работали
	pop ax										; в
	pop es										; процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_31_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 2
		jb Figure_31_rotate_yes_2
		je Figure_31_rotate_yes_3
		jmp Figure_31_rotate_yes_4
Figure_31_rotate_yes_2:
	mov Figure_rotate, 0
	push Start_coord_y
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_31_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_31_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_31_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_31_rotate_yes_3:
	mov Figure_rotate, 0
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_31_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_31_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_31_rotate_yes_4:
	mov Figure_rotate, 0
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_31_rotate_yes_4_next
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_31_rotate_yes_4_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_31_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_31_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_3_rotate
Figure_32_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 2
		jb Figure_32_rotate_yes_1
		je Figure_32_rotate_yes_3
		jmp Figure_32_rotate_yes_4
Figure_32_rotate_yes_1:
	mov Figure_rotate, 1
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_32_rotate_yes_1_next
	call Delete_figure
Figure_32_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_32_rotate_yes_3:
	mov Figure_rotate, 1
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_32_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_32_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_32_rotate_yes_4:
	mov Figure_rotate, 1
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_32_rotate_yes_4_next
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_32_rotate_yes_4_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_32_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_32_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_3_rotate
Figure_33_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 1
		jb Figure_33_rotate_yes_1
		je Figure_33_rotate_yes_2
		jmp Figure_33_rotate_yes_4
Figure_33_rotate_yes_1:
	mov Figure_rotate, 2
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_33_rotate_yes_1_next
	call Delete_figure
Figure_33_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_33_rotate_yes_2:
	mov Figure_rotate, 2
	push Start_coord_y
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_33_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_33_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_33_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_33_rotate_yes_4:
	mov Figure_rotate, 2
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_33_rotate_yes_4_next
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_33_rotate_yes_4_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_33_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_33_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_3_rotate
Figure_34_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 1
		jb Figure_34_rotate_yes_1
		je Figure_34_rotate_yes_2
		jmp Figure_34_rotate_yes_3
Figure_34_rotate_yes_1:
	mov Figure_rotate, 3
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_34_rotate_yes_1_next
	call Delete_figure
Figure_34_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_34_rotate_yes_2:
	mov Figure_rotate, 3
	push Start_coord_y
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_34_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_34_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_34_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_34_rotate_yes_3:
	mov Figure_rotate, 3
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_34_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_34_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_3_rotate
Figure_34_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_3_rotate
Check_figure_3_rotate endp

Figure_4 proc
	push ax										; Ложим значение регистра ax в стек
	push ax										; Ложим значение регистра ax в стек
	mov al, Red_color							; Присваиваем регситру al (младший байт ax) значение ячейки Red_color (красный цвет)
	mov Figure_color, al						; Ложим значение регистра al в ячейку Figure_color (присваиваем фигуре цвет)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_figure_4_rotate
	cmp Figure_rotate, 0
		je Figure_41
	cmp Figure_rotate, 1
		je Figure_42_1
	cmp Figure_rotate, 2
		je Figure_43_1
		jmp Figure_44
Figure_42_1:
	jmp Figure_42
Figure_43_1:
	jmp Figure_43
Figure_41:
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	push ax										; Ложим значение регистра ax в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 20						; Прибавляем к ячейке Start_coord_x 20 (перемещаем каретку на 2 квадратика вправо)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_41						; если да, то переходим по адресу Next_figure_41
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_41:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop ax										; Вынимаем значение из стека в регистр ax
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	jmp Exit_figure_4							; 
Figure_42:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_42						; если да, то переходим по адресу Next_figure_42
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_42						; если да, то переходим по адресу Next_figure_42
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_x, 10
	call Delete_figure
	call Square
Next_figure_42:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	sub Start_coord_y, 20						; 
	cmp Start_coord_y, 15						; 
		jb Exit_figure_42_next					; 
	call Check_position							; 
Exit_figure_42_next:
	add Start_coord_y, 20						;
	jmp Exit_figure_4							;
Figure_43:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_43						; если да, то переходим по адресу Next_figure_43
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_43:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_43_next					; если да, то переходим по адресу Next_figure_43_next
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
Exit_figure_43_next:
	add Start_coord_y, 10						; 
	jmp Exit_figure_4							; 
Figure_44:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_x, 10
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_44						; если да, то переходим по адресу Next_figure_44
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_44						; если да, то переходим по адресу Next_figure_44
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_44:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
Exit_figure_4:
	pop ax										; Вынимаем значение из стека в регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_4 endp

Check_figure_4_rotate proc
	push es
	push ax
	push di
	push si
	push dx
	push cx
	push bp
	mov ax, Rotate
	mov Old_rotate, ax
	xor cx, cx
	xor dx, dx
	xor bp, bp
	mov ax, 0A000h
	mov es, ax
	mov di, Start_coord_y
	mov si, Start_coord_x
	mov ax, 320
	mul di
	mov di, ax
	add di, si
	mov si, di
	cmp Rotate, 0
		je Figure_41_check
	cmp Rotate, 1
		je Figure_42_check_1
	cmp Rotate, 2
		je Figure_43_check_1
		jmp Figure_44_check_1
Figure_42_check_1:
	jmp Figure_42_check
Figure_43_check_1:
	jmp Figure_43_check
Figure_44_check_1:
	jmp Figure_44_check
Exit_check_figure_4_rotate_1:
	jmp Exit_check_figure_4_rotate
Figure_41_check:
	cmp Figure_rotate, 0
		je Exit_check_figure_4_rotate_1
	mov cx, 2
	Figure_41_check_right:
		add di, 10
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_41_rotate_left
		inc dx
	loop Figure_41_check_right
	sub di, 3200
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_41_rotate_no_1
		jmp Figure_41_rotate_yes_1
Figure_41_rotate_yes_1:
	jmp Figure_41_rotate_yes
	Figure_41_rotate_left:
		mov di, si
		mov cx, 2
		dec di
		sub cx, dx
		Figure_41_check_left:
			sub di, 10
			mov ax, es:[di]
			cmp ax, 0
				jne Figure_41_rotate_no_1
			sub Start_coord_x, 10
			cmp Start_coord_x, 100
				jb Figure_41_rotate_no_1
			sub Old_coord_x, 10
			inc bp
		loop Figure_41_check_left
		jmp Figure_41_rotate_yes_1
Figure_41_rotate_no_1:
	jmp Figure_41_rotate_no
Figure_42_check:
	cmp Figure_rotate, 1
		je Exit_check_figure_4_rotate_1
	sub di, 6400
	mov cx, 2
	Figure_42_check_right:
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_42_rotate_left
		add di, 10
		inc dx
	loop Figure_42_check_right
	add di, 6390
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_42_rotate_no_1
	sub di, 3200
	jmp Figure_42_rotate_yes
	Figure_42_rotate_left:
		mov di, si
		mov cx, 2
		dec di
		sub di, 6400
		sub cx, dx
		Figure_42_check_left:
			mov ax, es:[di]
			cmp ax, 0
				jne Figure_42_rotate_no_1
			sub di, 10
			sub Start_coord_x, 10
			cmp Start_coord_x, 100
				jb Figure_42_rotate_no_1
			sub Old_coord_x, 10
			inc bp
		loop Figure_42_check_left
		add di, 6420
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_42_rotate_no_1
		jmp Figure_42_rotate_yes
Figure_42_rotate_no_1:
	jmp Figure_42_rotate_no
Exit_check_figure_4_rotate_2:
	jmp Exit_check_figure_4_rotate
Figure_43_check:
	cmp Figure_rotate, 2
		je Exit_check_figure_4_rotate_2
	sub di, 3200
	add di, 20
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_43_rotate_left
	inc dx
	sub di, 20
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_43_rotate_no_1
	add di, 3200
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_43_rotate_no_1
	jmp Figure_43_rotate_yes_5
Figure_43_rotate_yes_5:
	jmp Figure_43_rotate_yes
	Figure_43_rotate_left:
		mov di, si
		sub di, 3200
		mov cx, 1
		dec di
		sub cx, dx
		Figure_43_check_left:
			mov ax, es:[di]
			cmp ax, 0
				jne Figure_43_rotate_no_1
			sub di, 10
			sub Start_coord_x, 10
			sub Old_coord_x, 10
			cmp Start_coord_x, 100
				jb Figure_43_rotate_no_1
			inc bp
		loop Figure_43_check_left
		mov di, si
		add di, 3200
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_43_rotate_no_1
		jmp Figure_43_rotate_yes_5
Figure_43_rotate_no_1:
	jmp Figure_43_rotate_no
Exit_check_figure_4_rotate_3:
	jmp Exit_check_figure_4_rotate	
Figure_44_check:
	cmp Figure_rotate, 3
		je Exit_check_figure_4_rotate_3
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_44_rotate_no_1
	mov di, si
	add di, 10
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_44_rotate_no_1
	jmp Figure_44_rotate_yes
Figure_44_rotate_no_1:
	jmp Figure_44_rotate_no
Exit_check_figure_4_rotate:
	pop bp
	pop cx
	pop dx
	pop si
	pop di
	pop ax
	pop es
ret
Figure_41_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 2
		jb Figure_41_rotate_yes_2
		je Figure_41_rotate_yes_3
		jmp Figure_41_rotate_yes_4
Figure_41_rotate_yes_2:
	mov Figure_rotate, 0
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_41_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_41_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	call Delete_figure
Figure_41_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_41_rotate_yes_3:
	mov Figure_rotate, 0
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_41_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_41_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_41_rotate_yes_4:
	mov Figure_rotate, 0
	push Start_coord_y
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_41_rotate_yes_4_next
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_41_rotate_yes_4_next
	call Delete_figure
Figure_41_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_41_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_4_rotate
Figure_42_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 2
		jb Figure_42_rotate_yes_1
		je Figure_42_rotate_yes_3
		jmp Figure_42_rotate_yes_4
Figure_42_rotate_yes_1:
	mov Figure_rotate, 1
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_42_rotate_yes_1_next
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
Figure_42_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_42_rotate_yes_3:
	mov Figure_rotate, 1
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_42_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_42_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_42_rotate_yes_4:
	mov Figure_rotate, 1
	push Start_coord_y
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_42_rotate_yes_4_next
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_42_rotate_yes_4_next
	call Delete_figure
Figure_42_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_42_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_4_rotate
Figure_43_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 1
		jb Figure_43_rotate_yes_1
		je Figure_43_rotate_yes_2
		jmp Figure_43_rotate_yes_4
Figure_43_rotate_yes_1:
	mov Figure_rotate, 2
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_43_rotate_yes_1_next
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
Figure_43_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_43_rotate_yes_2:
	mov Figure_rotate, 2
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_43_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_43_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	call Delete_figure
Figure_43_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_43_rotate_yes_4:
	mov Figure_rotate, 2
	push Start_coord_y
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_43_rotate_yes_4_next
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_43_rotate_yes_4_next
	call Delete_figure
Figure_43_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_43_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_4_rotate
Figure_44_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 1
		jb Figure_44_rotate_yes_1
		je Figure_44_rotate_yes_2
		jmp Figure_44_rotate_yes_3
Figure_44_rotate_yes_1:
	mov Figure_rotate, 3
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_44_rotate_yes_1_next
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
Figure_44_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_44_rotate_yes_2:
	mov Figure_rotate, 3
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_44_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_44_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	call Delete_figure
Figure_44_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_44_rotate_yes_3:
	mov Figure_rotate, 3
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_44_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_44_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_4_rotate
Figure_44_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_4_rotate
Check_figure_4_rotate endp

Figure_5 proc
	push ax										; Ложим значение регистра ax в стек
	push ax										; Ложим значение регистра ax в стек
	mov al, Pink_color							; Присваиваем регситру al (младший байт ax) значение ячейки Pink_color (розовый цвет)
	mov Figure_color, al						; Ложим значение регистра al в ячейку Figure_color (присваиваем фигуре цвет)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_figure_5_rotate
	cmp Figure_rotate, 0
		je Figure_51
	cmp Figure_rotate, 1
		je Figure_52_1
	cmp Figure_rotate, 2
		je Figure_53_1
		jmp Figure_54
Figure_52_1:
	jmp Figure_52
Figure_53_1:
	jmp Figure_53
Figure_51:
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	push ax										; Ложим значение регистра ax в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_51						; если да, то переходим по адресу Next_figure_51
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_51:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop ax										; Вынимаем значение из стека в регистр ax
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	jmp Exit_figure_5
Figure_52:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_52						; если да, то переходим по адресу Next_figure_52
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_52						; если да, то переходим по адресу Next_figure_52
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_52:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_52_next					; если да, то переходим по адресу Exit_figure_52_next
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
Exit_figure_52_next:
	add Start_coord_y, 10
	jmp Exit_figure_5
Figure_53:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_53						; если да, то переходим по адресу Next_figure_53
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 20						; Прибавляем к ячейке Start_coord_x 20 (перемещаем каретку на 2 квадратика вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_53:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_53_next					; если да, то переходим по адресу Exit_figure_53_next
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 20						; Прибавляем к ячейке Start_coord_x 20 (перемещаем каретку на 2 квадратика вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
Exit_figure_53_next:
	add Start_coord_y, 10
	jmp Exit_figure_5
Figure_54:
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_54						; если да, то переходим по адресу Next_figure_54
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_54						; если да, то переходим по адресу Next_figure_54
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_54:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_54_next					; если да, то переходим по адресу Exit_figure_54_next
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
Exit_figure_54_next:
	add Start_coord_y, 10
Exit_figure_5:	
	pop ax										; Вынимаем значение из стека в регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_5 endp

Check_figure_5_rotate proc
	push es
	push ax
	push di
	push si
	push dx
	push cx
	push bp
	mov ax, Rotate
	mov Old_rotate, ax
	xor cx, cx
	xor dx, dx
	xor bp, bp
	mov ax, 0A000h
	mov es, ax
	mov di, Start_coord_y
	mov si, Start_coord_x
	mov ax, 320
	mul di
	mov di, ax
	add di, si
	mov si, di
	cmp Rotate, 0
		je Figure_51_check
	cmp Rotate, 1
		je Figure_52_check_1
	cmp Rotate, 2
		je Figure_53_check_1
		jmp Figure_54_check_1
Figure_52_check_1:
	jmp Figure_52_check
Figure_53_check_1:
	jmp Figure_53_check
Figure_54_check_1:
	jmp Figure_54_check
Exit_check_figure_5_rotate_1:
	jmp Exit_check_figure_5_rotate
Figure_51_check:
	cmp Figure_rotate, 0
		je Exit_check_figure_5_rotate_1
	mov cx, 2
	Figure_51_check_right:
		add di, 10
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_51_rotate_left
		inc dx
	loop Figure_51_check_right
	sub di, 3190
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_51_rotate_no_1
		jmp Figure_51_rotate_yes_1
Figure_51_rotate_yes_1:
	jmp Figure_51_rotate_yes
	Figure_51_rotate_left:
		mov di, si
		mov cx, 2
		dec di
		sub cx, dx
		Figure_51_check_left:
			sub di, 10
			mov ax, es:[di]
			cmp ax, 0
				jne Figure_51_rotate_no_1
			sub Start_coord_x, 10
			cmp Start_coord_x, 100
				jb Figure_51_rotate_no_1
			sub Old_coord_x, 10
			inc bp
		loop Figure_51_check_left
		sub di, 3190
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_51_rotate_no_1
			jmp Figure_51_rotate_yes_1
Figure_51_rotate_no_1:
	jmp Figure_51_rotate_no
Figure_52_check:
	cmp Figure_rotate, 1
		je Exit_check_figure_5_rotate_1
	add di, 10
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_52_rotate_no_1
		jmp Figure_52_rotate_yes
Figure_52_rotate_no_1:
	jmp Figure_52_rotate_no
Exit_check_figure_5_rotate_2:
	jmp Exit_check_figure_5_rotate
Figure_53_check:
	cmp Figure_rotate, 2
		je Exit_check_figure_5_rotate_2
	sub di, 3200
	add di, 20
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_53_rotate_left
	inc dx
	sub di, 20
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_53_rotate_no_1
	add di, 3210
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_53_rotate_no_1
		jmp Figure_53_rotate_yes_5
Figure_53_rotate_yes_5:
	jmp Figure_53_rotate_yes
	Figure_53_rotate_left:
		mov di, si
		sub di, 3210
		mov cx, 2
		dec di
		sub cx, dx
		Figure_53_check_left:
			mov ax, es:[di]
			cmp ax, 0
				jne Figure_53_rotate_no_1
			sub di, 10
			sub Start_coord_x, 10
			sub Old_coord_x, 10
			cmp Start_coord_x, 100
				jb Figure_53_rotate_no_1
			inc bp
		loop Figure_53_check_left
		mov di, si
		add di, 3210
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_53_rotate_no_1
			jmp Figure_53_rotate_yes_5
Figure_53_rotate_no_1:
	jmp Figure_53_rotate_no
Exit_check_figure_5_rotate_3:
	jmp Exit_check_figure_5_rotate	
Figure_54_check:
	cmp Figure_rotate, 3
		je Exit_check_figure_5_rotate_3
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_54_rotate_no_1
	mov di, si
	sub di, 10
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_54_rotate_no_1
	jmp Figure_54_rotate_yes
Figure_54_rotate_no_1:
	jmp Figure_54_rotate_no
Exit_check_figure_5_rotate:
	pop bp
	pop cx
	pop dx
	pop si
	pop di
	pop ax
	pop es
ret
Figure_51_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 2
		jb Figure_51_rotate_yes_2
		je Figure_51_rotate_yes_3
		jmp Figure_51_rotate_yes_4
Figure_51_rotate_yes_2:
	mov Figure_rotate, 0
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_51_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_51_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_51_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_51_rotate_yes_3:
	mov Figure_rotate, 0
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_51_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_51_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_51_rotate_yes_4:
	mov Figure_rotate, 0
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_51_rotate_yes_4_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_51_rotate_yes_4_next
	call Delete_figure
Figure_51_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_51_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_5_rotate
Figure_52_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 2
		jb Figure_52_rotate_yes_1
		je Figure_52_rotate_yes_3
		jmp Figure_52_rotate_yes_4
Figure_52_rotate_yes_1:
	mov Figure_rotate, 1
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_52_rotate_yes_1_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
Figure_52_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_52_rotate_yes_3:
	mov Figure_rotate, 1
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_52_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_52_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_52_rotate_yes_4:
	mov Figure_rotate, 1
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_52_rotate_yes_4_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_52_rotate_yes_4_next
	call Delete_figure
Figure_52_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_52_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_4_rotate
Figure_53_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 1
		jb Figure_53_rotate_yes_1
		je Figure_53_rotate_yes_2
		jmp Figure_53_rotate_yes_4
Figure_53_rotate_yes_1:
	mov Figure_rotate, 2
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_53_rotate_yes_1_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
Figure_53_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_53_rotate_yes_2:
	mov Figure_rotate, 2
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_53_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_53_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_53_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_53_rotate_yes_4:
	mov Figure_rotate, 2
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_53_rotate_yes_4_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_53_rotate_yes_4_next
	call Delete_figure
Figure_53_rotate_yes_4_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_53_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_5_rotate
Figure_54_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
	cmp Figure_rotate, 1
		jb Figure_54_rotate_yes_1
		je Figure_54_rotate_yes_2
		jmp Figure_54_rotate_yes_3
Figure_54_rotate_yes_1:
	mov Figure_rotate, 3
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	push Old_coord_x
	add Old_coord_x, 20
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_54_rotate_yes_1_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
Figure_54_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_54_rotate_yes_2:
	mov Figure_rotate, 3
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_54_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_54_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_54_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_54_rotate_yes_3:
	mov Figure_rotate, 3
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_54_rotate_yes_3_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_54_rotate_yes_3_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_5_rotate
Figure_54_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_5_rotate
Check_figure_5_rotate endp

Figure_6 proc
	push ax										; Ложим значение регистра ax в стек
	push ax										; Ложим значение регистра ax в стек
	mov al, Green_color							; Присваиваем регситру al (младший байт ax) значение ячейки Green_color (зеленый цвет)
	mov Figure_color, al						; Ложим значение регистра al в ячейку Figure_color (присваиваем фигуре цвет)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_figure_6_rotate
	cmp Figure_rotate, 0
		je Figure_61
		jmp Figure_62
Figure_61:
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	push ax										; Ложим значение регистра ax в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_61						; если да, то переходим по адресу Next_figure_61
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_61:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop ax										; Вынимаем значение из стека в регистр ax
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_61_next					; если да, то переходим по адресу Exit_figure_61_next
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
Exit_figure_61_next:
	add Start_coord_y, 10						; Прибавляем ячейке Start_coord_y 10 (возвращаемся на квадратик ниже)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	jmp Exit_figure_6
Figure_62:
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	add Start_coord_x, 10
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	push ax										; Ложим значение регистра ax в стек
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_62						; если да, то переходим по адресу Next_figure_62
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub Start_coord_x, 10							; Вынимаем значение из стека в ячейку Start_coord_x
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_62						; если да, то переходим по адресу Next_figure_62
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_62:
	pop ax										; Вынимаем значение из стека в регистр ax
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop Start_coord_x
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x	
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_62_next					; если да, то переходим по адресу Exit_figure_62_next
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
Exit_figure_62_next:
	add Start_coord_y, 10						; Прибавляем ячейке Start_coord_y 10 (возвращаемся на квадратик ниже)
Exit_figure_6:	
	pop ax										; Вынимаем значение из стека в регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_6 endp

Check_figure_6_rotate proc
	push es
	push ax
	push di
	push si
	push dx
	push cx
	push bp
	mov ax, Rotate
	mov Old_rotate, ax
	xor cx, cx
	xor dx, dx
	xor bp, bp
	mov ax, 0A000h
	mov es, ax
	mov di, Start_coord_y
	mov si, Start_coord_x
	mov ax, 320
	mul di
	mov di, ax
	add di, si
	mov si, di
	cmp Rotate, 0
		je Figure_61_check
	cmp Rotate, 1
		je Figure_62_check_1
	cmp Rotate, 2
		je Figure_63_check_1
		jmp Figure_64_check_1
Figure_62_check_1:
	jmp Figure_62_check
Figure_63_check_1:
	jmp Figure_61_check
Figure_64_check_1:
	jmp Figure_62_check
Exit_check_figure_6_rotate_1:
	jmp Exit_check_figure_6_rotate
Figure_61_check:
	cmp Figure_rotate, 0
		je Exit_check_figure_6_rotate_1
	add di, 10
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_61_rotate_no_1
	inc dx
	sub di, 3200
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_61_rotate_no_1
		jmp Figure_61_rotate_yes_1
Figure_61_rotate_yes_1:
	jmp Figure_61_rotate_yes
Figure_61_rotate_no_1:
	jmp Figure_61_rotate_no
Figure_62_check:
	cmp Figure_rotate, 1
		je Exit_check_figure_6_rotate_1
	mov cx, 1
	Figure_62_check_right:
		add di, 10
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_62_rotate_left
		inc dx
	loop Figure_62_check_right
	sub di, 3190
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_62_rotate_no_1
		jmp Figure_62_rotate_yes_3
Figure_62_rotate_yes_3:
	jmp Figure_62_rotate_yes
	Figure_62_rotate_left:
		mov di, si
		mov cx, 1
		dec di
		sub cx, dx
		Figure_62_check_left:
			sub di, 10
			mov ax, es:[di]
			cmp ax, 0
				jne Figure_62_rotate_no_1
			sub Start_coord_x, 10
			cmp Start_coord_x, 100
				jb Figure_62_rotate_no_1
			sub Old_coord_x, 10
			inc bp
		loop Figure_62_check_left
		sub di, 3190
		mov ax, es:[di]
		cmp ax, 0
			jne Figure_62_rotate_no_1
			jmp Figure_62_rotate_yes_3
Figure_62_rotate_no_1:
	jmp Figure_62_rotate_no
Exit_check_figure_6_rotate:
	pop bp
	pop cx
	pop dx
	pop si
	pop di
	pop ax
	pop es
ret
Figure_61_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
Figure_61_rotate_yes_2:
	mov Figure_rotate, 0
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_61_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_61_rotate_yes_2_next
	call Delete_figure
Figure_61_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_6_rotate
Figure_61_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_6_rotate
Figure_62_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
Figure_62_rotate_yes_1:
	mov Figure_rotate, 1
	push Start_coord_y
	call Delete_figure	
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_62_rotate_yes_1_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_62_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_6_rotate
Figure_62_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_6_rotate
Check_figure_6_rotate endp

Figure_7 proc
	push ax										; Ложим значение регистра ax в стек
	push ax										; Ложим значение регистра ax в стек
	mov al, Yellow_color						; Присваиваем регситру al (младший байт ax) значение ячейки Yellow_color (желтый цвет)
	mov Figure_color, al						; Ложим значение регистра al в ячейку Figure_color (присваиваем фигуре цвет)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_figure_7_rotate
	cmp Figure_rotate, 0
		je Figure_71
		jmp Figure_72
Figure_71:
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 20							; Прибавляем к ячейке Old_coord_x 20 (перемещаем каретку от старой координаты квадрата на 2 квадратика вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	push ax										; Ложим значение регистра ax в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_71						; если да, то переходим по адресу Next_figure_71
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_71:
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop ax										; Вынимаем значение из стека в регистр ax
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	sub Start_coord_x, 20						; Вычитаем из ячейки Start_coord_x 20 (перемещаем каретку на 2 квадратика влево)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_71_next					; если да, то переходим по адресу Exit_figure_71_next
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
Exit_figure_71_next:
	add Start_coord_y, 10						; Прибавляем ячейке Start_coord_y 10 (возвращаемся на квадратик ниже)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	jmp Exit_figure_7
Figure_72:
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	push Start_coord_y							; Ложим значение ячейки Start_coord_y в стек
	mov ax, Start_coord_y						; Присваиваем регистру ax начальную координату фигурки по оси y (верхняя левая точка нижнего левого квадратика фигуры)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_72						; если да, то переходим по адресу Next_figure_72
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
	sub ax, 10									; Вычитаем из регистра ax 10 (перемещаем каретку на квадратик повыше)
	mov Start_coord_y, ax						; Присваиваем получившееся значение ячейке Start_coord_y
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Next_figure_72						; если да, то переходим по адресу Next_figure_72
	push Old_coord_x							; Ложим значение ячейки Old_coord_x в стек
	add Old_coord_x, 10							; Прибавляем к ячейке Old_coord_x 10 (перемещаем каретку от старой координаты квадрата на квадратик вправо)
	call Delete_figure							; Вызываем процедуру Delete_figure (закрашиваем предыдущее положение квадратика)
	pop Old_coord_x								; Вынимаем значение из стека в ячейку Old_coord_x
	call Square									; Вызываем процедуру Square (процедура рисования нового квадратика)
Next_figure_72:
	pop Start_coord_y							; Вынимаем значение из стека в ячейку Start_coord_y
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
	push ax										; Ложим значение регистра ax в стек
	mov ax, Start_coord_x						; Присваиваем регистру ax значение ячейки Start_coord_x
	mov Old_coord_x, ax							; Присваиваем ячейке Old_coord_x значение регистра ax (сохраняем предыдущую коордниту квадратика, чтобы его закрасить в следующей итерации)
	pop ax										; Вынимаем значение из стека в регистр ax
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
	push Start_coord_x							; Ложим значение ячейки Start_coord_x в стек
	add Start_coord_x, 10						; Прибавляем к ячейке Start_coord_x 10 (перемещаем каретку на квадратик вправо)
	sub Start_coord_y, 10						; Вычитаем из ячейки Start_coord_y 10 (перемещаем каретку на квадратик повыше)
	cmp Start_coord_y, 15						; Смотрим меньше ли наше значение 15 (квадратик за границей игрового поля),
		jb Exit_figure_7_next					; если да, то переходим по адресу Exit_figure_7_next
	call Check_position							; Вызываем прцедуру Check_position (проверка на достижение квадратика других квадратиков или границы игрового поля)
Exit_figure_7_next:
	add Start_coord_y, 10						; Прибавляем ячейке Start_coord_y 10 (возвращаемся на квадратик ниже)
	pop Start_coord_x							; Вынимаем значение из стека в ячейку Start_coord_x
Exit_figure_7:
	pop ax										; Вынимаем значение из стека в регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Figure_7 endp

Check_figure_7_rotate proc
	push es
	push ax
	push di
	push si
	push dx
	push cx
	push bp
	mov ax, Rotate
	mov Old_rotate, ax
	xor cx, cx
	xor dx, dx
	xor bp, bp
	mov ax, 0A000h
	mov es, ax
	mov di, Start_coord_y
	mov si, Start_coord_x
	mov ax, 320
	mul di
	mov di, ax
	add di, si
	mov si, di
	cmp Rotate, 0
		je Figure_71_check
	cmp Rotate, 1
		je Figure_72_check_1
	cmp Rotate, 2
		je Figure_73_check_1
		jmp Figure_74_check_1
Figure_72_check_1:
	jmp Figure_72_check
Figure_73_check_1:
	jmp Figure_71_check
Figure_74_check_1:
	jmp Figure_72_check
Exit_check_figure_7_rotate_1:
	jmp Exit_check_figure_7_rotate
Figure_71_check:
	cmp Figure_rotate, 0
		je Exit_check_figure_7_rotate_1
	add di, 10
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_71_rotate_no_1
	inc dx
	add di, 10
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_71_rotate_no_1
	inc dx
	sub di, 3190
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_71_rotate_no_1
		jmp Figure_71_rotate_yes_1
Figure_71_rotate_yes_1:
	jmp Figure_71_rotate_yes
Figure_71_rotate_no_1:
	jmp Figure_71_rotate_no
Figure_72_check:
	cmp Figure_rotate, 1
		je Exit_check_figure_7_rotate_1
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_72_rotate_no_1
	inc dx
	sub di, 3200
	mov ax, es:[di]
	cmp ax, 0
		jne Figure_72_rotate_no_1
		jmp Figure_72_rotate_yes_3
Figure_72_rotate_yes_3:
	jmp Figure_72_rotate_yes
Figure_72_rotate_no_1:
	jmp Figure_72_rotate_no
Exit_check_figure_7_rotate:
	pop bp
	pop cx
	pop dx
	pop si
	pop di
	pop ax
	pop es
ret
Figure_71_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
Figure_71_rotate_yes_2:
	mov Figure_rotate, 0
	push Start_coord_y
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_71_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
	call Delete_figure
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_71_rotate_yes_2_next
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_71_rotate_yes_2_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_7_rotate
Figure_71_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_7_rotate
Figure_72_rotate_yes:
	mov ax, 10
	xor dx, dx
	mul bp
	add Old_coord_x, ax
Figure_72_rotate_yes_1:
	mov Figure_rotate, 1
	push Start_coord_y
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure	
	add Old_coord_x, 10
	call Delete_figure	
	pop Old_coord_x
	sub Start_coord_y, 10
	cmp Start_coord_y, 15
		jb Figure_72_rotate_yes_1_next
	call Delete_figure
	push Old_coord_x
	add Old_coord_x, 10
	call Delete_figure
	pop Old_coord_x
Figure_72_rotate_yes_1_next:
	pop Start_coord_y
	sub Old_coord_x, ax
	mov Old_coord_x, 305
	jmp Exit_check_figure_7_rotate
Figure_72_rotate_no:
	mov ax, Rotate
	mov Old_rotate, ax
	mov ax, 10
	xor dx, dx
	mul bp
	add Start_coord_x, ax
	add Old_coord_x, ax
	jmp Exit_check_figure_7_rotate
ret
Check_figure_7_rotate endp

Rotate_figure proc
	push ax										; Ложим значение регистра ax в стек
	mov al, Action_1							; Ложим значение ячейки Action_1 (скан-код пробела) в регистр al
	cmp Current_key, al							; Если в Current_key лежит значение al (нажат пробел),
		je Inc_rotate							; то переходим по адресу Inc_rotate
	cmp Current_key, 1							; Сравниваем, что ввели в ячейку Current_key, если не кнопку Esc,
		jne Exit_rotate_figure					; то переходим по адресу Exit_move_x, 
	inc Exit_flag								; иначе увеличиваем значение ячейки Exit_flag на 1
Exit_rotate_figure:
	pop ax										; Вынимаем значение из стека в регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Inc_rotate:
	inc Rotate									; Увеличиваем значение ячейки Rotate на 1
	push ax										; Ложим значение регистра ax в стек
	push dx										; Ложим значение регистра dx в стек
	mov ax, 4									; Ложим в регистр ax значение 4 (количество позиций повтора)
	xchg ax, Rotate								; Меняем местами значение регистра ax и ячейки памяти Rotate
	xor dx, dx									; Зануляем регистр dx (старший регистр пары DX:AX)
	div Rotate									; Делим пару регистров DX:AX на значение ячейки Rotate
	mov Rotate, dx								; Ложим остаток от деления на 4 в ячейку Rotate
	pop dx										; Вынимаем значение из стека в регистр dx
	pop ax										; Вынимаем значение из стека в регистр ax
	jmp Exit_rotate_figure						; Переходим по адресу Exit_rotate_figure
Rotate_figure endp


Clear_background proc
	push ax										; Запоминаем все
	push cx										; регистры, с которыми
	push dx										; мы будем работать в процедурой
	mov al, Background_color					; Задаем цвет фона
	mov Upper_left_x, 0							; Координаты левой верхней точки по x
	mov Upper_left_y, 0							; и по y
	mov Lower_right_x, 319						; Координаты нижней правой точки по x
	mov Lower_right_y, 199						; и по y
	call Rectangle								; Рисуем прямоугольник
	pop dx										; Вынимаем из стека все
	pop cx										; регистры, с которыми
	pop ax										; мы работали в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Clear_background endp

Rectangle proc
	push ax										; Запоминаем все
	push bx										; регистры,с которыми
	push cx										; мы будем работать
	push dx										; в процедуре
	mov ah, 0ch									; Используем 0ch функцию для вывода пикселя
	mov bh, 1									; Задаем номер видеостраницы
	mov cx, Upper_left_x						; Задаем начальную координату по x
	mov dx, Upper_left_y						; Задаем начальную координату по y
	Start_rectangle:
		cmp cx, 319								; Смотрим, вышла ли каретка за пределы экрана,
			ja Inc_y							; если вышла то переходим по адрксу Inc_y
		cmp cx, Lower_right_x					; иначе смотрим, переступила ли каретка крайнее правое положение,
			jbe Fill							; если нет, то переходим по адресу Fill,
		jmp Inc_y								; иначе переходим по адресу Inc_y
	Fill:
		int 10h									; Выполняем 0ch функцию 10h прерывания, для вывода пикселя
		inc cx									; Перемещаем каретку на один пиксель вправо
		jmp Start_rectangle						; Прыгаем по адресу Start_rectangle
	Inc_y:
		inc dx									; Переводим каретку на следующую строку пикселей
		mov cx, Upper_left_x					; и на этой строке в начальное положение
		cmp dx, 199								; Смотрим, вышла ли каретка за пределы экрана,
			ja End_Rectangle					; если да, то переходим по адресу End_rectangle,
		cmp dx, Lower_right_y					; иначе смотрим, переступила ли каретка крайнее нижнее положение,
			jbe Start_rectangle					; если нет, то переходим по адресу Start_rectangle
End_rectangle:		
	pop dx										; Вынимаем из стека
	pop cx										; все регистры, с которыми
	pop bx										; мы работали
	pop ax										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Rectangle endp

Square proc
	push ax										; Запоминаем
	push bx										; регистры,
	push cx										; с которыми
	push dx										; будем работать
	push di										; в процедуре
	push si										; в
	push es										; стек
	mov ax, 0A000h								; Устанавливаем регистр es
	mov es, ax									; на видеопамять
	mov si, Start_coord_x						; Верхняя левая координата квадрата по x
	mov di, Start_coord_y						; Верхняя левая координата квадрата по y
	push ax										; Запоминаем значение регистра ax в стек
	mov ax, 320									; Записываем в ax 320
	mul di										; Умножаем координату фигуры по y на 320
	mov di, ax									; Записываем это значение в регистр di
	pop ax										; Вынимакем из стека значение в регистр di
	add di, si									; Прибавляем к координате по y значение по x
	mov cx, 10									; Высота равна 10
	Print_square_y:
		push cx									; Запоминаем текущее значение счетчика высоты
		mov dx, cx								; Присваиваем это значение регистру dx
		mov cx, 10								; Ширина равна 10
		Print_square_x:
			mov bh, Figure_color				; В bh хранится цвет фигуры
			cmp dx, 1							; Если каретка
			je White_color_square				; находится на верхней,
			cmp dx, 10							; нижней, крайней
			je White_color_square				; правой или крайней
			cmp cx, 1							; левой строках,
			je White_color_square				; то переходим по адресу
			cmp cx, 10							; White_color_square
			je White_color_square				; где bh=15
		Print_square_x_again:
			mov es:[di], bh						; Выводим пиксель
			inc di								; Увеличиваем на 1 номер пикселя
		loop Print_square_x						; Цикл по x
		add di, 310								; переводим каретку на крайнее левое положение на следующей строке
		pop cx									; Вынимае значение счетчика
	loop Print_square_y							; Цикл по y
	pop es										; Вынимаем из
	pop si										; стека все
	pop di										; значения регистров,
	pop dx										; которые мы
	pop cx										; использовали
	pop bx										; в
	pop ax										; процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
White_color_square:
	mov bh, Light_white_color					; Присваиваем регистру bh значение из ячейки памяти Light_white_color
	jmp Print_square_x_again					; Вызвращаемся по адресу Print_square_x_again
Square endp

Circle proc
	push ax										; Ложим в стек
	push bx										; все регистры,
	push cx										; с которыми
	push dx										; будем
	push bp										; работать
	push di										; в
	push si										; процедуре
	mov ah, 0ch									; работаем с функцией 0ch
	push ax										; Ложим регистр ax в стек
	mov ax, Radius_of_circle					; Присваиваем регистру ax
	xor dx, dx									; Зануляем страший регистр пары dx:ax
	mul ax										; Возводим радиус в квадрат R^2
	mov bx, ax									; Присваиваем регистру bx данное значение
	pop ax										; Возвращаем регистр ax из стека
	mov si, Center_of_circle_x					; Присваиваем регистру si значение Center_of_circle_x
	add si, Radius_of_circle					; Увеличиваем его на R (получаем крайнее правое значение по x)
	mov di,Center_of_circle_y					; Присваиваем регистру di значение Center_of_circle_y
	add di, Radius_of_circle					; Увеличиваем его на R (получаем крайнее нижнее значение по y)
	cmp si, 319									; Смотрим, вышло ли наше крайнее правое значение по x за край экрана,
	ja New_circle_x								; если да, то переходим по адресу New_circle_x
	Again_circle:
		cmp di, 199								; Смотрим, вышло ли наше крайнее нижнее значение по y за край экрана,
		ja New_circle_y							; если да, то переходим по адресу New_circle_y
	mov cx, Center_of_circle_x					; Присваиваем регистру cx значение Center_of_circle_x
	sub cx, Radius_of_circle					; Уменьшаем его на R (получаем крайнее левое значение по x)
	mov dx, Center_of_circle_y					; Присваиваем регистру dx значение Center_of_circle_y
	sub dx, Radius_of_circle					; Уменьшаем его на R (получаем крайнее верхнее значение по y)
	cmp cx, 0									; Смотрим, вышло ли наше крайнее левое значение по x за край экрана,
	jl First_circle_x_zero						; если да, то переходим по адресу First_circle_x_zero
	Again_coordinate:
		cmp dx, 0								; Смотрим, вышло ли наше крайнее верхнее значение по y за край экрана,
		jl First_circle_y_zero					; если да, то переходим по адресу First_circle_y_zero
	mov bp, cx									; Присваиваем регистру bp крайнее левое положение каретки
	Circle_draw:
		push dx									; Запоминаем регистры координат
		push cx									; и функции в стек,
		push ax									; чтобы не потерять значения
		push dx									; Ложим dx в стек
		mov ax, cx								; Присваиваем координату рассматриваемой точки регистру ax (X)
		sub ax, Center_of_circle_x				; Вычитаем из нее координату центра окружности по оси x (X-X0)
		xor dx, dx								; Зануляем страший регистр пары dx:ax
		mul ax									; Возводим получившееся значение в квадрат (X-X0)^2
		pop dx									; Вынимаем из стека регистр dx
		push bx									; Запоминаем в стек регистр bx
		mov bx, ax								; Присваиваем регистру bx полученный квадрат
		push dx									; Ложим в стек регистр dx
		mov ax, dx								; Присваиваем координату рассматриваемой точки регистру ax (Y)
		sub ax, Center_of_circle_y				; вычитаем из нее координату центра окружности по оси Y (Y-Y0)
		xor dx, dx								; Зануляем страший регистр пары dx:ax
		mul ax									; Возводим получившееся значение в квадрат (Y-Y0)^2
		pop dx									; Вынимаем из стека регистр dx
		add ax, bx								; Прибавляем к регистру ax значение из регистра bx (X-X0)^2+(Y-Y0)^2
		pop bx									; Вынимаем из стека значение R^2
		cmp ax, bx								; Сравниваем полученную сумму и квадрат радиуса (X-X0)^2+(Y-Y0)^2<=R^2
		jbe Circle_draw_true					; Если наша точка попала внутрь окружности, переходим по адресу Circle_draw_true
			pop ax								; Иначе вынимаем все регистры с координатами,
			pop cx								; функцией
			pop dx								; из стека
			inc cx								; Увеличиваем нашу координату по x на 1
			cmp cx, si							; Смотрим, перешагнула ли точка крайнее правое значение
			ja Inc_circle_y						; Если да, то переходим по адресу Inc_circle_y
			jmp Circle_draw						; Иначе снова выполняем предыдущие действия по аресу Circle_draw
		Circle_draw_true:
			pop ax								; Вынимаем все регистры с координатами,
			pop cx								; функцией
			pop dx								; из стека
			push bx								; Запоминаем наш bx (R^2) в стек
			mov bh, 0							; Устанавливаем 0 видеостраницу
			int 10h								; Выполняем 10h прерывание для вывода точки
			pop bx								; вынимаем наше значение R^2 из стека
			inc cx								; Увеличиваем нашу координату по x на 1
			cmp cx, si							; Смотрим, перешагнула ли точка крайнее правое значение
			ja Inc_circle_y						; Если да, то переходим по адресу Inc_circle_y
			jmp Circle_draw						; Иначе снова выполняем предыдущие действия по аресу Circle_draw
				Inc_circle_y:
					inc dx						; Увеличиваем значение функции по y на 1
					mov cx, bp					; Присваиваем регистру cx крайнее левое значение по оси x
					cmp dx, di					; Смотрим, перешагнула ли точка крайнее нижнее значение
					ja End_circle				; Если да. то переходим по адресу End_circle
					jmp Circle_draw				; Иначе снова выполняем предыдущие действия по аресу Circle_draw
End_circle:
		pop si									; Вынимаем
		pop di									; из стека
		pop bp									; регистры,
		pop dx									; с которыми
		pop cx									; будем
		pop bx									; работать
		pop ax									; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
	New_circle_x:
		mov si, 319								; Крайняя правая граница по x равна 319
		jmp Again_circle						; Переходим по адресу Again_circle
	New_circle_y:
		mov di, 199								; Крайняя нижняя граница по y равна 199
		jmp Again_circle						; Переходим по адресу Again_circle
	First_circle_x_zero:
		xor cx, cx								; Крайняя левая граница по x равна 0
		jmp Again_coordinate					; Переходим по адресу Again_coordinate
	First_circle_y_zero:
		xor dx, dx								; Крайняя верхняя граница по y равна 0
		jmp Again_coordinate					; Переходим по адресу Again_coordinate
Circle endp

Pointer proc
	push ax										; Запоминаем в стек регистр ax
	mov ax, Center_of_pointer_x					; Присваиваем ячейке памяти Center_of_circle_x
	mov Center_of_circle_x, ax					; значение ячейки Center_of_pointer_x
	mov ax, Current_pointer_y					; Прсваиваем ячейке памяти Center_of_circle_y
	mov Center_of_circle_y, ax					; значение ячейки Center_of_pointer_y
	mov ax, Radius_of_pointer					; Присваиваем значение ячйке памяти Radius_of_circle
	mov Radius_of_circle, ax					; значение ячейки Radius_of_pointer
	mov al, Pointer_color						; Задаем цвет указателя
	call Circle									; Рисуем круг
	pop ax										; Вынимаем из стека регистр ax
ret												; Вынимаем из стека регистр ip и передаем ему управление
Pointer endp

Write_score proc
	push ax										; Запоминаем в стек
	push bx										; регистры, с которыми
	push cx										; будем работать
	push dx										; в процедуре
	mov ax, 1300h								; Используем 13h функцию
	mov bh, 0									; Задаем номер видеостраницы
	mov bl, Font_color							; Задаем цвет шрифта
	mov dh, 17									; Задаем номер строки
	mov dl, 102									; Задаем номер столбца
	mov cx, 6									; Присваиваем регистру cx значение 6 (количество выводимых цифр)
	Number_output:
		push cx									; Запоминаем регистр cx в стек
		call Calculate_score					; вызываем процедуру заполнения ячейки памяти Number_of_score
		mov bp, offset Number_of_score			; Запоминаем в регистр bp смещение Number_of_score
		mov cx, 1								; Задаем количество символов в ячейке Number_of_score
		int 10h									; Используем 10h прерывание для вывода текста
		dec dl									; Переводим каретку на предыдущий символ
		pop cx									; Вынимаем значение из стека в регистр cx
	loop Number_output							; Зацикливаем метку Number_output 6 раз (cx = 6)
	pop dx										; Вынимаем значения из стека
	pop cx										; в регистры,
	pop bx										; с которыми работали
	pop ax										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Write_score endp

Calculate_score proc
	push ax										; Запоминаем в стек
	push cx										; регистры, с которыми
	push dx										; будем работать в процедуре
	cmp Score, 9999								; Смотрим, сколько цифр хранится
		ja Five_numbers							; в ячейке Score
	cmp Score, 999								; В зависимости
		ja Four_numbers							; от их количества
	cmp Score, 99								; переходим
		ja Three_numbers						; по
	cmp Score, 9								; нужной
		ja Two_numbers							; нам
		jmp One_number							; метке
Next_calculate_score:
	mov cx, Score								; Присваиваем регистру cx значение ячейки Score
	xor dx, dx									; Зануляем значение старшего регистра пары AX:DX
	xchg ax, cx									; Меняем местами значения регистров ax и cx
	div cx										; Делим значение регистра cx на ax (отделяем первую цифру)
	mov Score, dx								; Присваиваем ячейке Score значение регистра dx (оставшиеся цифры счета)
	mov Number_of_score, al						; присваиваем ячейке Number_of_score значение регистра al (перваяцифра счета)
	add Number_of_score, '0'					; Прибавляем ячейке Number_of_score код Ascii-символа '0' (переводим цифру в её Ascii код)
	pop dx										; Вынимаем из стека
	pop cx										; значения регистров, с которыми
	pop ax										; работали в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Five_numbers:
	mov ax, 10000								; Присваиваем регистру ax значение 10000
	jmp Next_calculate_score					; Переходим по адресу Next_calculate_score
Four_numbers:
	mov ax, 1000								; Присваиваем регистру ax значение 1000
	jmp Next_calculate_score					; Переходим по адресу Next_calculate_score
Three_numbers:
	mov ax, 100									; Присваиваем регистру ax значение 100
	jmp Next_calculate_score					; Переходим по адресу Next_calculate_score
Two_numbers:
	mov ax, 10									; Присваиваем регистру ax значение 10
	jmp Next_calculate_score					; Переходим по адресу Next_calculate_score
One_number:
	mov ax, 1									; Присваиваем регистру ax значение 1
	jmp Next_calculate_score					; Переходим по адресу Next_calculate_score
Calculate_score endp

Random proc 
	push ax 									; Запоминаем в стек регистры,
	push cx 									; с которыми будем
	push dx										; работать в процедуре
	mov ah, 2ch 								; Работаем с 2ch функцией
	int 21h 									; 21h-го прерывания (дать время DOS)
	mov al, dl 									; Прибавляем к регистру al значение регистра dl (сотые доли секунды)
	mov ah, dh 									; Прибавляем к регистру ah значение регистра dh (секунды)
	mov dl, cl 									; Прибавляем к регистру dl (сотые доли секунды) значение регитра cl (минуты)
	mov dh, ch 									; Прибавляем к регистру dh (секунды) значение регитра ch (часы)
	xor ax, dx 									; XOR-им регистр ax относительно регистра dx
	xor dx, dx 									; Зануляем регистр dx
	mov cx, 7 									; Присваиваем регистру cx значение 7 (количество фигур)
	div cx 										; Делим значение пары регистров DX:AX на значение регистра cx
	inc dx 										; Увеличиваем остаток от деления на 1
	mov Figure_number, dx						; Присваиваем ячейке памяти Figure_number значение регитра dx (номер выводимой фигуры)
	pop dx										; Вынимаем из стека
	pop cx 										; значения в регистры,
	pop ax 										; с которыми работали в процедуре
	ret 										; Вынимаем из стека регистр ip и передаем ему управление
Random endp

Menu proc
	push bx										; Запоминаем в стек
	push cx										; все регистры,
	push dx										; с которыми будем работать
	push ax										; в процедуре
	mov bl, Font_color							; Задаем цвет шрифта
	mov bh, 0									; Задаем номер видеостраницы
	mov dh, 18									; Задаем номер строки
	mov dl, 95									; Задаем номер столбца
	mov ax, 1300h								; Используем 13h функцию
	mov bp, offset New_game						; Запоминаем в регистр bp смещение New_game
	mov cx, 8									; Задаем количество символов в слове New game
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Controls						; Запоминаем в регистр bp смещение Controls
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Settings						; Запоминаем в регистр bp смещение Settings
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Credits						; Запоминаем в регистр bp смещение Credits
	mov cx, 7									; Задаем количество символов в слове Credits
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Exit							; Запоминаем в регистр bp смещение Exit
	mov cx, 4									; Задаем количество символов в слове Exit
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	pop ax										; Вынимаем из стека
	pop dx										; все регистры,
	pop cx										; с которыми работали
	pop bx										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Menu endp

Controls_buttons proc
	push bx										; Запоминаем в стек
	push cx										; все регистры,
	push dx										; с которыми будем работать
	push ax										; в процедуре
	mov bl, Font_color							; Задаем цвет шрифта
	mov bh, 0									; Задаем номер видеостраницы
	mov dh, 12									; Задаем номер строки
	mov dl, 95									; Задаем номер столбца
	mov ax, 1300h								; Используем 13h функцию
	mov bp, offset Up_button					; Запоминаем в регистр bp смещение Up_button
	mov cx, 9									; Задаем количество символов в слове Up_button
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Down_button					; Запоминаем в регистр bp смещение Down_button
	mov cx, 11									; Задаем количество символов в слове Down_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Left_button					; Запоминаем в регистр bp смещение Left_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Right_button					; Запоминаем в регистр bp смещение Right_button
	mov cx, 12									; Задаем количество символов в слове Right_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Rotate_button				; Запоминаем в регистр bp смещение Rotate_button
	mov cx, 13									; Задаем количество символов в слове Jump_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Accept_button				; Запоминаем в регистр bp смещение Accept_button
	mov cx, 13									; Задаем количество символов в слове Accept_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Back_button					; Запоминаем в регистр bp смещение Back_button
	mov cx, 4									; Задаем количество символов в слове Back_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	pop ax										; Вынимаем из стека
	pop dx										; все регистры,
	pop cx										; с которыми работали
	pop bx										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Controls_buttons endp

Press_change_button proc
	push bx										; Запоминаем в стек
	push cx										; все регистры,
	push dx										; с которыми будем работать
	push ax										; в процедуре
	mov bl, Font_color							; Задаем цвет шрифта
	mov bh, 0									; Задаем номер видеостраницы
	mov dh, 12									; Задаем номер строки
	mov dl, 92									; Задаем номер столбца
	mov ax, 1300h								; Используем 13h функцию
	mov bp, offset Press_button					; Запоминаем в регистр bp смещение Press_button
	mov cx, 16									; Задаем количество символов в слове Press_button
	int 10h										; Используем 10h прерывание для вывода текста
	pop ax										; Вынимаем из стека
	pop dx										; все регистры,
	pop cx										; с которыми работали
	pop bx										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Press_change_button endp

Press_change_color proc
	push bx										; Запоминаем в стек
	push cx										; все регистры,
	push dx										; с которыми будем работать
	push ax										; в процедуре
	mov bl, Font_color							; Задаем цвет шрифта
	mov bh, 0									; Задаем номер видеостраницы
	mov dh, 4									; Задаем номер строки
	mov dl, 88									; Задаем номер столбца
	mov ax, 1300h								; Используем 13h функцию
	mov bp, offset Black_1						; Запоминаем в регистр bp смещение Black_1
	mov cx, 15									; Задаем количество символов в слове Black_1
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Dark_blue_2					; Запоминаем в регистр bp смещение Dark_blue_2
	mov cx, 19									; Задаем количество символов в слове Dark_blue_2
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Green_3						; Запоминаем в регистр bp смещение Green_3
	mov cx, 15									; Задаем количество символов в слове Green_3
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Turquoise_4					; Запоминаем в регистр bp смещение Turquoise_4
	mov cx, 19									; Задаем количество символов в слове Turquoise_4
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Red_5						; Запоминаем в регистр bp смещение Red_5
	mov cx, 13									; Задаем количество символов в слове Red_5
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Purple_6						; Запоминаем в регистр bp смещение Purple_6
	mov cx, 16									; Задаем количество символов в слове Purple_6
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Brown_7						; Запоминаем в регистр bp смещение Brown_7
	mov cx, 15									; Задаем количество символов в слове Brown_7
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset White_8						; Запоминаем в регистр bp смещение White_8
	mov cx, 15									; Задаем количество символов в слове White_8
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Grey_9						; Запоминаем в регистр bp смещение Grey_9
	mov cx, 14									; Задаем количество символов в слове Grey_9
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Blue_0						; Запоминаем в регистр bp смещение Blue_0
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Light_green_minus			; Запоминаем в регистр bp смещение Light_green_minus
	mov cx, 25									; Задаем количество символов в слове Light_green_minus
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Light_turquoise_plus			; Запоминаем в регистр bp смещение Light_turquoise_plus
	mov cx, 28									; Задаем количество символов в слове Light_turquoise_plus
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Pink_backspase				; Запоминаем в регистр bp смещение Pink_backspase
	mov cx, 22									; Задаем количество символов в слове Pink_backspase
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Light_purple_tab				; Запоминаем в регистр bp смещение Light_purple_tab
	mov cx, 24									; Задаем количество символов в слове Light_purple_tab
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Yellow_q						; Запоминаем в регистр bp смещение Yellow_q
	mov cx, 16									; Задаем количество символов в слове Yellow_q
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Light_white_w				; Запоминаем в регистр bp смещение Light_white_w
	mov cx, 21									; Задаем количество символов в слове Light_white_w
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	pop ax										; Вынимаем из стека
	pop dx										; все регистры,
	pop cx										; с которыми работали
	pop bx										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Press_change_color endp

Settings_buttons proc
	push bx										; Запоминаем в стек
	push cx										; все регистры,
	push dx										; с которыми будем работать
	push ax										; в процедуре
	mov bl, Font_color							; Задаем цвет шрифта
	mov bh, 0									; Задаем номер видеостраницы
	mov dh, 12									; Задаем номер строки
	mov dl, 95									; Задаем номер столбца
	mov ax, 1300h								; Используем 13h функцию
	mov bp, offset Background_button			; Запоминаем в регистр bp смещение Background_button
	mov cx, 16									; Задаем количество символов в слове Background_button
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Font_button					; Запоминаем в регистр bp смещение Font_button
	mov cx, 10									; Задаем количество символов в слове Font_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Pointer_button				; Запоминаем в регистр bp смещение Pointer_button
	mov cx, 13									; Задаем количество символов в слове Pointer_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Back_button					; Запоминаем в регистр bp смещение Back_button
	mov cx, 4									; Задаем количество символов в слове Back_button
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	pop ax										; Вынимаем из стека
	pop dx										; все регистры,
	pop cx										; с которыми работали
	pop bx										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Settings_buttons endp

Credits_list proc
	push bx										; Запоминаем в стек
	push cx										; все регистры,
	push dx										; с которыми будем работать
	push ax										; в процедуре
	mov bl, Font_color							; Задаем цвет шрифта
	mov bh, 0									; Задаем номер видеостраницы
	mov dh, 14									; Задаем номер строки
	mov dl, 0									; Задаем номер столбца
	mov ax, 1300h								; Используем 13h функцию
	mov bp, offset Author						; Запоминаем в регистр bp смещение Author
	mov cx, 40									; Задаем количество символов в слове Author
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Team							; Запоминаем в регистр bp смещение Team
	mov cx, 12									; Задаем количество символов в слове Team
	inc dh										; Переходим на следующую строку
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Lecturer						; Запоминаем в регистр bp смещение Lecturer
	mov cx, 36									; Задаем количество символов в слове Lecturer
	add dh, 2									; Переходим на 2 строки вниз
	int 10h										; Используем 10h прерывание для вывода текста
	mov bp, offset Year							; Запоминаем в регистр bp смещение Year
	mov cx, 4									; Задаем количество символов в слове Year
	add dh, 6									; Переходим на 6 строк вниз
	mov dl, 98									; Стави каретку на 98 столбец (примерно по середине)
	int 10h										; Используем 10h прерывание для вывода текста
	pop ax										; Вынимаем из стека
	pop dx										; все регистры,
	pop cx										; с которыми работали
	pop bx										; в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Credits_list endp

Scan_code proc
	push ax										; Запоминаем в стек регистр, с которым будем работать в процедуре
	mov ah, 00h									; Функция 16h-го прерывания 00h
	int 16h										; для считывания скан-кода (ah)
	mov Current_key, ah							; Скан-код введенной клавиши лежит в bh
	pop ax										; Вынимаем из стека раннее введенные регистры в обратном порядке	
ret												; Вынимаем из стека регистр ip и передаем ему управление
Scan_code endp

Selection proc
	push ax										; Запоминаем все регистры, с которыми будем
	push dx										; работать в процедуре в стек
	Start_selection:
		call Clear_pointer						; Очистка указателя
		call Pointer							; Рисуем указатель
		mov ax, Menu_flag						; Ложжим в регистр ax флажек меню
		add ax, Menu_lines						; Прибавляем к ax количество пунктов в меню
		call Scan_code							; Ожидаем нажатие клавиши
		mov dl, Current_key						; Запоминаем нажатую клавишу в регистр dl
		cmp dl, Down							; Если нажали вниз,
		je Plus									; то переходим по адресу Plus
		cmp dl, Up								; Если нажали вверх,
		je Minus								; то переходим по адресу Minus
		cmp dl, Action_2						; Если был введен Enter,
		je Exit_selection						; то выходим из процедуры,
		jmp Start_selection						; иначе снова повторяем эти действия
	Exit_selection:
		pop dx									; Вынимаем из стека все регистры, с которыми
		pop ax									; работали в процедуре из стека
ret												; Вынимаем из стека регистр ip и передаем ему управление
	Plus:
		push ax									; Ложим ax в стек
		mov ax, Menu_lines						; Присваиваем регистру ax количество пунктов меню
		dec ax									; Уменьшаем на 1
		cmp Menu_flag, ax						; Если флаг установлен на последнем пункте,
		je Pointer_up							; то переходим по адресу Pointer_up
		add Current_pointer_y, 8				; Иначе прибавляем 8
		Pointer_up_continue:
			pop ax								; Вынимаем из стека ax
			inc ax								; Увеличием ax на 1
			xor dx, dx							; Зануляем старший регистр пары ax:dx
			div Menu_lines						; Делим наш ax на количество пунктов в меню
			mov Menu_flag, dx					; и переприсваиваем в ячейку памяти Start_selection остаток от деления
			jmp Start_selection					; И переходим по адресу Start_selection
	Minus:
		cmp Menu_flag, 0						; Если флаг равен 0,
		je Pointer_down							; то переходи по адресу Pointer_down
		sub Current_pointer_y, 8				; Иначе вычитаем 8
		Pointer_down_continue:
			dec ax								; Уменьшаем ax на 1
			xor dx, dx							; Зануляем старший регистр пары ax:dx
			div Menu_lines						; Делим наш ax на количество пунктов в меню
			mov Menu_flag, dx					; и переприсваиваем в ячейку памяти Start_selection остаток от деления
			jmp Start_selection					; И переходим по адресу Start_selection
	Pointer_up:
		push ax									; Ложим в стек ax
		mov ax, Center_of_pointer_y				; Переносим центр указателя
		mov Current_pointer_y, ax				; к первому пункту меню
		pop ax									; Вынимаем ax
		jmp Pointer_up_continue					; Переходим по адресу Pointer_up_continue
	Pointer_down:
		push ax									; Ложим в стек регистры,
		push cx									; с которыми будем работать
		push dx									; в метке
		mov ax, Menu_lines						; Лодим в ax количество пунктов меню
		dec ax									; Уменьшаем ax на 1
		mov cx, 8								; Присваиваем регистру cx значение 8
		xor dx, dx								; Зануляем страший регистр пары dx:ax
		mul cx									; Умножаем ax на cx
		mov cx, Current_pointer_y				; Присваиваем регистру cx текущее положение указателя по y
		add cx, ax								; Прибавляем к данному значению значение из регистра ax
		mov Current_pointer_y, cx				; Ложим получившееся значение в ячейку Current_pointer_y
		pop dx									; Вынимае из стека регистры,
		pop cx									; с которыми работали
		pop ax									; в метке
		jmp Pointer_down_continue				; Переходим по адресу Pointer_down_continue
Selection endp

Change_button proc
	push ax										; Ложим регистр ax в стек
	mov al, Up									; Сравниваем
	cmp Current_key, al							; все
	je Current_key_1							; клавиши,
	mov al, Down								; которые
	cmp Current_key, al							; используются
	je Current_key_1							; в
	mov al, Right								; игре
	cmp Current_key, al							; и
	je Current_key_1							; сравниваем
	mov al, Left								; её
	cmp Current_key, al							; с
	je Current_key_1							; введенной.
	mov al, Action_1							; Если она
	cmp Current_key, al							; не совпала
	je Current_key_1							; ни с одной из них,
	mov al, Action_2							; то в ячейке
	cmp Current_key, al							; Current_key сохраняем её,
	je Current_key_1							; иначе переходим по адресу Current_key_1
	End_change:
		pop ax									; Вынимаем регистр ax из стека
ret												; Вынимаем из стека регистр ip и передаем ему управление
Current_key_1:
	mov Current_key, 1							; Переприсваиваем нашей клавише значение 1
	jmp End_change								; Переходим по адресу End_change
Change_button endp

Change_color proc
	push ax										; Ложим регистр ax в стек
	sub Current_key, 2							; Вычитаем из Current_key 2, чтобы взять номер цвета
	cmp Current_key, 0							; Проверяем, что ввели,
		jl Current_key_color					; если ввели клавишк
	cmp Current_key, 15							; не из списка или цвет которой
		jg Current_key_color					; совпадает с уже используемым,
	mov al, Background_color					; то
	cmp Current_key, al							; переходим
		je Current_key_color					; по адресу
	mov al, Font_color							; Current_key_color,
	cmp Current_key, al							; иначе
		je Current_key_color					; выходим
	mov al, Pointer_color						; изё
	cmp Current_key, al							; процедуры
		je Current_key_color					; с введенным значением
	End_color:
		pop ax									; Вынимаем регистр ax из стека
ret												; Вынимаем из стека регистр ip и передаем ему управление
Current_key_color:
	mov Current_key, 20							; Переприсваиваем нашей клавише значение 20
	jmp End_color								; Переходим по адресу End_change
Change_color endp

Clear_pointer proc
	push ax										; Запоминаем все
	push cx										; регистры, с которыми
	push dx										; мы будем работать в процедурой
	mov ax, Center_of_pointer_x					; Вычисление координат
	sub ax, Radius_of_pointer					; левой верхней точки
	mov Upper_left_x, ax						; по x
	mov ax, Center_of_pointer_y					; Вычисление координат
	sub ax, Radius_of_pointer					; левой верхней точки
	mov Upper_left_y, ax						; по y
	mov ax, Center_of_circle_x					; Вычисление координат
	add ax, Radius_of_pointer					; правой нижней точки
	mov Lower_right_x, ax						; по x
	mov ax, Menu_lines							; Берем количество пунктов
	dec ax										; уменьшаем на единицу
	mov cx, 8									; умножаем на
	xor dx, dx									; 8
	mul cx										; и прибавляем
	add ax, Radius_of_pointer					; радиус
	add ax, Center_of_pointer_y					; и координату по y
	mov Lower_right_y, ax						; Получаем координату правой нижней точки по y
	mov al, Background_color					; Задаем цвет фона
	call Rectangle								; Рисуем прямоугольник
	pop dx										; Вынимаем из стека все
	pop cx										; регистры, с которыми
	pop ax										; мы работали в процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Clear_pointer endp

Print proc
	push ax										; Ложим в
	push bx										; стек
	push cx										; все регистры,
	push dx										; с которыми
	push si										; будем
	push di										; работать
	push es										; в процедуре
	xor si, si									; Зануляем регистр si
	mov ax, 0A000h 								; Установка es
	mov es, ax 									; на видеопамять
	mov ax, 320 								; Устанавливаем каретку
	mul kory									; на первый пиксель
	add ax, korx								; в начале картинки
	mov di, ax									; Ложим начальную позицию каретки в регистр di
	mov di_stop, di								; Ложим в ячейку памяти di_stop значения регистра di (начальное положение каретки)
	mov ax, dlin								; Регистру ax присваиваем длину нашей картинки по x
	add di_stop, ax								; Прибавляем 320 к значению в ячейке di_stop (Перевод каретки на конец картинки по x)
	mov cx, kol_array							; Число элементов в массиве
NumberOfPixels:
	xor ax, ax									; Зануляем регистр ax
	push si										; Запоминаем si в стек
	add si, offset_array						; Присваиваем регистру si смещение нашего массива в сегменте данных
	mov al, ds:[si]								; Присваиваем регистру al 1-й байт из массива картинки
	pop si										; Вынимаем из стека значение в регистр si
	cmp al, 0									; Смотрим, равно ли значение регистра al 0,
		jne printGroup 							; если нет, то переходим по адресу printGroup (надо кучу пикселей одного цвета),
		jmp printOfPixels 						; иначе - по адресу printOfPixels (если группа одиноких пикселей)
PrintBack:
	cmp cx, si									; пока есть элементы в массиве
		jg NumberOfPixels						; выполняем вывод пикселей
	pop es										; Вынимаем из
	pop di										; стека все
	pop si										; регистры,
	pop dx										; с которыми
	pop cx										; работали
	pop bx										; в
	pop ax										; процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Print endp

printGroup proc
	push si										; Запоминаем регистр si в стек
	add si, offset_array						; Прибавляем к si смещение нашего массива
	mov bh, ds:[si+1] 							; В регистр bh задаем цвет нашей группы пикселей
	pop si										; Вынимаем значение из стека в регистр si
	cmp bh, 16									; Если наш цвет черный, то
		je BlackprintGroup						; переходим по адресу BlackprintGroup
print_BlackGroup:
	push cx										; Иначе запоминаем значение cx в стек
	mov cx, ax									; И присваиваем этому регистру значение из регистра ax (количество пикселей с одинаковыми цветами)
printGroup_from_ax:
	cmp bh, 17									; Сравниваем значение регистра bh с 17 (прозрачность)
		je NextprintGroup						; Если оно равно 17, то переходим по адресу NextprintGroup
	mov es:[di], byte ptr bh					; иначе выводим наш пиксель
NextprintGroup:
	inc di										; Увеличиваем значение регистра di на 1 (смещаем каретку вправо)
	cmp di, di_stop								; Смотрим, достигла ли каретка конца картинки по оси x
		je obnov_di								; Если да, то переходим по адресу obnov_di
obnov_di_obrat:
	loop printGroup_from_ax						; Обрабатываем необходимое количество пикселей
	add si, 2									; Увеличиваем si на 2 (следующие элементы массива после количества и цвета первой группы пикселей)
	pop cx										; Вынимаем значение регистра cx (количество оставшихся элементов в исходном массиве)
	jmp PrintBack								; Возвращаемся к проверке на оставшиеся элементы в массиве
BlackprintGroup:
	mov bh, 0									; Ложим в регистр bh код черного цвета
	jmp print_BlackGroup						; Прыгаем по адресу print_BlackGroup
obnov_di:
	add di_stop, 320							; Перводим каретку на строку ниже
	push di_stop								; Запоминаем в стек конечное положение каретки по x
	push ax										; Запоминаем значение из регистра ax в стек
	mov ax, dlin								; Присваиваем регистру ax значение длины по оси x
	sub di_stop, ax								; Вычитаем из получившегося значения эту длину (переводим на начальное положение каретку)
	mov di, di_stop								; Присваиваем регистру di получившееся значение
	pop ax										; Вынимаем значение из стека в регистр ax
	pop di_stop									; Вынимаем из стека конечное положение каретки по x
	cmp ax, 0									; Если работали с одиночными пикселями,
		je obnov_di_obrat2						; то переходим по адресу obnov_di_obrat2 (выводим оставшиеся одиночные пиксели)
		jmp obnov_di_obrat						; иначе выводим оставшиеся одинаковые пиксели, если остались (переходи по адресу obnov_di_obrat)
printGroup endp

printOfPixels proc
	push bx										; Запоминаем значение регистра bx в стек
	xor bx, bx									; Зануляем значение регистра bx
	push si										; Запоминаем значение регистра si в стек
	add si, offset_array						; Прибавляем этому регистру смещение нашего массива в сегменте данных
	mov bl, ds:[si+1] 							; Определяем количество одиноких пикселей с разными цветами
	pop si										; Вынимаем значение из стека в регистр si
	push cx										; Запоминаем значение cx в стек
	mov cx, bx									; Присваиваем этому регистру значение из регистра ax (количество одиноких пикселей с разными цветами цветами)
	add si,2									; Увеличиваем si на 2 (следующие элементы массива после 0 и количества одиноких пикселей)
printPixels_from_bx:
	push si										; Запоминаем значение регистра si в стек 
	add si,offset_array							; Прибавляем этому регистру смещение нашего массива в сегменте данных
	mov bh, ds:[si] 							; Определяем цвет выводимого пикселя
	pop si 										; Вынимаем значение из стека в регистр si
	cmp bh, 16 									; Если цвет пикселя черный, то
		je BlackprintOfPixels					; переходим по адресу BlackprintOfPixels 
	cmp bh, 17									; иначе сравниваем значение регистра bh с 17 (прозрачность)
		je NextprintOfPixels					; если оно равно 17, то переходим по адресу NextprintOfPixels,
print_BlackPixels:
	mov es:[di], byte ptr bh					; иначе выводим текущий пиксель
NextprintOfPixels:
	inc di										; увеличиваем di на 1 (смещаем каретку вправо)
	inc si										; увеличиваем si на 1 (цвет следующего пикселя в массиве)
	cmp di,di_stop								; Смотрим, достигла ли каретка конца картинки по оси x
		je obnov_di								; Если да, то переходим по адресу obnov_di
obnov_di_obrat2:
	loop printPixels_from_bx					; Обрабатываем необходимое количество пикселей
	pop cx										; Вынимаем значение регистра cx (количество оставшихся элементов в исходном массиве)
	pop bx										; Вынимаем значение регистра bx
	jmp PrintBack								; Возвращаемся к проверке на оставшиеся элементы в массиве
BlackprintOfPixels:
	mov bh, 0									; Ложим в регистр bh код черного цвета
	jmp print_BlackPixels						; Прыгаем по адресу print_BlackPixels
printOfPixels endp
code ends

code2 segment
assume cs:code2, ds:Pictures, es:Pictures
Rulez label far
	push ax										; Ложим регистры ax
	push ds										; и ds в стек
	mov ax, Pictures							; Устанавливаем сегмент
	mov ds, ax									; Pictures
	mov korx_1, 0								; Задаем координату начала вывода картинки по x
	mov kory_1, 0								; Задаем координату начала вывода картинки по y
	mov dlin_1, 320								; Задаем длину нашей картинки по x
	mov kol_array_1, 12667						; Задаем длину массив
	mov offset_array_1, offset Rules			; Задаем в ячейку offset_array_1 смещение массива Rules
	call Print_1								; Вызываем метод рисования картинки по массиву
	pop ds										; Вынимаем значения из стека в регистры
	pop ax										; ds и ax
	jmp far ptr Rulez_end						; Прыгаем в другой сегмент по адресу Rulez_end
	
Print_1 proc
	push ax										; Ложим в
	push bx										; стек
	push cx										; все регистры,
	push dx										; с которыми
	push si										; будем
	push di										; работать
	push es										; в процедуре
	xor si, si									; Зануляем регистр si
	mov ax, 0A000h 								; Установка es
	mov es, ax 									; на видеопамять
	mov ax, 320 								; Устанавливаем каретку
	mul kory_1									; на первый пиксель
	add ax, korx_1								; в начале картинки
	mov di, ax									; Ложим начальную позицию каретки в регистр di
	mov di_stop_1, di							; Ложим в ячейку памяти di_stop_1 значения регистра di (начальное положение каретки)
	mov ax, dlin_1								; Регистру ax присваиваем длину нашей картинки по x
	add di_stop_1, ax							; Прибавляем 320 к значению в ячейке di_stop_1 (Перевод каретки на конец картинки по x)
	mov cx, kol_array_1							; Число элементов в массиве
NumberOfPixels_1:
	xor ax, ax									; Зануляем регистр ax
	push si										; Запоминаем si в стек
	add si, offset_array_1						; Присваиваем регистру si смещение нашего массива в сегменте данных
	mov al, ds:[si]								; Присваиваем регистру al 1-й байт из массива картинки
	pop si										; Вынимаем из стека значение в регистр si
	cmp al, 0									; Смотрим, равно ли значение регистра al 0,
		jne printGroup_1 						; если нет, то переходим по адресу printGroup_1 (надо кучу пикселей одного цвета),
		jmp printOfPixels_1 					; иначе - по адресу printOfPixels_1 (если группа одиноких пикселей)
PrintBack_1:
	cmp cx, si									; пока есть элементы в массиве
		jg NumberOfPixels_1						; выполняем вывод пикселей
	pop es										; Вынимаем из
	pop di										; стека все
	pop si										; регистры,
	pop dx										; с которыми
	pop cx										; работали
	pop bx										; в
	pop ax										; процедуре
ret												; Вынимаем из стека регистр ip и передаем ему управление
Print_1 endp

printGroup_1 proc
	push si										; Запоминаем регистр si в стек
	add si, offset_array_1						; Прибавляем к si смещение нашего массива
	mov bh, ds:[si+1] 							; В регистр bh задаем цвет нашей группы пикселей
	pop si										; Вынимаем значение из стека в регистр si
	cmp bh, 16									; Если наш цвет черный, то
		je BlackprintGroup_1					; переходим по адресу BlackprintGroup_1
print_BlackGroup_1:
	push cx										; Иначе запоминаем значение cx в стек
	mov cx, ax									; И присваиваем этому регистру значение из регистра ax (количество пикселей с одинаковыми цветами)
printGroup_from_ax_1:
	cmp bh, 17									; Сравниваем значение регистра bh с 17 (прозрачность)
		je NextprintGroup_1						; Если оно равно 17, то переходим по адресу NextprintGroup_1
	mov es:[di], byte ptr bh					; иначе выводим наш пиксель
NextprintGroup_1:
	inc di										; Увеличиваем значение регистра di на 1 (смещаем каретку вправо)
	cmp di, di_stop_1							; Смотрим, достигла ли каретка конца картинки по оси x
		je obnov_di_1							; Если да, то переходим по адресу obnov_di_1
obnov_di_obrat_1:
	loop printGroup_from_ax_1					; Обрабатываем необходимое количество пикселей
	add si, 2									; Увеличиваем si на 2 (следующие элементы массива после количества и цвета первой группы пикселей)
	pop cx										; Вынимаем значение регистра cx (количество оставшихся элементов в исходном массиве)
	jmp PrintBack_1								; Возвращаемся к проверке на оставшиеся элементы в массиве
BlackprintGroup_1:
	mov bh, 0									; Ложим в регистр bh код черного цвета
	jmp print_BlackGroup_1						; Прыгаем по адресу print_BlackGroup_1
obnov_di_1:
	add di_stop_1, 320							; Перводим каретку на строку ниже
	push di_stop_1								; Запоминаем в стек конечное положение каретки по x
	push ax										; Запоминаем значение из регистра ax в стек
	mov ax, dlin_1								; Присваиваем регистру ax значение длины по оси x
	sub di_stop_1, ax							; Вычитаем из получившегося значения эту длину (переводим на начальное положение каретку)
	mov di, di_stop_1							; Присваиваем регистру di получившееся значение
	pop ax										; Вынимаем значение из стека в регистр ax
	pop di_stop_1								; Вынимаем из стека конечное положение каретки по x
	cmp ax, 0									; Если работали с одиночными пикселями,
		je obnov_di_obrat2_1					; то переходим по адресу obnov_di_obrat2_1 (выводим оставшиеся одиночные пиксели)
		jmp obnov_di_obrat_1					; иначе выводим оставшиеся одинаковые пиксели, если остались (переходи по адресу obnov_di_obrat_1)
printGroup_1 endp

printOfPixels_1 proc
	push bx										; Запоминаем значение регистра bx в стек
	xor bx, bx									; Зануляем значение регистра bx
	push si										; Запоминаем значение регистра si в стек
	add si, offset_array_1						; Прибавляем этому регистру смещение нашего массива в сегменте данных
	mov bl, ds:[si+1] 							; Определяем количество одиноких пикселей с разными цветами
	pop si										; Вынимаем значение из стека в регистр si
	push cx										; Запоминаем значение cx в стек
	mov cx, bx									; Присваиваем этому регистру значение из регистра ax (количество одиноких пикселей с разными цветами цветами)
	add si,2									; Увеличиваем si на 2 (следующие элементы массива после 0 и количества одиноких пикселей)
printPixels_from_bx_1:
	push si										; Запоминаем значение регистра si в стек 
	add si,offset_array_1						; Прибавляем этому регистру смещение нашего массива в сегменте данных
	mov bh, ds:[si] 							; Определяем цвет выводимого пикселя
	pop si 										; Вынимаем значение из стека в регистр si
	cmp bh, 16 									; Если цвет пикселя черный, то
		je BlackprintOfPixels_1					; переходим по адресу BlackprintOfPixels_1 
	cmp bh, 17									; иначе сравниваем значение регистра bh с 17 (прозрачность)
		je NextprintOfPixels_1					; если оно равно 17, то переходим по адресу NextprintOfPixels_1,
print_BlackPixels_1:
	mov es:[di], byte ptr bh					; иначе выводим текущий пиксель
NextprintOfPixels_1:
	inc di										; увеличиваем di на 1 (смещаем каретку вправо)
	inc si										; увеличиваем si на 1 (цвет следующего пикселя в массиве)
	cmp di,di_stop_1							; Смотрим, достигла ли каретка конца картинки по оси x
		je obnov_di_1							; Если да, то переходим по адресу obnov_di_1
obnov_di_obrat2_1:
	loop printPixels_from_bx_1					; Обрабатываем необходимое количество пикселей
	pop cx										; Вынимаем значение регистра cx (количество оставшихся элементов в исходном массиве)
	pop bx										; Вынимаем значение регистра bx
	jmp PrintBack_1								; Возвращаемся к проверке на оставшиеся элементы в массиве
BlackprintOfPixels_1:
	mov bh, 0									; Ложим в регистр bh код черного цвета
	jmp print_BlackPixels_1						; Прыгаем по адресу print_BlackPixels_1
printOfPixels_1 endp
code2 ends

data segment
	Black_color db 0							; Черный цвет
	Dark_blue_color db 1						; Синий цвет
	Green_color db 2							; Зеленый цвет
	Turquoise_color db 3						; Бирюзовый цвет
	Red_color db 4								; Красный цвет
	Purple_color db 5							; Фиолетовый цвет
	Brown_color db 6							; Коричневый цвет
	White_color db 7							; Белый цвет
	Grey_color db 8								; Серый цвет
	Blue_color db 9								; Голубой цвет
	Light_green_color db 10						; Салатовый цвет
	Light_turquoise_color db 11					; Светло-бирюзовый цвет
	Pink_color db 12							; Розовый цвет
	Light_purple_color db 13					; Светло-фиолетовый цвет
	Yellow_color db 14							; Желтый цвет
	Light_white_color db 15						; Светло-белый цвет
	
	Background_color db 0						; Цвет фона (задается в setings) (по умолчанию - черный)
	Font_color db 15							; Цвет шрифта (задается в settings) (по умолчанию - ярко-белый)
	Pointer_color db 14							; Цвет указателя (задается в settings) (по умолчаню - желтый)
	
	Current_key db ?							; Скан-код нажатой клавиши
	Center_of_pointer_x dw ?					; Положение центра
	Center_of_pointer_y dw ?					; указателя и
	Radius_of_pointer dw 3						; его размер
	Current_pointer_y dw ?						; Текущее положение указателя
	
	Up db 17									; Клавиша вверх (по умолчанию - W)
	Down db 31									; Клавиша вниз (по умолчанию - S)
	Right db 32									; Клавиша вправо (по умолчанию - D)
	Left db 30									; Клавиша влево (по умолчанию - A)
	Action_1 db 57								; Клавиша действия (по умолчанию - Space)
	Action_2 db 28								; Клавиша действия (по умолчанию -Enter)
	
	Center_of_circle_x dw ?						; Координаты центра круга по x
	Center_of_circle_y dw ?						; и по y
	Radius_of_circle dw ?						; Радиус круга
	
	Upper_left_x dw ?							; Координаты левой верхней точки прямоугольника по x
	Upper_left_y dw ?							; и по y
	Lower_right_x dw ?							; Координаты нижней правой точки прямоугольника по x
	Lower_right_y dw ?							; и по y
	
	New_game db 'New game'
	Controls db 'Controls'
	Settings db 'Settings'
	Credits db 'Credits'
	Exit db 'Exit'
	
	Up_button db 'Up button'					
	Down_button db 'Down button'				
	Right_button db 'Right button'				
	Left_button db 'Left button'				
	Rotate_button db 'Rotate button'	 
	Accept_button db 'Accept button'
	Press_button db 'Press any button'
	
	Background_button db 'Background color'
	Font_button db 'Font color'
	Pointer_button db 'Pointer color'
	
	Black_1 db '1 - Black color'
	Dark_blue_2 db '2 - Dark blue color'
	Green_3 db '3 - Green color'
	Turquoise_4 db '4 - Turquoise color'
	Red_5 db '5 - Red color'
	Purple_6 db '6 - Purple color'
	Brown_7 db '7 - Brown color'
	White_8 db '8 - White color'
	Grey_9 db '9 - Grey color'
	Blue_0 db '0 - Blue color'
	Light_green_minus db 'Minus - Light green color'
	Light_turquoise_plus db 'Plus - Light turquoise color'
	Pink_backspase db 'Backspace - Pink color'
	Light_purple_tab db 'Tab - Light purple color'
	Yellow_q db 'Q - Yellow color'
	Light_white_w db 'W - Light white color'
	
	Author db ' '
	Lecturer db ' '
	Team db ' '
	Year db ' '
	
	Back_button db 'Back'
	
	Menu_lines dw ?								; Количество пунктов меню (по умолчанию - главного меню)
	Menu_flag dw ?								; Флажек меню
	
	Start_coord_x dw ?							; Начальная координата левой верхней точки фигуры по x
	Old_coord_x dw ?							; Старая начальная координата верхней левой точки фигуры по x
	Start_coord_y dw ?							; Начальная координата левой верхней точки фигуры по y
	Old_coord_y dw ?							; Старая начальная координата верхней левой точки фигуры по y
	Figure_color db ?							; Цвет фигуры
	Figure_number dw ?							; Номер выводимой фигуры (используется для процедуры Random)
	
	Old_int1ch dd ?								; Старый адрес вектора прерывания int_1ch из ТВП (segment:offset)
	
	Timer dw 0									; Таймер для int_1ch
	Speed_figure dw 4 							; Скорость изменение координат (4 примерно 0,25 секунд)
	Timer_flag dw 0								; Флаг таймера (0 - стоим, 1 - идем)
	Exit_flag dw ?								; Флаг выхода (1 - выход, 0 - продолжение игры)
	Score dw ?									; Счёт
	Number_of_score db ?						; Цифра счёта
	Rotate dw ?									; Флаг поворота
	Old_rotate dw ?								; Флаг предыдущего поворота
	
	Figure_rotate dw ?							; Показывает позицию фигуры (0 - начальное положение)
	
	Third_figure_right dw ?						; Количество клеточек 3-й фигуры справа, которые не нужно обрабатывать
	Third_figure_left dw ?						; Количество клеточек 3-й фигуры слева, которые не нужно обрабатывать
	Third_figure_right_up dw ?					; Количество клеточек 3-й фигуры справа сверху, которые не нужно обрабатывать
	Third_figure_left_up dw ?					; Количество клеточек 3-й фигуры слева сверху, которые не нужно обрабатывать
	Forth_figure_left dw ?						; Количество клеточек 4-й фигуры слева, которые не нужно обрабатывать
	Forth_figure_right dw ?						; Количество клеточек 4-й фигуры справа, которые не нужно обрабатывать
	Forth_figure_left_up dw ?					; Количество клеточек 4-й фигуры слева сверху, которые не нужно обрабатывать
	Forth_figure_right_up dw ?					; Количество клеточек 4-й фигуры справа сверху, которые не нужно обрабатывать
	Fifth_figure_both dw ?						; Количество клеточек 5-й фигуры с обоих сторон, которые не нужно обрабатывать
	Fifth_figure_left dw ?						; Количество клеточек 5-й фигуры слева, которые не нужно обрабатывать
	Fifth_figure_down dw ?						; Количество клеточек 5-й фигуры снизу, которые не нужно обрабатывать
	Fifth_figure_right dw ?						; Количество клеточек 5-й фигуры справа, которые не нужно обрабатывать
	Sixth_figure_both dw ?						; Количество клеточек 6-й фигуры с обоих сторон, которые не нужно обрабатывать
	Sixth_figure_both_up dw ?					; Количество клеточек 6-й фигуры с обоих сторон, которые не нужно обрабатывать
	Seventh_figure_both dw ?					; Количество клеточек 7-й фигуры с обоих сторон, которые не нужно обрабатывать
	Seventh_figure_both_up dw ?					; Количество клеточек 7-й фигуры с обоих сторон, которые не нужно обрабатывать
	
	korx dw ?									; Начальная левая верхняя координата рисунка по массиву на оси x
	kory dw ?									; Начальная левая верхняя координата рисунка по массиву на оси x
	dlin dw ?									; Длина картинки по оси x
	di_stop dw ?								; Крайнее правое положение каретки
	kol_array dw ?								; Количество байт в массиве картинки
	offset_array dw ?							; Смещение массива картинки относительно сегмента данных
	
	Menu_picture db 255,17,94,17,60,5,37,17,12,5,21,17,3,5,44,17,7,5,18,17,60,5,58,17,60,5,33,17,18,5,18,17,4,5,43,17,12,5,14,17,60,5,58,17,60,5,33,17,18,5,18,17,4,5,43,17,12,5,14,17,60,5,58,17,3,5,54,14,3,5,28,17,9,5,10,9,5,5,15,17,7,5,40,17,4,5,6,9,8,5,10,17,3,5,54,14,3,5,58,17,3,5,54,14,3,5,28,17,9,5,10,9,5,5,15,17,7,5,40,17,4,5,6,9,8,5,10,17,3,5,54,14,3,5,58,17,3,5,29,14,1,8,24,14,3,5,28,17,9,5,10,9,5,5,13,17,6,5,1,9,3,5,38,17,4,5,11,9,5,5,9,17,3,5,29,14,1,8,24,14,3,5,58,17,3,5,24,14,7,16,1,7,22,14,3,5,26,17,8,5,10,9,7,5,13,17,6,5,3,9,3,5,36,17,4,5,13,9,5,5,8,17,3,5,24,14,7,16,1,7,22,14,3,5,58,17,3,5,17,14
	db 1,8,6,14,9,16,1,7,20,14,3,5,26,17,8,5,10,9,7,5,13,17,6,5,3,9,3,5,36,17,4,5,13,9,5,5,8,17,3,5,17,14,1,8,6,14,9,16,1,7,20,14,3,5,58,17,3,5,16,14,3,16,2,7,1,16,2,8,12,16,1,8,17,14,3,5,25,17,5,5,11,9,10,5,12,17,6,5,4,9,3,5,35,17,4,5,11,9,2,5,3,9,4,5,7,17,3,5,16,14,3,16,2,7,1,16,2,8,12,16,1,8,17,14,3,5,58,17,3,5,16,14,21,16,1,7,16,14,3,5,22,17,5,5,10,9,10,5,2,9,2,5,11,17,3,5,9,9,5,5,30,17,4,5,5,9,3,5,3,9,6,5,3,9,3,5,6,17,3,5,16,14,21,16,1,7,16,14,3,5,58,17,3,5,16,14,22,16,16,14,3,5,22,17,5,5,10,9,10,5,2,9,2,5,11,17,3,5,9,9,5,5,30,17,4,5,5,9,3,5,3,9,6,5,3,9,3,5,6,17
	db 3,5,16,14,22,16,16,14,3,5,58,17,3,5,14,14,1,8,23,16,1,8,15,14,3,5,22,17,5,5,10,9,10,5,2,9,2,5,11,17,3,5,9,9,5,5,30,17,4,5,5,9,3,5,3,9,6,5,3,9,3,5,6,17,3,5,14,14,1,8,23,16,1,8,15,14,3,5,58,17,3,5,12,14,27,16,15,14,3,5,20,17,5,5,10,9,6,5,3,17,3,5,3,9,1,5,10,17,3,5,11,9,4,5,29,17,4,5,6,9,3,5,2,9,4,5,1,14,3,5,2,9,4,5,5,17,3,5,12,14,27,16,15,14,3,5,58,17,3,5,11,14,1,8,29,16,0,2,8,16,11,14,3,5,19,17,5,5,10,9,6,5,4,17,3,5,3,9,2,5,9,17,2,5,9,9,1,5,3,9,4,5,27,17,4,5,6,9,4,5,2,9,3,5,3,14,2,5,2,9,4,5,5,17,3,5,11,14,1,8,29,16,0,2,8,16,11,14,3,5,58,17,3,5,9,14,1,7,34,16
	db 1,8,9,14,3,5,19,17,5,5,10,9,6,5,4,17,3,5,3,9,2,5,9,17,2,5,8,9,3,5,2,9,5,5,25,17,4,5,7,9,5,5,1,9,2,5,4,14,2,5,2,9,4,5,5,17,3,5,9,14,1,7,34,16,1,8,9,14,3,5,58,17,3,5,9,14,37,16,8,14,3,5,19,17,5,5,10,9,6,5,4,17,3,5,3,9,2,5,9,17,2,5,8,9,3,5,2,9,5,5,25,17,4,5,7,9,5,5,1,9,2,5,4,14,2,5,2,9,4,5,5,17,3,5,9,14,37,16,8,14,3,5,58,17,3,5,8,14,36,16,10,14,3,5,18,17,3,5,10,9,5,5,8,17,3,5,3,9,2,5,6,17,4,5,7,9,6,5,4,9,4,5,22,17,3,5,7,9,3,5,1,17,3,5,1,9,3,5,3,14,2,5,1,9,5,5,5,17,3,5,8,14,36,16,10,14,3,5,58,17,3,5,7,14,37,16,10,14,3,5,18,17,3,5,10,9,5,5,8,17
	db 3,5,3,9,2,5,6,17,4,5,7,9,6,5,4,9,4,5,22,17,3,5,7,9,3,5,1,17,3,5,1,9,3,5,3,14,2,5,1,9,5,5,5,17,3,5,7,14,37,16,10,14,3,5,58,17,3,5,7,14,37,16,10,14,3,5,17,17,3,5,10,9,5,5,9,17,3,5,3,9,2,5,6,17,4,5,5,9,5,5,1,17,3,5,4,9,4,5,21,17,2,5,7,9,3,5,3,17,3,5,1,9,6,5,2,9,5,5,5,17,3,5,7,14,37,16,10,14,3,5,58,17,3,5,7,14,24,16,3,14,9,16,11,14,3,5,17,17,3,5,10,9,5,5,9,17,3,5,3,9,2,5,6,17,4,5,5,9,5,5,1,17,3,5,4,9,4,5,21,17,2,5,7,9,3,5,3,17,3,5,1,9,6,5,2,9,5,5,5,17,3,5,7,14,24,16,3,14,9,16,11,14,3,5,58,17,3,5,7,14,23,16,5,14,8,16,11,14,3,5,16,17,3,5,10,9,5,5,10,17
	db 3,5,3,9,2,5,5,17,5,5,4,9,5,5,2,17,4,5,4,9,4,5,19,17,3,5,6,9,4,5,3,17,3,5,1,9,6,5,1,9,5,5,6,17,3,5,7,14,23,16,5,14,8,16,11,14,3,5,58,17,3,5,7,14,18,16,1,7,13,14,5,16,10,14,3,5,16,17,3,5,10,9,5,5,10,17,3,5,3,9,2,5,5,17,4,5,5,9,4,5,4,17,5,5,3,9,4,5,17,17,3,5,6,9,4,5,4,17,4,5,2,9,2,5,3,9,5,5,6,17,3,5,7,14,18,16,1,7,13,14,5,16,10,14,3,5,58,17,3,5,6,14,17,16,17,14,1,8,2,16,11,14,3,5,15,17,3,5,11,9,3,5,12,17,3,5,3,9,2,5,4,17,5,5,4,9,5,5,5,17,5,5,3,9,5,5,15,17,3,5,5,9,4,5,6,17,3,5,7,9,4,5,7,17,3,5,6,14,17,16,17,14,1,8,2,16,11,14,3,5,58,17,3,5,6,14,17,16,18,14
	db 2,16,11,14,3,5,13,17,4,5,10,9,3,5,13,17,3,5,5,9,2,5,3,17,4,5,5,9,4,5,8,17,4,5,3,9,7,5,11,17,3,5,5,9,3,5,9,17,4,5,3,9,5,5,8,17,3,5,6,14,17,16,18,14,2,16,11,14,3,5,58,17,3,5,6,14,17,16,1,8,17,14,2,16,1,7,10,14,3,5,13,17,4,5,10,9,3,5,13,17,3,5,5,9,2,5,3,17,4,5,5,9,4,5,8,17,4,5,3,9,7,5,11,17,3,5,5,9,3,5,9,17,4,5,3,9,5,5,8,17,3,5,6,14,17,16,1,8,17,14,2,16,1,7,10,14,3,5,58,17,3,5,6,14,18,16,17,14,2,16,1,17,10,14,3,5,13,17,4,5,10,9,3,5,13,17,3,5,5,9,2,5,3,17,4,5,5,9,4,5,8,17,4,5,3,9,7,5,11,17,3,5,5,9,3,5,9,17,4,5,3,9,5,5,8,17,3,5,6,14,18,16,17,14,2,16,1,17,10,14
	db 3,5,58,17,3,5,6,14,18,16,17,14,1,7,2,16,10,14,3,5,12,17,4,5,10,9,3,5,13,17,4,5,5,9,2,5,3,17,4,5,4,9,3,5,11,17,4,5,3,9,8,5,8,17,3,5,5,9,4,5,10,17,4,5,1,9,6,5,8,17,3,5,6,14,18,16,17,14,1,7,2,16,10,14,3,5,58,17,3,5,6,14,18,16,7,14,3,16,9,14,1,16,10,14,3,5,12,17,3,5,10,9,4,5,12,17,4,5,6,9,2,5,3,17,4,5,4,9,3,5,12,17,3,5,6,9,7,5,6,17,3,5,4,9,4,5,12,17,9,5,9,17,3,5,6,14,18,16,7,14,3,16,9,14,1,16,10,14,3,5,58,17,3,5,6,14,18,16,6,14,5,16,8,14,1,16,10,14,3,5,11,17,4,5,10,9,4,5,11,17,4,5,7,9,2,5,2,17,3,5,6,9,3,5,13,17,3,5,7,9,6,5,4,17,4,5,3,9,4,5,14,17,7,5,10,17,3,5,6,14
	db 18,16,6,14,5,16,8,14,1,16,10,14,3,5,58,17,3,5,6,14,17,16,1,8,5,14,0,2,8,7,8,14,1,7,4,16,10,14,3,5,11,17,4,5,10,9,4,5,11,17,4,5,7,9,2,5,2,17,3,5,6,9,3,5,13,17,3,5,7,9,6,5,4,17,4,5,3,9,4,5,14,17,7,5,10,17,3,5,6,14,17,16,1,8,5,14,0,2,8,7,8,14,1,7,4,16,10,14,3,5,58,17,3,5,7,14,15,16,17,14,2,16,0,3,8,7,16,10,14,3,5,10,17,3,5,10,9,19,5,9,9,2,5,2,17,3,5,5,9,3,5,14,17,4,5,9,9,4,5,3,17,3,5,3,9,4,5,32,17,3,5,7,14,15,16,17,14,2,16,0,3,8,7,16,10,14,3,5,58,17,3,5,7,14,14,16,1,8,9,14,4,16,4,14,1,16,3,14,1,16,10,14,3,5,10,17,3,5,10,9,19,5,9,9,2,5,2,17,3,5,5,9,3,5,14,17,4,5,9,9
	db 4,5,3,17,3,5,3,9,4,5,32,17,3,5,7,14,14,16,1,8,9,14,4,16,4,14,1,16,3,14,1,16,10,14,3,5,58,17,3,5,7,14,14,16,9,14,1,16,2,14,3,16,1,8,2,14,5,16,10,14,3,5,9,17,4,5,10,9,3,5,3,9,11,5,11,9,2,5,2,17,3,5,5,9,3,5,14,17,4,5,8,9,4,5,3,17,3,5,4,9,3,5,33,17,3,5,7,14,14,16,9,14,1,16,2,14,3,16,1,8,2,14,5,16,10,14,3,5,58,17,3,5,7,14,4,16,3,14,7,16,11,14,1,7,2,16,4,14,2,16,1,7,2,16,10,14,3,5,8,17,4,5,10,9,4,5,25,9,2,5,2,17,3,5,6,9,3,5,13,17,4,5,7,9,4,5,4,17,3,5,4,9,2,5,34,17,3,5,7,14,4,16,3,14,7,16,11,14,1,7,2,16,4,14,2,16,1,7,2,16,10,14,3,5,58,17,3,5,7,14,3,16,1,14,10,16,21,14,0,2
	db 8,7,10,14,3,5,8,17,4,5,10,9,4,5,25,9,2,5,2,17,3,5,6,9,3,5,13,17,4,5,7,9,4,5,4,17,3,5,4,9,2,5,34,17,3,5,7,14,3,16,1,14,10,16,21,14,0,2,8,7,10,14,3,5,58,17,3,5,7,14,3,16,4,14,1,7,6,16,10,14,3,16,5,14,4,8,11,14,3,5,8,17,4,5,10,9,4,5,25,9,2,5,2,17,3,5,6,9,3,5,13,17,4,5,7,9,4,5,4,17,3,5,4,9,2,5,34,17,3,5,7,14,3,16,4,14,1,7,6,16,10,14,3,16,5,14,4,8,11,14,3,5,58,17,3,5,7,14,3,16,4,14,7,16,10,14,3,8,6,14,1,8,2,16,11,14,3,5,8,17,4,5,10,9,4,5,25,9,2,5,2,17,3,5,6,9,3,5,13,17,4,5,7,9,4,5,4,17,3,5,4,9,2,5,34,17,3,5,7,14,3,16,4,14,7,16,10,14,3,8,6,14,1,8,2,16,11,14,3,5
	db 58,17,3,5,7,14,1,8,3,16,1,14,3,16,0,2,8,14,4,16,22,14,1,16,10,14,3,5,7,17,4,5,10,9,7,5,22,9,3,5,3,17,4,5,4,9,3,5,11,17,5,5,6,9,4,5,5,17,3,5,4,9,2,5,10,17,9,5,16,17,3,5,7,14,1,8,3,16,1,14,3,16,0,2,8,14,4,16,22,14,1,16,10,14,3,5,58,17,3,5,8,14,3,16,2,14,0,4,16,14,16,14,4,16,22,14,1,16,10,14,3,5,7,17,4,5,10,9,7,5,22,9,3,5,3,17,4,5,4,9,3,5,11,17,5,5,6,9,4,5,5,17,3,5,4,9,2,5,10,17,9,5,16,17,3,5,8,14,3,16,2,14,0,4,16,14,16,14,4,16,22,14,1,16,10,14,3,5,58,17,3,5,8,14,4,16,5,14,4,16,22,14,1,16,10,14,3,5,7,17,3,5,11,9,15,5,13,9,3,5,4,17,4,5,4,9,5,5,8,17,5,5,6,9,4,5,6,17,3,5
	db 4,9,2,5,9,17,12,5,14,17,3,5,8,14,4,16,5,14,4,16,22,14,1,16,10,14,3,5,58,17,3,5,8,14,4,16,5,14,5,16,21,14,1,16,10,14,3,5,7,17,3,5,10,9,32,5,4,17,4,5,5,9,4,5,7,17,5,5,5,9,5,5,7,17,3,5,4,9,2,5,8,17,3,5,4,17,6,5,14,17,3,5,8,14,4,16,5,14,5,16,21,14,1,16,10,14,3,5,58,17,3,5,8,14,4,16,5,14,5,16,21,14,1,16,10,14,3,5,7,17,3,5,10,9,32,5,4,17,4,5,5,9,4,5,7,17,5,5,5,9,5,5,7,17,3,5,4,9,2,5,8,17,3,5,4,17,6,5,14,17,3,5,8,14,4,16,5,14,5,16,21,14,1,16,10,14,3,5,58,17,3,5,9,14,6,16,0,2,2,7,7,16,12,14,1,8,3,16,1,8,13,14,3,5,7,17,2,5,11,9,3,5,5,17,23,5,5,17,4,5,5,9,5,5,5,17,5,5,5,9
	db 5,5,8,17,3,5,5,9,2,5,7,17,2,5,7,17,5,5,13,17,3,5,9,14,6,16,0,2,2,7,7,16,12,14,1,8,3,16,1,8,13,14,3,5,58,17,3,5,9,14,1,8,6,16,1,14,7,16,14,14,0,3,8,16,7,13,14,3,5,6,17,2,5,11,9,3,5,35,17,4,5,5,9,4,5,3,17,6,5,5,9,4,5,10,17,3,5,5,9,3,5,16,17,6,5,11,17,3,5,9,14,1,8,6,16,1,14,7,16,14,14,0,3,8,16,7,13,14,3,5,58,17,3,5,10,14,6,16,1,14,12,16,1,8,9,14,0,2,16,7,2,16,11,14,3,5,5,17,3,5,11,9,3,5,35,17,4,5,5,9,5,5,2,17,4,5,7,9,3,5,12,17,3,5,4,9,4,5,15,17,6,5,11,17,3,5,10,14,6,16,1,14,12,16,1,8,9,14,0,2,16,7,2,16,11,14,3,5,58,17,3,5,10,14,21,16,10,14,2,16,11,14,3,5,5,17,3,5,11,9
	db 3,5,35,17,4,5,5,9,5,5,2,17,4,5,7,9,3,5,12,17,3,5,4,9,4,5,15,17,6,5,11,17,3,5,10,14,21,16,10,14,2,16,11,14,3,5,58,17,3,5,10,14,1,8,20,16,10,14,2,16,11,14,3,5,5,17,3,5,11,9,3,5,35,17,4,5,5,9,5,5,2,17,4,5,7,9,3,5,12,17,3,5,4,9,4,5,15,17,6,5,11,17,3,5,10,14,1,8,20,16,10,14,2,16,11,14,3,5,58,17,3,5,12,14,12,16,11,14,1,17,6,16,1,7,11,14,3,5,5,17,2,5,12,9,3,5,36,17,4,5,5,9,4,5,2,17,3,5,7,9,3,5,13,17,3,5,5,9,4,5,14,17,7,5,10,17,3,5,12,14,12,16,11,14,1,17,6,16,1,7,11,14,3,5,58,17,3,5,12,14,12,16,7,14,1,16,2,8,7,16,13,14,3,5,5,17,2,5,12,9,3,5,36,17,4,5,5,9,8,5,7,9,3,5,14,17,3,5,6,9
	db 3,5,14,17,3,5,1,9,3,5,10,17,3,5,12,14,12,16,7,14,1,16,2,8,7,16,13,14,3,5,58,17,3,5,12,14,12,16,7,14,10,16,13,14,3,5,5,17,2,5,12,9,3,5,38,17,3,5,7,9,3,5,6,9,5,5,16,17,3,5,6,9,4,5,10,17,4,5,2,9,3,5,10,17,3,5,12,14,12,16,7,14,10,16,13,14,3,5,58,17,3,5,12,14,12,16,10,14,6,16,1,7,13,14,3,5,5,17,2,5,12,9,3,5,39,17,3,5,7,9,1,5,5,9,6,5,17,17,3,5,7,9,4,5,7,17,6,5,1,9,3,5,11,17,3,5,12,14,12,16,10,14,6,16,1,7,13,14,3,5,58,17,3,5,12,14,12,16,10,14,5,16,15,14,3,5,5,17,2,5,12,9,3,5,39,17,3,5,7,9,1,5,5,9,6,5,17,17,3,5,7,9,4,5,7,17,6,5,1,9,3,5,11,17,3,5,12,14,12,16,10,14,5,16,15,14,3,5,58,17
	db 3,5,14,14,10,16,2,14,1,16,5,14,2,16,20,14,3,5,5,17,2,5,12,9,3,5,39,17,3,5,7,9,1,5,5,9,6,5,17,17,3,5,7,9,4,5,7,17,6,5,1,9,3,5,11,17,3,5,14,14,10,16,2,14,1,16,5,14,2,16,20,14,3,5,58,17,3,5,14,14,10,16,2,14,1,7,4,14,4,16,19,14,3,5,5,17,2,5,12,9,3,5,40,17,3,5,11,9,6,5,18,17,4,5,7,9,15,5,2,9,3,5,11,17,3,5,14,14,10,16,2,14,1,7,4,14,4,16,19,14,3,5,58,17,3,5,14,14,10,16,7,14,4,16,19,14,3,5,5,17,2,5,12,9,3,5,40,17,3,5,11,9,6,5,18,17,4,5,7,9,15,5,2,9,3,5,11,17,3,5,14,14,10,16,7,14,4,16,19,14,3,5,58,17,3,5,15,14,9,16,1,7,2,14,2,16,2,14,8,16,15,14,3,5,5,17,2,5,11,9,3,5,41,17,3,5,11,9,5,5
	db 20,17,4,5,6,9,13,5,4,9,3,5,11,17,3,5,15,14,9,16,1,7,2,14,2,16,2,14,8,16,15,14,3,5,58,17,3,5,19,14,11,16,0,2,14,8,7,16,15,14,3,5,5,17,2,5,11,9,3,5,42,17,4,5,7,9,5,5,24,17,3,5,20,9,3,5,13,17,3,5,19,14,11,16,0,2,14,8,7,16,15,14,3,5,58,17,3,5,21,14,11,16,2,8,3,16,17,14,3,5,5,17,2,5,11,9,3,5,43,17,5,5,4,9,5,5,26,17,4,5,17,9,3,5,14,17,3,5,21,14,11,16,2,8,3,16,17,14,3,5,58,17,3,5,21,14,15,16,1,7,17,14,3,5,5,17,2,5,11,9,3,5,43,17,5,5,4,9,5,5,26,17,4,5,17,9,3,5,14,17,3,5,21,14,15,16,1,7,17,14,3,5,58,17,3,5,21,14,14,16,1,7,18,14,3,5,5,17,2,5,11,9,3,5,44,17,5,5,3,9,4,5,28,17,4,5,14,9,5,5
	db 14,17,3,5,21,14,14,16,1,7,18,14,3,5,58,17,3,5,21,14,1,8,12,16,1,8,19,14,3,5,5,17,2,5,11,9,3,5,44,17,5,5,3,9,4,5,28,17,4,5,14,9,5,5,14,17,3,5,21,14,1,8,12,16,1,8,19,14,3,5,58,17,3,5,22,14,1,7,11,16,20,14,3,5,5,17,2,5,11,9,3,5,45,17,5,5,1,9,4,5,30,17,6,5,9,9,6,5,15,17,3,5,22,14,1,7,11,16,20,14,3,5,58,17,3,5,24,14,9,16,1,8,20,14,3,5,5,17,16,5,46,17,8,5,32,17,9,5,3,9,7,5,16,17,3,5,24,14,9,16,1,8,20,14,3,5,58,17,3,5,54,14,3,5,5,17,16,5,48,17,5,5,37,17,11,5,20,17,3,5,54,14,3,5,58,17,3,5,54,14,3,5,5,17,16,5,48,17,5,5,37,17,11,5,20,17,3,5,54,14,3,5,58,17,3,5,54,14,3,5,5,17,16,5,48,17,5,5,37,17
	db 11,5,20,17,3,5,54,14,3,5,58,17,60,5,5,17,16,5,49,17,3,5,42,17,5,5,22,17,60,5,58,17,60,5,5,17,16,5,49,17,3,5,42,17,5,5,22,17,60,5,58,17,60,5,142,17,60,5,255,17,255,17,218,17,14,5,11,17,6,5,10,17,3,5,11,17,4,5,9,17,4,5,19,17,12,5,31,17,8,5,21,17,7,5,17,17,3,5,130,17,14,5,11,17,7,5,9,17,4,5,10,17,6,5,6,17,5,5,19,17,12,5,31,17,11,5,16,17,10,5,15,17,7,5,124,17,19,5,9,17,8,5,7,17,5,5,10,17,16,5,18,17,17,5,27,17,13,5,14,17,11,5,15,17,10,5,118,17,7,5,13,9,4,5,8,17,19,5,10,17,15,5,18,17,3,5,12,9,5,5,23,17,6,5,6,9,5,5,9,17,6,5,5,9,4,5,14,17,2,5,4,9,11,5,110,17,5,5,16,9,5,5,7,17,3,5,2,9,14,5,9,17,3,5,2,9,11,5,16,17
	db 4,5,14,9,5,5,22,17,4,5,11,9,3,5,6,17,5,5,9,9,3,5,13,17,3,5,7,9,12,5,106,17,5,5,16,9,5,5,7,17,3,5,3,9,9,5,1,9,3,5,9,17,3,5,10,9,3,5,16,17,3,5,17,9,3,5,22,17,4,5,11,9,3,5,6,17,5,5,9,9,3,5,13,17,2,5,10,9,13,5,101,17,6,5,19,9,3,5,7,17,3,5,13,9,3,5,9,17,3,5,9,9,3,5,16,17,3,5,18,9,4,5,20,17,4,5,13,9,2,5,6,17,3,5,11,9,3,5,13,17,2,5,15,9,12,5,95,17,5,5,7,9,10,5,5,9,4,5,6,17,5,5,11,9,3,5,9,17,3,5,9,9,3,5,16,17,3,5,19,9,4,5,18,17,5,5,14,9,2,5,4,17,3,5,13,9,3,5,10,17,3,5,4,9,7,5,13,9,13,5,85,17,5,5,8,9,12,5,4,9,3,5,7,17,4,5,11,9,3,5,9,17,3,5,8,9,3,5,16,17
	db 4,5,20,9,3,5,18,17,4,5,15,9,2,5,4,17,3,5,13,9,3,5,10,17,3,5,3,9,14,5,11,9,13,5,81,17,5,5,8,9,12,5,4,9,3,5,7,17,4,5,11,9,3,5,9,17,3,5,8,9,3,5,14,17,4,5,22,9,3,5,18,17,4,5,15,9,4,5,1,17,3,5,14,9,3,5,9,17,4,5,3,9,4,5,2,14,12,5,11,9,11,5,78,17,4,5,9,9,14,5,3,9,3,5,7,17,4,5,11,9,3,5,8,17,3,5,9,9,3,5,14,17,4,5,23,9,2,5,17,17,5,5,16,9,3,5,1,17,3,5,15,9,2,5,9,17,3,5,3,9,5,5,4,14,12,5,14,9,6,5,76,17,6,5,6,9,5,5,9,17,3,5,3,9,3,5,7,17,4,5,11,9,3,5,8,17,3,5,7,9,4,5,13,17,5,5,9,9,3,5,13,9,2,5,16,17,3,5,18,9,3,5,1,17,3,5,15,9,2,5,9,17,3,5,2,9,5,5,10,14
	db 8,5,14,9,5,5,75,17,5,5,6,9,6,5,11,17,2,5,3,9,3,5,8,17,4,5,10,9,3,5,8,17,3,5,7,9,4,5,13,17,5,5,9,9,3,5,13,9,2,5,16,17,3,5,18,9,3,5,1,17,3,5,15,9,2,5,9,17,3,5,2,9,5,5,10,14,8,5,14,9,5,5,75,17,5,5,6,9,6,5,11,17,2,5,3,9,3,5,8,17,4,5,10,9,3,5,8,17,3,5,7,9,4,5,13,17,5,5,9,9,3,5,13,9,2,5,16,17,3,5,18,9,3,5,1,17,3,5,15,9,2,5,9,17,3,5,2,9,3,5,17,14,3,5,10,9,9,5,75,17,5,5,6,9,6,5,11,17,2,5,3,9,3,5,8,17,4,5,10,9,3,5,8,17,3,5,7,9,4,5,13,17,5,5,9,9,3,5,13,9,2,5,16,17,3,5,18,9,3,5,1,17,3,5,15,9,2,5,8,17,4,5,2,9,3,5,14,14,6,5,8,9,9,5,76,17,4,5,7,9
	db 4,5,14,17,2,5,3,9,3,5,8,17,5,5,9,9,3,5,6,17,4,5,8,9,3,5,12,17,6,5,9,9,8,5,10,9,3,5,13,17,3,5,8,9,4,5,7,9,6,5,6,9,3,5,7,9,2,5,8,17,4,5,3,9,5,5,6,14,9,5,4,9,10,5,80,17,5,5,6,9,4,5,16,17,3,5,1,9,3,5,8,17,5,5,9,9,3,5,6,17,4,5,8,9,3,5,12,17,6,5,9,9,8,5,10,9,3,5,13,17,3,5,8,9,4,5,7,9,6,5,6,9,3,5,7,9,2,5,8,17,4,5,4,9,4,5,4,14,8,5,5,9,9,5,82,17,4,5,6,9,6,5,16,17,6,5,10,17,4,5,9,9,3,5,6,17,4,5,8,9,3,5,12,17,6,5,7,9,10,5,10,9,3,5,13,17,3,5,7,9,6,5,6,9,6,5,6,9,3,5,7,9,2,5,7,17,3,5,6,9,14,5,6,9,7,5,85,17,4,5,6,9,6,5,16,17,6,5,10,17
	db 4,5,9,9,3,5,6,17,4,5,8,9,3,5,11,17,5,5,9,9,4,5,1,17,6,5,9,9,4,5,10,17,4,5,8,9,8,5,4,9,5,5,7,9,4,5,6,9,2,5,7,17,3,5,7,9,11,5,4,9,9,5,87,17,3,5,7,9,4,5,18,17,6,5,10,17,4,5,9,9,3,5,6,17,4,5,8,9,3,5,11,17,5,5,8,9,5,5,2,17,5,5,9,9,4,5,10,17,4,5,8,9,4,5,1,17,3,5,4,9,5,5,7,9,4,5,7,9,2,5,6,17,3,5,7,9,7,5,6,9,8,5,88,17,4,5,6,9,5,5,20,17,5,5,12,17,3,5,8,9,3,5,6,17,4,5,8,9,3,5,10,17,4,5,10,9,4,5,7,17,2,5,9,9,5,5,8,17,4,5,8,9,3,5,2,17,4,5,3,9,5,5,6,9,5,5,7,9,2,5,6,17,3,5,17,9,7,5,92,17,4,5,6,9,4,5,21,17,4,5,13,17,3,5,8,9,3,5,6,17
	db 4,5,8,9,2,5,11,17,4,5,9,9,4,5,8,17,2,5,9,9,5,5,8,17,4,5,8,9,3,5,2,17,4,5,3,9,4,5,7,9,5,5,7,9,2,5,6,17,3,5,13,9,8,5,95,17,3,5,6,9,3,5,23,17,4,5,13,17,4,5,7,9,3,5,6,17,4,5,8,9,2,5,11,17,4,5,9,9,4,5,8,17,2,5,9,9,5,5,8,17,3,5,9,9,3,5,2,17,4,5,3,9,4,5,5,9,7,5,7,9,2,5,6,17,3,5,11,9,8,5,97,17,3,5,6,9,3,5,23,17,4,5,13,17,4,5,7,9,3,5,6,17,4,5,8,9,2,5,11,17,4,5,9,9,4,5,8,17,3,5,8,9,5,5,8,17,3,5,9,9,3,5,2,17,4,5,3,9,4,5,5,9,7,5,7,9,2,5,6,17,2,5,10,9,7,5,99,17,3,5,6,9,4,5,41,17,3,5,7,9,13,5,7,9,3,5,11,17,4,5,8,9,3,5,10,17,3,5,10,9
	db 5,5,6,17,3,5,7,9,3,5,5,17,4,5,2,9,4,5,4,9,8,5,7,9,2,5,5,17,3,5,4,9,9,5,101,17,3,5,8,9,4,5,41,17,3,5,7,9,13,5,7,9,3,5,11,17,2,5,10,9,3,5,10,17,3,5,10,9,5,5,6,17,3,5,7,9,3,5,5,17,4,5,2,9,3,5,5,9,8,5,7,9,2,5,5,17,3,5,4,9,7,5,103,17,3,5,6,9,6,5,41,17,3,5,27,9,3,5,11,17,2,5,10,9,3,5,6,17,9,5,8,9,5,5,6,17,3,5,7,9,3,5,5,17,4,5,2,9,3,5,4,9,9,5,7,9,2,5,5,17,3,5,4,9,4,5,106,17,3,5,6,9,6,5,41,17,3,5,27,9,3,5,11,17,2,5,10,9,2,5,5,17,11,5,8,9,5,5,6,17,3,5,6,9,4,5,5,17,5,5,1,9,3,5,4,9,4,5,1,17,4,5,7,9,2,5,5,17,3,5,4,9,2,5,105,17,6,5,6,9
	db 4,5,43,17,3,5,28,9,3,5,10,17,2,5,10,9,2,5,1,17,10,5,1,14,4,5,9,9,5,5,3,17,4,5,7,9,3,5,8,17,3,5,6,9,4,5,3,17,4,5,7,9,2,5,5,17,3,5,4,9,2,5,105,17,6,5,6,9,4,5,43,17,3,5,28,9,3,5,10,17,2,5,10,9,2,5,1,17,10,5,1,14,4,5,9,9,5,5,3,17,4,5,7,9,3,5,8,17,4,5,5,9,3,5,4,17,4,5,7,9,2,5,5,17,3,5,4,9,3,5,104,17,6,5,5,9,5,5,43,17,3,5,28,9,3,5,9,17,2,5,11,9,13,5,1,14,4,5,9,9,5,5,3,17,4,5,7,9,3,5,9,17,3,5,4,9,4,5,4,17,4,5,7,9,2,5,5,17,3,5,4,9,3,5,104,17,6,5,5,9,5,5,42,17,4,5,28,9,3,5,9,17,2,5,11,9,9,5,5,14,4,5,9,9,5,5,3,17,4,5,7,9,3,5,9,17,3,5,4,9
	db 4,5,4,17,4,5,7,9,2,5,5,17,3,5,4,9,3,5,103,17,6,5,6,9,4,5,43,17,3,5,7,9,13,5,9,9,3,5,9,17,2,5,11,9,6,5,8,14,4,5,9,9,5,5,3,17,4,5,7,9,3,5,10,17,8,5,6,17,4,5,7,9,2,5,5,17,3,5,4,9,3,5,103,17,6,5,6,9,4,5,43,17,3,5,7,9,13,5,9,9,3,5,9,17,2,5,11,9,2,5,12,14,4,5,9,9,5,5,3,17,4,5,7,9,3,5,10,17,7,5,7,17,4,5,7,9,2,5,5,17,3,5,4,9,3,5,103,17,6,5,6,9,4,5,41,17,5,5,7,9,3,5,7,17,3,5,9,9,4,5,8,17,2,5,11,9,2,5,12,14,4,5,9,9,5,5,3,17,4,5,7,9,3,5,11,17,5,5,8,17,4,5,6,9,2,5,6,17,3,5,4,9,3,5,103,17,6,5,6,9,4,5,41,17,5,5,7,9,3,5,7,17,3,5,9,9,4,5,8,17
	db 2,5,11,9,2,5,12,14,4,5,9,9,5,5,5,17,3,5,6,9,3,5,24,17,4,5,6,9,2,5,7,17,3,5,4,9,3,5,102,17,6,5,7,9,4,5,17,17,1,5,22,17,4,5,8,9,3,5,7,17,3,5,9,9,4,5,8,17,2,5,11,9,2,5,12,14,4,5,11,9,3,5,5,17,3,5,6,9,3,5,24,17,4,5,6,9,2,5,7,17,3,5,4,9,3,5,102,17,6,5,7,9,4,5,16,17,3,5,21,17,4,5,8,9,3,5,7,17,3,5,9,9,4,5,8,17,2,5,11,9,2,5,11,14,5,5,11,9,3,5,5,17,3,5,7,9,3,5,23,17,3,5,7,9,2,5,7,17,3,5,4,9,3,5,102,17,6,5,7,9,6,5,14,17,3,5,20,17,5,5,7,9,3,5,8,17,4,5,10,9,3,5,7,17,2,5,11,9,2,5,6,14,10,5,11,9,4,5,4,17,3,5,7,9,3,5,23,17,3,5,7,9,2,5,7,17,3,5,4,9
	db 3,5,103,17,6,5,8,9,4,5,14,17,6,5,17,17,4,5,8,9,3,5,10,17,3,5,9,9,3,5,7,17,2,5,11,9,2,5,5,14,11,5,11,9,4,5,4,17,3,5,7,9,3,5,23,17,3,5,7,9,2,5,7,17,3,5,5,9,4,5,101,17,6,5,9,9,5,5,10,17,8,5,17,17,4,5,8,9,3,5,10,17,3,5,9,9,3,5,7,17,2,5,11,9,13,5,1,17,4,5,11,9,4,5,4,17,3,5,9,9,3,5,21,17,3,5,6,9,3,5,7,17,3,5,5,9,4,5,101,17,6,5,10,9,6,5,8,17,8,5,16,17,4,5,9,9,3,5,10,17,3,5,10,9,3,5,6,17,2,5,11,9,8,5,7,17,3,5,11,9,4,5,4,17,3,5,9,9,3,5,20,17,4,5,6,9,3,5,7,17,3,5,5,9,4,5,104,17,3,5,12,9,7,5,5,17,9,5,15,17,4,5,9,9,3,5,10,17,3,5,10,9,3,5,6,17,2,5,11,9
	db 8,5,7,17,3,5,11,9,4,5,4,17,3,5,9,9,3,5,20,17,4,5,6,9,3,5,8,17,4,5,3,9,5,5,103,17,5,5,10,9,10,5,2,17,9,5,15,17,4,5,9,9,3,5,10,17,3,5,10,9,3,5,6,17,2,5,11,9,7,5,8,17,4,5,10,9,4,5,4,17,4,5,8,9,3,5,20,17,3,5,7,9,3,5,8,17,4,5,4,9,4,5,103,17,5,5,10,9,10,5,2,17,9,5,15,17,4,5,9,9,3,5,11,17,3,5,9,9,3,5,6,17,2,5,11,9,7,5,8,17,4,5,10,9,4,5,4,17,4,5,8,9,3,5,20,17,3,5,7,9,3,5,8,17,4,5,4,9,5,5,104,17,5,5,12,9,11,5,1,9,5,5,14,17,3,5,11,9,2,5,12,17,3,5,10,9,3,5,5,17,2,5,11,9,3,5,12,17,4,5,10,9,4,5,4,17,4,5,8,9,4,5,19,17,3,5,6,9,3,5,10,17,4,5,4,9,5,5,104,17
	db 5,5,14,9,8,5,1,9,5,5,14,17,3,5,11,9,2,5,12,17,3,5,10,9,3,5,5,17,2,5,11,9,3,5,12,17,4,5,10,9,4,5,4,17,4,5,8,9,4,5,19,17,3,5,6,9,3,5,10,17,4,5,6,9,4,5,103,17,6,5,16,9,2,5,4,9,5,5,14,17,3,5,11,9,2,5,12,17,3,5,10,9,3,5,5,17,2,5,11,9,3,5,12,17,4,5,8,9,5,5,5,17,4,5,8,9,4,5,19,17,3,5,6,9,3,5,11,17,3,5,7,9,4,5,104,17,7,5,19,9,5,5,13,17,4,5,11,9,2,5,13,17,3,5,10,9,3,5,4,17,2,5,11,9,3,5,12,17,4,5,8,9,5,5,5,17,4,5,8,9,4,5,19,17,3,5,6,9,3,5,11,17,3,5,8,9,3,5,106,17,8,5,15,9,6,5,13,17,3,5,12,9,2,5,13,17,3,5,10,9,3,5,4,17,2,5,11,9,3,5,12,17,4,5,8,9,5,5,5,17
	db 4,5,8,9,4,5,17,17,3,5,7,9,3,5,14,17,2,5,9,9,5,5,103,17,9,5,13,9,5,5,14,17,3,5,10,9,3,5,14,17,3,5,10,9,3,5,4,17,2,5,11,9,3,5,12,17,4,5,8,9,5,5,5,17,4,5,8,9,4,5,17,17,3,5,7,9,3,5,15,17,2,5,7,9,7,5,105,17,8,5,10,9,6,5,14,17,3,5,10,9,3,5,15,17,3,5,9,9,3,5,5,17,2,5,10,9,3,5,12,17,4,5,8,9,5,5,7,17,3,5,8,9,4,5,16,17,3,5,7,9,3,5,15,17,3,5,3,9,10,5,107,17,19,5,17,17,4,5,7,9,5,5,15,17,5,5,6,9,3,5,6,17,2,5,10,9,3,5,12,17,4,5,8,9,5,5,7,17,15,5,15,17,4,5,3,9,7,5,15,17,11,5,116,17,14,5,20,17,13,5,18,17,11,5,7,17,15,5,12,17,17,5,11,17,6,5,23,17,9,5,18,17,6,5,124,17,8,5,23,17
	db 10,5,21,17,9,5,9,17,14,5,15,17,11,5,44,17,6,5,20,17,3,5,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,226,17
	db 11,17,6,5,23,17,9,5,18,17,6,5,124,17,8,5,23,17,10,5,21,17,9,5,9,17,14,5,15,17,11,5,44,17,6,5,20,17,3,5,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,226,17
	
	Controls_picture db 255,17,91,17,13,5,20,17,3,5,33,17,2,5,21,17,3,5,9,17,2,5,33,17,1,5,13,17,1,5,45,17,2,5,21,17,1,5,47,17,1,5,49,17,13,5,19,17,4,5,33,17,3,5,20,17,3,5,9,17,4,5,28,17,7,5,9,17,6,5,40,17,3,5,20,17,3,5,11,17,3,5,28,17,7,5,44,17,18,5,17,17,4,5,32,17,5,5,19,17,3,5,9,17,7,5,21,17,11,5,9,17,9,5,37,17,3,5,20,17,4,5,8,17,5,5,25,17,11,5,40,17,7,5,12,9,4,5,14,17,5,5,31,17,6,5,19,17,4,5,7,17,12,5,14,17,15,5,7,17,12,5,33,17,6,5,19,17,4,5,8,17,5,5,24,17,13,5,39,17,3,5,16,9,5,5,13,17,5,5,31,17,6,5,19,17,4,5,7,17,2,5,3,9,10,5,8,17,10,5,4,9,4,5,7,17,3,5,4,9,8,5,30,17,6,5,20,17,5,5,5,17,3,5,1,9,3,5,22,17
	db 5,5,6,9,5,5,37,17,3,5,16,9,5,5,11,17,5,5,1,9,2,5,29,17,7,5,19,17,4,5,7,17,2,5,6,9,21,5,8,9,5,5,6,17,3,5,8,9,7,5,25,17,5,5,1,9,3,5,19,17,5,5,5,17,3,5,2,9,2,5,22,17,5,5,6,9,5,5,35,17,5,5,18,9,3,5,9,17,6,5,3,9,2,5,27,17,4,5,2,9,3,5,18,17,5,5,5,17,3,5,9,9,16,5,10,9,5,5,6,17,3,5,8,9,7,5,24,17,6,5,2,9,2,5,19,17,5,5,5,17,3,5,2,9,2,5,22,17,5,5,6,9,5,5,32,17,5,5,7,9,10,5,4,9,4,5,8,17,6,5,3,9,2,5,27,17,4,5,2,9,3,5,18,17,5,5,4,17,3,5,14,9,8,5,17,9,2,5,6,17,3,5,2,9,1,5,6,9,9,5,21,17,6,5,2,9,2,5,19,17,1,5,2,9,9,5,4,9,2,5,20,17,4,5,9,9,4,5,32,17
	db 5,5,7,9,10,5,4,9,4,5,8,17,5,5,4,9,2,5,27,17,3,5,3,9,6,5,15,17,5,5,4,17,3,5,15,9,4,5,20,9,2,5,5,17,4,5,2,9,3,5,7,9,8,5,18,17,6,5,3,9,2,5,19,17,1,5,2,9,9,5,4,9,2,5,20,17,3,5,10,9,4,5,32,17,5,5,7,9,11,5,3,9,4,5,7,17,3,5,8,9,4,5,22,17,5,5,4,9,6,5,14,17,2,5,1,9,3,5,3,17,3,5,39,9,2,5,5,17,3,5,3,9,5,5,7,9,8,5,15,17,3,5,8,9,4,5,16,17,2,5,2,9,8,5,4,9,2,5,19,17,4,5,9,9,5,5,32,17,5,5,7,9,11,5,3,9,4,5,7,17,3,5,8,9,4,5,21,17,6,5,5,9,5,5,13,17,3,5,1,9,3,5,3,17,3,5,39,9,2,5,5,17,3,5,3,9,2,5,1,14,7,5,4,9,8,5,13,17,3,5,8,9,4,5,17,17,2,5,3,9
	db 2,5,6,9,3,5,20,17,3,5,9,9,4,5,34,17,5,5,7,9,11,5,3,9,4,5,7,17,3,5,9,9,3,5,21,17,5,5,6,9,5,5,13,17,3,5,1,9,3,5,4,17,2,5,36,9,5,5,5,17,3,5,3,9,2,5,1,14,7,5,4,9,8,5,13,17,3,5,8,9,4,5,17,17,2,5,11,9,3,5,19,17,3,5,10,9,3,5,34,17,4,5,8,9,13,5,2,9,4,5,6,17,2,5,12,9,2,5,21,17,5,5,6,9,5,5,13,17,3,5,1,9,3,5,4,17,2,5,36,9,5,5,5,17,3,5,3,9,2,5,4,14,5,5,7,9,4,5,13,17,2,5,10,9,3,5,17,17,2,5,11,9,3,5,18,17,4,5,9,9,4,5,32,17,6,5,5,9,5,5,9,17,2,5,2,9,4,5,6,17,2,5,8,9,1,5,4,9,3,5,19,17,4,5,8,9,4,5,13,17,3,5,1,9,3,5,4,17,2,5,10,9,6,5,6,9,10,5,3,9
	db 5,5,6,17,2,5,4,9,2,5,6,14,4,5,7,9,4,5,12,17,1,5,8,9,1,5,2,9,5,5,16,17,2,5,9,9,3,5,19,17,3,5,10,9,3,5,32,17,4,5,6,9,6,5,10,17,2,5,2,9,4,5,6,17,2,5,7,9,2,5,5,9,2,5,19,17,4,5,9,9,4,5,12,17,3,5,1,9,3,5,5,17,2,5,3,9,12,5,5,9,18,5,7,17,2,5,4,9,2,5,8,14,2,5,8,9,3,5,12,17,1,5,7,9,3,5,1,9,5,5,16,17,2,5,9,9,3,5,19,17,3,5,9,9,3,5,33,17,4,5,6,9,6,5,10,17,2,5,2,9,4,5,6,17,2,5,7,9,2,5,5,9,3,5,17,17,4,5,11,9,3,5,12,17,2,5,3,9,2,5,5,17,17,5,5,9,15,5,10,17,2,5,3,9,3,5,7,14,3,5,9,9,2,5,12,17,1,5,7,9,3,5,1,9,5,5,16,17,2,5,9,9,3,5,18,17,3,5,10,9
	db 3,5,33,17,3,5,7,9,6,5,10,17,2,5,2,9,4,5,4,17,3,5,6,9,5,5,4,9,3,5,17,17,4,5,12,9,3,5,11,17,2,5,3,9,3,5,5,17,10,5,4,17,2,5,5,9,3,5,8,17,4,5,9,17,2,5,4,9,3,5,5,14,5,5,7,9,4,5,8,17,4,5,7,9,5,5,3,9,5,5,13,17,2,5,9,9,3,5,18,17,3,5,9,9,3,5,33,17,4,5,7,9,6,5,10,17,2,5,2,9,4,5,4,17,3,5,6,9,5,5,5,9,3,5,16,17,4,5,12,9,3,5,11,17,2,5,3,9,3,5,5,17,4,5,10,17,2,5,5,9,3,5,21,17,2,5,3,9,3,5,4,14,6,5,7,9,4,5,9,17,4,5,7,9,5,5,3,9,5,5,14,17,2,5,7,9,4,5,18,17,3,5,9,9,3,5,33,17,4,5,6,9,3,5,14,17,2,5,2,9,4,5,4,17,3,5,5,9,4,5,1,17,2,5,5,9,3,5,15,17
	db 4,5,12,9,3,5,11,17,2,5,3,9,3,5,5,17,4,5,10,17,2,5,5,9,3,5,19,17,4,5,3,9,3,5,1,14,8,5,4,9,8,5,9,17,4,5,5,9,4,5,1,17,2,5,5,9,4,5,13,17,2,5,7,9,4,5,18,17,3,5,9,9,3,5,33,17,3,5,7,9,3,5,15,17,7,5,4,17,3,5,5,9,4,5,1,17,2,5,5,9,4,5,14,17,4,5,12,9,3,5,11,17,2,5,3,9,3,5,5,17,4,5,10,17,2,5,5,9,3,5,19,17,3,5,3,9,10,5,5,9,8,5,11,17,4,5,5,9,4,5,1,17,2,5,5,9,4,5,13,17,2,5,7,9,4,5,18,17,3,5,9,9,3,5,32,17,3,5,6,9,5,5,15,17,6,5,4,17,4,5,4,9,4,5,2,17,4,5,4,9,4,5,13,17,4,5,12,9,3,5,11,17,2,5,3,9,3,5,19,17,2,5,6,9,2,5,19,17,3,5,2,9,9,5,5,9,8,5,12,17
	db 5,5,5,9,3,5,2,17,3,5,4,9,5,5,12,17,2,5,7,9,4,5,16,17,5,5,9,9,3,5,32,17,3,5,6,9,5,5,15,17,6,5,4,17,3,5,5,9,3,5,3,17,5,5,4,9,3,5,13,17,4,5,13,9,3,5,10,17,2,5,4,9,2,5,18,17,2,5,7,9,2,5,19,17,3,5,2,9,9,5,5,9,8,5,12,17,5,5,5,9,3,5,3,17,4,5,4,9,3,5,12,17,2,5,7,9,4,5,16,17,4,5,8,9,4,5,33,17,2,5,7,9,3,5,17,17,6,5,3,17,4,5,4,9,4,5,4,17,5,5,4,9,5,5,10,17,2,5,16,9,3,5,9,17,2,5,4,9,2,5,18,17,2,5,7,9,2,5,18,17,4,5,2,9,6,5,4,9,10,5,14,17,5,5,3,9,5,5,4,17,5,5,3,9,4,5,10,17,3,5,5,9,3,5,18,17,4,5,8,9,4,5,32,17,3,5,7,9,3,5,17,17,6,5,3,17,3,5,5,9
	db 3,5,8,17,3,5,3,9,7,5,8,17,2,5,16,9,3,5,9,17,2,5,4,9,2,5,18,17,2,5,7,9,2,5,18,17,4,5,2,9,3,5,4,9,10,5,17,17,4,5,4,9,4,5,6,17,4,5,4,9,5,5,8,17,3,5,5,9,3,5,18,17,4,5,8,9,4,5,31,17,4,5,4,9,5,5,19,17,5,5,3,17,3,5,5,9,3,5,8,17,3,5,4,9,6,5,8,17,2,5,4,9,2,5,10,9,3,5,9,17,2,5,4,9,2,5,18,17,2,5,7,9,2,5,17,17,5,5,6,9,10,5,20,17,4,5,4,9,4,5,6,17,4,5,4,9,5,5,8,17,3,5,5,9,3,5,17,17,4,5,8,9,5,5,31,17,3,5,5,9,5,5,19,17,4,5,4,17,3,5,5,9,3,5,8,17,3,5,5,9,6,5,6,17,2,5,4,9,3,5,11,9,2,5,9,17,2,5,4,9,2,5,18,17,2,5,7,9,2,5,17,17,4,5,5,9,9,5,23,17
	db 4,5,4,9,4,5,6,17,4,5,4,9,5,5,8,17,3,5,5,9,3,5,17,17,4,5,8,9,4,5,31,17,4,5,5,9,3,5,21,17,4,5,4,17,3,5,3,9,4,5,9,17,4,5,6,9,5,5,5,17,2,5,4,9,3,5,11,9,2,5,9,17,2,5,4,9,2,5,18,17,2,5,7,9,2,5,17,17,4,5,5,9,5,5,27,17,4,5,3,9,3,5,9,17,5,5,3,9,7,5,5,17,3,5,5,9,3,5,17,17,4,5,8,9,4,5,31,17,3,5,6,9,3,5,21,17,4,5,4,17,3,5,3,9,4,5,10,17,3,5,6,9,6,5,4,17,2,5,4,9,3,5,12,9,2,5,8,17,2,5,4,9,2,5,18,17,2,5,7,9,2,5,17,17,4,5,5,9,4,5,28,17,4,5,3,9,3,5,10,17,4,5,5,9,6,5,4,17,3,5,5,9,2,5,18,17,4,5,9,9,4,5,29,17,4,5,5,9,4,5,28,17,3,5,4,9,4,5,11,17
	db 2,5,7,9,6,5,3,17,2,5,4,9,4,5,11,9,3,5,7,17,2,5,4,9,2,5,18,17,2,5,7,9,3,5,16,17,3,5,6,9,8,5,23,17,2,5,6,9,3,5,12,17,3,5,5,9,6,5,3,17,3,5,5,9,2,5,18,17,4,5,9,9,4,5,29,17,3,5,6,9,4,5,28,17,3,5,4,9,4,5,11,17,2,5,9,9,4,5,3,17,2,5,5,9,3,5,12,9,2,5,7,17,2,5,4,9,2,5,18,17,2,5,8,9,2,5,15,17,3,5,7,9,10,5,21,17,2,5,6,9,3,5,12,17,3,5,5,9,6,5,4,17,2,5,5,9,2,5,18,17,5,5,8,9,5,5,27,17,4,5,6,9,4,5,28,17,3,5,4,9,3,5,12,17,3,5,9,9,3,5,3,17,2,5,5,9,4,5,11,9,3,5,6,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,3,5,12,9,8,5,19,17,2,5,5,9,4,5,12,17,4,5,8,9
	db 3,5,3,17,2,5,5,9,2,5,19,17,5,5,9,9,5,5,25,17,4,5,6,9,4,5,28,17,3,5,4,9,3,5,12,17,3,5,9,9,3,5,3,17,2,5,5,9,4,5,11,9,3,5,6,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,2,5,17,9,7,5,16,17,2,5,5,9,4,5,12,17,4,5,8,9,3,5,3,17,2,5,5,9,2,5,19,17,5,5,9,9,5,5,25,17,4,5,6,9,4,5,28,17,3,5,4,9,3,5,12,17,3,5,8,9,4,5,3,17,2,5,5,9,4,5,11,9,3,5,6,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,2,5,4,9,2,5,13,9,6,5,15,17,2,5,5,9,4,5,12,17,4,5,6,9,4,5,4,17,2,5,5,9,2,5,19,17,5,5,9,9,5,5,23,17,5,5,6,9,2,5,31,17,3,5,4,9,4,5,11,17,3,5,8,9,3,5,4,17,2,5,5,9,5,5,11,9
	db 3,5,5,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,2,5,2,9,6,5,13,9,6,5,13,17,2,5,6,9,3,5,12,17,4,5,5,9,4,5,5,17,2,5,5,9,2,5,21,17,4,5,9,9,9,5,18,17,5,5,6,9,2,5,31,17,3,5,4,9,4,5,11,17,3,5,8,9,3,5,4,17,2,5,5,9,5,5,11,9,3,5,5,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,2,5,2,9,8,5,13,9,5,5,12,17,2,5,6,9,3,5,12,17,4,5,5,9,4,5,5,17,2,5,5,9,2,5,21,17,7,5,8,9,13,5,12,17,5,5,6,9,2,5,31,17,3,5,4,9,4,5,11,17,3,5,8,9,3,5,4,17,2,5,6,9,5,5,11,9,2,5,5,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,2,5,4,9,8,5,13,9,4,5,11,17,2,5,6,9,3,5,12,17,4,5,5,9,4,5,5,17
	db 2,5,5,9,2,5,23,17,8,5,7,9,15,5,8,17,5,5,6,9,2,5,31,17,3,5,4,9,4,5,11,17,3,5,8,9,3,5,4,17,2,5,6,9,5,5,11,9,2,5,5,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,2,5,4,9,8,5,13,9,4,5,11,17,2,5,6,9,3,5,12,17,4,5,5,9,4,5,5,17,2,5,5,9,2,5,25,17,10,5,8,9,11,5,7,17,4,5,7,9,2,5,32,17,3,5,3,9,4,5,9,17,4,5,8,9,2,5,7,17,1,5,6,9,5,5,12,9,2,5,4,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,2,5,4,9,8,5,13,9,4,5,12,17,4,5,3,9,3,5,9,17,6,5,5,9,4,5,6,17,2,5,5,9,2,5,27,17,10,5,11,9,8,5,5,17,4,5,6,9,3,5,32,17,3,5,3,9,4,5,9,17,4,5,7,9,3,5,7,17,2,5,5,9,2,5,1,17
	db 2,5,12,9,2,5,4,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,2,5,4,9,2,5,2,17,6,5,11,9,4,5,12,17,4,5,3,9,3,5,9,17,6,5,5,9,4,5,5,17,3,5,5,9,2,5,31,17,7,5,14,9,4,5,4,17,5,5,6,9,3,5,32,17,3,5,3,9,5,5,8,17,4,5,7,9,2,5,8,17,2,5,5,9,2,5,1,17,2,5,13,9,3,5,2,17,2,5,4,9,2,5,17,17,3,5,8,9,2,5,14,17,3,5,3,9,2,5,3,17,8,5,10,9,3,5,11,17,4,5,3,9,5,5,6,17,6,5,5,9,3,5,7,17,3,5,5,9,2,5,34,17,5,5,14,9,5,5,2,17,4,5,7,9,3,5,32,17,3,5,5,9,3,5,6,17,5,5,7,9,3,5,8,17,2,5,5,9,2,5,2,17,2,5,12,9,3,5,2,17,2,5,3,9,3,5,17,17,3,5,8,9,2,5,15,17,2,5,3,9,3,5,5,17
	db 6,5,10,9,3,5,10,17,4,5,4,9,4,5,5,17,5,5,5,9,4,5,8,17,3,5,5,9,3,5,35,17,3,5,15,9,4,5,2,17,4,5,7,9,3,5,32,17,3,5,5,9,3,5,6,17,5,5,6,9,4,5,8,17,2,5,5,9,2,5,2,17,2,5,12,9,4,5,1,17,2,5,3,9,3,5,17,17,3,5,8,9,2,5,15,17,3,5,3,9,2,5,6,17,7,5,9,9,2,5,10,17,4,5,4,9,4,5,5,17,5,5,5,9,4,5,8,17,3,5,5,9,3,5,36,17,3,5,15,9,3,5,2,17,4,5,7,9,3,5,32,17,3,5,5,9,4,5,4,17,5,5,6,9,3,5,10,17,4,5,3,9,2,5,3,17,4,5,9,9,6,5,4,9,3,5,17,17,3,5,8,9,2,5,16,17,2,5,3,9,2,5,9,17,5,5,8,9,3,5,9,17,4,5,4,9,5,5,4,17,5,5,5,9,3,5,9,17,3,5,5,9,3,5,36,17,3,5,15,9
	db 3,5,2,17,4,5,7,9,3,5,17,17,1,5,15,17,3,5,5,9,3,5,3,17,5,5,6,9,2,5,12,17,4,5,4,9,2,5,2,17,5,5,11,9,3,5,4,9,3,5,17,17,3,5,8,9,2,5,16,17,2,5,3,9,3,5,9,17,5,5,7,9,4,5,8,17,5,5,5,9,3,5,2,17,5,5,6,9,3,5,10,17,2,5,6,9,3,5,36,17,3,5,15,9,2,5,3,17,4,5,7,9,3,5,16,17,4,5,13,17,3,5,5,9,4,5,2,17,4,5,7,9,2,5,12,17,4,5,4,9,2,5,2,17,5,5,11,9,3,5,4,9,3,5,17,17,3,5,8,9,2,5,16,17,4,5,2,9,2,5,11,17,4,5,7,9,3,5,8,17,5,5,5,9,3,5,2,17,3,5,8,9,2,5,11,17,2,5,6,9,3,5,36,17,3,5,14,9,3,5,3,17,4,5,7,9,3,5,16,17,4,5,13,17,3,5,5,9,4,5,2,17,4,5,6,9,3,5,12,17
	db 4,5,4,9,2,5,2,17,5,5,17,9,4,5,17,17,3,5,8,9,2,5,16,17,4,5,2,9,2,5,13,17,3,5,6,9,3,5,8,17,5,5,5,9,3,5,2,17,3,5,8,9,2,5,11,17,2,5,6,9,3,5,7,17,7,5,22,17,3,5,13,9,4,5,3,17,5,5,6,9,6,5,12,17,6,5,12,17,3,5,5,9,4,5,2,17,4,5,5,9,4,5,13,17,3,5,4,9,2,5,3,17,4,5,17,9,3,5,18,17,3,5,8,9,2,5,17,17,4,5,1,9,3,5,12,17,4,5,6,9,2,5,8,17,5,5,5,9,3,5,2,17,3,5,8,9,2,5,11,17,2,5,6,9,3,5,7,17,7,5,22,17,3,5,13,9,3,5,5,17,4,5,8,9,4,5,11,17,8,5,12,17,3,5,5,9,3,5,2,17,2,5,7,9,3,5,14,17,3,5,4,9,2,5,3,17,5,5,16,9,3,5,18,17,3,5,8,9,2,5,17,17,4,5,1,9,3,5,13,17
	db 3,5,6,9,2,5,9,17,4,5,5,9,3,5,2,17,2,5,8,9,2,5,12,17,2,5,6,9,3,5,7,17,7,5,22,17,3,5,12,9,3,5,6,17,4,5,9,9,5,5,8,17,3,5,4,9,2,5,12,17,3,5,5,9,6,5,7,9,3,5,15,17,4,5,3,9,2,5,6,17,2,5,16,9,3,5,18,17,3,5,8,9,2,5,18,17,3,5,2,9,2,5,14,17,4,5,5,9,2,5,8,17,4,5,5,9,7,5,7,9,3,5,12,17,2,5,7,9,4,5,2,17,12,5,20,17,3,5,11,9,4,5,6,17,5,5,8,9,6,5,7,17,3,5,4,9,2,5,13,17,3,5,6,9,3,5,7,9,2,5,18,17,3,5,3,9,2,5,7,17,2,5,15,9,2,5,19,17,3,5,8,9,2,5,18,17,3,5,2,9,3,5,14,17,3,5,5,9,2,5,11,17,2,5,7,9,2,5,5,9,6,5,12,17,3,5,7,9,10,5,4,9,5,5,19,17,3,5,11,9
	db 3,5,7,17,5,5,8,9,6,5,7,17,3,5,4,9,2,5,14,17,2,5,7,9,1,5,7,9,2,5,19,17,3,5,3,9,2,5,7,17,2,5,15,9,2,5,20,17,2,5,8,9,2,5,18,17,4,5,2,9,3,5,13,17,4,5,5,9,2,5,11,17,2,5,6,9,1,5,4,9,7,5,13,17,3,5,7,9,10,5,6,9,3,5,19,17,3,5,9,9,5,5,9,17,3,5,11,9,5,5,5,17,3,5,4,9,2,5,14,17,2,5,14,9,3,5,21,17,2,5,2,9,3,5,6,17,3,5,12,9,4,5,20,17,2,5,8,9,2,5,18,17,4,5,2,9,3,5,13,17,4,5,5,9,2,5,11,17,2,5,6,9,1,5,4,9,7,5,13,17,2,5,8,9,9,5,8,9,5,5,16,17,3,5,8,9,5,5,10,17,5,5,9,9,9,5,1,17,3,5,4,9,2,5,14,17,2,5,14,9,3,5,21,17,2,5,2,9,3,5,6,17,3,5,12,9,4,5,20,17
	db 2,5,7,9,3,5,20,17,2,5,3,9,3,5,13,17,4,5,4,9,2,5,11,17,2,5,6,9,1,5,4,9,7,5,13,17,2,5,11,9,2,5,14,9,4,5,14,17,4,5,7,9,5,5,11,17,5,5,9,9,9,5,1,17,3,5,4,9,2,5,15,17,3,5,11,9,4,5,21,17,2,5,2,9,3,5,6,17,3,5,12,9,3,5,21,17,2,5,7,9,2,5,21,17,3,5,2,9,4,5,12,17,4,5,4,9,3,5,10,17,3,5,9,9,7,5,14,17,2,5,27,9,5,5,13,17,3,5,8,9,4,5,12,17,5,5,9,9,9,5,1,17,3,5,4,9,2,5,15,17,3,5,10,9,5,5,21,17,2,5,2,9,3,5,6,17,3,5,12,9,3,5,21,17,2,5,7,9,2,5,22,17,2,5,3,9,4,5,11,17,4,5,4,9,3,5,10,17,3,5,9,9,7,5,13,17,2,5,29,9,4,5,13,17,3,5,7,9,5,5,15,17,4,5,10,9,9,5,5,9
	db 2,5,15,17,3,5,10,9,4,5,22,17,3,5,1,9,3,5,7,17,3,5,10,9,4,5,21,17,2,5,7,9,2,5,22,17,3,5,3,9,5,5,11,17,2,5,4,9,4,5,9,17,3,5,9,9,5,5,15,17,2,5,29,9,4,5,12,17,4,5,6,9,4,5,18,17,4,5,11,9,6,5,6,9,2,5,16,17,4,5,5,9,5,5,24,17,3,5,2,9,2,5,7,17,3,5,9,9,4,5,22,17,2,5,7,9,2,5,22,17,3,5,4,9,5,5,10,17,3,5,4,9,3,5,10,17,4,5,6,9,4,5,17,17,2,5,31,9,2,5,12,17,4,5,6,9,4,5,18,17,4,5,23,9,2,5,16,17,5,5,4,9,4,5,25,17,4,5,1,9,2,5,8,17,3,5,8,9,4,5,22,17,2,5,7,9,2,5,22,17,3,5,5,9,4,5,11,17,2,5,4,9,3,5,11,17,5,5,3,9,4,5,18,17,2,5,32,9,2,5,11,17,4,5,6,9,4,5,19,17
	db 6,5,20,9,2,5,16,17,5,5,4,9,4,5,26,17,3,5,1,9,2,5,8,17,4,5,7,9,4,5,22,17,2,5,7,9,2,5,23,17,3,5,5,9,5,5,9,17,3,5,4,9,2,5,11,17,5,5,3,9,4,5,17,17,3,5,32,9,2,5,11,17,4,5,6,9,4,5,21,17,7,5,16,9,3,5,18,17,4,5,3,9,4,5,27,17,2,5,1,9,2,5,10,17,4,5,3,9,4,5,25,17,1,5,7,9,2,5,23,17,3,5,7,9,3,5,10,17,2,5,4,9,4,5,10,17,5,5,2,9,3,5,18,17,3,5,11,9,8,5,13,9,2,5,11,17,3,5,5,9,5,5,22,17,9,5,13,9,4,5,18,17,4,5,3,9,4,5,27,17,5,5,10,17,4,5,3,9,4,5,25,17,1,5,7,9,2,5,23,17,3,5,7,9,3,5,10,17,3,5,4,9,3,5,10,17,5,5,2,9,3,5,18,17,3,5,8,9,13,5,11,9,2,5,10,17,4,5,4,9
	db 5,5,26,17,7,5,10,9,6,5,19,17,4,5,1,9,3,5,29,17,5,5,10,17,4,5,3,9,4,5,25,17,1,5,2,9,3,5,2,9,2,5,23,17,3,5,7,9,3,5,10,17,3,5,4,9,3,5,12,17,3,5,1,9,3,5,19,17,2,5,8,9,15,5,10,9,2,5,10,17,3,5,3,9,6,5,27,17,7,5,10,9,6,5,20,17,6,5,31,17,5,5,9,17,9,5,27,17,0,2,5,9,8,5,24,17,3,5,6,9,2,5,11,17,3,5,6,9,1,5,12,17,7,5,19,17,2,5,2,9,26,5,4,9,3,5,9,17,4,5,3,9,5,5,29,17,18,5,25,17,4,5,32,17,5,5,9,17,9,5,27,17,10,5,24,17,2,5,5,9,4,5,12,17,10,5,13,17,4,5,19,17,3,5,3,9,26,5,2,9,4,5,9,17,4,5,2,9,6,5,34,17,13,5,25,17,4,5,32,17,5,5,9,17,9,5,27,17,3,5,3,17,4,5,25,17,9,5,13,17
	db 11,5,12,17,4,5,19,17,11,5,15,17,11,5,8,17,12,5,36,17,13,5,25,17,4,5,33,17,4,5,11,17,5,5,29,17,2,5,5,17,3,5,25,17,8,5,13,17,4,5,4,17,4,5,12,17,4,5,19,17,4,5,27,17,5,5,9,17,11,5,40,17,8,5,28,17,3,5,35,17,2,5,12,17,1,5,32,17,2,5,5,17,3,5,26,17,7,5,13,17,4,5,4,17,4,5,13,17,2,5,20,17,4,5,27,17,5,5,11,17,4,5,1,17,4,5,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17
	db 255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,182,17
	
	Settings_picture db 255,17,81,17,1,5,38,17,9,5,17,17,2,5,30,17,3,5,7,17,2,5,38,17,2,5,14,17,6,5,17,17,2,5,20,17,3,5,25,17,8,5,33,17,1,5,39,17,6,5,34,17,14,5,14,17,4,5,25,17,8,5,5,17,6,5,30,17,9,5,8,17,12,5,14,17,3,5,19,17,3,5,24,17,12,5,25,17,8,5,35,17,9,5,27,17,9,5,8,9,11,5,6,17,6,5,20,17,11,5,5,17,8,5,22,17,15,5,7,17,14,5,13,17,4,5,18,17,3,5,24,17,12,5,22,17,12,5,32,17,12,5,25,17,7,5,14,9,9,5,4,17,11,5,13,17,15,5,4,17,8,5,22,17,15,5,6,17,5,5,6,14,5,5,11,17,5,5,18,17,4,5,22,17,4,5,6,9,7,5,17,17,14,5,30,17,5,5,5,9,4,5,23,17,5,5,21,9,6,5,3,17,2,5,3,9,10,5,6,17,9,5,6,9,3,5,3,17,2,5,5,9,10,5,8,17,12,5,6,9
	db 4,5,4,17,4,5,10,14,4,5,10,17,5,5,18,17,4,5,22,17,4,5,6,9,7,5,16,17,5,5,7,9,6,5,27,17,3,5,9,9,2,5,22,17,3,5,28,9,2,5,3,17,2,5,3,9,10,5,6,17,9,5,6,9,3,5,3,17,2,5,7,9,22,5,12,9,4,5,4,17,3,5,12,14,3,5,9,17,6,5,18,17,4,5,20,17,4,5,11,9,5,5,15,17,5,5,7,9,6,5,27,17,2,5,10,9,3,5,20,17,3,5,29,9,3,5,2,17,2,5,5,9,20,5,9,9,4,5,1,17,2,5,16,9,8,5,21,9,2,5,2,17,4,5,13,14,3,5,8,17,2,5,2,9,3,5,17,17,6,5,17,17,4,5,13,9,6,5,13,17,5,5,7,9,6,5,26,17,2,5,11,9,3,5,20,17,3,5,29,9,3,5,1,17,3,5,8,9,15,5,11,9,4,5,1,17,2,5,16,9,8,5,21,9,2,5,2,17,3,5,14,14,3,5,8,17,2,5,2,9
	db 3,5,17,17,6,5,17,17,4,5,13,9,6,5,11,17,5,5,10,9,5,5,26,17,2,5,11,9,2,5,21,17,3,5,30,9,2,5,1,17,2,5,14,9,6,5,17,9,2,5,1,17,2,5,16,9,8,5,21,9,2,5,2,17,3,5,14,14,3,5,8,17,2,5,2,9,7,5,13,17,6,5,16,17,4,5,11,9,2,5,3,9,4,5,11,17,4,5,11,9,5,5,26,17,2,5,11,9,2,5,21,17,3,5,31,9,0,2,5,17,2,5,15,9,3,5,19,9,2,5,1,17,2,5,45,9,2,5,2,17,4,5,13,14,3,5,5,17,5,5,3,9,7,5,12,17,2,5,1,9,4,5,14,17,3,5,6,9,3,5,3,9,5,5,3,9,4,5,9,17,4,5,11,9,5,5,25,17,3,5,9,9,4,5,20,17,3,5,12,9,7,5,13,9,0,2,5,17,2,5,37,9,2,5,1,17,2,5,45,9,2,5,3,17,3,5,12,14,3,5,5,17,6,5,4,9,6,5,12,17
	db 2,5,1,9,4,5,14,17,3,5,6,9,3,5,3,9,5,5,3,9,4,5,8,17,5,5,10,9,6,5,25,17,3,5,8,9,4,5,21,17,3,5,10,9,12,5,10,9,0,2,5,17,2,5,37,9,2,5,1,17,2,5,45,9,2,5,3,17,4,5,10,14,4,5,5,17,5,5,5,9,6,5,12,17,7,5,14,17,3,5,6,9,3,5,3,9,5,5,3,9,4,5,8,17,4,5,10,9,4,5,27,17,3,5,9,9,3,5,22,17,3,5,8,9,18,5,5,9,2,5,1,17,2,5,35,9,4,5,1,17,2,5,4,9,13,5,10,9,19,5,5,17,5,5,6,14,5,5,6,17,5,5,5,9,6,5,12,17,7,5,14,17,3,5,6,9,3,5,3,9,5,5,3,9,4,5,7,17,4,5,11,9,3,5,28,17,3,5,8,9,4,5,22,17,3,5,5,9,7,5,7,17,14,5,1,17,2,5,35,9,4,5,1,17,2,5,6,9,6,5,4,17,3,5,6,9,4,5,1,17
	db 14,5,8,17,14,5,7,17,5,5,5,9,6,5,12,17,2,5,1,9,4,5,14,17,3,5,6,9,3,5,3,9,5,5,3,9,4,5,6,17,5,5,10,9,4,5,28,17,2,5,9,9,3,5,23,17,2,5,5,9,6,5,12,17,11,5,1,17,2,5,9,9,7,5,4,9,9,5,3,9,6,5,3,17,3,5,3,9,7,5,4,17,3,5,5,9,4,5,7,17,7,5,11,17,12,5,8,17,5,5,5,9,6,5,12,17,2,5,1,9,4,5,13,17,3,5,7,9,3,5,2,9,3,5,1,14,3,5,2,9,4,5,6,17,3,5,12,9,3,5,29,17,2,5,8,9,3,5,24,17,2,5,5,9,2,5,24,17,2,5,3,17,2,5,3,9,12,5,4,9,17,5,4,17,7,5,10,17,3,5,5,9,3,5,28,17,8,5,10,17,4,5,7,9,5,5,12,17,2,5,1,9,4,5,12,17,3,5,6,9,5,5,2,9,2,5,3,14,2,5,2,9,4,5,6,17,3,5,10,9
	db 4,5,29,17,2,5,9,9,3,5,24,17,2,5,5,9,2,5,29,17,2,5,3,9,12,5,4,9,17,5,5,17,6,5,10,17,3,5,4,9,3,5,47,17,4,5,10,9,3,5,11,17,2,5,1,9,4,5,11,17,4,5,6,9,6,5,1,9,2,5,3,14,2,5,2,9,4,5,5,17,3,5,11,9,4,5,29,17,2,5,9,9,2,5,25,17,2,5,4,9,2,5,30,17,17,5,4,9,15,5,23,17,3,5,5,9,2,5,46,17,5,5,11,9,2,5,11,17,2,5,2,9,3,5,11,17,4,5,6,9,6,5,1,9,2,5,3,14,2,5,2,9,4,5,5,17,3,5,10,9,4,5,30,17,2,5,9,9,2,5,25,17,2,5,4,9,2,5,31,17,4,5,10,17,2,5,4,9,2,5,36,17,3,5,5,9,2,5,32,17,1,5,13,17,5,5,11,9,3,5,10,17,1,5,3,9,3,5,10,17,3,5,6,9,4,5,1,17,3,5,1,9,2,5,3,14,2,5,1,9
	db 5,5,5,17,3,5,10,9,4,5,30,17,2,5,9,9,2,5,24,17,3,5,4,9,2,5,31,17,3,5,11,17,2,5,4,9,2,5,36,17,3,5,5,9,2,5,31,17,2,5,13,17,5,5,11,9,3,5,10,17,1,5,3,9,3,5,10,17,3,5,6,9,4,5,1,17,3,5,1,9,2,5,3,14,2,5,1,9,5,5,5,17,3,5,10,9,4,5,30,17,2,5,9,9,2,5,24,17,2,5,5,9,2,5,45,17,2,5,4,9,2,5,36,17,3,5,5,9,2,5,31,17,3,5,12,17,5,5,11,9,3,5,10,17,1,5,3,9,3,5,10,17,2,5,7,9,2,5,4,17,3,5,1,9,5,5,2,9,5,5,5,17,3,5,10,9,4,5,30,17,2,5,9,9,2,5,23,17,2,5,6,9,2,5,45,17,2,5,4,9,2,5,36,17,3,5,5,9,2,5,30,17,4,5,12,17,5,5,11,9,3,5,9,17,2,5,3,9,3,5,10,17,2,5,7,9,2,5,4,17
	db 3,5,1,9,5,5,2,9,5,5,5,17,3,5,10,9,4,5,28,17,4,5,9,9,2,5,23,17,2,5,6,9,2,5,45,17,2,5,4,9,2,5,36,17,2,5,6,9,2,5,30,17,4,5,12,17,5,5,11,9,3,5,9,17,2,5,3,9,3,5,9,17,3,5,5,9,4,5,4,17,3,5,1,9,5,5,1,9,6,5,3,17,5,5,10,9,4,5,28,17,3,5,8,9,3,5,24,17,2,5,6,9,2,5,43,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,29,17,6,5,11,17,5,5,12,9,3,5,8,17,1,5,5,9,2,5,9,17,2,5,5,9,4,5,5,17,4,5,1,9,2,5,3,9,6,5,3,17,4,5,9,9,5,5,29,17,3,5,8,9,3,5,24,17,2,5,5,9,3,5,43,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,29,17,6,5,11,17,2,5,16,9,3,5,6,17,2,5,5,9,2,5,9,17,2,5,4,9,4,5,7,17
	db 3,5,6,9,4,5,5,17,4,5,9,9,5,5,29,17,3,5,8,9,3,5,24,17,2,5,5,9,3,5,43,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,29,17,3,5,1,9,2,5,11,17,2,5,16,9,3,5,6,17,1,5,5,9,3,5,8,17,2,5,5,9,2,5,10,17,3,5,3,9,6,5,5,17,4,5,9,9,5,5,28,17,4,5,7,9,4,5,24,17,2,5,4,9,3,5,44,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,28,17,4,5,1,9,2,5,11,17,2,5,4,9,1,5,11,9,3,5,6,17,2,5,4,9,3,5,8,17,2,5,5,9,2,5,10,17,3,5,3,9,6,5,4,17,4,5,9,9,6,5,28,17,4,5,7,9,3,5,25,17,2,5,4,9,3,5,44,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,28,17,3,5,3,9,2,5,9,17,2,5,4,9,2,5,12,9,2,5,7,17,1,5,4,9,3,5,8,17
	db 2,5,5,9,2,5,10,17,3,5,3,9,6,5,4,17,4,5,9,9,4,5,30,17,4,5,7,9,3,5,25,17,2,5,4,9,4,5,43,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,28,17,3,5,3,9,2,5,9,17,2,5,4,9,2,5,12,9,2,5,7,17,1,5,4,9,3,5,7,17,2,5,5,9,3,5,11,17,3,5,1,9,7,5,4,17,4,5,9,9,4,5,30,17,4,5,7,9,3,5,25,17,2,5,5,9,3,5,43,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,28,17,3,5,3,9,2,5,9,17,2,5,4,9,2,5,13,9,2,5,5,17,2,5,4,9,3,5,7,17,2,5,4,9,3,5,13,17,8,5,6,17,4,5,9,9,4,5,30,17,4,5,8,9,3,5,24,17,2,5,5,9,3,5,43,17,3,5,5,9,2,5,35,17,3,5,6,9,2,5,27,17,3,5,4,9,2,5,9,17,2,5,4,9,3,5,12,9,3,5,4,17
	db 2,5,4,9,3,5,6,17,3,5,3,9,3,5,15,17,6,5,7,17,4,5,10,9,5,5,28,17,4,5,8,9,3,5,24,17,2,5,5,9,3,5,43,17,3,5,5,9,3,5,34,17,3,5,7,9,2,5,26,17,3,5,4,9,2,5,9,17,2,5,5,9,2,5,13,9,2,5,4,17,2,5,4,9,3,5,6,17,3,5,3,9,3,5,15,17,6,5,7,17,4,5,10,9,5,5,28,17,4,5,8,9,4,5,23,17,2,5,6,9,3,5,18,17,7,5,17,17,3,5,6,9,2,5,34,17,2,5,8,9,2,5,26,17,3,5,5,9,1,5,9,17,2,5,5,9,3,5,12,9,3,5,4,17,1,5,4,9,3,5,6,17,3,5,2,9,4,5,28,17,5,5,9,9,6,5,28,17,4,5,9,9,4,5,21,17,2,5,6,9,9,5,9,17,10,5,16,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,26,17,3,5,5,9,1,5,9,17,2,5,5,9,3,5,12,9
	db 3,5,4,17,1,5,4,9,3,5,6,17,3,5,2,9,4,5,29,17,5,5,10,9,6,5,26,17,4,5,9,9,4,5,21,17,2,5,6,9,29,5,15,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,26,17,3,5,5,9,2,5,8,17,2,5,5,9,3,5,12,9,3,5,4,17,1,5,4,9,3,5,5,17,3,5,3,9,3,5,30,17,5,5,10,9,6,5,26,17,4,5,9,9,4,5,21,17,2,5,9,9,18,5,6,9,2,5,15,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,2,5,8,17,2,5,5,9,4,5,12,9,3,5,3,17,1,5,4,9,3,5,5,17,3,5,3,9,2,5,31,17,5,5,10,9,6,5,28,17,3,5,8,9,10,5,15,17,2,5,15,9,8,5,10,9,3,5,14,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,2,5,8,17,2,5,5,9,4,5,12,9,3,5,3,17
	db 1,5,4,9,3,5,5,17,3,5,3,9,2,5,33,17,4,5,10,9,11,5,22,17,7,5,6,9,13,5,10,17,2,5,33,9,3,5,14,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,7,17,2,5,6,9,4,5,12,9,2,5,3,17,1,5,5,9,2,5,5,17,3,5,3,9,2,5,33,17,8,5,9,9,14,5,17,17,8,5,6,9,15,5,6,17,2,5,34,9,2,5,14,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,7,17,2,5,6,9,4,5,12,9,2,5,2,17,2,5,5,9,2,5,5,17,3,5,3,9,2,5,35,17,9,5,8,9,16,5,15,17,9,5,9,9,10,5,5,17,2,5,33,9,3,5,14,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,7,17,2,5,6,9,4,5,12,9,2,5,2,17,2,5,4,9,3,5,5,17,3,5,3,9
	db 2,5,37,17,12,5,9,9,12,5,15,17,9,5,11,9,7,5,4,17,2,5,33,9,3,5,14,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,7,17,2,5,6,9,4,5,12,9,7,5,3,9,3,5,5,17,3,5,3,9,2,5,40,17,11,5,12,9,9,5,17,17,6,5,15,9,2,5,4,17,2,5,33,9,3,5,14,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,1,5,6,9,4,5,13,9,5,5,4,9,3,5,4,17,3,5,3,9,2,5,9,17,9,5,27,17,8,5,15,9,5,5,19,17,5,5,14,9,4,5,2,17,2,5,30,9,5,5,15,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,2,5,5,9,0,2,5,17,2,5,13,9,4,5,5,9,3,5,4,17,3,5,3,9,2,5,9,17,9,5,30,17,6,5,15,9,6,5,19,17
	db 3,5,15,9,3,5,2,17,2,5,26,9,8,5,16,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,2,5,5,9,0,2,5,17,2,5,14,9,3,5,5,9,3,5,4,17,3,5,3,9,2,5,8,17,12,5,31,17,3,5,17,9,4,5,20,17,3,5,15,9,2,5,2,17,2,5,11,9,1,5,9,9,12,5,17,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,2,5,5,9,1,5,2,17,2,5,13,9,1,5,7,9,3,5,4,17,3,5,3,9,2,5,7,17,4,5,4,17,5,5,32,17,3,5,17,9,3,5,20,17,3,5,15,9,2,5,2,17,3,5,10,9,16,5,23,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,2,5,5,9,1,5,2,17,2,5,21,9,3,5,4,17,3,5,3,9,2,5,7,17,4,5,4,17,5,5,32,17
	db 3,5,17,9,3,5,20,17,3,5,15,9,1,5,3,17,3,5,10,9,13,5,26,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,3,5,4,9,1,5,3,17,5,5,17,9,3,5,4,17,3,5,4,9,2,5,6,17,2,5,8,17,4,5,31,17,3,5,17,9,2,5,21,17,3,5,14,9,2,5,3,17,3,5,10,9,2,5,2,17,6,5,29,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,3,5,4,9,2,5,2,17,6,5,16,9,3,5,4,17,3,5,4,9,3,5,16,17,5,5,29,17,3,5,16,9,3,5,21,17,3,5,14,9,2,5,4,17,2,5,10,9,2,5,37,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,3,5,4,9,2,5,2,17,6,5,16,9,3,5,5,17,3,5,3,9,4,5,15,17,5,5,29,17,3,5,16,9
	db 3,5,21,17,3,5,13,9,3,5,4,17,2,5,9,9,3,5,37,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,8,17,3,5,4,9,2,5,2,17,6,5,15,9,4,5,5,17,3,5,3,9,4,5,15,17,5,5,29,17,3,5,14,9,5,5,21,17,3,5,13,9,2,5,5,17,2,5,9,9,3,5,37,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,9,17,2,5,4,9,2,5,3,17,5,5,15,9,4,5,5,17,3,5,3,9,4,5,15,17,5,5,29,17,3,5,14,9,4,5,22,17,3,5,13,9,2,5,5,17,3,5,8,9,3,5,37,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,9,17,3,5,3,9,2,5,3,17,6,5,14,9,4,5,5,17,3,5,4,9,3,5,15,17,6,5,28,17,3,5,13,9,4,5,23,17,3,5,12,9,3,5,5,17
	db 3,5,9,9,2,5,37,17,4,5,6,9,2,5,34,17,2,5,8,9,2,5,25,17,3,5,6,9,3,5,9,17,3,5,3,9,2,5,7,17,2,5,14,9,4,5,5,17,3,5,5,9,2,5,15,17,2,5,1,9,3,5,28,17,3,5,12,9,5,5,23,17,3,5,12,9,2,5,6,17,3,5,9,9,2,5,37,17,4,5,6,9,2,5,34,17,2,5,7,9,3,5,25,17,4,5,4,9,3,5,11,17,2,5,3,9,2,5,8,17,2,5,13,9,3,5,7,17,3,5,5,9,3,5,11,17,3,5,2,9,3,5,28,17,3,5,12,9,4,5,24,17,3,5,9,9,5,5,6,17,3,5,9,9,2,5,37,17,4,5,6,9,2,5,34,17,2,5,7,9,3,5,26,17,3,5,4,9,3,5,11,17,3,5,2,9,2,5,8,17,2,5,13,9,3,5,7,17,3,5,6,9,4,5,7,17,5,5,1,9,3,5,29,17,3,5,10,9,6,5,24,17,3,5,8,9,5,5,7,17
	db 3,5,9,9,2,5,38,17,3,5,6,9,2,5,34,17,2,5,7,9,2,5,27,17,3,5,4,9,3,5,12,17,2,5,2,9,3,5,7,17,3,5,10,9,5,5,7,17,3,5,6,9,4,5,7,17,5,5,1,9,3,5,29,17,3,5,9,9,5,5,25,17,4,5,7,9,6,5,8,17,3,5,8,9,2,5,38,17,3,5,5,9,3,5,34,17,2,5,7,9,2,5,27,17,3,5,4,9,3,5,12,17,2,5,2,9,3,5,7,17,3,5,10,9,5,5,7,17,3,5,6,9,4,5,7,17,5,5,1,9,3,5,28,17,4,5,8,9,5,5,26,17,3,5,8,9,5,5,9,17,3,5,8,9,2,5,38,17,3,5,5,9,2,5,35,17,2,5,7,9,2,5,27,17,3,5,4,9,3,5,12,17,2,5,2,9,3,5,7,17,3,5,10,9,3,5,9,17,3,5,6,9,15,5,2,9,3,5,28,17,3,5,9,9,4,5,27,17,3,5,7,9,6,5,9,17,3,5,8,9
	db 2,5,38,17,3,5,5,9,2,5,35,17,2,5,7,9,2,5,27,17,3,5,4,9,3,5,12,17,2,5,3,9,2,5,7,17,3,5,10,9,3,5,9,17,3,5,6,9,15,5,2,9,3,5,28,17,3,5,9,9,4,5,27,17,3,5,7,9,6,5,9,17,3,5,7,9,3,5,38,17,3,5,5,9,2,5,36,17,1,5,7,9,2,5,28,17,3,5,3,9,3,5,13,17,2,5,2,9,2,5,8,17,3,5,8,9,4,5,10,17,3,5,5,9,14,5,3,9,3,5,28,17,3,5,8,9,5,5,26,17,4,5,6,9,4,5,12,17,3,5,7,9,3,5,38,17,3,5,5,9,2,5,36,17,1,5,7,9,2,5,28,17,3,5,2,9,3,5,14,17,2,5,2,9,2,5,8,17,3,5,8,9,3,5,13,17,2,5,19,9,3,5,29,17,4,5,7,9,4,5,28,17,4,5,6,9,4,5,12,17,3,5,7,9,3,5,38,17,3,5,5,9,2,5,36,17,2,5,6,9
	db 2,5,28,17,3,5,2,9,3,5,14,17,3,5,1,9,2,5,9,17,3,5,7,9,3,5,13,17,4,5,17,9,2,5,30,17,4,5,7,9,4,5,28,17,4,5,6,9,4,5,12,17,3,5,7,9,3,5,38,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,28,17,3,5,2,9,3,5,14,17,3,5,1,9,2,5,9,17,4,5,6,9,3,5,13,17,4,5,17,9,2,5,30,17,4,5,7,9,4,5,28,17,4,5,6,9,4,5,12,17,3,5,8,9,2,5,18,17,5,5,15,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,28,17,4,5,1,9,3,5,15,17,2,5,1,9,2,5,11,17,4,5,2,9,3,5,16,17,4,5,14,9,4,5,30,17,4,5,7,9,4,5,28,17,3,5,6,9,4,5,13,17,4,5,6,9,26,5,15,17,3,5,5,9,2,5,36,17,2,5,6,9,2,5,29,17,3,5,1,9,3,5,15,17,2,5,1,9,2,5,11,17
	db 4,5,2,9,3,5,16,17,4,5,14,9,4,5,30,17,3,5,6,9,5,5,28,17,4,5,6,9,3,5,15,17,3,5,7,9,25,5,17,17,1,5,5,9,2,5,36,17,2,5,6,9,2,5,29,17,3,5,1,9,2,5,16,17,2,5,1,9,2,5,11,17,4,5,2,9,3,5,16,17,4,5,14,9,4,5,28,17,5,5,5,9,5,5,29,17,3,5,6,9,3,5,16,17,3,5,12,9,11,5,7,9,2,5,17,17,1,5,5,9,2,5,36,17,2,5,6,9,2,5,29,17,3,5,1,9,2,5,17,17,4,5,11,17,4,5,2,9,3,5,16,17,4,5,14,9,4,5,28,17,4,5,3,9,7,5,30,17,3,5,5,9,3,5,17,17,3,5,30,9,2,5,17,17,1,5,2,9,2,5,1,9,2,5,36,17,2,5,1,9,7,5,30,17,5,5,17,17,4,5,11,17,4,5,2,9,3,5,17,17,5,5,10,9,5,5,28,17,5,5,3,9,6,5,31,17,3,5,5,9
	db 3,5,17,17,3,5,29,9,3,5,17,17,0,2,5,9,6,5,36,17,10,5,30,17,5,5,18,17,4,5,10,17,8,5,19,17,8,5,4,9,6,5,29,17,5,5,3,9,6,5,31,17,3,5,3,9,5,5,17,17,3,5,29,9,3,5,17,17,8,5,36,17,10,5,30,17,5,5,18,17,4,5,10,17,8,5,22,17,12,5,32,17,5,5,2,9,7,5,29,17,12,5,18,17,3,5,7,9,14,5,9,9,2,5,17,17,3,5,2,17,3,5,36,17,4,5,3,17,3,5,31,17,3,5,19,17,4,5,10,17,8,5,22,17,12,5,30,17,14,5,31,17,11,5,19,17,35,5,17,17,3,5,2,17,3,5,36,17,4,5,3,17,3,5,31,17,3,5,19,17,4,5,12,17,4,5,24,17,12,5,30,17,13,5,34,17,3,5,1,17,5,5,21,17,33,5,17,17,2,5,4,17,2,5,36,17,3,5,4,17,3,5,32,17,2,5,20,17,3,5,13,17,1,5,30,17,6,5,34,17
	db 5,5,1,17,5,5,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17
	db 255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,49,17
	
	Credits_picture db 255,17,95,17,14,5,20,17,3,5,138,17,6,5,14,17,2,5,40,17,3,5,24,17,1,5,55,17,14,5,19,17,8,5,131,17,13,5,10,17,6,5,32,17,10,5,18,17,6,5,50,17,19,5,17,17,12,5,42,17,16,5,19,17,3,5,46,17,15,5,9,17,8,5,24,17,16,5,16,17,9,5,45,17,8,5,13,9,4,5,14,17,15,5,34,17,9,5,10,9,11,5,10,17,6,5,43,17,5,5,6,14,6,5,8,17,8,5,24,17,16,5,14,17,12,5,44,17,4,5,18,9,4,5,13,17,5,5,4,9,9,5,30,17,7,5,16,9,9,5,9,17,10,5,38,17,4,5,10,14,5,5,6,17,2,5,5,9,12,5,8,17,12,5,7,9,4,5,10,17,7,5,5,9,5,5,42,17,3,5,19,9,4,5,13,17,5,5,9,9,7,5,27,17,7,5,16,9,9,5,9,17,12,5,36,17,3,5,13,14,3,5,6,17,2,5,7,9,24,5,13,9,4,5,10,17,5,5,9,9
	db 3,5,38,17,6,5,22,9,2,5,13,17,5,5,9,9,7,5,26,17,5,5,23,9,6,5,8,17,12,5,35,17,4,5,14,14,3,5,4,17,2,5,18,9,8,5,22,9,2,5,9,17,4,5,10,9,4,5,34,17,7,5,24,9,3,5,12,17,5,5,2,9,1,5,7,9,9,5,20,17,5,5,30,9,2,5,8,17,14,5,33,17,3,5,15,14,3,5,4,17,2,5,18,9,8,5,22,9,2,5,8,17,4,5,11,9,4,5,34,17,6,5,26,9,2,5,11,17,6,5,2,9,3,5,8,9,8,5,17,17,5,5,31,9,3,5,7,17,15,5,32,17,3,5,15,14,3,5,4,17,2,5,18,9,8,5,22,9,2,5,8,17,4,5,11,9,3,5,35,17,6,5,15,9,4,5,7,9,2,5,11,17,6,5,2,9,3,5,8,9,8,5,17,17,5,5,31,9,3,5,8,17,5,5,1,9,10,5,30,17,4,5,14,14,3,5,4,17,2,5,48,9,2,5,8,17,4,5,11,9
	db 3,5,35,17,5,5,11,9,9,5,7,9,2,5,11,17,3,5,5,9,6,5,7,9,8,5,15,17,5,5,33,9,1,5,8,17,5,5,4,9,13,5,25,17,3,5,13,14,3,5,5,17,2,5,48,9,2,5,7,17,5,5,9,9,5,5,35,17,4,5,11,9,11,5,6,9,2,5,11,17,3,5,5,9,2,5,1,14,8,5,4,9,8,5,12,17,5,5,12,9,9,5,13,9,1,5,8,17,5,5,6,9,12,5,24,17,4,5,10,14,5,5,5,17,2,5,48,9,2,5,7,17,5,5,8,9,4,5,37,17,3,5,12,9,11,5,6,9,2,5,11,17,3,5,5,9,2,5,1,14,8,5,4,9,8,5,12,17,5,5,10,9,14,5,10,9,1,5,9,17,5,5,7,9,12,5,23,17,5,5,6,14,6,5,6,17,2,5,4,9,15,5,10,9,20,5,7,17,3,5,11,9,3,5,37,17,3,5,12,9,13,5,5,9,2,5,11,17,3,5,5,9,2,5,1,14,8,5,4,9
	db 8,5,12,17,5,5,8,9,20,5,5,9,2,5,9,17,5,5,10,9,11,5,22,17,15,5,7,17,2,5,6,9,8,5,4,17,3,5,6,9,4,5,1,17,15,5,9,17,3,5,10,9,4,5,35,17,4,5,10,9,5,5,9,17,2,5,5,9,2,5,11,17,3,5,5,9,2,5,5,14,5,5,7,9,4,5,12,17,5,5,5,9,7,5,9,17,14,5,9,17,5,5,11,9,12,5,21,17,13,5,9,17,3,5,3,9,9,5,4,17,3,5,5,9,4,5,7,17,8,5,11,17,2,5,11,9,3,5,35,17,4,5,8,9,7,5,10,17,2,5,5,9,2,5,11,17,2,5,6,9,2,5,7,14,4,5,7,9,4,5,11,17,2,5,7,9,6,5,14,17,11,5,9,17,6,5,15,9,8,5,22,17,8,5,12,17,7,5,12,17,3,5,5,9,3,5,27,17,2,5,10,9,3,5,36,17,4,5,8,9,7,5,10,17,2,5,5,9,2,5,11,17,2,5,6,9,2,5,9,14
	db 2,5,8,9,3,5,11,17,2,5,7,9,2,5,26,17,2,5,11,17,5,5,16,9,8,5,42,17,6,5,12,17,3,5,4,9,3,5,27,17,2,5,11,9,3,5,36,17,3,5,9,9,7,5,10,17,2,5,5,9,2,5,11,17,2,5,5,9,3,5,8,14,3,5,9,9,2,5,11,17,2,5,7,9,2,5,39,17,5,5,17,9,8,5,59,17,3,5,5,9,2,5,27,17,2,5,11,9,2,5,37,17,3,5,9,9,7,5,10,17,3,5,4,9,2,5,10,17,2,5,6,9,3,5,6,14,5,5,7,9,4,5,11,17,2,5,7,9,2,5,39,17,5,5,19,9,7,5,22,17,1,5,35,17,3,5,5,9,2,5,27,17,2,5,11,9,2,5,36,17,3,5,10,9,7,5,10,17,3,5,4,9,2,5,10,17,2,5,5,9,3,5,5,14,6,5,7,9,4,5,12,17,2,5,7,9,2,5,39,17,5,5,19,9,7,5,21,17,2,5,35,17,3,5,5,9,2,5,27,17
	db 2,5,11,9,2,5,36,17,3,5,9,9,4,5,14,17,3,5,4,9,2,5,6,17,5,5,6,9,3,5,1,14,7,5,9,9,5,5,12,17,2,5,6,9,2,5,40,17,5,5,20,9,7,5,20,17,3,5,34,17,3,5,5,9,2,5,27,17,2,5,11,9,2,5,36,17,3,5,9,9,4,5,15,17,3,5,3,9,2,5,6,17,5,5,6,9,9,5,10,9,4,5,13,17,3,5,6,9,2,5,40,17,6,5,9,9,5,5,6,9,7,5,18,17,4,5,34,17,3,5,5,9,2,5,27,17,2,5,11,9,2,5,35,17,3,5,6,9,8,5,15,17,3,5,3,9,1,5,7,17,4,5,7,9,4,5,11,9,6,5,15,17,2,5,7,9,2,5,41,17,5,5,8,9,8,5,5,9,7,5,17,17,4,5,34,17,2,5,6,9,2,5,23,17,6,5,11,9,2,5,35,17,3,5,6,9,8,5,15,17,3,5,3,9,1,5,7,17,4,5,18,9,10,5,14,17,2,5,8,9
	db 2,5,41,17,5,5,7,9,10,5,5,9,6,5,16,17,6,5,33,17,2,5,6,9,2,5,23,17,5,5,10,9,3,5,36,17,2,5,7,9,5,5,18,17,7,5,6,17,5,5,18,9,8,5,16,17,2,5,8,9,2,5,41,17,5,5,6,9,13,5,5,9,6,5,14,17,6,5,33,17,2,5,6,9,2,5,23,17,5,5,10,9,3,5,35,17,3,5,7,9,5,5,18,17,7,5,6,17,4,5,15,9,9,5,19,17,2,5,7,9,3,5,41,17,5,5,6,9,13,5,5,9,6,5,14,17,3,5,1,9,2,5,33,17,2,5,6,9,2,5,23,17,5,5,10,9,3,5,34,17,4,5,4,9,7,5,21,17,5,5,5,17,5,5,10,9,11,5,22,17,2,5,7,9,3,5,41,17,5,5,6,9,7,5,1,17,6,5,5,9,6,5,12,17,4,5,1,9,2,5,33,17,2,5,6,9,2,5,22,17,6,5,9,9,4,5,34,17,3,5,5,9,7,5,21,17,3,5,7,17
	db 5,5,8,9,10,5,25,17,2,5,6,9,3,5,43,17,4,5,6,9,7,5,2,17,5,5,6,9,6,5,11,17,3,5,3,9,2,5,32,17,2,5,6,9,2,5,22,17,6,5,9,9,3,5,35,17,3,5,5,9,7,5,31,17,3,5,10,9,5,5,30,17,2,5,6,9,3,5,43,17,5,5,5,9,7,5,2,17,6,5,5,9,6,5,11,17,3,5,3,9,2,5,32,17,2,5,6,9,2,5,22,17,6,5,9,9,3,5,34,17,4,5,5,9,3,5,35,17,3,5,10,9,5,5,30,17,2,5,6,9,4,5,42,17,5,5,5,9,6,5,3,17,6,5,6,9,5,5,11,17,3,5,3,9,2,5,32,17,2,5,6,9,2,5,22,17,6,5,9,9,3,5,34,17,3,5,6,9,3,5,35,17,3,5,10,9,4,5,31,17,2,5,7,9,3,5,42,17,5,5,5,9,6,5,4,17,5,5,6,9,8,5,7,17,3,5,4,9,2,5,31,17,3,5,6,9,2,5,22,17
	db 6,5,10,9,3,5,32,17,4,5,5,9,4,5,35,17,3,5,10,9,9,5,26,17,2,5,7,9,3,5,42,17,5,5,5,9,5,5,5,17,6,5,6,9,7,5,7,17,3,5,4,9,2,5,31,17,3,5,7,9,2,5,21,17,6,5,10,9,3,5,32,17,3,5,6,9,4,5,34,17,3,5,11,9,11,5,24,17,2,5,7,9,3,5,42,17,5,5,5,9,5,5,5,17,6,5,6,9,7,5,7,17,3,5,5,9,1,5,31,17,2,5,8,9,2,5,21,17,6,5,10,9,4,5,30,17,4,5,6,9,4,5,33,17,3,5,16,9,9,5,22,17,2,5,8,9,3,5,20,17,7,5,14,17,5,5,5,9,5,5,6,17,5,5,7,9,7,5,6,17,3,5,5,9,1,5,31,17,2,5,8,9,2,5,22,17,6,5,11,9,4,5,28,17,3,5,7,9,4,5,33,17,2,5,22,9,7,5,19,17,2,5,8,9,9,5,11,17,10,5,14,17,5,5,5,9,5,5,7,17
	db 5,5,6,9,7,5,6,17,3,5,5,9,2,5,30,17,2,5,8,9,2,5,22,17,6,5,11,9,4,5,28,17,3,5,7,9,4,5,33,17,2,5,24,9,6,5,18,17,2,5,8,9,31,5,13,17,5,5,5,9,5,5,7,17,5,5,6,9,7,5,5,17,3,5,6,9,2,5,30,17,2,5,8,9,2,5,22,17,6,5,11,9,4,5,26,17,4,5,7,9,2,5,36,17,2,5,26,9,6,5,16,17,2,5,11,9,20,5,6,9,2,5,12,17,5,5,6,9,5,5,7,17,5,5,6,9,7,5,5,17,3,5,6,9,2,5,30,17,2,5,8,9,2,5,26,17,3,5,10,9,11,5,19,17,4,5,7,9,2,5,36,17,2,5,28,9,5,5,15,17,2,5,17,9,10,5,10,9,3,5,11,17,5,5,6,9,5,5,7,17,5,5,7,9,6,5,5,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,26,17,9,5,6,9,14,5,14,17,4,5,7,9,2,5,36,17
	db 2,5,30,9,4,5,14,17,2,5,37,9,3,5,11,17,5,5,6,9,5,5,7,17,5,5,6,9,7,5,5,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,27,17,10,5,6,9,16,5,10,17,3,5,8,9,2,5,36,17,2,5,6,9,7,5,17,9,4,5,14,17,2,5,37,9,3,5,11,17,5,5,5,9,5,5,8,17,5,5,6,9,7,5,5,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,29,17,11,5,10,9,10,5,9,17,3,5,8,9,2,5,36,17,2,5,6,9,8,5,16,9,4,5,14,17,2,5,37,9,3,5,11,17,5,5,5,9,5,5,8,17,5,5,6,9,7,5,5,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,33,17,9,5,12,9,7,5,8,17,2,5,8,9,3,5,36,17,2,5,6,9,9,5,15,9,4,5,14,17,2,5,37,9,3,5,11,17,5,5,5,9,5,5,8,17,5,5,6,9,7,5,5,17,3,5,6,9
	db 3,5,29,17,2,5,8,9,2,5,37,17,6,5,16,9,2,5,7,17,3,5,8,9,3,5,36,17,2,5,6,9,2,5,2,17,6,5,14,9,4,5,14,17,2,5,34,9,5,5,11,17,6,5,5,9,5,5,7,17,5,5,7,9,7,5,5,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,39,17,5,5,15,9,4,5,5,17,3,5,8,9,3,5,36,17,3,5,5,9,2,5,5,17,9,5,10,9,3,5,13,17,2,5,34,9,5,5,11,17,5,5,6,9,5,5,7,17,5,5,6,9,7,5,6,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,41,17,3,5,16,9,3,5,5,17,3,5,8,9,3,5,37,17,2,5,5,9,3,5,7,17,7,5,10,9,3,5,12,17,2,5,30,9,8,5,12,17,5,5,6,9,4,5,7,17,5,5,7,9,7,5,6,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,16,9,2,5,5,17,3,5,8,9
	db 3,5,37,17,3,5,5,9,2,5,8,17,8,5,9,9,2,5,12,17,2,5,13,9,1,5,10,9,13,5,13,17,5,5,6,9,4,5,7,17,5,5,7,9,7,5,6,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,16,9,2,5,5,17,3,5,8,9,3,5,38,17,2,5,5,9,2,5,12,17,5,5,8,9,3,5,11,17,3,5,12,9,18,5,19,17,5,5,6,9,4,5,6,17,6,5,6,9,8,5,6,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,16,9,1,5,6,17,3,5,9,9,2,5,20,17,1,5,17,17,2,5,5,9,3,5,12,17,5,5,7,9,4,5,10,17,3,5,12,9,2,5,2,17,7,5,26,17,5,5,5,9,5,5,6,17,6,5,6,9,5,5,9,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,15,9,2,5,6,17,3,5,9,9,2,5,19,17,4,5,15,17,4,5,4,9
	db 2,5,14,17,4,5,7,9,3,5,11,17,2,5,12,9,2,5,35,17,5,5,5,9,5,5,5,17,6,5,6,9,6,5,9,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,15,9,2,5,6,17,4,5,8,9,2,5,19,17,4,5,15,17,5,5,3,9,2,5,14,17,4,5,7,9,3,5,11,17,2,5,11,9,3,5,34,17,5,5,6,9,5,5,1,17,9,5,6,9,6,5,10,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,14,9,3,5,6,17,4,5,8,9,5,5,15,17,6,5,14,17,5,5,3,9,2,5,16,17,3,5,6,9,3,5,11,17,2,5,11,9,3,5,34,17,5,5,6,9,4,5,1,17,10,5,6,9,6,5,10,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,14,9,2,5,8,17,3,5,9,9,4,5,14,17,3,5,2,9,3,5,14,17,4,5,3,9,5,5,13,17,4,5,6,9
	db 2,5,11,17,3,5,10,9,3,5,34,17,5,5,6,9,14,5,6,9,6,5,11,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,14,9,2,5,8,17,3,5,10,9,7,5,9,17,3,5,4,9,2,5,14,17,5,5,3,9,4,5,14,17,3,5,6,9,2,5,11,17,3,5,11,9,2,5,34,17,5,5,6,9,13,5,6,9,6,5,12,17,3,5,6,9,3,5,29,17,2,5,8,9,2,5,42,17,3,5,13,9,3,5,8,17,4,5,9,9,8,5,8,17,3,5,4,9,2,5,15,17,4,5,4,9,3,5,15,17,4,5,5,9,2,5,10,17,3,5,11,9,2,5,34,17,5,5,6,9,12,5,6,9,7,5,12,17,4,5,4,9,3,5,30,17,2,5,7,9,3,5,42,17,3,5,13,9,2,5,9,17,4,5,9,9,8,5,8,17,3,5,4,9,2,5,15,17,5,5,3,9,4,5,15,17,3,5,5,9,2,5,10,17,3,5,11,9,2,5,33,17
	db 5,5,8,9,4,5,10,9,7,5,16,17,3,5,4,9,3,5,30,17,2,5,7,9,3,5,42,17,3,5,10,9,5,5,11,17,3,5,11,9,8,5,5,17,3,5,4,9,2,5,15,17,5,5,4,9,4,5,14,17,4,5,5,9,2,5,10,17,5,5,8,9,2,5,33,17,5,5,21,9,7,5,17,17,3,5,4,9,3,5,30,17,2,5,7,9,2,5,43,17,3,5,9,9,5,5,12,17,3,5,11,9,8,5,5,17,2,5,5,9,2,5,15,17,5,5,5,9,3,5,14,17,4,5,5,9,2,5,10,17,5,5,8,9,2,5,33,17,5,5,19,9,8,5,18,17,3,5,4,9,3,5,30,17,2,5,7,9,2,5,42,17,4,5,8,9,6,5,12,17,3,5,13,9,10,5,1,17,2,5,5,9,2,5,19,17,2,5,5,9,3,5,14,17,4,5,4,9,2,5,10,17,5,5,8,9,2,5,33,17,5,5,18,9,8,5,19,17,3,5,4,9,3,5,30,17,2,5,7,9
	db 2,5,42,17,3,5,9,9,5,5,13,17,5,5,12,9,9,5,1,17,2,5,5,9,2,5,19,17,2,5,5,9,4,5,13,17,4,5,4,9,3,5,9,17,5,5,8,9,2,5,33,17,5,5,18,9,8,5,19,17,3,5,4,9,3,5,30,17,2,5,7,9,2,5,42,17,3,5,8,9,6,5,13,17,5,5,13,9,8,5,1,17,2,5,5,9,2,5,20,17,2,5,5,9,4,5,12,17,4,5,4,9,3,5,9,17,5,5,8,9,2,5,33,17,5,5,17,9,8,5,21,17,3,5,3,9,3,5,31,17,1,5,7,9,2,5,42,17,3,5,8,9,6,5,16,17,4,5,13,9,9,5,5,9,2,5,20,17,3,5,5,9,6,5,11,17,2,5,4,9,4,5,8,17,5,5,7,9,3,5,33,17,5,5,12,9,12,5,22,17,3,5,2,9,3,5,32,17,1,5,7,9,2,5,41,17,4,5,7,9,4,5,20,17,4,5,14,9,6,5,6,9,2,5,20,17,3,5,6,9
	db 6,5,10,17,3,5,4,9,3,5,8,17,5,5,7,9,3,5,33,17,5,5,10,9,12,5,24,17,3,5,2,9,3,5,32,17,2,5,6,9,2,5,41,17,4,5,7,9,4,5,20,17,4,5,26,9,2,5,20,17,3,5,7,9,5,5,11,17,2,5,4,9,3,5,8,17,5,5,7,9,3,5,33,17,5,5,9,9,12,5,25,17,3,5,2,9,3,5,32,17,2,5,6,9,2,5,41,17,4,5,7,9,4,5,21,17,6,5,23,9,2,5,21,17,3,5,7,9,6,5,9,17,3,5,4,9,2,5,8,17,5,5,8,9,2,5,20,17,5,5,7,17,5,5,6,9,13,5,28,17,4,5,1,9,3,5,32,17,2,5,6,9,2,5,41,17,4,5,7,9,4,5,23,17,5,5,21,9,3,5,21,17,4,5,9,9,3,5,10,17,2,5,4,9,4,5,7,17,5,5,7,9,27,5,7,17,5,5,4,9,14,5,30,17,3,5,1,9,3,5,32,17,2,5,6,9,2,5,41,17
	db 3,5,7,9,4,5,24,17,6,5,20,9,3,5,21,17,4,5,9,9,3,5,10,17,3,5,4,9,3,5,7,17,5,5,12,9,13,5,7,9,2,5,7,17,5,5,2,9,11,5,35,17,3,5,1,9,2,5,33,17,2,5,6,9,2,5,40,17,4,5,7,9,3,5,25,17,7,5,19,9,3,5,21,17,5,5,8,9,3,5,10,17,3,5,4,9,3,5,7,17,5,5,14,9,8,5,10,9,2,5,7,17,16,5,37,17,3,5,1,9,2,5,33,17,2,5,6,9,2,5,40,17,3,5,7,9,3,5,29,17,7,5,14,9,5,5,21,17,5,5,8,9,3,5,10,17,3,5,4,9,3,5,7,17,5,5,32,9,2,5,7,17,14,5,40,17,5,5,33,17,2,5,1,9,7,5,40,17,3,5,6,9,3,5,30,17,9,5,12,9,5,5,22,17,4,5,8,9,2,5,11,17,3,5,6,9,1,5,7,17,5,5,31,9,3,5,7,17,12,5,42,17,5,5,33,17,10,5,40,17
	db 3,5,6,9,3,5,31,17,10,5,8,9,3,5,26,17,5,5,7,9,2,5,11,17,3,5,6,9,1,5,7,17,5,5,32,9,2,5,7,17,10,5,44,17,5,5,33,17,10,5,40,17,3,5,3,9,6,5,38,17,6,5,3,9,5,5,26,17,4,5,5,9,5,5,12,17,10,5,6,17,5,5,12,9,9,5,11,9,2,5,7,17,8,5,47,17,3,5,34,17,4,5,3,17,3,5,38,17,13,5,39,17,14,5,27,17,12,5,13,17,11,5,5,17,39,5,7,17,8,5,47,17,3,5,34,17,4,5,3,17,3,5,38,17,12,5,44,17,8,5,29,17,11,5,13,17,4,5,4,17,4,5,9,17,35,5,8,17,4,5,51,17,2,5,34,17,3,5,4,17,3,5,40,17,3,5,1,17,6,5,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17
	db 255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17
	db 255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,47,17
	
	Arena db 255,17,255,17,255,17,255,17,255,17,24,17,54,5,176,17,54,5,36,17,54,5,176,17,54,5,36,17,54,5,176,17,54,5,36,17,2,5,50,14,2,5,176,17,2,5,50,14,2,5,36,17,2,5,27,14,1,8,22,14,2,5,176,17,2,5,25,14,1,16,3,14,3,16,0,2,8,7,16,14,2,5,36,17,2,5,22,14,7,16,1,7,20,14,2,5,176,17,2,5,25,14,6,16,0,2,14,7,3,16,14,14,2,5,36,17,2,5,16,14,1,8,5,14,8,16,1,7,19,14,2,5,176,17,2,5,23,14,2,16,3,14,3,16,0,2,14,7,3,14,0,4,16,14,8,16,10,14,2,5,36,17,2,5,15,14,3,16,2,7,2,8,11,16,1,8,16,14,2,5,176,17,2,5,21,14,12,16,2,14,3,16,12,14,2,5,36,17,2,5,15,14,19,16,1,7,15,14,2,5,176,17,2,5,20,14,11,16,0,3,8,7,14,2,16,0,2,14,16,12,14,2,5,36,17,2,5,15,14,20
	db 16,15,14,2,5,176,17,2,5,19,14,1,16,2,14,2,16,1,7,3,14,1,7,2,16,3,14,2,16,2,14,0,2,16,7,10,14,2,5,36,17,2,5,13,14,1,8,21,16,1,8,14,14,2,5,26,17,122,5,28,17,2,5,18,14,1,16,5,14,1,8,4,16,5,14,0,2,16,14,4,16,10,14,2,5,36,17,2,5,11,14,25,16,14,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,16,14,2,16,17,14,0,3,16,14,8,2,16,10,14,2,5,36,17,2,5,10,14,1,8,27,16,0,2,8,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,15,14,1,16,10,14,1,8,2,16,0,2,8,7,5,14,5,16,9,14,2,5,36,17,2,5,9,14,1,7,30,16,1,8,9,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,15,14,1,16,7,14,1,7,9,16,1,8,6,14,1,16,9,14,2,5,36,17,2,5,9,14,33,16,8,14,2,5,26,17
	db 1,5,120,16,1,5,28,17,2,5,14,14,2,16,5,14,1,16,12,14,2,16,5,14,1,16,8,14,2,5,36,17,2,5,7,14,33,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,14,14,1,16,6,14,2,16,6,14,4,16,2,14,2,8,4,14,1,16,8,14,2,5,36,17,2,5,7,14,33,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,14,14,1,16,17,14,1,7,2,16,1,8,2,16,3,14,1,16,8,14,2,5,36,17,2,5,7,14,22,16,2,14,9,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,13,14,1,16,23,14,1,16,3,14,1,16,8,14,2,5,36,17,2,5,7,14,21,16,4,14,8,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,13,14,1,8,23,14,1,16,3,14,1,16,8,14,2,5,36,17,2,5,7,14,16,16,1,7,12,14,4,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17
	db 2,5,13,14,1,16,24,14,2,16,0,2,14,16,8,14,2,5,36,17,2,5,6,14,15,16,16,14,1,8,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,13,14,1,16,27,14,1,16,8,14,2,5,36,17,2,5,6,14,15,16,17,14,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,13,14,1,16,27,14,1,16,8,14,2,5,36,17,2,5,6,14,15,16,1,8,16,14,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,14,14,1,16,26,14,1,16,8,14,2,5,36,17,2,5,6,14,16,16,16,14,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,14,14,1,16,25,14,0,2,7,16,8,14,2,5,36,17,2,5,6,14,16,16,16,14,0,2,7,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,14,14,0,2,8,16,24,14,1,16,9,14,2,5,36,17,2,5,6,14,16,16,7,14,2,16
	db 19,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,15,14,1,16,24,14,1,16,9,14,2,5,36,17,2,5,6,14,15,16,1,8,5,14,0,2,8,7,7,14,1,7,3,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,16,14,1,16,23,14,1,16,9,14,2,5,36,17,2,5,7,14,13,16,16,14,2,16,0,2,8,7,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,16,14,0,2,16,7,22,14,1,16,9,14,2,5,36,17,2,5,7,14,13,16,9,14,3,16,4,14,1,16,13,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,17,14,1,16,21,14,1,16,10,14,2,5,36,17,2,5,7,14,13,16,8,14,0,2,16,14,3,16,1,8,2,14,4,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,18,14,1,16,19,14,1,8,11,14,2,5,36,17,2,5,7,14,3,16,3,14,7,16,10,14,2,16,4,14,2,16,0,2
	db 7,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,19,14,0,2,16,7,4,14,2,16,10,14,1,16,12,14,2,5,36,17,2,5,7,14,13,16,19,14,1,8,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,20,14,0,3,16,7,8,2,16,0,2,14,16,9,14,1,16,13,14,2,5,36,17,2,5,7,14,3,16,3,14,1,7,6,16,9,14,2,16,5,14,4,8,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,20,14,1,8,3,16,2,14,1,16,8,14,1,16,14,14,2,5,36,17,2,5,7,14,3,16,3,14,7,16,9,14,2,8,6,14,1,8,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,17,14,4,16,2,14,1,7,11,16,15,14,2,5,36,17,2,5,7,14,1,8,2,16,1,14,3,16,0,2,8,14,4,16,30,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,14,14,1,7,3,16,8,14,1,7,2
	db 16,21,14,2,5,36,17,2,5,8,14,2,16,2,14,0,4,16,14,16,14,4,16,30,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,12,14,1,7,2,16,1,8,10,14,0,3,7,14,16,21,14,2,5,36,17,2,5,8,14,3,16,5,14,4,16,30,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,11,14,2,16,13,14,1,16,23,14,2,5,36,17,2,5,8,14,3,16,5,14,4,16,30,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,10,14,2,16,15,14,0,3,16,14,16,20,14,2,5,36,17,2,5,9,14,5,16,0,2,2,7,6,16,11,14,1,8,3,16,1,8,12,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,10,14,1,16,16,14,0,2,7,14,2,16,19,14,2,5,36,17,2,5,9,14,1,8,5,16,1,14,6,16,13,14,0,3,8,16,7,12,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,9,14,1,16,17,14,1,8
	db 2,14,1,16,19,14,2,5,36,17,2,5,10,14,5,16,1,14,11,16,1,8,8,14,0,2,16,7,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,8,14,2,16,17,14,1,16,3,14,1,16,18,14,2,5,36,17,2,5,10,14,19,16,9,14,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,8,14,1,16,18,14,1,16,3,14,1,16,18,14,2,5,36,17,2,5,10,14,19,16,9,14,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,8,14,1,16,18,14,1,16,4,14,1,16,17,14,2,5,36,17,2,5,11,14,11,16,10,14,1,17,6,16,1,7,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,7,14,1,8,19,14,2,16,3,14,2,16,16,14,2,5,36,17,2,5,11,14,11,16,7,14,0,2,16,8,7,16,12,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,7,14,1,16,19,14,0,2,7,16
	db 4,14,0,2,16,7,15,14,2,5,36,17,2,5,11,14,11,16,7,14,9,16,12,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,1,16,21,14,1,16,5,14,2,16,14,14,2,5,36,17,2,5,11,14,11,16,9,14,6,16,1,7,12,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,1,16,21,14,1,7,7,14,2,16,12,14,2,5,36,17,2,5,11,14,11,16,9,14,5,16,14,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,1,16,22,14,1,16,6,14,1,8,2,16,11,14,2,5,36,17,2,5,13,14,9,16,2,14,1,7,4,14,3,16,18,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,1,16,23,14,1,16,8,14,1,8,2,16,1,8,8,14,2,5,36,17,2,5,13,14,9,16,7,14,3,16,18,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,0,2,16,8,22,14,1,16,11,14,3,16
	db 6,14,2,5,36,17,2,5,14,14,8,16,1,7,2,14,2,16,2,14,7,16,14,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,3,14,5,16,1,8,20,14,0,2,16,7,12,14,1,8,2,16,4,14,2,5,36,17,2,5,18,14,10,16,0,2,14,8,6,16,14,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,3,14,3,16,2,14,1,16,20,14,2,16,13,14,3,16,3,14,2,5,36,17,2,5,20,14,10,16,1,8,3,16,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,3,14,3,16,2,14,2,16,19,14,2,16,14,14,3,16,2,14,2,5,36,17,2,5,20,14,13,16,1,7,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,14,0,4,16,8,16,7,23,14,0,2,8,16,14,14,0,2,16,7,2,16,1,14,2,5,36,17,2,5,20,14,12,16,1,7,17,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,14,0,5
	db 16,14,16,14,16,23,14,1,16,14,14,0,2,16,14,2,16,1,14,2,5,36,17,2,5,20,14,11,16,1,8,18,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,14,0,3,16,14,7,2,14,1,16,22,14,0,2,16,7,13,14,0,5,16,14,8,16,14,2,5,36,17,2,5,20,14,1,7,10,16,19,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,14,1,16,28,14,1,16,13,14,1,7,2,14,0,2,16,14,2,5,36,17,2,5,22,14,8,16,1,8,19,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,31,14,1,16,18,14,2,5,36,17,2,5,50,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,31,14,1,16,18,14,2,5,36,17,2,5,50,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,50,14,2,5,36,17,54,5,26,17,1,5,120,16,1,5,28,17,2,5,50,14,2,5,36,17,54,5,26,17,1,5,120,16,1,5,28
	db 17,54,5,36,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,116,17,1,5,120,16,1,5,198,17,1,5,120,16,1,5,118,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,36,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,36,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,36,17,2,5,22,14,2,16,0,2,7,8,6,16,18,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,50,14,2,5,36,17,2,5,19,14,4,16,9,14,2,16,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,19,14,0,2,7,8,3,17,0,2,8,7,24,14,2,5,36,17,2,5,17,14,3,16,8,14,2,16,3,14,0,2,7,8,15,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,16,14,0,2,7,6,10,16,1,7,21,14,2,5,36,17,2,5,14,14,4,16,6,14,1,7,2,14,7,16,1,17,2,16,13,14,2,5,26,17,1,5,120,16,1
	db 5,28,17,2,5,14,14,1,8,3,16,0,2,6,17,5,14,2,17,4,16,19,14,2,5,36,17,2,5,13,14,2,16,1,14,2,7,7,14,1,7,6,16,0,4,14,16,7,14,2,16,12,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,12,14,1,7,3,16,1,17,12,14,1,6,2,16,1,8,17,14,2,5,36,17,2,5,12,14,3,16,0,3,14,16,8,2,16,6,14,0,2,16,8,2,16,1,14,2,16,0,2,14,16,2,14,1,16,12,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,10,14,1,6,2,16,1,17,8,14,6,16,2,17,2,14,2,16,1,7,15,14,2,5,36,17,2,5,11,14,2,16,2,14,1,16,2,14,0,2,8,16,6,14,2,16,0,2,14,7,3,16,0,2,14,16,3,14,1,16,11,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,9,14,1,7,2,16,8,14,2,16,1,17,10,14,0,3,17,16,8,14,14,2,5,36,17,2
	db 5,10,14,2,16,1,14,3,16,3,14,0,2,16,7,4,14,0,9,8,16,14,8,14,7,16,14,16,2,7,2,14,2,16,10,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,8,14,1,7,2,16,12,14,0,2,17,6,2,16,0,2,6,17,5,14,0,3,17,16,6,13,14,2,5,36,17,2,5,9,14,2,16,1,14,2,16,1,8,5,14,1,16,4,14,0,3,16,14,16,6,14,2,16,3,14,0,2,16,7,9,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,8,14,2,16,13,14,0,2,17,16,3,7,0,2,17,16,5,14,0,3,6,16,7,12,14,2,5,36,17,2,5,9,14,1,16,2,14,0,3,16,8,16,5,14,2,16,3,14,0,3,7,14,8,6,14,2,16,4,14,1,16,9,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,7,14,0,3,7,16,17,13,14,1,17,6,14,1,8,5,14,0,3,6,16,7,11,14,2,5,36,17,2,5,8,14,1
	db 16,2,14,3,16,6,14,2,16,13,14,2,16,3,14,0,2,7,16,8,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,7,14,0,2,16,6,2,14,1,16,11,14,1,8,7,14,1,16,5,14,2,16,11,14,2,5,36,17,2,5,7,14,1,16,3,14,1,16,9,14,1,16,13,14,1,7,2,16,3,14,2,16,7,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,0,2,7,16,2,14,0,2,16,17,10,14,1,17,4,14,1,16,3,14,0,2,7,17,5,14,2,16,10,14,2,5,36,17,2,5,6,14,2,16,2,14,0,2,16,8,9,14,1,7,14,14,2,16,0,4,7,14,8,14,2,16,6,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,0,5,8,17,14,17,6,11,14,1,17,4,14,2,16,3,14,1,6,5,14,0,2,6,16,10,14,2,5,36,17,2,5,6,14,0,5,16,14,7,16,7,20,14,4,16,2,14,2,16,0,6,7,14,16
	db 7,14,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,1,16,2,14,1,16,12,14,0,2,17,7,3,14,0,2,16,8,3,14,1,16,6,14,2,16,9,14,2,5,36,17,2,5,5,14,1,16,2,14,2,16,20,14,0,2,16,8,2,14,2,16,0,2,14,8,2,16,0,2,14,16,2,14,2,16,4,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,1,16,2,17,2,14,0,3,17,14,17,2,16,8,14,0,2,17,7,6,14,1,16,8,14,2,16,8,14,2,5,36,17,2,5,4,14,1,16,5,14,0,4,7,16,7,14,2,16,12,14,1,16,5,14,3,16,5,14,2,16,1,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,0,3,16,14,17,2,14,1,17,2,16,1,6,2,16,8,14,1,16,5,14,1,17,9,14,0,3,17,16,17,7,14,2,5,36,17,2,5,3,14,3,16,3,14,2,7,4,14,2,16,10,14
	db 1,16,9,14,1,16,5,14,1,8,2,14,1,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,7,16,3,14,1,6,5,14,0,2,8,17,8,14,0,2,16,8,2,7,1,6,2,14,1,17,8,14,2,16,7,14,2,5,36,17,2,5,2,14,2,16,5,14,1,16,5,14,2,16,10,14,1,7,9,14,0,2,16,7,7,14,2,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,8,17,2,14,1,6,3,14,1,7,3,14,1,16,9,14,2,17,3,14,1,17,9,14,0,2,17,16,7,14,2,5,36,17,2,5,2,14,1,16,5,14,1,16,8,14,1,16,8,14,1,16,11,14,1,16,8,14,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,16,17,2,14,1,7,3,14,0,2,16,8,2,14,0,2,8,17,6,14,2,17,5,14,1,16,10,14,1,16,7,14,2,5,36,17,2,5,1,14,2,16
	db 14,14,1,16,8,14,0,4,8,14,7,8,3,16,1,8,4,14,1,16,6,14,0,3,8,14,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,2,14,1,17,4,14,0,2,6,8,3,14,1,16,7,14,2,6,3,14,1,17,11,14,0,2,16,17,6,14,2,5,36,17,2,5,2,16,0,2,14,8,3,14,0,4,7,14,7,16,3,8,3,16,1,8,8,14,1,16,9,14,3,16,1,8,5,14,0,3,16,14,8,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,2,14,1,17,8,14,0,3,8,17,6,7,14,0,5,17,16,17,16,17,11,14,0,2,17,16,6,14,2,5,36,17,2,5,1,16,2,14,1,7,3,14,2,16,8,14,1,7,7,14,1,16,4,14,3,16,5,14,0,2,7,16,5,14,0,3,8,14,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,3,14,1,16,7,14,0,3,17,14,16
	db 14,14,1,17,9,14,1,16,6,14,2,5,36,17,2,5,1,7,6,14,1,8,4,14,0,2,8,16,20,14,1,16,10,14,0,3,16,14,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,3,14,0,2,17,16,5,14,1,16,2,14,1,16,7,14,1,17,5,14,1,6,10,14,1,16,6,14,2,5,36,17,2,5,0,3,16,14,16,3,14,1,7,38,14,0,2,16,14,2,16,1,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,3,14,0,2,17,14,2,17,2,6,1,17,3,14,2,17,7,14,4,17,1,16,11,14,1,16,6,14,2,5,36,17,2,5,0,3,16,14,16,14,14,1,7,27,14,1,8,2,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,3,14,0,2,7,16,5,14,3,16,1,17,5,14,0,2,16,6,16,14,2,17,4,14,1,16,6,14,2,5,36,17,2,5,0,3,16,14,7,4,14,0,2
	db 16,7,6,14,0,2,8,16,10,14,3,16,0,2,8,7,2,14,0,4,7,16,7,16,6,14,1,8,3,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,3,14,1,17,2,14,1,17,7,14,1,17,16,14,0,2,17,16,5,14,1,16,6,14,2,5,36,17,2,5,1,16,6,14,1,7,8,16,13,14,1,8,6,16,1,8,7,14,1,16,3,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,3,14,0,2,6,16,4,14,2,17,18,14,0,4,16,8,7,16,5,14,1,16,6,14,2,5,36,17,2,5,1,16,8,14,5,16,16,14,1,8,2,16,1,8,14,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,5,14,3,16,1,17,17,14,0,3,17,16,7,3,14,1,16,5,14,1,16,6,14,2,5,36,17,2,5,0,3,16,14,8,40,14,1,16,3,14,0,3,8,16,14,2
	db 5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,24,14,0,2,17,16,6,14,1,16,5,14,1,16,6,14,2,5,36,17,2,5,0,3,16,14,8,39,14,1,16,5,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,22,14,0,3,17,16,7,7,14,1,16,4,14,0,2,17,16,6,14,2,5,36,17,2,5,1,16,40,14,1,16,6,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,19,14,1,17,2,16,1,7,9,14,1,6,4,14,0,2,17,8,6,14,2,5,36,17,2,5,1,16,2,14,1,16,36,14,0,2,16,7,6,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,16,16,14,1,17,2,16,1,8,12,14,1,17,4,14,1,16,7,14,2,5,36,17,2,5,1,16,3,14,1,8,34,14,2,16,7,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28
	db 17,2,5,4,14,1,16,14,14,1,17,2,16,1,8,13,14,0,2,8,17,4,14,1,16,7,14,2,5,36,17,2,5,1,16,3,14,2,16,30,14,2,16,4,14,1,8,5,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,6,17,6,14,1,17,2,16,0,2,8,7,17,14,1,8,2,16,4,14,0,2,17,16,7,14,2,5,36,17,2,5,1,16,5,14,1,16,26,14,1,8,3,16,11,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,8,16,2,14,0,5,17,6,16,6,7,20,14,2,16,0,2,7,6,4,14,0,2,16,17,7,14,2,5,36,17,2,5,1,8,4,14,5,16,1,7,16,14,1,7,4,16,3,14,0,4,16,14,7,16,9,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,7,16,2,14,0,2,16,8,22,14,2,16,2,14,1,17,4,14,1,16,8,14
	db 2,5,36,17,2,5,1,8,4,14,1,8,2,14,1,7,2,14,1,8,2,16,0,2,8,7,4,14,2,7,1,8,7,16,5,14,1,8,2,14,1,7,9,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,1,16,3,14,1,6,20,14,0,3,8,16,7,2,14,1,7,4,14,0,2,17,16,8,14,2,5,36,17,2,5,1,16,11,14,0,2,7,16,4,14,0,2,7,8,4,14,0,2,16,7,4,14,1,16,3,14,1,16,4,14,1,7,8,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,0,2,16,17,2,14,1,6,18,14,0,3,8,16,8,4,14,1,16,4,14,2,16,8,14,2,5,36,17,2,5,1,16,9,14,2,16,3,14,1,16,7,14,1,7,24,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,0,2,8,16,19,14,0,3,7,16,7,6,14,1,16,4,14,1,16,9,14,2,5,36
	db 17,2,5,2,16,13,14,1,8,2,14,2,16,2,14,2,16,24,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,0,2,7,16,3,14,1,7,14,14,0,3,8,16,7,6,14,0,2,8,17,4,14,1,16,9,14,2,5,36,17,2,5,0,2,14,16,13,14,0,3,16,14,7,2,14,2,16,26,14,0,2,8,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,0,2,16,17,2,14,0,2,17,7,10,14,1,7,2,16,9,14,1,16,4,14,0,2,17,16,9,14,2,5,36,17,2,5,0,2,14,16,18,14,1,16,27,14,0,2,8,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,0,2,8,16,3,14,2,16,1,7,4,14,0,4,7,8,16,6,11,14,0,2,7,16,4,14,1,16,10,14,2,5,36,17,2,5,0,2,7,16,12,14,1,8,33,14,0,2,7,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,0
	db 2,7,16,3,14,0,3,17,16,6,3,16,2,8,1,7,13,14,0,2,16,17,4,14,1,16,10,14,2,5,36,17,2,5,2,16,12,14,1,7,4,14,1,8,29,14,1,16,2,5,26,17,1,5,120,16,1,5,28,17,2,5,7,14,0,2,8,16,4,14,0,2,16,7,16,14,0,3,8,16,17,4,14,0,2,16,17,10,14,2,5,36,17,2,5,2,16,1,8,16,14,1,16,29,14,1,16,2,5,26,17,1,5,120,16,1,5,28,17,2,5,8,14,0,2,16,6,3,14,0,2,17,16,16,14,0,2,16,17,4,14,0,2,17,16,11,14,2,5,36,17,2,5,1,14,2,16,16,14,1,16,29,14,1,16,2,5,26,17,1,5,120,16,1,5,28,17,2,5,8,14,0,2,8,16,4,14,2,16,14,14,2,16,5,14,0,2,6,16,11,14,2,5,36,17,2,5,1,14,2,16,16,14,1,16,29,14,1,16,2,5,26,17,1,5,120,16,1,5,28,17,2,5,9,14,0,2,16,6,4
	db 14,0,2,6,8,12,14,2,16,6,14,0,2,16,8,11,14,2,5,36,17,2,5,0,4,14,8,14,16,15,14,1,8,28,14,2,7,2,5,26,17,1,5,120,16,1,5,28,17,2,5,10,14,0,2,16,6,4,14,0,2,6,16,9,14,0,3,7,16,17,6,14,0,2,17,16,12,14,2,5,36,17,2,5,3,14,1,16,15,14,1,7,28,14,0,2,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,10,14,1,8,2,16,5,14,0,2,16,7,5,14,1,7,2,16,8,14,0,2,16,8,12,14,2,5,36,17,2,5,3,14,2,16,45,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,11,14,2,16,1,17,5,14,2,16,0,4,7,14,7,8,2,16,1,17,7,14,0,2,17,16,13,14,2,5,36,17,2,5,3,14,2,16,42,14,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,12,14,0,3,17,16,6,6,14,2,17,0,2,6,17,9,14,0
	db 3,17,16,6,13,14,2,5,36,17,2,5,5,14,1,16,41,14,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,13,14,1,6,2,16,1,17,16,14,1,17,2,16,14,14,2,5,36,17,2,5,5,14,1,16,40,14,0,2,7,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,16,14,4,16,1,17,9,14,1,17,2,16,1,17,16,14,2,5,36,17,2,5,3,14,1,16,2,14,1,7,39,14,2,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,18,14,1,8,6,16,2,6,4,16,1,8,18,14,2,5,36,17,2,5,3,14,2,7,0,3,14,16,7,37,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,23,14,5,7,22,14,2,5,36,17,2,5,8,14,2,16,35,14,1,16,4,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,50,14,2,5,36,17,2,5,10,14,1,16,34,14,1,16,4,14,2,5,26
	db 17,1,5,120,16,1,5,28,17,2,5,50,14,2,5,36,17,2,5,11,14,1,8,33,14,1,16,4,14,2,5,26,17,1,5,120,16,1,5,28,17,54,5,36,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,36,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,116,17,1,5,120,16,1,5,198,17,1,5,120,16,1,5,118,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,36,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,36,17,54,5,26,17,1,5,120,16,1,5,28,17,54,5,36,17,2,5,19,14,1,7,4,8,2,7,24,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,50,14,2,5,36,17,2,5,13,14,1,7,17,16,2,8,17,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,50,14,2,5,36,17,2,5,12,14,5,16,2,14,2,7,5,14,1,7,2,8,5,16,16,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,21
	db 14,5,16,24,14,2,5,36,17,2,5,9,14,1,7,3,16,2,8,0,2,7,8,3,7,11,14,2,8,3,16,14,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,17,14,11,16,1,7,2,16,19,14,2,5,36,17,2,5,8,14,2,16,2,7,4,14,4,8,11,14,9,16,1,7,9,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,14,14,2,16,0,2,7,16,13,14,2,16,17,14,2,5,36,17,2,5,7,14,2,16,5,14,1,7,5,16,2,8,1,7,7,14,3,8,0,3,7,14,7,2,8,5,16,7,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,12,14,2,7,1,16,18,14,0,2,16,7,15,14,2,5,36,17,2,5,6,14,0,3,7,16,7,3,14,4,16,1,7,3,14,10,8,7,14,3,8,5,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,11,14,1,16,2,8,20,14,0,2,8,16,14,14,2,5,36,17,2,5,5,14,0
	db 2,8,16,3,14,4,16,3,14,2,7,0,2,14,7,10,8,4,14,3,16,2,8,7,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,9,14,1,16,26,14,1,7,2,16,11,14,2,5,36,17,2,5,3,14,2,8,0,3,16,8,14,4,16,1,7,2,14,7,16,12,14,2,16,5,14,4,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,7,14,2,16,1,7,27,14,3,7,10,14,2,5,36,17,2,5,3,14,3,16,1,14,3,16,4,14,1,16,6,14,0,2,7,16,10,14,0,2,16,7,5,14,5,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,7,14,1,16,31,14,0,2,16,7,9,14,2,5,36,17,2,5,2,14,1,8,2,16,0,2,14,8,2,16,1,8,3,14,1,16,8,14,2,16,7,14,2,7,1,16,4,14,2,7,2,16,1,8,2,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,2,16,32,14
	db 0,2,7,16,8,14,2,5,36,17,2,5,2,14,3,16,0,4,14,8,14,7,3,14,2,16,9,14,1,16,7,14,2,16,7,14,0,5,7,16,14,8,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,1,16,34,14,1,7,8,14,2,5,36,17,2,5,2,14,1,16,9,14,1,16,10,14,1,16,7,14,2,16,10,14,2,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,2,7,43,14,2,5,36,17,2,5,0,3,14,7,16,9,14,0,3,16,14,7,2,16,6,14,1,16,2,7,5,14,2,16,10,14,2,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,8,16,36,14,1,16,7,14,2,5,36,17,2,5,1,14,2,16,7,14,2,8,0,3,16,14,8,4,16,4,14,1,16,2,7,5,14,2,16,10,14,2,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,2,16,37,14,1,16,6,14
	db 2,5,36,17,2,5,0,3,14,16,8,6,14,1,8,3,16,1,14,5,16,4,14,1,16,7,14,3,16,8,14,0,3,16,14,16,5,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,16,8,37,14,1,16,6,14,2,5,36,17,2,5,0,2,14,16,6,14,4,8,1,16,2,8,2,16,6,14,1,16,9,14,10,16,0,2,14,16,2,8,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,3,14,0,2,7,8,39,14,1,16,5,14,2,5,36,17,2,5,0,2,14,16,8,14,3,8,2,16,7,14,1,16,13,14,2,16,5,14,4,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,3,14,1,16,40,14,1,16,5,14,2,5,36,17,2,5,0,2,14,16,8,14,2,8,2,14,2,16,1,8,3,14,0,3,7,16,8,12,14,2,16,7,14,3,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,3,14,1,16,22,14,1,7,4
	db 8,13,14,1,16,5,14,2,5,36,17,2,5,0,2,14,16,7,14,1,8,5,14,1,7,5,16,1,7,12,14,2,16,2,14,2,7,2,16,3,14,3,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,14,2,16,13,14,0,4,8,16,8,7,12,14,4,7,7,14,2,8,4,14,2,5,36,17,2,5,0,2,14,16,28,14,1,8,4,16,2,14,3,16,2,14,2,16,3,14,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,14,2,16,18,14,1,7,2,8,1,7,2,8,3,7,0,2,8,7,12,14,1,16,4,14,2,5,36,17,2,5,0,2,14,16,31,14,0,3,16,8,14,2,16,5,14,1,16,3,14,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,14,2,16,20,14,3,16,1,8,3,7,14,14,1,16,4,14,2,5,36,17,2,5,0,2,14,16,27,14,0,2,7,8,2,14,1,16,2,14,6,16,0,3,14,16
	db 7,2,14,1,16,2,7,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,4,14,8,16,7,10,14,1,16,2,8,4,16,0,3,8,14,7,2,16,5,14,0,2,8,14,2,16,4,8,6,14,2,16,3,14,2,5,36,17,2,5,0,2,14,16,20,14,7,8,2,14,3,16,0,4,14,8,16,14,2,16,0,5,14,8,16,8,16,2,14,1,16,2,7,2,5,26,17,1,5,120,16,1,5,28,17,2,5,1,14,2,16,8,14,1,7,14,16,5,14,10,16,5,14,1,8,3,14,2,5,36,17,2,5,0,2,7,16,20,14,4,8,3,14,0,2,8,14,3,16,0,3,14,16,7,5,14,0,3,16,14,16,2,14,1,16,2,7,2,5,26,17,1,5,120,16,1,5,28,17,2,5,1,14,2,16,8,14,15,16,4,14,1,7,3,16,0,2,8,16,3,8,3,16,4,14,1,8,3,14,2,5,36,17,2,5,0,2,14,16,24,14,1,7,2,8,2,14,2,16,2,14,5,16,1,8,4
	db 16,2,14,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,16,12,14,2,16,1,7,6,14,1,16,4,14,1,8,2,14,2,16,0,2,14,7,5,14,1,8,5,14,1,16,3,14,2,5,36,17,2,5,0,2,14,16,19,14,1,7,9,14,2,16,2,14,1,16,8,14,1,16,2,14,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,16,9,14,1,8,2,7,1,16,2,8,4,14,0,3,7,8,16,4,14,1,16,2,14,2,16,7,14,1,7,5,14,1,16,3,14,2,5,36,17,2,5,0,2,14,16,20,14,8,8,1,7,2,16,2,14,1,16,8,14,1,16,2,14,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,16,9,14,1,8,3,16,1,8,2,16,4,14,0,2,8,16,3,14,2,8,2,14,0,2,16,8,6,14,0,3,8,14,7,4,14,1,16,3,14,2,5,36,17,2,5,0,3,14
	db 16,14,2,7,26,14,2,7,0,3,16,14,16,7,14,0,2,8,16,2,8,1,16,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,8,10,14,3,16,0,3,8,7,8,3,7,0,3,14,8,16,3,14,2,8,2,14,2,16,2,8,0,2,7,8,2,7,0,2,14,16,5,14,1,16,3,14,2,5,36,17,2,5,0,2,14,16,3,14,0,3,8,14,7,25,14,0,3,16,14,16,7,14,0,2,16,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,7,7,14,2,8,5,16,1,8,3,16,1,8,3,16,3,14,0,2,7,8,2,14,1,7,2,16,1,8,6,16,1,8,4,14,1,16,3,14,2,5,36,17,2,5,0,3,14,16,8,2,14,0,3,8,14,7,2,14,2,7,21,14,0,3,16,14,16,7,14,0,2,16,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,16,9,14,1,8,5,16,2,8
	db 2,14,2,8,1,16,3,14,0,2,7,8,3,14,4,16,1,14,3,7,2,8,2,7,1,14,2,16,3,14,2,5,36,17,2,5,2,14,1,16,2,14,0,3,8,14,7,2,14,2,8,21,14,0,3,16,14,16,6,14,0,3,7,16,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,16,6,14,2,8,4,14,1,8,2,16,2,7,8,14,0,4,7,16,14,7,2,14,3,16,4,8,0,3,7,17,7,2,14,1,7,4,14,2,5,36,17,2,5,2,14,1,16,3,14,0,3,8,14,8,3,14,1,8,20,14,0,3,16,14,16,6,14,1,16,2,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,1,16,4,14,0,5,8,14,8,14,7,5,14,0,4,8,16,8,7,9,14,0,2,16,8,3,14,0,2,16,8,4,16,0,3,7,14,7,3,14,1,8,4,14,2,5,36,17,2,5,2,14,1,16,3,14,0,3,8,14,8,3,14,0,2,7
	db 8,19,14,0,3,16,14,16,6,14,1,16,2,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,1,16,4,14,1,8,10,14,1,7,3,16,2,7,2,14,0,7,16,7,14,8,16,8,7,2,14,1,16,2,7,4,14,0,2,7,8,3,14,1,8,4,14,2,5,36,17,2,5,2,14,1,7,2,8,2,14,2,8,4,14,1,7,6,14,3,8,10,14,0,3,16,14,16,6,14,1,16,2,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,1,16,4,14,1,8,2,14,0,3,7,16,7,12,14,1,16,2,7,8,16,5,14,2,16,4,14,1,8,4,14,2,5,36,17,2,5,3,14,2,16,2,14,2,8,5,14,1,8,7,14,0,2,7,8,2,7,7,14,0,3,16,14,16,6,14,1,16,2,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,1,16,4,14,1,7,3,14,2,8,12,14,1,16,2,8,2,16,1,8,5,16
	db 5,14,0,2,16,8,4,14,1,8,4,14,2,5,36,17,2,5,3,14,2,16,3,14,2,8,4,14,1,8,6,14,1,7,5,8,4,14,2,8,0,3,16,14,16,6,14,1,16,2,14,2,8,1,7,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,16,8,14,0,2,16,8,11,14,1,7,2,16,0,4,7,8,16,7,3,16,3,14,1,8,3,16,5,14,1,16,4,14,2,5,36,17,2,5,3,14,2,7,1,16,2,14,2,8,4,14,1,7,6,14,0,3,7,8,7,2,14,2,8,3,14,2,16,0,2,14,16,2,8,3,16,3,14,0,2,16,14,3,7,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,16,10,14,3,16,7,8,0,5,16,7,16,8,16,2,8,0,2,7,8,2,16,1,8,2,16,1,8,2,7,5,14,0,2,7,16,4,14,2,5,36,17,2,5,5,14,1,16,2,14,4,8,11,14,3,8,0,3,14,7,8,2,14,2,16
	db 0,2,14,16,5,14,1,16,2,14,0,2,16,14,3,7,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,16,9,14,1,7,2,14,0,2,16,8,2,16,3,8,0,2,16,8,5,17,0,8,7,8,16,17,7,17,16,17,3,16,5,14,0,2,7,16,4,14,2,5,36,17,2,5,5,14,1,16,3,14,3,8,14,14,1,8,4,14,2,16,0,2,14,16,6,14,0,4,16,14,16,14,3,7,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,3,14,16,8,11,14,1,8,2,16,0,3,17,8,16,3,8,1,7,2,17,5,8,1,16,4,8,1,16,2,7,5,14,2,8,4,14,2,5,36,17,2,5,6,14,1,16,2,14,3,8,3,14,1,8,5,14,2,7,4,14,1,8,2,14,1,8,2,7,0,2,14,16,7,14,0,3,8,16,14,3,7,2,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,2,14,1,16,14,14,0,7,8,16,8,16,8
	db 16,8,2,17,0,4,16,7,17,16,3,8,3,16,1,7,7,14,0,2,16,7,4,14,2,5,36,17,2,5,6,14,1,16,2,14,1,8,2,14,1,8,3,14,1,8,5,14,1,7,3,16,2,14,0,3,8,14,16,3,14,0,2,16,8,2,7,3,8,3,16,1,14,2,7,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,0,2,14,7,2,16,13,14,0,2,7,16,3,8,0,11,7,8,7,8,17,8,16,17,16,8,16,2,8,1,7,8,14,1,16,5,14,2,5,36,17,2,5,6,14,2,16,2,14,3,8,1,7,3,14,2,8,7,14,1,16,3,14,1,16,3,14,0,4,16,14,7,14,2,16,0,5,14,7,14,16,14,2,7,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,3,14,1,16,14,14,0,2,7,16,2,8,0,4,16,8,7,8,2,17,0,2,16,7,2,8,0,4,7,16,14,7,8,14,1,8,5,14,2,5,36,17,2,5,7,14,1,16,2
	db 14,4,8,3,14,2,8,8,14,1,16,2,14,1,16,3,14,1,16,2,14,1,7,2,16,0,5,14,8,7,16,14,2,7,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,1,8,16,14,0,2,16,8,4,7,3,8,0,3,16,7,8,11,14,1,16,5,14,2,5,36,17,2,5,7,14,0,2,16,8,3,14,3,8,1,7,3,14,1,8,8,14,0,3,16,14,16,3,14,6,16,1,14,2,16,2,14,2,8,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,4,14,0,2,16,7,17,14,1,7,2,8,2,16,2,8,1,7,12,14,1,16,6,14,2,5,36,17,2,5,8,14,1,16,4,14,1,8,2,14,1,8,2,7,2,14,1,8,7,14,2,16,3,14,0,2,8,16,5,14,0,2,8,16,2,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,5,14,1,16,18,14,5,8,13,14,2,8,6,14,2,5,36,17,2,5,8,14,0,2
	db 8,16,4,14,0,3,8,14,17,2,7,1,8,2,14,1,8,7,14,1,16,2,7,2,14,2,16,3,14,0,2,7,16,3,14,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,0,2,16,7,20,14,1,7,12,14,1,16,8,14,2,5,36,17,2,5,9,14,3,16,3,14,2,8,2,14,2,8,9,14,3,16,3,14,6,16,2,14,1,8,2,16,3,14,2,5,26,17,1,5,120,16,1,5,28,17,2,5,6,14,0,2,8,16,20,14,1,7,12,14,1,8,8,14,2,5,36,17,2,5,10,14,3,16,4,14,6,8,8,14,2,16,10,14,0,2,7,16,5,14,2,5,26,17,122,5,28,17,2,5,7,14,1,7,21,14,1,7,10,14,2,8,8,14,2,5,36,17,2,5,12,14,2,16,1,8,5,14,9,8,0,2,7,14,2,8,1,16,9,14,2,16,5,14,2,5,176,17,2,5,8,14,0,3,8,16,7,28,14,0,2,16,8,9,14,2,5,36,17,2,5
	db 14,14,2,16,1,8,6,14,5,8,2,14,1,7,2,8,3,16,1,7,3,14,1,8,2,16,1,7,6,14,2,5,176,17,2,5,9,14,0,3,7,8,7,25,14,3,8,10,14,2,5,36,17,2,5,15,14,4,16,7,14,1,7,6,8,2,14,7,16,1,7,7,14,2,5,176,17,2,5,11,14,1,16,2,8,22,14,3,16,11,14,2,5,36,17,2,5,17,14,4,16,16,14,4,16,9,14,2,5,176,17,2,5,14,14,2,16,1,8,16,14,1,7,2,16,1,8,13,14,2,5,36,17,2,5,20,14,1,7,3,16,2,7,7,14,4,16,1,7,12,14,2,5,176,17,2,5,15,14,1,8,3,16,14,14,2,16,1,8,14,14,2,5,36,17,2,5,22,14,1,7,4,16,6,14,2,16,15,14,2,5,176,17,2,5,16,14,0,2,7,8,2,16,1,8,10,14,0,4,7,8,16,7,15,14,2,5,36,17,2,5,26,14,8,16,16,14,2,5,176,17,2,5,21,14,1,7,3,16,1
	db 8,4,16,1,7,19,14,2,5,36,17,2,5,50,14,2,5,176,17,2,5,50,14,2,5,36,17,54,5,176,17,54,5,36,17,54,5,176,17,54,5,36,17,54,5,176,17,54,5,255,17,255,17,255,17,212,17
	
	Smorc db 255,17,113,17,1,5,97,17,3,5,40,17,1,5,175,17,6,5,94,17,4,5,39,17,7,5,168,17,9,5,93,17,4,5,39,17,10,5,163,17,12,5,90,17,7,5,37,17,14,5,159,17,5,5,5,9,4,5,89,17,7,5,37,17,3,5,5,9,9,5,156,17,3,5,9,9,2,5,86,17,7,5,1,9,3,5,36,17,3,5,5,9,9,5,156,17,2,5,10,9,3,5,84,17,7,5,3,9,3,5,35,17,3,5,9,9,9,5,151,17,2,5,11,9,3,5,84,17,7,5,3,9,3,5,35,17,3,5,9,9,9,5,151,17,2,5,11,9,2,5,85,17,7,5,3,9,3,5,35,17,3,5,3,9,1,5,7,9,10,5,148,17,2,5,11,9,2,5,84,17,7,5,4,9,3,5,34,17,4,5,3,9,3,5,8,9,9,5,145,17,3,5,9,9,4,5,83,17,3,5,10,9,6,5,30,17,3,5,4,9,5,5,8,9,10,5,142,17,3,5,8,9,4,5,84,17,3,5,10,9
	db 6,5,30,17,3,5,4,9,2,5,1,14,8,5,5,9,9,5,139,17,3,5,9,9,3,5,85,17,3,5,10,9,6,5,30,17,3,5,4,9,2,5,1,14,8,5,5,9,9,5,139,17,3,5,8,9,4,5,84,17,3,5,12,9,5,5,30,17,3,5,4,9,2,5,4,14,6,5,8,9,5,5,139,17,2,5,9,9,3,5,85,17,2,5,10,9,1,5,3,9,5,5,29,17,2,5,5,9,2,5,7,14,4,5,8,9,5,5,138,17,2,5,8,9,3,5,86,17,2,5,9,9,3,5,2,9,6,5,28,17,2,5,5,9,2,5,9,14,2,5,10,9,3,5,137,17,2,5,9,9,3,5,86,17,2,5,9,9,3,5,2,9,6,5,28,17,2,5,3,9,4,5,8,14,3,5,11,9,2,5,137,17,2,5,9,9,2,5,84,17,4,5,8,9,6,5,5,9,4,5,25,17,2,5,4,9,4,5,6,14,5,5,8,9,5,5,137,17,2,5,9,9,2,5,84,17,4,5,8,9
	db 6,5,5,9,4,5,25,17,2,5,4,9,4,5,6,14,5,5,8,9,5,5,137,17,2,5,9,9,2,5,36,17,8,5,21,17,7,5,12,17,4,5,8,9,6,5,5,9,4,5,25,17,2,5,3,9,4,5,4,14,7,5,8,9,5,5,37,17,14,5,87,17,2,5,9,9,2,5,36,17,11,5,16,17,10,5,11,17,4,5,6,9,5,5,1,17,3,5,5,9,4,5,21,17,5,5,3,9,4,5,1,14,9,5,5,9,9,5,37,17,14,5,87,17,2,5,9,9,2,5,35,17,13,5,14,17,11,5,11,17,4,5,6,9,5,5,1,17,3,5,5,9,4,5,21,17,4,5,3,9,12,5,5,9,10,5,36,17,19,5,83,17,4,5,9,9,2,5,33,17,6,5,6,9,5,5,9,17,6,5,5,9,4,5,9,17,5,5,5,9,5,5,2,17,5,5,4,9,4,5,20,17,4,5,3,9,12,5,5,9,10,5,33,17,7,5,13,9,4,5,81,17,3,5,8,9,3,5,34,17
	db 4,5,11,9,3,5,6,17,5,5,9,9,3,5,9,17,4,5,6,9,4,5,4,17,6,5,3,9,4,5,19,17,4,5,2,9,10,5,6,9,9,5,35,17,5,5,16,9,5,5,80,17,3,5,8,9,3,5,34,17,4,5,11,9,3,5,6,17,5,5,9,9,3,5,8,17,5,5,4,9,6,5,5,17,6,5,3,9,6,5,16,17,4,5,2,9,10,5,6,9,9,5,35,17,5,5,16,9,5,5,80,17,3,5,8,9,3,5,33,17,4,5,13,9,2,5,6,17,3,5,11,9,3,5,8,17,4,5,5,9,5,5,9,17,4,5,3,9,8,5,12,17,5,5,2,9,7,5,4,9,12,5,35,17,6,5,19,9,3,5,79,17,4,5,7,9,4,5,32,17,5,5,14,9,2,5,4,17,3,5,13,9,3,5,7,17,4,5,5,9,5,5,9,17,4,5,3,9,8,5,12,17,5,5,2,9,3,5,5,9,12,5,36,17,5,5,7,9,10,5,5,9,4,5,78,17,4,5,7,9
	db 3,5,33,17,4,5,15,9,2,5,4,17,3,5,13,9,3,5,7,17,4,5,5,9,5,5,9,17,4,5,3,9,8,5,11,17,6,5,7,9,11,5,39,17,5,5,8,9,12,5,4,9,3,5,78,17,4,5,7,9,3,5,33,17,4,5,15,9,4,5,1,17,3,5,14,9,3,5,7,17,4,5,5,9,5,5,9,17,4,5,3,9,8,5,11,17,5,5,5,9,11,5,42,17,5,5,8,9,12,5,4,9,3,5,78,17,4,5,7,9,3,5,32,17,5,5,16,9,3,5,1,17,3,5,15,9,2,5,7,17,4,5,4,9,4,5,12,17,4,5,3,9,9,5,9,17,5,5,5,9,6,5,46,17,4,5,9,9,14,5,3,9,3,5,78,17,4,5,8,9,3,5,31,17,3,5,18,9,3,5,1,17,3,5,15,9,2,5,7,17,4,5,4,9,4,5,13,17,3,5,7,9,7,5,7,17,5,5,5,9,5,5,45,17,6,5,6,9,5,5,9,17,3,5,3,9,3,5,78,17
	db 4,5,8,9,3,5,31,17,3,5,18,9,3,5,1,17,3,5,15,9,2,5,6,17,3,5,6,9,4,5,14,17,3,5,8,9,6,5,6,17,3,5,7,9,9,5,40,17,5,5,6,9,6,5,11,17,2,5,3,9,3,5,78,17,4,5,8,9,4,5,30,17,3,5,18,9,3,5,1,17,3,5,15,9,2,5,6,17,3,5,6,9,4,5,14,17,3,5,8,9,6,5,6,17,3,5,7,9,9,5,40,17,5,5,6,9,6,5,11,17,2,5,3,9,3,5,79,17,4,5,9,9,4,5,28,17,3,5,18,9,3,5,1,17,3,5,15,9,2,5,6,17,3,5,5,9,4,5,15,17,4,5,10,9,4,5,4,17,3,5,8,9,12,5,37,17,5,5,6,9,6,5,11,17,2,5,3,9,3,5,79,17,4,5,9,9,4,5,27,17,3,5,8,9,4,5,7,9,6,5,6,9,3,5,7,9,2,5,6,17,3,5,5,9,4,5,15,17,4,5,10,9,4,5,3,17,3,5,14,9
	db 9,5,34,17,4,5,7,9,4,5,14,17,2,5,3,9,3,5,79,17,4,5,9,9,4,5,27,17,3,5,8,9,4,5,7,9,6,5,6,9,3,5,7,9,2,5,6,17,3,5,5,9,4,5,15,17,4,5,9,9,4,5,4,17,2,5,19,9,9,5,29,17,5,5,6,9,4,5,16,17,3,5,1,9,3,5,81,17,3,5,8,9,10,5,21,17,3,5,7,9,6,5,6,9,6,5,6,9,3,5,7,9,2,5,6,17,3,5,6,9,4,5,14,17,4,5,8,9,4,5,5,17,2,5,5,9,2,5,15,9,7,5,27,17,4,5,6,9,6,5,16,17,6,5,82,17,7,5,6,9,13,5,14,17,4,5,8,9,8,5,4,9,5,5,7,9,4,5,6,9,2,5,6,17,3,5,6,9,4,5,14,17,4,5,8,9,4,5,5,17,2,5,2,9,7,5,15,9,7,5,25,17,4,5,6,9,6,5,16,17,6,5,83,17,8,5,6,9,15,5,10,17,4,5,8,9,4,5,1,17
	db 3,5,4,9,5,5,7,9,4,5,7,9,2,5,5,17,3,5,6,9,4,5,14,17,4,5,8,9,4,5,5,17,2,5,2,9,9,5,15,9,6,5,24,17,3,5,7,9,4,5,18,17,6,5,85,17,9,5,9,9,10,5,9,17,4,5,8,9,3,5,2,17,4,5,3,9,5,5,6,9,5,5,7,9,2,5,5,17,3,5,6,9,4,5,14,17,4,5,8,9,4,5,5,17,2,5,5,9,9,5,15,9,4,5,21,17,4,5,6,9,5,5,20,17,5,5,87,17,9,5,11,9,7,5,8,17,4,5,8,9,3,5,2,17,4,5,3,9,4,5,7,9,5,5,7,9,2,5,6,17,4,5,4,9,4,5,12,17,5,5,7,9,4,5,7,17,2,5,5,9,9,5,15,9,4,5,21,17,4,5,6,9,4,5,21,17,4,5,92,17,6,5,15,9,2,5,8,17,3,5,9,9,3,5,2,17,4,5,3,9,4,5,5,9,7,5,7,9,2,5,6,17,4,5,4,9,4,5,12,17
	db 5,5,7,9,4,5,7,17,2,5,5,9,9,5,15,9,4,5,21,17,3,5,6,9,3,5,23,17,4,5,94,17,5,5,14,9,4,5,6,17,3,5,9,9,3,5,2,17,4,5,3,9,4,5,5,9,7,5,7,9,2,5,6,17,4,5,4,9,6,5,9,17,5,5,7,9,4,5,8,17,2,5,5,9,2,5,2,17,7,5,13,9,4,5,21,17,3,5,6,9,3,5,23,17,4,5,96,17,3,5,15,9,3,5,6,17,3,5,7,9,3,5,5,17,4,5,2,9,4,5,4,9,8,5,7,9,2,5,6,17,4,5,5,9,5,5,7,17,6,5,5,9,6,5,9,17,3,5,4,9,2,5,3,17,9,5,12,9,3,5,19,17,3,5,6,9,4,5,124,17,3,5,15,9,2,5,6,17,3,5,7,9,3,5,5,17,4,5,2,9,3,5,5,9,8,5,7,9,2,5,6,17,4,5,5,9,5,5,7,17,6,5,5,9,6,5,10,17,2,5,4,9,3,5,6,17,7,5,11,9
	db 4,5,15,17,3,5,8,9,4,5,124,17,3,5,15,9,2,5,6,17,3,5,7,9,3,5,5,17,4,5,2,9,3,5,4,9,9,5,7,9,2,5,6,17,4,5,5,9,6,5,5,17,6,5,5,9,6,5,11,17,2,5,4,9,3,5,6,17,7,5,11,9,4,5,15,17,3,5,6,9,6,5,124,17,3,5,15,9,1,5,7,17,3,5,6,9,4,5,5,17,5,5,1,9,3,5,4,9,4,5,1,17,4,5,7,9,2,5,7,17,4,5,6,9,4,5,3,17,7,5,5,9,5,5,13,17,3,5,4,9,2,5,7,17,8,5,10,9,3,5,15,17,3,5,6,9,6,5,124,17,3,5,14,9,2,5,5,17,4,5,7,9,3,5,8,17,3,5,6,9,4,5,3,17,4,5,7,9,2,5,7,17,4,5,6,9,4,5,3,17,7,5,5,9,5,5,14,17,2,5,4,9,2,5,10,17,6,5,9,9,4,5,11,17,6,5,6,9,4,5,126,17,3,5,14,9,2,5,5,17
	db 4,5,7,9,3,5,8,17,4,5,5,9,3,5,4,17,4,5,7,9,2,5,7,17,4,5,6,9,5,5,2,17,5,5,7,9,3,5,16,17,2,5,4,9,3,5,10,17,6,5,8,9,5,5,10,17,6,5,6,9,4,5,126,17,3,5,13,9,3,5,5,17,4,5,7,9,3,5,9,17,3,5,4,9,4,5,4,17,4,5,7,9,2,5,7,17,4,5,6,9,5,5,2,17,5,5,7,9,3,5,16,17,5,5,2,9,2,5,13,17,4,5,8,9,4,5,10,17,6,5,5,9,5,5,126,17,3,5,13,9,2,5,6,17,4,5,7,9,3,5,9,17,3,5,4,9,4,5,4,17,4,5,7,9,2,5,7,17,4,5,6,9,5,5,2,17,5,5,7,9,3,5,16,17,5,5,2,9,2,5,15,17,4,5,6,9,4,5,10,17,6,5,5,9,5,5,126,17,3,5,13,9,2,5,6,17,4,5,7,9,3,5,10,17,8,5,6,17,4,5,7,9,2,5,8,17,4,5,6,9
	db 4,5,2,17,3,5,8,9,3,5,18,17,5,5,1,9,3,5,14,17,5,5,7,9,2,5,9,17,6,5,6,9,4,5,127,17,3,5,12,9,3,5,6,17,4,5,7,9,3,5,10,17,7,5,7,17,4,5,7,9,2,5,8,17,4,5,6,9,8,5,8,9,3,5,19,17,5,5,1,9,3,5,15,17,4,5,7,9,2,5,9,17,6,5,6,9,4,5,127,17,3,5,12,9,2,5,7,17,4,5,7,9,3,5,11,17,5,5,8,17,4,5,6,9,2,5,11,17,3,5,8,9,3,5,7,9,5,5,21,17,4,5,2,9,2,5,16,17,5,5,6,9,2,5,8,17,6,5,6,9,4,5,127,17,3,5,9,9,5,5,9,17,3,5,6,9,3,5,24,17,4,5,6,9,2,5,12,17,3,5,8,9,1,5,6,9,6,5,22,17,4,5,2,9,3,5,17,17,3,5,6,9,2,5,8,17,6,5,6,9,4,5,127,17,3,5,8,9,5,5,10,17,3,5,6,9,3,5,24,17
	db 4,5,6,9,2,5,12,17,3,5,8,9,1,5,6,9,6,5,22,17,5,5,2,9,4,5,15,17,4,5,6,9,2,5,7,17,6,5,7,9,4,5,17,17,1,5,107,17,4,5,7,9,6,5,10,17,3,5,7,9,3,5,23,17,3,5,7,9,2,5,12,17,3,5,8,9,1,5,6,9,6,5,22,17,5,5,2,9,4,5,15,17,4,5,6,9,2,5,7,17,6,5,7,9,4,5,16,17,3,5,106,17,3,5,8,9,5,5,11,17,3,5,7,9,3,5,23,17,3,5,7,9,2,5,13,17,3,5,12,9,7,5,23,17,5,5,2,9,4,5,15,17,4,5,6,9,2,5,7,17,6,5,7,9,6,5,14,17,3,5,106,17,3,5,7,9,6,5,11,17,3,5,7,9,3,5,23,17,3,5,7,9,2,5,13,17,3,5,12,9,7,5,26,17,2,5,3,9,4,5,15,17,4,5,5,9,2,5,8,17,6,5,8,9,4,5,14,17,6,5,103,17,3,5,7,9,6,5,11,17
	db 3,5,9,9,3,5,21,17,3,5,6,9,3,5,13,17,3,5,12,9,7,5,26,17,3,5,2,9,5,5,14,17,4,5,5,9,3,5,7,17,6,5,9,9,5,5,10,17,8,5,102,17,4,5,6,9,4,5,14,17,3,5,9,9,3,5,20,17,4,5,6,9,3,5,13,17,3,5,12,9,6,5,28,17,2,5,3,9,5,5,13,17,4,5,5,9,3,5,7,17,6,5,10,9,6,5,8,17,8,5,102,17,4,5,6,9,4,5,14,17,3,5,9,9,3,5,20,17,4,5,6,9,3,5,14,17,5,5,7,9,6,5,30,17,3,5,4,9,5,5,13,17,2,5,5,9,4,5,9,17,3,5,12,9,7,5,5,17,9,5,101,17,4,5,6,9,4,5,14,17,4,5,8,9,3,5,20,17,3,5,7,9,3,5,15,17,6,5,4,9,6,5,31,17,3,5,5,9,5,5,12,17,3,5,5,9,3,5,9,17,5,5,10,9,10,5,2,17,9,5,101,17,4,5,6,9,4,5,14,17
	db 4,5,8,9,3,5,20,17,3,5,7,9,3,5,15,17,6,5,4,9,6,5,31,17,3,5,6,9,4,5,13,17,2,5,5,9,3,5,9,17,5,5,10,9,10,5,2,17,9,5,101,17,3,5,6,9,4,5,15,17,4,5,8,9,4,5,19,17,3,5,6,9,3,5,17,17,6,5,3,9,5,5,33,17,3,5,6,9,6,5,10,17,4,5,4,9,2,5,11,17,5,5,12,9,11,5,1,9,5,5,100,17,4,5,6,9,3,5,16,17,4,5,8,9,4,5,19,17,3,5,6,9,3,5,17,17,6,5,3,9,5,5,33,17,3,5,8,9,4,5,11,17,3,5,4,9,5,5,9,17,5,5,14,9,8,5,1,9,5,5,100,17,3,5,6,9,3,5,17,17,4,5,8,9,4,5,19,17,3,5,6,9,3,5,19,17,5,5,1,9,4,5,35,17,3,5,8,9,4,5,11,17,4,5,4,9,4,5,9,17,6,5,16,9,2,5,4,9,5,5,100,17,3,5,5,9,3,5,18,17
	db 4,5,8,9,4,5,19,17,3,5,6,9,3,5,19,17,5,5,1,9,4,5,35,17,3,5,8,9,4,5,11,17,4,5,4,9,4,5,11,17,7,5,19,9,5,5,100,17,3,5,5,9,3,5,18,17,4,5,8,9,4,5,17,17,3,5,7,9,3,5,21,17,8,5,36,17,3,5,8,9,4,5,11,17,4,5,4,9,4,5,13,17,8,5,15,9,6,5,100,17,3,5,3,9,5,5,18,17,4,5,8,9,4,5,17,17,3,5,7,9,3,5,23,17,5,5,38,17,3,5,7,9,3,5,12,17,4,5,7,9,1,5,14,17,9,5,13,9,5,5,99,17,12,5,21,17,3,5,8,9,4,5,16,17,3,5,7,9,3,5,23,17,5,5,38,17,2,5,6,9,5,5,13,17,12,5,16,17,8,5,10,9,6,5,99,17,11,5,22,17,15,5,15,17,4,5,3,9,7,5,23,17,5,5,38,17,2,5,6,9,5,5,13,17,12,5,18,17,19,5,104,17,3,5,1,17,5,5,26,17
	db 6,5,23,17,9,5,26,17,3,5,40,17,10,5,15,17,13,5,21,17,14,5,170,17,6,5,28,17,3,5,40,17,9,5,15,17,5,5,4,17,5,5,25,17,8,5,250,17,8,5,15,17,5,5,4,17,5,5,255,17,255,17,255,17,255,17,255,17,61,17,1,7,255,17,63,17,0,2,4,8,255,17,62,17,0,3,7,4,7,125,17,1,7,172,17,1,7,17,17,2,4,1,8,125,17,0,2,4,8,173,17,1,8,16,17,2,4,1,7,124,17,0,3,7,4,7,173,17,0,2,8,7,14,17,3,4,1,7,105,17,1,7,17,17,2,4,1,8,175,17,1,4,12,17,5,4,107,17,1,8,16,17,2,4,1,7,175,17,2,4,11,17,5,4,107,17,0,2,8,7,14,17,3,4,1,7,175,17,3,4,1,7,7,17,1,7,6,4,108,17,1,4,12,17,5,4,176,17,4,4,7,17,7,4,1,7,107,17,2,4,11,17,5,4,30,17,3,5,143,17,14,4,1,14,4,4,107,17,3,4
	db 1,7,7,17,1,7,6,4,27,17,8,5,141,17,13,4,2,14,4,4,1,7,106,17,4,4,7,17,7,4,1,7,26,17,1,5,6,9,1,5,141,17,2,4,0,2,14,17,9,4,2,14,5,4,106,17,14,4,1,14,4,4,25,17,1,5,7,9,2,5,118,17,0,2,7,2,4,16,6,2,3,16,0,3,2,8,7,2,17,1,7,3,4,3,14,6,4,4,14,5,4,106,17,13,4,2,14,4,4,1,7,24,17,1,5,7,9,1,5,118,17,1,10,2,16,0,2,2,8,9,2,2,17,4,16,1,17,3,4,1,8,3,14,4,4,1,17,5,14,5,4,106,17,2,4,0,2,14,17,9,4,2,14,5,4,23,17,2,5,5,9,3,5,116,17,2,16,3,10,2,2,1,8,11,2,2,10,0,2,2,6,2,16,0,2,6,7,5,14,0,2,17,8,6,14,6,4,1,7,82,17,0,2,7,2,4,16,6,2,3,16,0,3,2,8,7,2,17,1,7,3,4,3,14,6,4,4,14,5,4
	db 23,17,2,5,5,9,2,5,115,17,0,4,8,16,8,2,2,10,0,4,2,8,2,8,17,2,0,3,6,16,17,12,14,9,4,79,17,1,10,2,16,0,2,2,8,9,2,2,17,4,16,1,17,3,4,1,8,3,14,4,4,1,17,5,14,5,4,23,17,1,5,5,9,2,5,114,17,0,4,7,8,10,8,2,2,1,10,3,2,1,8,13,2,0,3,8,2,8,2,2,0,2,8,6,2,16,1,17,10,14,9,4,1,7,76,17,2,16,3,10,2,2,1,8,11,2,2,10,0,2,2,6,2,16,0,2,6,7,5,14,0,2,17,8,6,14,6,4,1,7,20,17,1,5,6,9,1,5,115,17,1,16,3,10,1,8,2,2,2,8,2,2,2,8,12,2,2,8,5,2,0,2,6,16,11,14,11,4,72,17,0,4,8,16,8,2,2,10,0,4,2,8,2,8,17,2,0,3,6,16,17,12,14,9,4,18,17,1,5,6,9,1,5,115,17,2,10,4,2,0,2,8,16,3,2,0,3,8,7,2
	db 3,17,1,2,2,10,0,5,2,10,16,6,2,2,6,4,2,1,8,2,2,1,6,11,14,13,4,1,7,66,17,0,4,7,8,10,8,2,2,1,10,3,2,1,8,13,2,0,3,8,2,8,2,2,0,2,8,6,2,16,1,17,10,14,9,4,1,7,17,17,1,5,6,9,1,5,113,17,0,3,7,16,10,2,2,1,17,2,2,1,17,5,2,1,14,3,2,2,17,1,8,4,10,1,6,2,2,1,6,7,2,0,2,16,17,13,14,13,4,2,7,62,17,1,16,3,10,1,8,2,2,2,8,2,2,2,8,12,2,2,8,5,2,0,2,6,16,11,14,11,4,14,17,2,5,5,9,2,5,113,17,1,16,3,10,4,2,1,17,5,2,0,4,14,17,2,17,2,8,5,10,0,4,6,2,6,16,2,6,5,2,0,2,6,16,2,17,15,14,0,3,7,14,8,11,4,1,8,58,17,2,10,4,2,0,2,8,16,3,2,0,3,8,7,2,3,17,1,2,2,10,0,5,2,10,16,6,2,2,6
	db 4,2,1,8,2,2,1,6,11,14,13,4,1,7,10,17,2,5,5,9,2,5,112,17,0,9,7,16,10,2,10,2,17,2,17,4,2,2,17,3,2,2,16,0,4,17,8,10,16,2,10,0,3,6,2,6,2,16,0,2,17,6,5,2,1,16,2,17,1,7,18,14,6,4,2,7,59,17,0,3,7,16,10,2,2,1,17,2,2,1,17,5,2,1,14,3,2,2,17,1,8,4,10,1,6,2,2,1,6,7,2,0,2,16,17,13,14,13,4,2,7,5,17,3,5,4,9,2,5,40,17,2,5,35,17,4,5,32,17,1,16,2,10,0,4,2,10,2,17,2,16,1,10,5,2,0,7,14,17,2,16,2,17,16,2,8,0,3,10,16,17,2,16,1,17,3,16,2,2,2,6,2,2,0,2,16,8,3,17,12,14,4,4,1,7,66,17,1,16,3,10,4,2,1,17,5,2,0,4,14,17,2,17,2,8,5,10,0,4,6,2,6,16,2,6,5,2,0,2,6,16,2,17,15,14,0,3,7,14,8
	db 11,4,0,2,8,17,3,5,4,9,2,5,25,17,6,5,8,17,3,5,15,17,5,5,11,17,1,5,9,9,3,5,27,17,2,10,5,2,0,4,17,2,10,2,3,10,0,3,2,14,17,2,2,0,2,17,16,4,10,0,3,2,6,16,2,17,3,16,4,2,2,6,2,16,2,17,10,14,6,4,1,7,66,17,0,9,7,16,10,2,10,2,17,2,17,4,2,2,17,3,2,2,16,0,4,17,8,10,16,2,10,0,3,6,2,6,2,16,0,2,17,6,5,2,1,16,2,17,1,7,18,14,6,4,2,7,4,17,3,5,5,9,2,5,21,17,2,5,7,9,2,5,5,17,5,5,14,17,1,5,3,9,3,5,8,17,1,5,12,9,1,5,26,17,0,3,16,8,10,7,2,1,10,3,2,2,10,0,2,14,17,3,2,2,10,1,2,4,10,1,16,2,6,3,16,0,3,2,6,16,2,6,1,8,2,16,2,17,9,14,7,4,67,17,1,16,2,10,0,4,2,10,2,17,2,16,1,10,5,2
	db 0,7,14,17,2,16,2,17,16,2,8,0,3,10,16,17,2,16,1,17,3,16,2,2,2,6,2,2,0,2,16,8,3,17,12,14,4,4,1,7,12,17,2,5,6,9,2,5,20,17,2,5,7,9,2,5,5,17,2,5,2,9,1,5,14,17,0,2,5,9,2,5,3,9,3,5,5,17,1,5,12,9,1,5,26,17,4,10,8,2,2,16,0,2,2,16,2,8,1,17,2,2,2,10,3,2,3,10,1,2,2,16,1,17,2,16,6,2,0,3,6,16,7,7,14,6,4,1,8,69,17,2,10,5,2,0,4,17,2,10,2,3,10,0,3,2,14,17,2,2,0,2,17,16,4,10,0,3,2,6,16,2,17,3,16,4,2,2,6,2,16,2,17,10,14,6,4,1,7,13,17,2,5,6,9,2,5,18,17,2,5,3,9,5,5,2,9,1,5,4,17,1,5,5,9,2,5,12,17,0,4,5,9,5,14,2,5,3,9,2,5,4,17,0,2,5,9,3,5,4,17,5,5,25,17,1,7,3,10,7
	db 2,2,17,6,2,2,17,6,2,0,2,10,16,2,10,0,5,6,16,17,16,6,4,2,1,8,2,2,2,16,1,17,5,14,7,4,1,7,68,17,0,3,16,8,10,7,2,1,10,3,2,2,10,0,2,14,17,3,2,2,10,1,2,4,10,1,16,2,6,3,16,0,3,2,6,16,2,6,1,8,2,16,2,17,9,14,7,4,15,17,4,5,4,9,8,5,10,17,3,5,2,9,2,5,3,17,2,5,0,2,9,5,4,17,1,5,3,9,0,2,5,9,3,5,11,17,1,9,2,5,3,14,1,5,3,9,1,5,4,17,2,9,11,17,1,5,25,17,1,7,13,2,1,17,2,16,1,2,2,16,2,2,1,17,5,2,1,16,3,10,3,16,3,2,2,8,3,2,2,16,2,17,4,14,7,4,69,17,4,10,8,2,2,16,0,2,2,16,2,8,1,17,2,2,2,10,3,2,3,10,1,2,2,16,1,17,2,16,6,2,0,3,6,16,7,7,14,6,4,1,8,18,17,5,5,3,9,10,5,7
	db 17,2,5,2,9,2,5,5,17,0,3,5,9,5,3,17,1,5,3,9,3,5,2,9,2,5,8,17,2,5,0,3,9,5,14,3,5,2,9,3,5,4,17,2,9,15,17,1,7,2,8,13,16,0,2,2,8,4,17,1,16,7,2,1,17,2,7,0,6,2,7,2,7,17,16,3,7,2,16,1,8,6,10,2,16,1,10,3,16,3,2,0,3,8,17,6,4,16,0,2,8,17,4,14,7,4,68,17,1,7,3,10,7,2,2,17,6,2,2,17,6,2,0,2,10,16,2,10,0,5,6,16,17,16,6,4,2,1,8,2,2,2,16,1,17,5,14,7,4,1,7,20,17,6,5,7,9,4,5,5,17,2,5,3,9,1,5,6,17,0,3,5,9,5,3,17,1,5,2,9,2,5,0,2,17,5,2,9,2,5,8,17,6,5,2,9,3,5,5,17,1,5,2,9,15,17,5,16,2,2,1,17,6,2,0,2,8,2,4,16,2,17,0,3,16,2,8,5,2,1,17,2,8,0,6,7,8,17,8,16
	db 17,4,7,2,16,5,8,1,10,2,16,1,10,2,16,0,3,6,2,8,2,2,1,6,5,16,0,2,8,17,4,14,7,4,68,17,1,7,13,2,1,17,2,16,1,2,2,16,2,2,1,17,5,2,1,16,3,10,3,16,3,2,2,8,3,2,2,16,2,17,4,14,7,4,25,17,3,5,9,9,2,5,4,17,1,5,3,9,2,5,6,17,3,5,2,17,2,5,1,9,2,5,3,17,2,5,2,9,1,5,7,17,3,5,2,9,4,5,7,17,0,3,5,9,5,15,17,6,8,0,3,7,8,7,2,2,6,7,2,8,1,2,3,16,0,2,2,8,5,2,1,8,5,7,0,2,2,17,6,7,0,2,2,8,5,2,2,16,1,10,2,16,2,2,0,3,6,2,6,6,16,0,2,8,17,4,14,7,4,46,17,1,7,2,8,13,16,0,2,2,8,4,17,1,16,7,2,1,17,2,7,0,6,2,7,2,7,17,16,3,7,2,16,1,8,6,10,2,16,1,10,3,16,3,2,0,3,8,17,6
	db 4,16,0,2,8,17,4,14,7,4,27,17,2,5,9,9,1,5,3,17,1,5,3,9,2,5,8,17,2,5,2,17,2,5,1,9,2,5,4,17,2,5,1,9,2,5,5,17,2,5,2,9,2,5,11,17,1,5,2,9,16,17,1,8,2,16,1,2,4,8,1,17,2,2,9,8,0,3,7,8,16,3,2,3,14,2,7,3,14,1,7,2,16,6,7,1,16,2,14,5,16,2,10,0,3,8,16,6,9,16,0,2,8,7,6,14,6,4,46,17,5,16,2,2,1,17,6,2,0,2,8,2,4,16,2,17,0,3,16,2,8,5,2,1,17,2,8,0,6,7,8,17,8,16,17,4,7,2,16,5,8,1,10,2,16,1,10,2,16,0,3,6,2,8,2,2,1,6,5,16,0,2,8,17,4,14,7,4,27,17,2,5,9,9,1,5,3,17,1,5,2,9,2,5,9,17,1,5,3,17,2,5,0,2,9,5,5,17,2,5,1,9,3,5,4,17,1,5,3,9,3,5,10,17,1,5,2,9,3,5
	db 5,17,3,5,6,17,1,7,2,16,1,2,8,8,2,2,3,16,1,2,2,8,0,3,7,8,16,3,2,1,8,4,7,0,3,8,7,8,2,16,6,7,0,2,16,17,5,16,0,2,17,2,3,16,1,17,9,16,1,17,8,14,1,17,4,4,46,17,6,8,0,3,7,8,7,2,2,6,7,2,8,1,2,3,16,0,2,2,8,5,2,1,8,5,7,0,2,2,17,6,7,0,2,2,8,5,2,2,16,1,10,2,16,2,2,0,3,6,2,6,6,16,0,2,8,17,4,14,7,4,27,17,2,5,8,9,2,5,2,17,1,5,3,9,2,5,12,17,2,5,2,9,1,5,6,17,2,5,2,9,3,5,2,17,2,9,1,5,5,9,3,5,6,17,1,5,13,9,1,5,7,17,1,8,2,16,11,8,3,16,0,2,2,8,2,7,0,2,16,2,2,8,0,2,7,8,2,7,2,8,2,10,0,2,16,2,5,7,0,2,16,8,5,10,16,16,9,14,4,4,47,17,1,8,2,16,1,2,4,8
	db 1,17,2,2,9,8,0,3,7,8,16,3,2,3,14,2,7,3,14,1,7,2,16,6,7,1,16,2,14,5,16,2,10,0,3,8,16,6,9,16,0,2,8,7,6,14,6,4,27,17,2,5,8,9,1,5,3,17,1,5,2,9,3,5,12,17,2,5,2,9,1,5,6,17,2,5,3,9,2,5,2,17,2,9,3,5,6,9,1,5,5,17,1,5,13,9,1,5,9,17,2,16,8,8,7,16,3,7,2,8,6,7,1,8,2,10,0,2,7,16,2,17,1,2,2,16,0,4,2,8,10,8,2,10,6,16,1,17,4,16,2,17,0,2,16,6,2,16,1,8,8,14,4,4,48,17,1,7,2,16,1,2,8,8,2,2,3,16,1,2,2,8,0,3,7,8,16,3,2,1,8,4,7,0,3,8,7,8,2,16,6,7,0,2,16,17,5,16,0,2,17,2,3,16,1,17,9,16,1,17,8,14,1,17,4,4,27,17,2,5,7,9,2,5,1,17,3,5,2,9,2,5,14,17,2,5,0,2,9,5
	db 5,17,3,5,2,9,1,5,4,17,2,9,0,2,5,17,2,5,5,9,1,5,5,17,1,5,13,9,1,5,10,17,2,16,7,8,4,16,0,4,8,7,8,2,7,7,3,8,6,10,1,17,2,16,1,17,2,8,0,3,2,8,10,4,16,1,2,7,16,0,8,17,6,17,6,16,2,16,6,3,4,6,14,2,4,50,17,1,8,2,16,11,8,3,16,0,2,2,8,2,7,0,2,16,2,2,8,0,2,7,8,2,7,2,8,2,10,0,2,16,2,5,7,0,2,16,8,5,10,16,16,9,14,4,4,27,17,2,5,5,9,3,5,2,17,3,5,2,9,2,5,14,17,2,5,1,9,2,5,3,17,3,5,2,9,1,5,5,17,0,3,5,9,5,2,17,3,5,4,9,1,5,4,17,1,5,4,9,6,5,15,17,2,16,1,17,5,8,4,16,1,8,2,7,2,8,0,3,7,8,7,2,8,1,7,2,8,0,2,7,8,4,16,0,7,14,2,17,8,17,8,16,3,10,3,16,2,2,4,16
	db 2,17,0,4,6,16,6,17,2,6,1,17,2,16,7,4,2,14,3,4,1,7,50,17,2,16,8,8,7,16,3,7,2,8,6,7,1,8,2,10,0,2,7,16,2,17,1,2,2,16,0,4,2,8,10,8,2,10,6,16,1,17,4,16,2,17,0,2,16,6,2,16,1,8,8,14,4,4,26,17,3,5,4,9,4,5,2,17,2,5,3,9,1,5,15,17,2,5,2,9,1,5,2,17,3,5,2,9,1,5,6,17,2,5,0,2,9,5,4,17,2,5,2,9,2,5,3,17,1,5,4,9,6,5,15,17,3,16,5,8,4,16,1,8,2,7,2,8,8,7,3,2,4,17,1,7,3,8,0,2,17,2,3,10,3,16,2,2,5,16,0,2,17,6,2,17,2,16,0,2,17,6,2,16,7,4,1,8,2,14,2,4,1,7,51,17,2,16,7,8,4,16,0,4,8,7,8,2,7,7,3,8,6,10,1,17,2,16,1,17,2,8,0,3,2,8,10,4,16,1,2,7,16,0,8,17,6,17,6,16
	db 2,16,6,3,4,6,14,2,4,26,17,2,5,4,9,4,5,3,17,2,5,3,9,2,5,6,17,1,5,7,17,2,5,2,9,2,5,1,17,2,5,3,9,1,5,7,17,3,5,5,17,2,5,2,9,1,5,3,17,1,5,4,9,1,5,21,17,1,7,2,16,4,8,3,16,1,2,3,8,4,7,8,2,4,16,1,14,2,8,0,2,16,2,2,17,3,2,1,17,8,2,2,16,0,3,17,16,6,3,8,1,17,2,16,14,4,51,17,2,16,1,17,5,8,4,16,1,8,2,7,2,8,0,3,7,8,7,2,8,1,7,2,8,0,2,7,8,4,16,0,7,14,2,17,8,17,8,16,3,10,3,16,2,2,4,16,2,17,0,4,6,16,6,17,2,6,1,17,2,16,7,4,2,14,3,4,1,7,24,17,2,5,4,9,2,5,5,17,2,5,3,9,3,5,5,17,1,5,8,17,1,5,2,9,2,5,0,2,17,5,4,9,1,5,7,17,2,5,0,2,9,5,5,17,2,5,2,9,1,5
	db 2,17,1,5,3,9,2,5,23,17,2,16,10,8,1,17,3,7,2,2,1,16,3,2,1,17,6,16,0,4,2,16,8,17,2,2,1,17,11,2,1,6,4,16,3,17,3,16,15,4,50,17,3,16,5,8,4,16,1,8,2,7,2,8,8,7,3,2,4,17,1,7,3,8,0,2,17,2,3,10,3,16,2,2,5,16,0,2,17,6,2,17,2,16,0,2,17,6,2,16,7,4,1,8,2,14,2,4,1,7,24,17,2,5,4,9,2,5,5,17,3,5,4,9,2,5,3,17,3,5,8,17,1,5,6,9,3,5,9,17,0,3,5,9,5,6,17,1,5,2,9,1,5,2,17,1,5,4,9,1,5,23,17,0,2,8,16,9,8,0,2,7,16,3,7,3,2,9,16,0,3,17,2,16,2,17,5,2,1,17,8,2,1,6,4,16,0,3,6,17,6,3,16,5,4,1,8,3,7,2,8,4,4,51,17,1,7,2,16,4,8,3,16,1,2,3,8,4,7,8,2,4,16,1,14,2,8,0,2,16
	db 2,2,17,3,2,1,17,8,2,2,16,0,3,17,16,6,3,8,1,17,2,16,14,4,23,17,1,5,4,9,3,5,7,17,2,5,4,9,3,5,1,17,4,5,7,17,1,5,6,9,3,5,10,17,0,2,5,9,2,5,4,17,1,5,2,9,1,5,3,17,1,5,3,9,1,5,24,17,0,4,8,16,2,8,2,7,4,8,0,3,2,16,8,2,7,4,2,5,16,0,6,2,8,17,16,2,17,16,2,0,4,6,2,16,17,5,16,1,6,4,4,1,7,12,17,3,7,49,17,2,16,10,8,1,17,3,7,2,2,1,16,3,2,1,17,6,16,0,4,2,16,8,17,2,2,1,17,11,2,1,6,4,16,3,17,3,16,15,4,21,17,2,5,4,9,1,5,9,17,2,5,5,9,4,5,1,9,2,5,7,17,1,5,5,9,3,5,11,17,1,5,3,9,1,5,4,17,1,5,2,9,1,5,2,17,1,5,2,9,2,5,24,17,1,7,2,16,0,3,2,8,7,2,8,2,7,0,3,8,16
	db 8,2,7,4,2,5,16,0,6,17,8,17,16,2,17,2,2,1,17,13,2,0,2,6,2,7,16,5,4,15,17,1,7,49,17,0,2,8,16,9,8,0,2,7,16,3,7,3,2,9,16,0,3,17,2,16,2,17,5,2,1,17,8,2,1,6,4,16,0,3,6,17,6,3,16,5,4,1,8,3,7,2,8,4,4,21,17,2,5,3,9,2,5,11,17,2,5,8,9,2,5,8,17,2,5,2,9,2,5,13,17,1,5,3,9,1,5,4,17,1,5,2,9,1,5,2,17,1,5,3,9,1,5,7,17,2,5,16,17,1,8,2,16,2,8,9,7,1,17,4,2,3,16,0,5,2,8,17,16,17,21,2,5,16,1,6,5,4,66,17,0,4,8,16,2,8,2,7,4,8,0,3,2,16,8,2,7,4,2,5,16,0,6,2,8,17,16,2,17,16,2,0,4,6,2,16,17,5,16,1,6,4,4,1,7,12,17,3,7,16,17,7,5,13,17,3,5,5,9,2,5,10,17,4,5,14,17,1,5,2
	db 9,2,5,4,17,5,5,0,2,17,5,3,9,6,5,3,9,1,5,19,17,3,16,0,2,8,7,2,8,0,2,7,8,2,7,0,2,17,16,3,2,2,16,0,2,2,8,2,16,4,17,19,2,0,2,16,17,2,16,0,2,4,8,2,17,1,8,3,4,65,17,1,7,2,16,0,3,2,8,7,2,8,2,7,0,3,8,16,8,2,7,4,2,5,16,0,6,17,8,17,16,2,17,2,2,1,17,13,2,0,2,6,2,7,16,5,4,15,17,1,7,17,17,6,5,15,17,7,5,12,17,2,5,16,17,3,5,5,17,2,5,1,17,2,5,2,17,13,5,19,17,1,8,3,16,2,8,0,3,7,8,17,2,8,0,2,17,16,3,2,2,16,2,8,2,16,0,4,2,17,2,17,15,2,3,6,1,2,4,16,2,7,3,17,1,7,2,4,66,17,1,8,2,16,2,8,9,7,1,17,4,2,3,16,0,5,2,8,17,16,17,21,2,5,16,1,6,5,4,73,17,2,5,65,17,0,2,8,17,4
	db 16,0,5,17,7,8,17,16,2,2,2,16,2,17,1,16,6,2,2,17,1,2,16,16,1,6,3,16,7,17,0,2,4,7,68,17,3,16,0,2,8,7,2,8,0,2,7,8,2,7,0,2,17,16,3,2,2,16,0,2,2,8,2,16,4,17,19,2,0,2,16,17,2,16,0,2,4,8,2,17,1,8,3,4,141,17,3,16,0,2,17,7,2,8,4,2,0,4,16,2,17,8,11,2,0,2,10,2,17,16,8,17,1,4,68,17,1,8,3,16,2,8,0,3,7,8,17,2,8,0,2,17,16,3,2,2,16,2,8,2,16,0,4,2,17,2,17,15,2,3,6,1,2,4,16,2,7,3,17,1,7,2,4,141,17,1,8,2,16,2,2,2,7,1,16,3,2,2,17,0,2,8,16,2,8,4,2,7,10,5,8,0,2,17,8,2,17,4,6,2,17,2,16,9,17,1,7,69,17,0,2,8,17,4,16,0,5,17,7,8,17,16,2,2,2,16,2,17,1,16,6,2,2,17,1,2,16,16,1,6
	db 3,16,7,17,0,2,4,7,140,17,1,8,2,16,2,2,1,7,7,2,1,16,2,8,2,2,1,8,2,2,4,8,8,10,0,2,8,10,2,16,3,6,0,3,17,6,17,2,16,10,17,1,7,70,17,3,16,0,2,17,7,2,8,4,2,0,4,16,2,17,8,11,2,0,2,10,2,17,16,8,17,1,4,142,17,0,2,16,17,6,2,0,4,17,2,17,8,2,10,1,8,2,2,1,8,23,16,0,2,6,16,81,17,1,8,2,16,2,2,2,7,1,16,3,2,2,17,0,2,8,16,2,8,4,2,7,10,5,8,0,2,17,8,2,17,4,6,2,17,2,16,9,17,1,7,140,17,0,2,8,16,7,2,2,17,1,2,2,10,0,4,8,17,8,2,26,16,81,17,1,8,2,16,2,2,1,7,7,2,1,16,2,8,2,2,1,8,2,2,4,8,8,10,0,2,8,10,2,16,3,6,0,3,17,6,17,2,16,10,17,1,7,139,17,0,2,8,16,3,2,1,17,2,2,1,17,4,2,2,10
	db 0,2,2,17,4,16,1,17,2,7,1,16,2,8,0,3,7,2,16,2,7,0,4,8,7,2,16,2,8,0,2,16,7,4,16,83,17,0,2,16,17,6,2,0,4,17,2,17,8,2,10,1,8,2,2,1,8,23,16,0,2,6,16,150,17,0,2,7,16,3,2,1,17,2,2,1,17,8,2,4,16,3,7,0,4,16,2,7,8,2,16,2,7,0,2,8,17,2,16,2,8,0,2,16,7,4,16,1,7,81,17,0,2,8,16,7,2,2,17,1,2,2,10,0,4,8,17,8,2,26,16,150,17,1,7,4,2,2,16,0,2,17,2,2,17,1,2,2,17,1,2,23,16,0,2,8,7,4,16,1,7,81,17,0,2,8,16,3,2,1,17,2,2,1,17,4,2,2,10,0,2,2,17,4,16,1,17,2,7,1,16,2,8,0,3,7,2,16,2,7,0,4,8,7,2,16,2,8,0,2,16,7,4,16,150,17,0,3,8,2,8,2,2,2,16,5,2,0,2,17,8,4,16,2,8,19,16,1,8,4
	db 16,1,7,81,17,0,2,7,16,3,2,1,17,2,2,1,17,8,2,4,16,3,7,0,4,16,2,7,8,2,16,2,7,0,2,8,17,2,16,2,8,0,2,16,7,4,16,1,7,149,17,0,3,8,2,8,2,2,0,2,16,17,4,2,1,17,2,8,4,16,0,2,7,8,24,16,1,8,81,17,1,7,4,2,2,16,0,2,17,2,2,17,1,2,2,17,1,2,23,16,0,2,8,7,4,16,1,7,149,17,0,5,8,2,8,2,16,5,2,2,17,5,16,2,7,1,8,3,16,1,2,16,16,0,2,8,7,4,16,80,17,0,3,8,2,8,2,2,2,16,5,2,0,2,17,8,4,16,2,8,19,16,1,8,4,16,1,7,148,17,0,3,7,16,2,2,8,1,16,6,2,6,16,2,7,1,8,3,16,2,8,13,16,0,5,17,16,8,7,2,3,16,80,17,0,3,8,2,8,2,2,0,2,16,17,4,2,1,17,2,8,4,16,0,2,7,8,24,16,1,8,148,17,0,2,7,16,2,2,0
	db 3,8,16,17,4,2,4,16,0,3,8,16,8,3,7,2,16,0,3,7,8,7,4,16,2,8,3,16,0,2,8,7,4,16,3,7,3,16,1,7,79,17,0,5,8,2,8,2,16,5,2,2,17,5,16,2,7,1,8,3,16,1,2,16,16,0,2,8,7,4,16,147,17,0,2,8,16,2,2,1,8,6,2,3,16,0,3,7,8,16,4,7,2,16,2,8,1,7,4,16,2,7,3,16,0,3,7,17,7,3,16,3,7,1,8,2,16,1,8,78,17,0,3,7,16,2,2,8,1,16,6,2,6,16,2,7,1,8,3,16,2,8,13,16,0,5,17,16,8,7,2,3,16,147,17,0,7,8,16,8,2,8,2,17,4,2,2,16,2,7,1,8,5,7,2,16,4,7,2,16,1,2,2,7,0,2,2,16,4,7,1,8,2,16,4,7,3,16,1,8,77,17,0,2,7,16,2,2,0,3,8,16,17,4,2,4,16,0,3,8,16,8,3,7,2,16,0,3,7,8,7,4,16,2,8,3,16,0,2,8
	db 7,4,16,3,7,3,16,1,7,146,17,0,2,8,16,2,2,1,8,5,2,1,17,5,16,0,3,8,7,8,2,7,0,4,8,16,8,17,2,7,0,3,2,16,2,2,7,0,4,2,16,7,17,3,7,0,2,17,16,4,7,4,16,77,17,0,2,8,16,2,2,1,8,6,2,3,16,0,3,7,8,16,4,7,2,16,2,8,1,7,4,16,2,7,3,16,0,3,7,17,7,3,16,3,7,1,8,2,16,1,8,146,17,0,2,8,16,2,2,0,7,8,16,2,10,2,17,8,2,16,3,2,2,17,1,2,5,16,4,2,1,16,4,2,1,16,2,8,13,16,77,17,0,7,8,16,8,2,8,2,17,4,2,2,16,2,7,1,8,5,7,2,16,4,7,2,16,1,2,2,7,0,2,2,16,4,7,1,8,2,16,4,7,3,16,1,8,145,17,0,4,7,16,2,8,2,2,2,10,2,2,2,17,0,2,2,17,26,2,1,8,4,2,2,10,2,16,1,8,76,17,0,2,8,16,2,2,1,8,5
	db 2,1,17,5,16,0,3,8,7,8,2,7,0,4,8,16,8,17,2,7,0,3,2,16,2,2,7,0,4,2,16,7,17,3,7,0,2,17,16,4,7,4,16,145,17,0,6,7,8,2,8,2,8,3,10,4,2,0,2,17,2,3,10,1,2,2,10,12,2,1,8,15,2,0,2,16,7,75,17,0,2,8,16,2,2,0,7,8,16,2,10,2,17,8,2,16,3,2,2,17,1,2,5,16,4,2,1,16,4,2,1,16,2,8,13,16,146,17,1,8,3,2,1,8,3,10,5,2,2,10,2,2,1,17,2,8,4,17,2,8,2,2,6,8,14,2,0,2,16,7,75,17,0,4,7,16,2,8,2,2,2,10,2,2,2,17,0,2,2,17,26,2,1,8,4,2,2,10,2,16,1,8,146,17,1,16,2,8,1,17,3,2,1,10,2,2,1,17,4,2,1,10,6,16,21,2,2,10,2,16,1,7,76,17,0,6,7,8,2,8,2,8,3,10,4,2,0,2,17,2,3,10,1,2,2,10,12,2,1,8
	db 15,2,0,2,16,7,145,17,1,16,4,17,1,2,3,10,0,2,2,17,3,2,2,10,1,8,14,16,4,6,8,2,4,16,78,17,1,8,3,2,1,8,3,10,5,2,2,10,2,2,1,17,2,8,4,17,2,8,2,2,6,8,14,2,0,2,16,7,145,17,0,2,7,16,6,2,1,16,5,2,2,8,3,2,28,16,1,7,78,17,1,16,2,8,1,17,3,2,1,10,2,2,1,17,4,2,1,10,6,16,21,2,2,10,2,16,1,7,147,17,1,7,7,16,1,10,3,2,2,8,0,2,2,8,3,2,2,8,4,10,21,16,79,17,1,16,4,17,1,2,3,10,0,2,2,17,3,2,2,10,1,8,14,16,4,6,8,2,4,16,150,17,2,7,4,16,2,10,6,2,2,8,1,2,2,8,0,2,10,2,23,16,79,17,0,2,7,16,6,2,1,16,5,2,2,8,3,2,28,16,1,7,151,17,2,7,2,16,3,10,2,2,0,2,8,2,2,8,0,2,2,8,2,10,25,16,80,17,1,7
	db 7,16,1,10,3,2,2,8,0,2,2,8,3,2,2,8,4,10,21,16,155,17,1,7,2,16,3,2,2,16,0,3,2,16,2,10,16,5,2,1,6,10,16,1,7,83,17,2,7,4,16,2,10,6,2,2,8,1,2,2,8,0,2,10,2,23,16,156,17,1,8,2,16,2,17,1,8,4,2,1,8,19,2,5,16,1,7,86,17,2,7,2,16,3,10,2,2,0,2,8,2,2,8,0,2,2,8,2,10,25,16,158,17,2,16,1,8,3,2,1,8,10,2,0,3,8,6,8,2,2,2,8,5,2,3,16,1,7,90,17,1,7,2,16,3,2,2,16,0,3,2,16,2,10,16,5,2,1,6,10,16,1,7,160,17,2,16,2,8,13,2,1,16,2,8,8,2,3,16,92,17,1,8,2,16,2,17,1,8,4,2,1,8,19,2,5,16,1,7,162,17,3,16,11,2,9,16,1,6,2,2,4,16,94,17,2,16,1,8,3,2,1,8,10,2,0,3,8,6,8,2,2,2,8,5,2,3,16,1,7
	db 164,17,1,2,3,16,6,2,19,16,95,17,2,16,2,8,13,2,1,16,2,8,8,2,3,16,167,17,1,8,24,16,1,7,97,17,3,16,11,2,9,16,1,6,2,2,4,16,174,17,1,7,116,17,1,2,3,16,6,2,19,16,255,17,38,17,1,8,24,16,1,7,255,17,46,17,1,7,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,55,17
	
	Kappa db 255,17,99,17,3,5,4,17,2,5,48,17,2,5,75,17,12,5,41,17,13,5,122,17,8,5,44,17,4,5,71,17,20,5,34,17,19,5,120,17,8,5,41,17,3,5,3,9,2,5,66,17,9,5,10,9,6,5,29,17,8,5,11,9,5,5,120,17,1,5,4,9,3,5,33,17,8,5,5,9,4,5,64,17,9,5,10,9,6,5,29,17,8,5,11,9,5,5,120,17,2,5,4,9,3,5,28,17,8,5,5,9,5,5,67,17,9,5,10,9,6,5,29,17,8,5,11,9,5,5,121,17,1,5,5,9,2,5,26,17,5,5,6,9,8,5,66,17,7,5,12,9,7,5,28,17,7,5,12,9,6,5,122,17,2,5,4,9,2,5,23,17,4,5,5,9,8,5,71,17,7,5,12,9,7,5,28,17,7,5,12,9,6,5,122,17,2,5,4,9,3,5,16,17,8,5,3,9,9,5,70,17,5,5,10,9,10,5,2,9,3,5,23,17,6,5,9,9,11,5,2,9,2,5,122,17,2,5,5,9
	db 2,5,13,17,6,5,5,9,9,5,73,17,5,5,10,9,10,5,2,9,3,5,23,17,6,5,9,9,11,5,2,9,2,5,122,17,2,5,5,9,3,5,8,17,9,5,3,9,8,5,77,17,5,5,10,9,10,5,2,9,3,5,23,17,6,5,9,9,11,5,2,9,2,5,123,17,1,5,6,9,2,5,6,17,7,5,4,9,8,5,77,17,6,5,9,9,7,5,4,17,2,5,4,9,1,5,21,17,5,5,10,9,7,5,4,17,2,5,3,9,1,5,123,17,2,5,5,9,2,5,4,17,5,5,5,9,7,5,80,17,6,5,9,9,7,5,5,17,2,5,4,9,2,5,19,17,5,5,10,9,6,5,6,17,2,5,3,9,2,5,122,17,2,5,5,9,2,5,3,17,3,5,6,9,3,5,86,17,6,5,9,9,7,5,5,17,2,5,4,9,2,5,19,17,5,5,10,9,6,5,6,17,2,5,3,9,2,5,122,17,2,5,5,9,2,5,1,17,4,5,5,9,3,5,87,17,3,5,10,9
	db 5,5,10,17,2,5,4,9,2,5,18,17,3,5,10,9,5,5,10,17,2,5,3,9,2,5,122,17,2,5,5,9,5,5,6,9,3,5,88,17,3,5,10,9,5,5,10,17,2,5,4,9,2,5,18,17,3,5,10,9,5,5,10,17,2,5,3,9,2,5,121,17,3,5,5,9,3,5,7,9,3,5,89,17,3,5,10,9,5,5,10,17,2,5,4,9,2,5,18,17,3,5,10,9,5,5,10,17,2,5,3,9,2,5,21,17,12,5,88,17,3,5,5,9,2,5,6,9,4,5,43,17,12,5,34,17,3,5,10,9,5,5,11,17,2,5,4,9,2,5,17,17,3,5,10,9,5,5,11,17,2,5,3,9,2,5,21,17,12,5,88,17,2,5,6,9,2,5,5,9,3,5,45,17,12,5,34,17,3,5,10,9,5,5,11,17,2,5,4,9,2,5,17,17,3,5,10,9,5,5,11,17,2,5,3,9,2,5,18,17,3,5,12,9,4,5,84,17,2,5,6,9,2,5,4,9,4,5,42,17
	db 3,5,12,9,4,5,28,17,4,5,10,9,5,5,12,17,2,5,4,9,2,5,15,17,4,5,10,9,5,5,12,17,2,5,3,9,2,5,15,17,5,5,13,9,5,5,83,17,2,5,6,9,2,5,3,9,4,5,41,17,4,5,13,9,5,5,26,17,4,5,11,9,3,5,14,17,2,5,4,9,2,5,14,17,4,5,11,9,3,5,14,17,2,5,3,9,2,5,15,17,4,5,16,9,3,5,83,17,2,5,6,9,2,5,3,9,3,5,42,17,3,5,16,9,3,5,24,17,5,5,11,9,2,5,15,17,2,5,6,9,2,5,10,17,6,5,11,9,2,5,15,17,2,5,5,9,2,5,13,17,4,5,18,9,4,5,81,17,2,5,6,9,2,5,1,9,4,5,42,17,3,5,18,9,4,5,22,17,5,5,11,9,2,5,15,17,2,5,6,9,2,5,10,17,6,5,11,9,2,5,15,17,2,5,5,9,2,5,12,17,5,5,19,9,3,5,81,17,2,5,6,9,2,5,1,9,3,5,41,17
	db 5,5,19,9,3,5,22,17,5,5,11,9,2,5,15,17,2,5,6,9,2,5,10,17,6,5,11,9,2,5,15,17,2,5,5,9,2,5,10,17,4,5,22,9,3,5,81,17,1,5,7,9,5,5,40,17,5,5,21,9,3,5,21,17,3,5,12,9,3,5,13,17,5,5,6,9,2,5,9,17,4,5,11,9,4,5,13,17,5,5,5,9,2,5,8,17,5,5,9,9,3,5,13,9,2,5,80,17,1,5,7,9,5,5,38,17,6,5,8,9,3,5,13,9,2,5,20,17,3,5,12,9,3,5,12,17,5,5,7,9,2,5,9,17,4,5,11,9,4,5,11,17,6,5,6,9,2,5,8,17,5,5,9,9,3,5,13,9,2,5,79,17,2,5,6,9,4,5,40,17,6,5,8,9,3,5,13,9,2,5,20,17,3,5,12,9,3,5,12,17,5,5,7,9,2,5,9,17,4,5,11,9,4,5,11,17,6,5,6,9,2,5,8,17,5,5,9,9,3,5,13,9,2,5,79,17,2,5,6,9
	db 4,5,40,17,6,5,8,9,3,5,13,9,2,5,19,17,2,5,12,9,20,5,9,9,2,5,8,17,2,5,12,9,21,5,8,9,2,5,7,17,5,5,9,9,8,5,10,9,3,5,77,17,2,5,5,9,4,5,40,17,5,5,9,9,9,5,9,9,4,5,16,17,2,5,12,9,20,5,9,9,2,5,8,17,2,5,12,9,21,5,8,9,2,5,7,17,5,5,9,9,8,5,10,9,3,5,77,17,1,5,6,9,4,5,40,17,5,5,9,9,9,5,9,9,4,5,14,17,3,5,12,9,4,5,26,9,2,5,6,17,3,5,12,9,5,5,25,9,2,5,7,17,5,5,8,9,9,5,10,9,3,5,77,17,1,5,5,9,5,5,40,17,5,5,8,9,10,5,9,9,4,5,14,17,3,5,12,9,4,5,26,9,2,5,6,17,3,5,12,9,5,5,25,9,2,5,6,17,4,5,9,9,4,5,2,17,5,5,9,9,4,5,76,17,1,5,5,9,5,5,39,17,4,5,9,9,4,5,2,17
	db 6,5,8,9,5,5,13,17,3,5,12,9,4,5,26,9,2,5,6,17,3,5,12,9,5,5,25,9,2,5,5,17,3,5,11,9,3,5,7,17,3,5,8,9,4,5,74,17,2,5,4,9,5,5,39,17,3,5,11,9,3,5,8,17,2,5,8,9,5,5,12,17,3,5,12,9,4,5,26,9,2,5,6,17,3,5,12,9,5,5,25,9,2,5,5,17,3,5,10,9,3,5,8,17,3,5,8,9,4,5,74,17,2,5,4,9,2,5,1,9,2,5,39,17,3,5,10,9,3,5,9,17,2,5,8,9,5,5,10,17,5,5,10,9,8,5,23,9,3,5,5,17,4,5,11,9,8,5,22,9,3,5,5,17,3,5,10,9,3,5,8,17,3,5,8,9,4,5,74,17,2,5,3,9,3,5,2,9,2,5,38,17,3,5,10,9,3,5,9,17,2,5,8,9,5,5,10,17,4,5,11,9,15,5,14,9,4,5,6,17,3,5,12,9,15,5,14,9,3,5,6,17,3,5,9,9,3,5,9,17
	db 3,5,10,9,5,5,71,17,2,5,3,9,2,5,3,9,2,5,38,17,3,5,9,9,3,5,10,17,2,5,11,9,4,5,8,17,4,5,10,9,34,5,6,17,3,5,11,9,33,5,6,17,2,5,10,9,3,5,9,17,3,5,10,9,5,5,71,17,2,5,2,9,2,5,5,9,2,5,37,17,2,5,10,9,3,5,10,17,2,5,11,9,4,5,8,17,4,5,10,9,34,5,6,17,3,5,11,9,33,5,6,17,2,5,10,9,2,5,4,17,11,5,8,9,5,5,71,17,2,5,2,9,2,5,5,9,2,5,37,17,2,5,10,9,2,5,4,17,11,5,9,9,4,5,8,17,3,5,11,9,4,5,5,17,24,5,7,17,2,5,12,9,3,5,6,17,23,5,7,17,2,5,10,9,2,5,1,17,9,5,1,14,4,5,9,9,5,5,68,17,4,5,1,9,2,5,7,9,3,5,35,17,2,5,10,9,2,5,1,17,10,5,1,14,3,5,10,9,4,5,5,17,4,5,11,9,4,5,35,17
	db 3,5,12,9,3,5,37,17,2,5,10,9,2,5,1,17,9,5,1,14,4,5,9,9,5,5,68,17,3,5,2,9,2,5,8,9,4,5,33,17,2,5,10,9,2,5,1,17,10,5,1,14,3,5,10,9,4,5,5,17,4,5,11,9,4,5,35,17,3,5,12,9,3,5,36,17,2,5,11,9,8,5,5,14,4,5,9,9,5,5,68,17,3,5,1,9,3,5,10,9,4,5,30,17,2,5,11,9,8,5,6,14,3,5,10,9,4,5,5,17,4,5,11,9,4,5,35,17,3,5,12,9,3,5,36,17,2,5,11,9,5,5,8,14,4,5,9,9,5,5,68,17,3,5,1,9,4,5,10,9,5,5,28,17,2,5,11,9,5,5,9,14,3,5,10,9,4,5,5,17,2,5,13,9,4,5,35,17,2,5,13,9,3,5,36,17,2,5,11,9,2,5,11,14,4,5,9,9,5,5,68,17,3,5,1,9,2,5,1,17,3,5,10,9,4,5,27,17,2,5,11,9,2,5,12,14,3,5,10,9
	db 4,5,5,17,2,5,13,9,4,5,35,17,2,5,13,9,3,5,36,17,2,5,11,9,2,5,11,14,4,5,9,9,5,5,68,17,3,5,1,9,2,5,2,17,3,5,11,9,7,5,22,17,2,5,11,9,2,5,12,14,3,5,10,9,4,5,5,17,2,5,13,9,4,5,35,17,2,5,13,9,3,5,36,17,2,5,11,9,2,5,11,14,4,5,10,9,4,5,68,17,3,5,0,2,9,5,4,17,4,5,12,9,7,5,19,17,2,5,11,9,2,5,12,14,3,5,11,9,3,5,5,17,2,5,13,9,4,5,35,17,2,5,13,9,3,5,36,17,2,5,11,9,2,5,10,14,5,5,10,9,4,5,68,17,3,5,0,2,9,5,6,17,4,5,13,9,8,5,15,17,2,5,11,9,2,5,11,14,4,5,11,9,3,5,5,17,2,5,13,9,4,5,35,17,2,5,13,9,3,5,36,17,2,5,11,9,2,5,4,14,11,5,10,9,5,5,67,17,3,5,0,2,9,5,7,17,6,5,14,9
	db 6,5,13,17,2,5,11,9,2,5,4,14,11,5,11,9,4,5,4,17,2,5,13,9,4,5,35,17,2,5,13,9,3,5,36,17,2,5,11,9,12,5,1,17,4,5,10,9,5,5,66,17,4,5,0,2,9,5,9,17,7,5,14,9,4,5,12,17,2,5,11,9,13,5,1,17,3,5,11,9,4,5,4,17,2,5,13,9,4,5,35,17,2,5,13,9,3,5,36,17,2,5,11,9,7,5,8,17,2,5,10,9,5,5,66,17,3,5,2,9,1,5,12,17,7,5,13,9,3,5,11,17,2,5,11,9,7,5,8,17,2,5,11,9,4,5,4,17,2,5,13,9,4,5,35,17,2,5,13,9,3,5,36,17,2,5,11,9,6,5,9,17,3,5,9,9,5,5,66,17,3,5,2,9,1,5,17,17,5,5,12,9,2,5,10,17,2,5,11,9,6,5,9,17,3,5,10,9,4,5,4,17,2,5,12,9,3,5,37,17,2,5,12,9,3,5,37,17,2,5,11,9,6,5,9,17,3,5,9,9
	db 5,5,66,17,3,5,2,9,2,5,19,17,7,5,6,9,4,5,9,17,2,5,11,9,6,5,9,17,3,5,10,9,4,5,4,17,2,5,12,9,3,5,37,17,2,5,12,9,3,5,37,17,2,5,11,9,3,5,12,17,3,5,9,9,5,5,66,17,3,5,2,9,2,5,22,17,7,5,1,9,7,5,8,17,2,5,11,9,3,5,12,17,3,5,10,9,4,5,4,17,2,5,12,9,3,5,37,17,2,5,12,9,3,5,37,17,2,5,11,9,3,5,12,17,3,5,8,9,5,5,67,17,3,5,2,9,2,5,26,17,6,5,13,17,2,5,11,9,3,5,12,17,3,5,9,9,4,5,5,17,2,5,12,9,3,5,37,17,2,5,12,9,3,5,37,17,2,5,11,9,3,5,12,17,3,5,8,9,5,5,67,17,3,5,3,9,2,5,44,17,2,5,11,9,3,5,12,17,3,5,9,9,4,5,5,17,2,5,12,9,3,5,37,17,2,5,12,9,3,5,37,17,2,5,11,9,3,5,12,17
	db 3,5,8,9,5,5,67,17,3,5,4,9,2,5,43,17,2,5,11,9,3,5,12,17,3,5,9,9,4,5,5,17,17,5,37,17,17,5,38,17,2,5,10,9,3,5,12,17,3,5,8,9,5,5,68,17,3,5,2,9,3,5,44,17,2,5,10,9,3,5,12,17,3,5,9,9,4,5,5,17,17,5,37,17,17,5,38,17,2,5,10,9,3,5,12,17,3,5,8,9,5,5,68,17,9,5,43,17,2,5,10,9,3,5,12,17,3,5,9,9,4,5,5,17,17,5,37,17,17,5,38,17,15,5,12,17,16,5,68,17,11,5,41,17,15,5,12,17,16,5,5,17,17,5,37,17,17,5,149,17,5,5,95,17,17,5,37,17,17,5,149,17,3,5,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,98,17,13,7,2,17,6,7,158,17,13,7,2,17,6,7,118,17,3,7,6,8,2,7,10,8,5,7,153,17,3,7,6,8
	db 2,7,10,8,5,7,114,17,1,7,6,8,2,16,9,8,1,16,7,8,6,7,147,17,1,7,6,8,2,16,9,8,1,16,7,8,6,7,107,17,2,7,2,8,1,7,4,8,3,16,8,8,1,16,3,8,2,16,4,8,1,7,3,8,2,7,143,17,2,7,2,8,1,7,4,8,3,16,8,8,1,16,3,8,2,16,4,8,1,7,3,8,2,7,103,17,5,7,4,8,4,16,8,8,3,16,7,8,1,16,6,8,1,7,140,17,5,7,4,8,4,16,8,8,3,16,7,8,1,16,6,8,1,7,100,17,0,2,7,8,2,7,8,8,2,16,3,8,1,16,7,8,1,16,16,8,1,7,136,17,0,2,7,8,2,7,8,8,2,16,3,8,1,16,7,8,1,16,16,8,1,7,96,17,1,7,2,8,1,7,9,8,2,16,3,8,0,3,16,8,16,3,8,3,16,12,8,1,16,5,8,2,7,132,17,1,7,2,8,1,7,9,8,2,16,3,8,0,3,16,8,16,3,8,3,16,12,8,1,16
	db 5,8,2,7,93,17,2,7,7,8,1,16,8,8,1,16,16,8,3,16,10,8,1,7,130,17,2,7,7,8,1,16,8,8,1,16,16,8,3,16,10,8,1,7,91,17,2,7,8,8,1,16,6,8,2,16,4,8,1,16,12,8,2,16,12,8,129,17,2,7,8,8,1,16,6,8,2,16,4,8,1,16,12,8,2,16,12,8,91,17,1,7,6,8,1,7,28,8,1,16,14,8,0,2,17,7,126,17,1,7,6,8,1,7,28,8,1,16,14,8,0,2,17,7,86,17,2,7,6,8,1,7,26,8,1,16,2,8,4,16,5,8,7,16,1,8,124,17,2,7,6,8,1,7,26,8,1,16,2,8,4,16,5,8,7,16,1,8,85,17,1,7,15,8,1,7,9,8,6,16,2,8,3,16,2,8,2,16,4,8,11,16,20,17,3,5,100,17,1,7,15,8,1,7,9,8,6,16,2,8,3,16,2,8,2,16,4,8,11,16,83,17,2,7,20,8,1,16,5,8,1,16,3,8,7,16,2,8,2,16
	db 4,8,11,16,1,7,16,17,8,5,96,17,2,7,20,8,1,16,5,8,1,16,3,8,7,16,2,8,2,16,4,8,11,16,1,7,81,17,2,7,7,8,1,16,7,8,1,7,3,8,2,16,4,8,2,16,2,8,10,16,1,8,2,16,1,8,4,16,1,8,10,16,16,17,1,5,6,9,1,5,95,17,2,7,7,8,1,16,7,8,1,7,3,8,2,16,4,8,2,16,2,8,10,16,1,8,2,16,1,8,4,16,1,8,10,16,80,17,3,7,18,8,1,16,6,8,1,16,2,8,11,16,1,8,6,16,0,2,8,16,2,8,8,16,1,8,14,17,1,5,7,9,2,5,93,17,3,7,18,8,1,16,6,8,1,16,2,8,11,16,1,8,6,16,0,2,8,16,2,8,8,16,1,8,79,17,2,7,18,8,1,16,6,8,2,16,1,8,12,16,1,8,2,16,1,8,3,16,4,8,8,16,1,8,14,17,1,5,7,9,1,5,94,17,2,7,18,8,1,16,6,8,2,16,1,8,12,16,1,8
	db 2,16,1,8,3,16,4,8,8,16,1,8,79,17,2,7,23,8,0,6,16,8,16,8,16,8,2,16,1,8,8,16,0,3,8,16,8,4,16,2,8,0,2,16,8,9,16,1,7,12,17,2,5,5,9,3,5,94,17,2,7,23,8,0,6,16,8,16,8,16,8,2,16,1,8,8,16,0,3,8,16,8,4,16,2,8,0,2,16,8,9,16,1,7,78,17,1,7,23,8,6,16,1,8,10,16,2,8,7,16,2,8,10,16,0,2,8,7,11,17,2,5,5,9,2,5,95,17,1,7,23,8,6,16,1,8,10,16,2,8,7,16,2,8,10,16,0,2,8,7,76,17,1,7,14,8,1,16,5,8,0,2,16,8,8,16,1,8,3,16,1,8,4,16,5,8,6,16,1,8,11,16,2,8,11,17,1,5,5,9,2,5,95,17,1,7,14,8,1,16,5,8,0,2,16,8,8,16,1,8,3,16,1,8,4,16,5,8,6,16,1,8,11,16,2,8,76,17,1,7,13,8,1,16,4,8,4,16,1,8
	db 8,16,1,8,2,16,1,8,5,16,5,8,17,16,2,8,10,17,1,5,6,9,1,5,96,17,1,7,13,8,1,16,4,8,4,16,1,8,8,16,1,8,2,16,1,8,5,16,5,8,17,16,2,8,75,17,2,7,10,8,1,16,3,8,17,16,1,8,6,16,0,2,8,16,8,8,15,16,1,8,10,17,1,5,6,9,1,5,95,17,2,7,10,8,1,16,3,8,17,16,1,8,6,16,0,2,8,16,8,8,15,16,1,8,75,17,1,7,11,8,0,2,16,8,19,16,2,8,3,16,14,8,13,16,1,8,10,17,1,5,6,9,1,5,95,17,1,7,11,8,0,2,16,8,19,16,2,8,3,16,14,8,13,16,1,8,75,17,1,7,13,8,19,16,0,4,8,16,8,16,17,8,12,16,9,17,2,5,5,9,2,5,95,17,1,7,13,8,19,16,0,4,8,16,8,16,17,8,12,16,75,17,11,8,23,16,21,8,11,16,9,17,2,5,5,9,2,5,95,17,11,8,23,16,21,8,11,16,74,17
	db 1,7,10,8,14,16,1,8,8,16,8,8,1,7,14,8,10,16,8,17,3,5,4,9,2,5,40,17,2,5,35,17,4,5,14,17,1,7,10,8,14,16,1,8,8,16,8,8,1,7,14,8,10,16,74,17,1,7,9,8,13,16,2,8,2,16,2,8,0,2,16,8,2,16,6,8,5,7,1,8,2,7,11,8,9,16,8,17,3,5,4,9,2,5,25,17,6,5,8,17,3,5,15,17,5,5,11,17,1,5,9,9,3,5,9,17,1,7,9,8,13,16,2,8,2,16,2,8,0,2,16,8,2,16,6,8,5,7,1,8,2,7,11,8,9,16,74,17,0,3,7,8,16,6,8,13,16,1,8,2,16,5,8,1,16,7,8,6,7,1,8,2,7,12,8,8,16,1,7,7,17,3,5,5,9,2,5,21,17,2,5,7,9,2,5,5,17,5,5,14,17,1,5,3,9,3,5,8,17,1,5,12,9,1,5,9,17,0,3,7,8,16,6,8,13,16,1,8,2,16,5,8,1,16,7,8,6,7,1,8
	db 2,7,12,8,8,16,1,7,73,17,1,7,2,16,0,2,8,16,3,8,18,16,11,8,4,7,0,2,8,7,3,8,1,7,12,8,8,16,9,17,2,5,6,9,2,5,20,17,2,5,7,9,2,5,5,17,2,5,2,9,1,5,14,17,0,2,5,9,2,5,3,9,3,5,5,17,1,5,12,9,1,5,9,17,1,7,2,16,0,2,8,16,3,8,18,16,11,8,4,7,0,2,8,7,3,8,1,7,12,8,8,16,74,17,1,7,2,16,1,8,2,16,2,8,18,16,10,8,7,7,3,8,1,7,13,8,7,16,9,17,2,5,6,9,2,5,18,17,2,5,3,9,5,5,2,9,1,5,4,17,1,5,5,9,2,5,12,17,0,4,5,9,5,14,2,5,3,9,2,5,4,17,0,2,5,9,3,5,4,17,5,5,9,17,1,7,2,16,1,8,2,16,2,8,18,16,10,8,7,7,3,8,1,7,13,8,7,16,74,17,1,7,24,16,12,8,6,7,18,8,5,16,1,8,10,17,4,5,4,9
	db 8,5,10,17,3,5,2,9,2,5,3,17,2,5,0,2,9,5,4,17,1,5,3,9,0,2,5,9,3,5,11,17,1,9,2,5,3,14,1,5,3,9,1,5,4,17,2,9,11,17,1,5,9,17,1,7,24,16,12,8,6,7,18,8,5,16,1,8,74,17,1,7,21,16,4,8,1,7,9,8,7,7,18,8,6,16,11,17,5,5,3,9,10,5,7,17,2,5,2,9,2,5,5,17,0,3,5,9,5,3,17,1,5,3,9,3,5,2,9,2,5,8,17,2,5,0,3,9,5,14,3,5,2,9,3,5,4,17,2,9,21,17,1,7,21,16,4,8,1,7,9,8,7,7,18,8,6,16,74,17,1,7,20,16,13,8,0,2,7,8,7,7,18,8,6,16,13,17,6,5,7,9,4,5,5,17,2,5,3,9,1,5,6,17,0,3,5,9,5,3,17,1,5,2,9,2,5,0,2,17,5,2,9,2,5,8,17,6,5,2,9,3,5,5,17,1,5,2,9,21,17,1,7,20,16,13,8,0,2,7
	db 8,7,7,18,8,6,16,75,17,19,16,0,2,8,16,5,8,1,7,2,8,1,7,2,8,9,7,20,8,5,16,17,17,3,5,9,9,2,5,4,17,1,5,3,9,2,5,6,17,3,5,2,17,2,5,1,9,2,5,3,17,2,5,2,9,1,5,7,17,3,5,2,9,4,5,7,17,0,3,5,9,5,22,17,19,16,0,2,8,16,5,8,1,7,2,8,1,7,2,8,9,7,20,8,5,16,75,17,1,8,15,16,1,8,2,16,9,8,3,7,3,8,10,7,18,8,4,16,19,17,2,5,9,9,1,5,3,17,1,5,3,9,2,5,8,17,2,5,2,17,2,5,1,9,2,5,4,17,2,5,1,9,2,5,5,17,2,5,2,9,2,5,11,17,1,5,2,9,22,17,1,8,15,16,1,8,2,16,9,8,3,7,3,8,10,7,18,8,4,16,75,17,1,8,14,16,3,8,1,16,10,8,3,7,2,8,7,7,2,8,1,7,18,8,4,16,19,17,2,5,9,9,1,5,3,17,1,5,2,9
	db 2,5,9,17,1,5,3,17,2,5,0,2,9,5,5,17,2,5,1,9,3,5,4,17,1,5,3,9,3,5,10,17,1,5,2,9,3,5,5,17,3,5,11,17,1,8,14,16,3,8,1,16,10,8,3,7,2,8,7,7,2,8,1,7,18,8,4,16,75,17,1,8,14,16,8,8,0,2,7,8,3,7,1,8,11,7,7,8,2,7,0,2,8,7,11,8,4,16,19,17,2,5,8,9,2,5,2,17,1,5,3,9,2,5,12,17,2,5,2,9,1,5,6,17,2,5,2,9,3,5,2,17,2,9,1,5,5,9,3,5,6,17,1,5,13,9,1,5,10,17,1,8,14,16,8,8,0,2,7,8,3,7,1,8,11,7,7,8,2,7,0,2,8,7,11,8,4,16,75,17,1,8,13,16,8,8,19,7,6,8,3,7,12,8,4,16,19,17,2,5,8,9,1,5,3,17,1,5,2,9,3,5,12,17,2,5,2,9,1,5,6,17,2,5,3,9,2,5,2,17,2,9,3,5,6,9,1,5,5,17
	db 1,5,13,9,1,5,10,17,1,8,13,16,8,8,19,7,6,8,3,7,12,8,4,16,75,17,2,8,12,16,0,2,8,16,4,8,20,7,6,8,5,7,11,8,3,16,1,8,19,17,2,5,7,9,2,5,1,17,3,5,2,9,2,5,14,17,2,5,0,2,9,5,5,17,3,5,2,9,1,5,4,17,2,9,0,2,5,17,2,5,5,9,1,5,5,17,1,5,13,9,1,5,10,17,2,8,12,16,0,2,8,16,4,8,20,7,6,8,5,7,11,8,3,16,1,8,75,17,2,8,13,16,4,8,19,7,8,8,4,7,13,8,2,16,1,8,19,17,2,5,5,9,3,5,2,17,3,5,2,9,2,5,14,17,2,5,1,9,2,5,3,17,3,5,2,9,1,5,5,17,0,3,5,9,5,2,17,3,5,4,9,1,5,4,17,1,5,4,9,6,5,14,17,2,8,13,16,4,8,19,7,8,8,4,7,13,8,2,16,1,8,75,17,0,2,7,8,13,16,3,8,17,7,28,8,2,16,1,7,18
	db 17,3,5,4,9,4,5,2,17,2,5,3,9,1,5,15,17,2,5,2,9,1,5,2,17,3,5,2,9,1,5,6,17,2,5,0,2,9,5,4,17,2,5,2,9,2,5,3,17,1,5,4,9,6,5,14,17,0,2,7,8,13,16,3,8,17,7,28,8,2,16,1,7,75,17,0,2,7,8,12,16,3,8,17,7,29,8,2,16,1,7,18,17,2,5,4,9,4,5,3,17,2,5,3,9,2,5,6,17,1,5,7,17,2,5,2,9,2,5,1,17,2,5,3,9,1,5,7,17,3,5,5,17,2,5,2,9,1,5,3,17,1,5,4,9,1,5,19,17,0,2,7,8,12,16,3,8,17,7,29,8,2,16,1,7,75,17,0,2,7,8,11,16,3,8,14,7,0,2,8,7,2,8,2,16,18,8,1,16,8,8,0,3,16,8,7,18,17,2,5,4,9,2,5,5,17,2,5,3,9,3,5,5,17,1,5,8,17,1,5,2,9,2,5,0,2,17,5,4,9,1,5,7,17,2,5,0,2,9,5
	db 5,17,2,5,2,9,1,5,2,17,1,5,3,9,2,5,19,17,0,2,7,8,11,16,3,8,14,7,0,2,8,7,2,8,2,16,18,8,1,16,8,8,0,3,16,8,7,76,17,1,7,11,16,2,8,13,7,4,8,6,16,12,8,10,16,3,8,0,2,16,8,19,17,2,5,4,9,2,5,5,17,3,5,4,9,2,5,3,17,3,5,8,17,1,5,6,9,3,5,9,17,0,3,5,9,5,6,17,1,5,2,9,1,5,2,17,1,5,4,9,1,5,20,17,1,7,11,16,2,8,13,7,4,8,6,16,12,8,10,16,3,8,0,2,16,8,77,17,0,2,7,8,9,16,3,8,7,7,0,2,8,7,25,8,13,16,0,3,8,16,7,19,17,1,5,4,9,3,5,7,17,2,5,4,9,3,5,1,17,4,5,7,17,1,5,6,9,3,5,10,17,0,2,5,9,2,5,4,17,1,5,2,9,1,5,3,17,1,5,3,9,1,5,20,17,0,2,7,8,9,16,3,8,7,7,0,2,8,7,25
	db 8,13,16,0,3,8,16,7,77,17,3,7,1,8,7,16,1,8,8,7,11,8,5,16,10,8,11,16,1,8,3,16,2,8,1,7,18,17,2,5,4,9,1,5,9,17,2,5,5,9,4,5,1,9,2,5,7,17,1,5,5,9,3,5,11,17,1,5,3,9,1,5,4,17,1,5,2,9,1,5,2,17,1,5,2,9,2,5,20,17,3,7,1,8,7,16,1,8,8,7,11,8,5,16,10,8,11,16,1,8,3,16,2,8,1,7,76,17,1,7,2,8,2,7,1,8,5,16,2,8,8,7,7,8,9,16,6,8,2,7,2,8,13,16,4,8,19,17,2,5,3,9,2,5,11,17,2,5,8,9,2,5,8,17,2,5,2,9,2,5,13,17,1,5,3,9,1,5,4,17,1,5,2,9,1,5,2,17,1,5,3,9,1,5,7,17,2,5,10,17,1,7,2,8,2,7,1,8,5,16,2,8,8,7,7,8,9,16,6,8,2,7,2,8,13,16,4,8,77,17,1,7,6,8,4,16,2,8,8,7
	db 5,8,7,16,1,8,3,16,6,8,2,7,2,8,13,16,4,8,18,17,7,5,13,17,3,5,5,9,2,5,10,17,4,5,14,17,1,5,2,9,2,5,4,17,5,5,0,2,17,5,3,9,6,5,3,9,1,5,10,17,1,7,6,8,4,16,2,8,8,7,5,8,7,16,1,8,3,16,6,8,2,7,2,8,13,16,4,8,77,17,1,7,7,8,3,16,2,8,7,7,5,8,3,16,14,8,4,7,0,2,8,16,5,8,1,16,2,8,3,16,4,8,1,7,19,17,6,5,15,17,7,5,12,17,2,5,16,17,3,5,5,17,2,5,1,17,2,5,2,17,13,5,10,17,1,7,7,8,3,16,2,8,7,7,5,8,3,16,14,8,4,7,0,2,8,16,5,8,1,16,2,8,3,16,4,8,1,7,77,17,2,7,6,8,3,16,2,8,9,7,20,8,4,7,17,8,1,7,59,17,2,5,54,17,2,7,6,8,3,16,2,8,9,7,20,8,4,7,17,8,1,7,77,17,2,7,2,8,3,7
	db 3,8,1,16,2,8,13,7,13,8,8,7,16,8,116,17,2,7,2,8,3,7,3,8,1,16,2,8,13,7,13,8,8,7,16,8,78,17,2,7,2,8,1,7,5,8,1,16,2,8,15,7,11,8,8,7,16,8,116,17,2,7,2,8,1,7,5,8,1,16,2,8,15,7,11,8,8,7,16,8,78,17,2,7,2,8,1,7,8,8,19,7,4,8,11,7,16,8,116,17,2,7,2,8,1,7,8,8,19,7,4,8,11,7,16,8,78,17,5,7,4,8,1,7,2,8,20,7,2,8,13,7,16,8,116,17,5,7,4,8,1,7,2,8,20,7,2,8,13,7,16,8,78,17,5,7,3,8,0,2,7,17,37,7,16,8,116,17,5,7,3,8,0,2,7,17,37,7,16,8,78,17,5,7,2,8,41,7,15,8,116,17,5,7,2,8,41,7,15,8,79,17,7,7,1,8,39,7,15,8,117,17,7,7,1,8,39,7,15,8,79,17,35,7,3,8,10,7,14,8,117,17,35,7,3,8,10,7,14,8
	db 80,17,32,7,3,8,12,7,14,8,118,17,32,7,3,8,12,7,14,8,80,17,31,7,4,8,11,7,15,8,118,17,31,7,4,8,11,7,15,8,81,17,25,7,0,4,8,7,8,7,5,8,10,7,16,8,119,17,25,7,0,4,8,7,8,7,5,8,10,7,16,8,82,17,20,7,0,2,8,7,18,8,2,7,17,8,120,17,20,7,0,2,8,7,18,8,2,7,17,8,82,17,20,7,16,8,2,16,21,8,120,17,20,7,16,8,2,16,21,8,83,17,19,7,10,8,3,7,12,8,1,16,13,8,121,17,19,7,10,8,3,7,12,8,1,16,13,8,85,17,2,8,0,2,7,8,13,7,9,8,6,7,8,8,3,16,13,8,123,17,2,8,0,2,7,8,13,7,9,8,6,7,8,8,3,16,13,8,85,17,1,7,3,8,13,7,9,8,7,7,7,8,1,16,15,8,123,17,1,7,3,8,13,7,9,8,7,7,7,8,1,16,15,8,87,17,2,7,3,8,13,7,5,8,6,7,11,8,1,16
	db 13,8,125,17,2,7,3,8,13,7,5,8,6,7,11,8,1,16,13,8,89,17,2,7,2,8,13,7,2,8,6,7,27,8,127,17,2,7,2,8,13,7,2,8,6,7,27,8,90,17,4,8,15,7,31,8,1,7,128,17,4,8,15,7,31,8,1,7,91,17,3,8,5,7,1,8,9,7,20,8,3,16,8,8,1,7,129,17,3,8,5,7,1,8,9,7,20,8,3,16,8,8,1,7,91,17,1,7,9,8,7,7,4,8,3,16,2,8,13,16,10,8,130,17,1,7,9,8,7,7,4,8,3,16,2,8,13,16,10,8,92,17,1,7,14,8,3,7,2,8,4,7,2,8,1,7,21,8,1,7,130,17,1,7,14,8,3,7,2,8,4,7,2,8,1,7,21,8,1,7,93,17,1,7,17,8,5,7,24,8,132,17,1,7,17,8,5,7,24,8,95,17,1,7,16,8,7,7,21,8,134,17,1,7,16,8,7,7,21,8,97,17,1,7,15,8,6,7,21,8,136,17,1,7,15,8,6,7,21,8
	db 99,17,1,7,14,8,5,7,21,8,1,7,137,17,1,7,14,8,5,7,21,8,1,7,101,17,14,8,3,7,22,8,140,17,14,8,3,7,22,8,103,17,13,8,1,7,22,8,1,7,142,17,13,8,1,7,22,8,1,7,104,17,1,7,35,8,143,17,1,7,35,8,106,17,1,7,32,8,1,7,145,17,1,7,32,8,1,7,109,17,1,7,12,8,3,7,15,8,148,17,1,7,12,8,3,7,15,8,112,17,12,8,6,7,11,8,150,17,12,8,6,7,11,8,112,17,1,7,13,8,2,7,13,8,150,17,1,7,13,8,2,7,13,8,113,17,27,8,1,7,151,17,27,8,1,7,113,17,1,7,25,8,1,7,152,17,1,7,25,8,1,7,116,17,1,7,21,8,1,7,156,17,1,7,21,8,1,7,121,17,3,7,14,8,1,7,161,17,3,7,14,8,1,7,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17
	db 255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,239,17	
data ends

Pictures segment
	Rules db 255,17,255,17,255,17,255,17,255,17,255,17,255,17,29,17,1,5,215,17,14,5,7,17,14,5,1,17,9,5,2,17,14,5,8,17,18,5,8,17,10,5,6,17,2,5,210,17,12,5,9,17,8,5,6,17,5,5,7,17,8,5,14,17,8,5,4,17,3,5,7,17,3,5,4,17,4,5,5,17,4,5,102,17,10,2,4,17,5,2,2,17,4,2,2,17,8,2,3,17,12,2,57,17,8,5,2,17,3,5,8,17,8,5,7,17,3,5,8,17,8,5,14,17,8,5,5,17,2,5,6,17,3,5,13,17,6,5,103,17,4,2,3,17,1,2,5,17,3,2,2,17,3,2,6,17,4,2,5,17,1,2,3,17,4,2,3,17,1,2,57,17,8,5,3,17,3,5,7,17,8,5,8,17,1,5,9,17,8,5,14,17,8,5,6,17,1,5,5,17,7,5,10,17,6,5,103,17,4,2,10,17,6,2,7,17,4,2,9,17,4,2,61,17,8,5,3,17,3,5,7,17,8,5,8,17,1,5,9,17
	db 8,5,14,17,8,5,11,17,11,5,7,17,6,5,103,17,7,2,8,17,4,2,8,17,4,2,9,17,4,2,61,17,8,5,3,17,2,5,8,17,8,5,8,17,1,5,9,17,8,5,14,17,13,5,6,17,13,5,6,17,4,5,104,17,4,2,11,17,5,2,7,17,4,2,9,17,4,2,61,17,12,5,9,17,8,5,8,17,1,5,9,17,8,5,14,17,13,5,7,17,12,5,6,17,4,5,104,17,4,2,10,17,7,2,6,17,4,2,9,17,4,2,61,17,8,5,2,17,3,5,8,17,8,5,8,17,1,5,9,17,8,5,14,17,8,5,3,17,2,5,8,17,11,5,7,17,2,5,105,17,4,2,3,17,1,2,5,17,2,2,3,17,4,2,5,17,4,2,9,17,4,2,61,17,8,5,3,17,3,5,7,17,8,5,7,17,2,5,9,17,8,5,6,17,1,5,7,17,8,5,13,17,12,5,6,17,2,5,103,17,10,2,3,17,3,2,3,17,6,2,2,17,8,2,5,17,8,2,59,17
	db 8,5,3,17,4,5,7,17,8,5,5,17,3,5,9,17,8,5,6,17,1,5,7,17,8,5,6,17,1,5,7,17,11,5,218,17,8,5,4,17,4,5,7,17,8,5,3,17,3,5,10,17,8,5,5,17,2,5,7,17,8,5,5,17,2,5,5,17,1,5,3,17,8,5,7,17,2,5,210,17,8,5,5,17,4,5,7,17,12,5,11,17,8,5,4,17,3,5,7,17,8,5,4,17,3,5,5,17,1,5,7,17,4,5,6,17,4,5,209,17,8,5,6,17,4,5,7,17,10,5,12,17,8,5,3,17,4,5,7,17,8,5,3,17,4,5,5,17,3,5,6,17,2,5,7,17,4,5,206,17,13,5,3,17,6,5,8,17,7,5,10,17,18,5,4,17,18,5,6,17,9,5,9,17,2,5,127,17,3,9,255,17,62,17,4,9,255,17,61,17,5,9,34,17,6,2,3,17,9,2,3,17,10,2,3,17,10,2,3,17,8,2,227,17,5,9,32,17,2,2,10,17,4,2,2,17,2,2,4,17
	db 4,2,3,17,1,2,5,17,4,2,3,17,1,2,5,17,4,2,1,17,2,2,228,17,4,9,30,17,4,2,9,17,4,2,2,17,2,2,4,17,4,2,9,17,4,2,9,17,4,2,2,17,1,2,229,17,4,9,29,17,7,2,6,17,4,2,2,17,2,2,4,17,7,2,6,17,7,2,6,17,4,2,2,17,2,2,229,17,4,9,29,17,7,2,5,17,7,2,5,17,4,2,9,17,4,2,9,17,4,2,2,17,2,2,230,17,4,9,30,17,5,2,5,17,4,2,8,17,4,2,9,17,4,2,9,17,4,2,2,17,1,2,232,17,5,9,30,17,3,2,5,17,4,2,8,17,4,2,3,17,1,2,5,17,4,2,3,17,1,2,5,17,4,2,1,17,2,2,233,17,5,9,24,17,7,2,4,17,9,2,3,17,10,2,3,17,10,2,3,17,8,2,235,17,5,9,255,17,61,17,5,9,255,17,62,17,4,9,27,17,8,2,1,17,3,2,2,17,9,2,255,17,12,17,4,9,28,17,4,2
	db 4,17,1,2,5,17,4,2,2,17,2,2,30,17,9,2,6,17,8,2,6,17,6,2,5,17,6,2,1,17,5,2,4,17,12,2,169,17,4,9,27,17,4,2,4,17,1,2,5,17,4,2,2,17,2,2,32,17,4,2,2,17,2,2,7,17,4,2,6,17,4,2,2,17,1,2,7,17,4,2,2,17,4,2,5,17,1,2,3,17,4,2,3,17,1,2,170,17,4,9,26,17,4,2,4,17,1,2,5,17,4,2,2,17,2,2,5,17,2,9,25,17,4,2,2,17,2,2,7,17,4,2,5,17,5,2,10,17,4,2,2,17,4,2,9,17,4,2,173,17,2,16,4,9,13,16,12,17,4,2,4,17,1,2,5,17,7,2,5,17,3,9,25,17,7,2,8,17,4,2,5,17,5,2,10,17,10,2,9,17,4,2,172,17,1,16,3,14,5,9,11,14,1,16,11,17,4,2,3,17,2,2,5,17,4,2,7,17,4,9,25,17,4,2,1,17,2,2,8,17,4,2,5,17,5,2,1,17,3,2
	db 6,17,4,2,2,17,4,2,9,17,4,2,171,17,1,16,5,14,4,9,12,14,1,16,11,17,4,2,1,17,2,2,6,17,4,2,6,17,4,9,26,17,4,2,2,17,2,2,7,17,4,2,5,17,5,2,2,17,2,2,6,17,4,2,2,17,4,2,9,17,4,2,171,17,1,16,2,14,4,4,3,9,12,14,1,16,13,17,4,2,5,17,8,2,4,17,3,9,27,17,4,2,2,17,3,2,6,17,4,2,6,17,4,2,2,17,2,2,6,17,4,2,2,17,4,2,9,17,4,2,171,17,1,16,2,14,1,4,5,14,3,4,2,14,4,4,4,14,1,16,33,17,4,9,25,17,7,2,2,17,3,2,3,17,8,2,6,17,5,2,6,17,6,2,1,17,5,2,6,17,8,2,169,17,1,16,2,14,4,4,1,14,2,4,3,14,2,4,7,14,1,16,32,17,4,9,255,17,6,17,1,16,2,14,4,4,2,14,2,4,2,14,2,4,7,14,1,16,31,17,4,9,255,17,7,17,1,16,2,14
	db 1,4,6,14,2,4,1,14,2,4,7,14,1,16,31,17,3,9,31,17,1,9,231,17,1,16,2,14,4,4,1,14,3,4,3,14,4,4,4,14,1,16,30,17,4,9,30,17,3,9,230,17,1,16,21,14,1,16,29,17,4,9,30,17,4,9,231,17,1,16,19,14,1,16,29,17,4,9,30,17,4,9,233,17,19,16,30,17,3,9,31,17,3,9,255,17,27,17,4,9,30,17,4,9,254,17,13,16,5,17,9,16,4,9,3,17,12,16,5,17,10,16,4,9,2,17,12,16,5,17,12,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,11,16,124,17,1,16,13,14,1,16,3,17,1,16,9,14,3,9,3,17,1,16,12,14,1,16,3,17,1,16,9,14,4,9,2,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16
	db 12,14,1,16,3,17,1,16,11,14,1,16,122,17,1,16,15,14,0,3,16,17,16,9,14,4,9,0,3,16,17,16,14,14,0,3,16,17,16,10,14,3,9,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,2,14,2,4,10,14,0,4,16,17,16,14,2,4,10,14,1,16,121,17,1,16,3,14,3,4,9,14,0,5,16,17,16,14,4,3,14,1,4,2,14,4,9,0,5,14,16,17,16,14,4,4,9,14,0,4,16,17,16,14,4,4,4,14,4,9,0,4,16,17,16,14,5,4,8,14,0,4,16,17,16,14,2,4,1,14,2,4,8,14,0,5,16,17,16,14,4,3,14,1,4,8,14,0,3,16,17,16,2,14,1,4,10,14,0,3,16,17,16,2,14,3,4,9,14,0,4,16,17,16,14,4,4,8,14,0,3,16,17,16,2,14,1,4,11,14,0,3,16,17
	db 16,2,14,1,4,10,14,1,16,121,17,1,16,2,14,1,4,3,14,1,4,8,14,0,10,16,17,16,14,4,14,4,14,4,14,4,9,2,14,0,5,16,17,16,14,4,12,14,0,5,16,17,16,14,4,2,14,1,4,3,14,4,9,0,4,14,16,17,16,3,14,1,4,10,14,0,3,16,17,16,2,14,3,4,9,14,0,5,16,17,16,14,4,3,14,1,4,8,14,0,3,16,17,16,2,14,1,4,10,14,0,5,16,17,16,14,4,3,14,1,4,8,14,0,5,16,17,16,14,4,2,14,1,4,8,14,0,4,16,17,16,14,2,4,11,14,0,3,16,17,16,2,14,2,4,9,14,1,16,121,17,1,16,2,14,1,4,3,14,1,4,8,14,0,4,16,17,16,14,5,4,1,14,3,9,3,14,0,4,16,17,16,14,4,4,9,14,0,4,16,17,16,14,3,4,3,14,4,9,2,14,0,3,16,17,16,3,14,1,4,10,14,0,3,16,17,16,3,14,1,4,10,14,0,5,16,17,16,14,4
	db 3,14,1,4,8,14,0,3,16,17,16,2,14,1,4,10,14,0,5,16,17,16,14,4,3,14,1,4,8,14,0,5,16,17,16,14,4,2,14,1,4,8,14,0,4,16,17,16,14,2,4,11,14,0,3,16,17,16,2,14,2,4,9,14,1,16,121,17,1,16,2,14,1,4,3,14,1,4,8,14,0,4,16,17,16,14,5,4,1,14,3,9,3,14,0,4,16,17,16,14,4,4,9,14,0,4,16,17,16,14,3,4,3,14,3,9,3,14,0,3,16,17,16,3,14,1,4,10,14,0,3,16,17,16,3,14,1,4,10,14,0,5,16,17,16,14,4,3,14,1,4,8,14,0,3,16,17,16,2,14,1,4,10,14,0,5,16,17,16,14,4,3,14,1,4,8,14,0,4,16,17,16,14,4,4,8,14,0,4,16,17,16,14,2,4,11,14,0,3,16,17,16,2,14,2,4,9,14,1,16,121,17,1,16,2,14,1,4,3,14,1,4,8,14,0,4,16,17,16,14,5,4,7,14,0,5,16,17,16,14
	db 4,12,14,0,6,16,17,16,14,4,14,2,4,1,14,4,9,3,14,0,3,16,17,16,3,14,1,4,10,14,0,3,16,17,16,3,14,1,4,10,14,0,4,16,17,16,14,2,4,1,14,2,4,8,14,0,3,16,17,16,2,14,1,4,10,14,0,5,16,17,16,14,4,3,14,1,4,8,14,0,5,16,17,16,14,4,11,14,0,3,16,17,16,2,14,1,4,11,14,0,3,16,17,16,2,14,1,4,10,14,1,16,121,17,1,16,3,14,5,4,7,14,0,3,16,17,16,2,14,0,3,4,14,4,8,14,0,4,16,17,16,14,4,4,9,14,0,5,16,17,16,14,4,2,14,1,4,4,9,4,14,0,3,16,17,16,3,14,1,4,10,14,0,3,16,17,16,3,14,1,4,10,14,0,3,16,17,16,2,14,3,4,9,14,0,3,16,17,16,2,14,1,4,10,14,0,3,16,17,16,2,14,3,4,9,14,0,5,16,17,16,14,4,11,14,0,3,16,17,16,2,14,2,4,10,14,0,4,16,17
	db 16,14,2,4,10,14,1,16,121,17,1,16,10,14,2,1,3,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,5,14,3,9,5,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,1,16,121,17,1,16,15,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,4,14,4,9,5,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,2,14,2,4,10,14,0,4,16,17,16,14,2,4,10,14,1,16,121,17,1,16,9,14,1,1,2,14,1,1,2,14,0,3,16,17,16,7,14,0,3,1,14,1,3,14,0,3,16,17,16,9,14,0,3,1,14,1,2,14,0
	db 3,16,17,16,3,14,4,9,1,1,2,14,1,1,2,14,0,3,16,17,16,9,14,3,1,2,14,0,3,16,17,16,7,14,1,1,2,14,1,1,3,14,0,3,16,17,16,9,14,3,1,2,14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,3,14,0,3,16,17,16,8,14,4,1,0,4,14,16,17,16,2,14,1,4,5,14,1,1,3,14,0,5,1,14,16,17,16,2,14,1,4,3,14,2,1,5,14,1,16,121,17,1,16,9,14,0,2,1,14,2,1,2,14,0,3,16,17,16,7,14,0,3,1,14,1,3,14,0,3,16,17,16,9,14,0,3,1,14,1,2,14,0,3,16,17,16,2,14,4,9,0,4,14,1,14,1,3,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,7,14,1,1,2,14,1,1,3,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,2
	db 14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,3,14,0,3,16,17,16,11,14,0,5,1,14,16,17,16,2,14,1,4,6,14,0,3,1,14,1,2,14,0,3,16,17,16,2,14,1,4,4,14,1,1,5,14,1,16,121,17,1,16,9,14,4,1,2,14,0,3,16,17,16,7,14,0,3,1,14,1,3,14,0,3,16,17,16,9,14,3,1,2,14,0,3,16,17,16,2,14,3,9,2,14,3,1,3,14,0,3,16,17,16,9,14,3,1,2,14,0,3,16,17,16,7,14,4,1,3,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,3,14,0,3,16,17,16,9,14,3,1,0,4,14,16,17,16,2,14,1,4,7,14,1,1,3,14,0,3,16,17,16,2,14,1,4,4,14,4,1,2,14,1,16,121,17,1,16,9,14,2,1,0,2,14,1,2,14,0,3,16,17,16,7,14,0
	db 3,1,14,1,3,14,0,3,16,17,16,10,14,1,1,3,14,0,4,16,17,16,14,4,9,2,14,1,1,2,14,1,1,2,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,7,14,1,1,2,14,1,1,3,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,3,14,0,3,16,17,16,11,14,0,5,1,14,16,17,16,2,14,1,4,6,14,0,3,1,14,1,2,14,0,3,16,17,16,2,14,1,4,4,14,1,1,2,14,1,1,2,14,1,16,121,17,1,16,9,14,1,1,2,14,1,1,2,14,0,3,16,17,16,7,14,4,1,2,14,0,3,16,17,16,8,14,3,1,3,14,0,3,16,17,16,4,9,3,14,1,1,2,14,1,1,2,14,0,3,16,17,16,9,14,3,1,2,14,0,3,16,17,16,7,14,1,1,2,14,1,1,3,14,0,3,16,17,16,9,14,1,1
	db 4,14,0,3,16,17,16,6,14,5,1,2,14,0,3,16,17,16,6,14,6,1,2,14,0,3,16,17,16,8,14,4,1,0,4,14,16,17,16,2,14,2,4,4,14,1,1,3,14,0,6,1,14,16,17,16,14,2,4,4,14,4,1,2,14,1,16,121,17,1,16,15,14,0,3,16,17,16,10,14,1,1,2,14,0,3,16,17,16,14,14,0,3,16,17,16,3,9,10,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,11,14,1,1,2,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,1,16,122,17,1,16,13,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,2,17,4,9,9,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14
	db 1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,124,17,13,16,5,17,11,16,5,17,12,16,2,17,4,9,10,16,5,17,12,16,5,17,12,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,11,16,172,17,4,9,255,17,14,17,13,16,5,17,11,16,5,17,12,16,1,17,3,9,1,14,11,16,5,17,12,16,5,17,12,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,11,16,5,17,12,16,140,17,1,16,13,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,4,9,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,138,17,1,16,15,14,0,3,16,17,16,13,14,0,3,16,17,16,12,14,4,9,1,16,13,14,0,3,16,17,16,14
	db 14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,2,14,1,4,10,14,0,3,16,17,16,14,14,1,16,137,17,1,16,3,14,2,4,10,14,0,3,16,17,16,2,14,3,4,8,14,0,4,16,17,16,14,5,4,6,14,3,9,0,3,17,16,14,4,4,8,14,0,3,16,17,16,2,14,4,4,8,14,0,5,16,17,16,14,4,2,14,1,4,9,14,0,3,16,17,16,4,14,1,4,9,14,0,5,16,17,16,14,4,2,14,1,4,8,14,0,5,16,17,16,14,4,12,14,0,3,16,17,16,13,14,0,3,16,17,16,2,14,0,3,4,14,4,9,14,1,16,137,17,1,16,2,14,4,4,9,14,0,4,16,17,16,14,2,4,10,14,0,3,16,17,16,2,14,1,4,2,14,1,4,5,14,4,9,0,4,17,16,14,4,11,14,0,3,16,17,16,2,14,1,4,11,14,0,5,16,17,16,14,4,2,14,1,4,9,14
	db 0,3,16,17,16,4,14,1,4,9,14,0,7,16,17,16,14,4,14,4,9,14,0,5,16,17,16,14,4,12,14,0,3,16,17,16,13,14,0,3,16,17,16,2,14,0,3,4,14,4,9,14,1,16,137,17,1,16,2,14,1,4,2,14,1,4,9,14,0,3,16,17,16,2,14,2,4,9,14,0,3,16,17,16,2,14,1,4,2,14,1,4,4,14,4,9,0,4,16,17,16,14,3,4,9,14,0,3,16,17,16,2,14,0,2,4,14,2,4,8,14,0,4,16,17,16,14,4,4,9,14,0,3,16,17,16,4,14,1,4,9,14,0,4,16,17,16,14,3,4,9,14,0,5,16,17,16,14,4,12,14,0,3,16,17,16,2,14,1,4,10,14,0,3,16,17,16,14,14,1,16,137,17,1,16,2,14,4,4,9,14,0,3,16,17,16,3,14,2,4,8,14,0,3,16,17,16,2,14,1,4,2,14,1,4,3,14,4,9,0,6,14,16,17,16,14,4,11,14,0,3,16,17,16,2,14,1,4,2,14
	db 2,4,7,14,0,5,16,17,16,14,4,2,14,1,4,9,14,0,3,16,17,16,2,14,0,3,4,14,4,9,14,0,5,16,17,16,14,4,2,14,1,4,8,14,0,5,16,17,16,14,4,12,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,1,16,137,17,1,16,2,14,1,4,2,14,1,4,9,14,0,4,16,17,16,14,3,4,9,14,0,4,16,17,16,14,5,4,3,14,3,9,2,14,0,5,16,17,16,14,4,11,14,0,3,16,17,16,2,14,4,4,8,14,0,5,16,17,16,14,4,2,14,1,4,9,14,0,3,16,17,16,2,14,3,4,9,14,0,5,16,17,16,14,4,2,14,1,4,8,14,0,4,16,17,16,14,3,4,10,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,1,16,137,17,1,16,15,14,0,3,16,17,16,13,14,0,3,16,17,16,9,14,3,9,2,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16
	db 14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,1,16,137,17,1,16,10,14,1,1,4,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,1,16,137,17,1,16,10,14,1,1,4,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,8,14,3,1,3,14,0,3,16,17,16,2,14,1,4,2,14,2,1,0,3,14,1,14,2,1,0,4,14,16,17,16,8,14,4,1,2,14,1,16,137,17,1,16,9,14,3,1,3,14,0,3,16,17,16,6,14,1,1,3,14,1
	db 1,2,14,0,3,16,17,16,8,14,4,1,2,14,0,3,16,17,16,8,14,2,1,3,14,0,3,16,17,16,8,14,4,1,2,14,0,3,16,17,16,8,14,4,1,2,14,0,3,16,17,16,8,14,3,1,3,14,0,3,16,17,16,8,14,2,1,3,14,0,3,16,17,16,8,14,0,3,1,14,1,3,14,0,3,16,17,16,6,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,3,14,1,4,7,14,2,1,0,2,14,16,137,17,1,16,2,14,3,9,3,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,2,14,2,9,2,14,1,1,3,14,1,1,2,14,0,3,16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,7,14,4,1,2,14,0,3,16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,7,14,1,1,3,14,1,1,2,14,0,3,16,17,16,7,14,1,1,2,14,1,1,2,14
	db 0,3,16,17,16,8,14,0,3,1,14,1,3,14,0,3,16,17,16,7,14,3,1,3,14,0,3,16,17,16,3,14,1,4,5,14,4,1,0,2,14,16,137,17,0,2,16,14,4,9,3,14,0,5,1,14,1,14,1,2,14,0,4,16,17,16,14,3,9,2,14,3,1,0,2,14,1,2,14,0,3,16,17,16,8,14,4,1,2,14,0,3,16,17,16,7,14,1,1,2,14,1,1,2,14,0,3,16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,8,14,4,1,2,14,0,3,16,17,16,7,14,1,1,3,14,1,1,2,14,0,3,16,17,16,7,14,1,1,2,14,1,1,2,14,0,3,16,17,16,8,14,0,3,1,14,1,3,14,0,3,16,17,16,2,14,1,4,3,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,11,14,2,1,0,2,14,16,137,17,1,16,5,9,4,14,3,1,3,14,0,3,16,17,16,4,9,2,14,0,5,1,14,1,14,1,2,14,0,3
	db 16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,7,14,4,1,2,14,0,3,16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,8,14,1,1,5,14,0,3,16,17,16,7,14,1,1,3,14,1,1,2,14,0,3,16,17,16,7,14,1,1,2,14,1,1,2,14,0,3,16,17,16,7,14,5,1,2,14,0,4,16,17,16,14,2,4,2,14,2,1,0,3,14,1,14,2,1,0,4,14,16,17,16,8,14,4,1,2,14,1,16,137,17,4,9,7,14,1,1,4,14,0,2,16,17,4,9,3,14,3,1,0,2,14,1,2,14,0,3,16,17,16,8,14,4,1,2,14,0,3,16,17,16,7,14,1,1,2,14,1,1,2,14,0,3,16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,8,14,1,1,5,14,0,3,16,17,16,8,14,3,1,3,14,0,3,16,17,16,6,14,2,1,2,14,1,1,2,14,0,3,16,17,16,7,14,1,1,3,14,1
	db 1,2,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,1,16,135,17,5,9,12,14,0,2,16,17,4,9,10,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,135,17,5,9,1,17,12,16,2,17,3,9,11,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,12,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,11,16,5,17,12,16,135,17,5,9,15,17,4,9,255,17,40,17,5,9,15,17,4,9,1,14,11,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,12,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,11,16,150,17,4,9,16,17,4,9,0,2,14,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11
	db 14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,147,17,5,9,17,17,4,9,1,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,5,14,1,4,8,14,0,3,16,17,16,2,14,1,4,10,14,1,16,145,17,5,9,17,17,4,9,0,2,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,5,14,1,4,8,14,0,3,16,17,16,2,14,1,4,10,14,1,16,144,17,5,9,17,17,4,9,2,17,0,2,16,14,4,4,8,14,0,3,16,17,16,2,14,1,4,3,14,1,4
	db 7,14,0,3,16,17,16,2,14,4,4,7,14,0,3,16,17,16,2,14,2,4,1,14,2,4,7,14,0,3,16,17,16,2,14,4,4,8,14,0,5,16,17,16,14,4,2,14,1,4,9,14,0,3,16,17,16,2,14,1,4,3,14,1,4,6,14,0,3,16,17,16,4,14,1,4,9,14,0,3,16,17,16,3,14,1,4,9,14,1,16,143,17,4,9,18,17,4,9,3,17,1,16,4,14,1,4,8,14,0,3,16,17,16,3,14,0,3,4,14,4,8,14,0,4,16,17,16,14,2,4,10,14,0,3,16,17,16,3,14,0,3,4,14,4,8,14,0,3,16,17,16,2,14,1,4,2,14,1,4,8,14,0,4,16,17,16,14,2,4,0,2,14,4,9,14,0,3,16,17,16,2,14,2,4,1,14,2,4,6,14,0,3,16,17,16,3,14,1,4,10,14,0,3,16,17,16,4,14,1,4,8,14,1,16,141,17,5,9,19,17,4,9,3,17,1,16,2,14,2,4,9,14,0,3,16,17,16,4,14
	db 1,4,9,14,0,4,16,17,16,14,2,4,10,14,0,3,16,17,16,3,14,0,3,4,14,4,8,14,0,3,16,17,16,2,14,4,4,8,14,0,4,16,17,16,14,4,4,9,14,0,3,16,17,16,2,14,5,4,6,14,0,3,16,17,16,4,14,1,4,9,14,0,3,16,17,16,3,14,1,4,9,14,1,16,140,17,5,9,19,17,4,9,4,17,0,3,16,14,4,11,14,0,3,16,17,16,3,14,0,3,4,14,4,8,14,0,4,16,17,16,14,2,4,10,14,0,3,16,17,16,3,14,0,3,4,14,4,8,14,0,3,16,17,16,2,14,1,4,2,14,1,4,8,14,0,6,16,17,16,14,4,14,2,4,9,14,0,3,16,17,16,2,14,0,5,4,14,4,14,4,6,14,0,3,16,17,16,5,14,1,4,8,14,0,3,16,17,16,2,14,1,4,10,14,1,16,139,17,5,9,19,17,4,9,5,17,0,2,16,14,4,4,8,14,0,3,16,17,16,2,14,1,4,3,14,1,4,7,14,0
	db 3,16,17,16,2,14,4,4,7,14,0,3,16,17,16,4,14,1,4,9,14,0,3,16,17,16,2,14,4,4,8,14,0,5,16,17,16,14,4,2,14,1,4,9,14,0,3,16,17,16,2,14,0,5,4,14,4,14,4,6,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,1,16,138,17,4,9,21,17,3,9,6,17,1,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,1,16,136,17,5,9,21,17,4,9,6,17,1,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,1,16,136,17,4,9,21,17,4,9,7,17,1,16,9,14,3,1,0,4,14
	db 16,17,16,8,14,2,1,0,2,14,1,2,14,0,3,16,17,16,8,14,4,1,0,4,14,16,17,16,7,14,1,1,3,14,1,1,2,14,0,3,16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,7,14,5,1,2,14,0,3,16,17,16,8,14,1,1,4,14,0,3,16,17,16,9,14,4,1,0,4,14,16,17,16,5,14,1,1,2,14,3,1,2,14,1,16,136,17,3,9,21,17,4,9,8,17,1,16,8,14,1,1,2,14,0,5,1,14,16,17,16,9,14,0,3,1,14,1,2,14,0,3,16,17,16,7,14,2,1,4,14,0,3,16,17,16,7,14,2,1,1,14,2,1,2,14,0,3,16,17,16,8,14,0,2,1,14,2,1,2,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,8,14,1,1,4,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,5,14,0,3,1,14,1,3,14,0,3,1,14,16,160,17,3,9,9,17,1,16,9,14,3
	db 1,0,4,14,16,17,16,9,14,3,1,2,14,0,3,16,17,16,7,14,2,1,4,14,0,3,16,17,16,7,14,5,1,2,14,0,3,16,17,16,8,14,4,1,2,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,8,14,4,1,0,4,14,16,17,16,9,14,4,1,0,4,14,16,17,16,5,14,3,1,3,14,0,3,1,14,16,159,17,4,9,9,17,1,16,9,14,0,7,1,14,1,14,16,17,16,11,14,1,1,2,14,0,3,16,17,16,7,14,2,1,4,14,0,3,16,17,16,7,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,8,14,2,1,0,2,14,1,2,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,8,14,1,1,2,14,0,5,1,14,16,17,16,3,14,1,4,5,14,1,1,2,14,0,5,1,14,16,17,16,2,14,1,4,2,14,0,3,1,14,1,3,14,0,3,1,14,16,98,17,8,2,5,17,10,2,4,17,9,2,3,17,12,2
	db 9,17,4,9,10,17,1,16,9,14,0,7,1,14,1,14,16,17,16,11,14,1,1,2,14,0,3,16,17,16,7,14,2,1,4,14,0,3,16,17,16,7,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,8,14,2,1,0,2,14,1,2,14,0,3,16,17,16,9,14,1,1,4,14,0,3,16,17,16,8,14,1,1,2,14,0,5,1,14,16,17,16,3,14,1,4,5,14,1,1,2,14,0,5,1,14,16,17,16,2,14,1,4,2,14,0,3,1,14,1,3,14,0,3,1,14,16,100,17,4,2,9,17,4,2,3,17,1,2,5,17,4,2,3,17,1,2,3,17,1,2,3,17,4,2,3,17,1,2,8,17,4,9,11,17,1,16,8,14,2,1,0,6,14,1,14,16,17,16,11,14,1,1,2,14,0,3,16,17,16,8,14,4,1,0,4,14,16,17,16,7,14,0,5,1,14,1,14,1,2,14,0,3,16,17,16,8,14,1,1,2,14,1,1,2,14,0,3,16,17,16,9,14,1,1,4
	db 14,0,3,16,17,16,8,14,4,1,0,4,14,16,17,16,2,14,2,4,5,14,4,1,0,4,14,16,17,16,5,14,1,1,2,14,3,1,2,14,1,16,100,17,4,2,9,17,4,2,9,17,4,2,11,17,4,2,12,17,3,9,12,17,1,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,0,3,16,17,16,14,14,0,3,16,17,16,13,14,1,16,100,17,4,2,9,17,7,2,6,17,7,2,8,17,4,2,11,17,4,9,13,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,3,17,1,16,12,14,1,16,3,17,1,16,11,14,1,16,101,17,4,2,9,17,4,2,9,17,4,2,2,17,1,2,8,17,4,2,10,17
	db 4,9,15,17,11,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,12,16,5,17,12,16,5,17,11,16,5,17,12,16,5,17,11,16,102,17,4,2,3,17,2,2,4,17,4,2,9,17,4,2,11,17,4,2,9,17,4,9,255,17,7,17,4,2,3,17,2,2,4,17,4,2,3,17,1,2,5,17,4,2,11,17,4,2,9,17,3,9,50,17,78,16,133,17,11,2,2,17,10,2,4,17,7,2,7,17,8,2,6,17,4,9,49,17,1,16,78,14,1,16,186,17,4,9,49,17,1,16,80,14,1,16,184,17,4,9,50,17,1,16,80,14,1,16,184,17,3,9,51,17,1,16,80,14,1,16,183,17,4,9,51,17,1,16,80,14,1,16,182,17,4,9,52,17,1,16,80,14,1,16,181,17,4,9,53,17,1,16,28,14,3,4,1,14,4,4,2,14,2,4,3,14,4,4,1,14,4,4,28,14,1,16,181,17,3,9,54,17,1,16,27,14,2,4,3,14,1,4,2,14,0,2,4,14,4,4
	db 1,14,2,4,4,14,1,4,31,14,1,16,181,17,3,9,54,17,1,16,28,14,2,4,2,14,4,4,0,2,14,4,2,14,0,2,4,14,2,4,4,14,4,4,21,14,3,9,4,14,1,16,238,17,1,16,29,14,2,4,0,2,14,4,4,14,4,4,1,14,2,4,4,14,1,4,23,14,8,9,1,16,238,17,1,16,27,14,3,4,2,14,1,4,4,14,1,4,2,14,1,4,2,14,4,4,1,14,4,4,21,14,11,9,235,17,1,16,75,14,13,9,231,17,1,16,79,14,13,9,227,17,1,16,80,14,1,16,2,17,13,9,137,17,5,2,4,17,9,2,3,17,10,2,3,17,10,2,3,17,8,2,31,17,1,16,80,14,1,16,7,17,12,9,132,17,1,2,11,17,4,2,2,17,2,2,4,17,4,2,3,17,1,2,5,17,4,2,3,17,1,2,5,17,4,2,1,17,2,2,30,17,1,16,80,14,1,16,11,17,12,9,128,17,4,2,8,17,4,2,2,17,2,2,4,17,4,2,9,17
	db 4,2,9,17,4,2,2,17,1,2,30,17,1,16,80,14,1,16,15,17,13,9,123,17,6,2,6,17,4,2,2,17,2,2,4,17,7,2,6,17,7,2,6,17,4,2,2,17,2,2,30,17,1,16,78,14,1,16,20,17,11,9,121,17,7,2,5,17,7,2,5,17,4,2,9,17,4,2,9,17,4,2,2,17,2,2,31,17,78,16,25,17,8,9,122,17,5,2,5,17,4,2,8,17,4,2,9,17,4,2,9,17,4,2,2,17,1,2,139,17,4,9,125,17,1,2,6,17,4,2,8,17,4,2,3,17,1,2,5,17,4,2,3,17,1,2,5,17,4,2,1,17,2,2,255,17,8,17,5,2,5,17,8,2,4,17,10,2,3,17,10,2,3,17,8,2,127,17,9,2,8,17,6,2,6,17,12,2,7,17,2,2,7,17,12,2,2,17,10,2,241,17,4,2,2,17,2,2,6,17,3,2,2,17,3,2,5,17,1,2,3,17,4,2,3,17,1,2,6,17,4,2,6,17,1,2,3,17,4,2
	db 3,17,1,2,4,17,4,2,3,17,1,2,241,17,4,2,2,17,2,2,5,17,3,2,4,17,3,2,8,17,4,2,10,17,4,2,10,17,4,2,8,17,4,2,61,17,8,2,7,17,6,2,4,17,7,2,2,17,2,2,2,17,4,2,2,17,5,2,2,17,3,2,130,17,7,2,6,17,3,2,4,17,3,2,8,17,4,2,9,17,2,2,2,17,2,2,9,17,4,2,8,17,7,2,60,17,4,2,1,17,2,2,5,17,3,2,2,17,3,2,4,17,5,2,2,17,3,2,3,17,2,2,5,17,4,2,2,17,1,2,131,17,4,2,1,17,2,2,6,17,3,2,4,17,3,2,8,17,4,2,8,17,3,2,2,17,2,2,9,17,4,2,8,17,4,2,63,17,4,2,2,17,1,2,4,17,3,2,4,17,3,2,4,17,4,2,2,17,4,2,2,17,2,2,5,17,7,2,131,17,4,2,2,17,2,2,5,17,3,2,4,17,3,2,8,17,4,2,8,17,8,2,8,17,4,2,8,17,4,2
	db 63,17,4,2,2,17,2,2,3,17,3,2,4,17,3,2,4,17,4,2,2,17,4,2,1,17,2,2,6,17,7,2,131,17,4,2,2,17,3,2,5,17,3,2,2,17,3,2,9,17,4,2,6,17,3,2,3,17,5,2,7,17,4,2,8,17,4,2,3,17,1,2,59,17,4,2,2,17,2,2,3,17,3,2,4,17,3,2,5,17,12,2,6,17,0,2,2,17,5,2,129,17,7,2,2,17,3,2,5,17,6,2,8,17,8,2,4,17,3,2,6,17,3,2,4,17,8,2,4,17,10,2,59,17,4,2,2,17,1,2,4,17,3,2,4,17,3,2,5,17,4,2,2,17,5,2,7,17,1,2,2,17,4,2,255,17,14,17,4,2,1,17,2,2,5,17,3,2,2,17,3,2,7,17,2,2,4,17,3,2,8,17,1,2,3,17,3,2,255,17,12,17,8,2,7,17,6,2,8,17,2,2,4,17,2,2,7,17,5,2,2,17,3,2,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17
	db 131,17,6,6,2,17,7,6,5,17,4,6,1,17,2,6,2,17,3,6,2,17,5,6,1,17,2,6,5,17,4,6,2,17,2,6,1,17,2,6,2,17,2,6,4,17,3,6,1,17,3,6,1,17,8,6,6,17,8,6,2,17,3,6,8,17,3,6,2,17,3,6,2,17,3,6,4,17,2,6,4,17,3,6,1,17,3,6,2,17,4,6,1,17,6,6,7,17,3,6,2,17,3,6,2,17,3,6,1,17,3,6,1,17,8,6,1,17,5,6,4,17,3,6,2,17,5,6,7,17,5,6,2,17,5,6,1,17,3,6,1,17,8,6,1,17,8,6,2,17,3,6,2,17,3,6,1,17,3,6,2,17,4,6,6,17,4,6,1,17,3,6,2,17,4,6,1,17,6,6,29,17,2,6,5,17,2,6,3,17,1,6,6,17,3,6,0,2,17,6,2,17,2,6,1,17,2,6,3,17,2,6,2,17,1,6,7,17,3,6,1,17,5,6,3,17,3,6,4,17,3,6,0,2,17,6,2,17,1,6
	db 2,17,2,6,2,17,1,6,6,17,1,6,2,17,2,6,2,17,0,2,6,17,2,6,1,17,2,6,6,17,2,6,5,17,2,6,2,17,2,6,5,17,3,6,4,17,3,6,0,2,17,6,2,17,2,6,5,17,2,6,9,17,2,6,3,17,2,6,1,17,2,6,2,17,3,6,0,2,17,6,2,17,1,6,2,17,2,6,2,17,1,6,2,17,2,6,1,17,2,6,2,17,2,6,1,17,2,6,2,17,2,6,10,17,1,6,2,17,2,6,3,17,2,6,3,17,1,6,2,17,1,6,2,17,2,6,2,17,0,3,6,17,6,2,17,2,6,2,17,0,2,6,17,2,6,1,17,2,6,2,17,3,6,0,2,17,6,2,17,2,6,10,17,2,6,3,17,1,6,2,17,2,6,5,17,2,6,32,17,2,6,5,17,4,6,9,17,3,6,3,17,2,6,1,17,2,6,3,17,2,6,2,17,1,6,8,17,7,6,3,17,2,6,1,17,2,6,3,17,5,6,5,17,2,6,12,17,2,6,4
	db 17,2,6,1,17,2,6,6,17,2,6,5,17,6,6,4,17,2,6,0,2,17,6,4,17,5,6,2,17,2,6,1,17,2,6,2,17,4,6,7,17,2,6,3,17,2,6,1,17,2,6,2,17,5,6,5,17,2,6,5,17,4,6,3,17,2,6,1,17,2,6,2,17,2,6,10,17,4,6,4,17,2,6,3,17,1,6,5,17,2,6,7,17,2,6,4,17,2,6,1,17,2,6,2,17,5,6,3,17,3,6,8,17,2,6,3,17,1,6,3,17,3,6,3,17,4,6,30,17,2,6,5,17,2,6,12,17,2,6,3,17,2,6,1,17,2,6,3,17,5,6,8,17,3,6,1,17,2,6,3,17,6,6,3,17,0,2,6,17,3,6,5,17,2,6,12,17,2,6,4,17,2,6,1,17,2,6,6,17,2,6,5,17,2,6,2,17,2,6,3,17,6,6,3,17,0,2,6,17,3,6,2,17,2,6,2,17,1,6,2,17,2,6,9,17,2,6,3,17,2,6,1,17,2,6,2,17,0,2,6
	db 17,3,6,5,17,2,6,5,17,2,6,1,17,2,6,2,17,2,6,1,17,2,6,2,17,2,6,2,17,1,6,7,17,1,6,2,17,2,6,3,17,2,6,2,17,1,6,6,17,2,6,7,17,2,6,4,17,2,6,1,17,2,6,2,17,0,2,6,17,3,6,5,17,2,6,7,17,2,6,2,17,1,6,6,17,2,6,2,17,2,6,30,17,6,6,2,17,5,6,9,17,4,6,3,17,3,6,5,17,3,6,10,17,1,6,2,17,2,6,2,17,2,6,2,17,4,6,1,17,3,6,1,17,3,6,3,17,4,6,10,17,4,6,4,17,3,6,8,17,3,6,2,17,3,6,2,17,3,6,1,17,2,6,2,17,4,6,1,17,3,6,1,17,3,6,2,17,3,6,2,17,6,6,7,17,3,6,2,17,3,6,2,17,3,6,1,17,3,6,3,17,4,6,3,17,4,6,1,17,2,6,2,17,3,6,2,17,6,6,6,17,5,6,5,17,3,6,6,17,4,6,5,17,4,6,4,17,3,6,2
	db 17,3,6,1,17,3,6,1,17,4,6,9,17,3,6,4,17,4,6,2,17,6,6,255,17,255,17,157,17,8,6,1,17,3,6,2,17,3,6,1,17,6,6,8,17,3,6,2,17,3,6,2,17,3,6,1,17,3,6,1,17,8,6,1,17,5,6,4,17,3,6,2,17,4,6,4,17,4,6,7,17,5,6,3,17,2,6,4,17,3,6,1,17,3,6,1,17,6,6,1,17,4,6,195,17,1,6,2,17,2,6,2,17,1,6,2,17,2,6,2,17,2,6,3,17,2,6,10,17,2,6,3,17,2,6,1,17,2,6,2,17,3,6,0,2,17,6,2,17,1,6,2,17,2,6,2,17,1,6,2,17,2,6,1,17,2,6,2,17,2,6,1,17,2,6,2,17,2,6,4,17,3,6,10,17,2,6,1,17,2,6,2,17,3,6,4,17,3,6,0,2,17,6,3,17,2,6,5,17,2,6,199,17,2,6,5,17,6,6,3,17,4,6,8,17,2,6,3,17,2,6,1,17,2,6,2,17,5,6,5
	db 17,2,6,5,17,4,6,3,17,2,6,1,17,2,6,2,17,2,6,5,17,3,6,9,17,4,6,2,17,2,6,0,2,17,6,4,17,5,6,3,17,4,6,3,17,2,6,199,17,2,6,5,17,2,6,2,17,2,6,3,17,2,6,10,17,2,6,3,17,2,6,1,17,2,6,2,17,0,2,6,17,3,6,5,17,2,6,5,17,2,6,1,17,2,6,2,17,2,6,1,17,2,6,2,17,2,6,2,17,1,6,3,17,3,6,8,17,2,6,3,17,6,6,3,17,0,2,6,17,3,6,3,17,2,6,5,17,2,6,2,17,1,6,195,17,4,6,3,17,3,6,2,17,3,6,1,17,6,6,8,17,3,6,2,17,3,6,2,17,3,6,1,17,3,6,3,17,4,6,3,17,4,6,1,17,2,6,2,17,3,6,2,17,6,6,1,17,4,6,8,17,4,6,1,17,2,6,3,17,3,6,1,17,3,6,1,17,3,6,1,17,6,6,1,17,6,6,255,17,255,17,255,17,255,17,255,17,255,17,255
	db 17,255,17,255,17,255,17,194,17,8,6,2,17,3,6,6,17,4,6,1,17,3,6,1,17,3,6,2,17,3,6,1,17,5,6,3,17,6,6,2,17,4,6,2,17,6,6,5,17,8,6,1,17,3,6,2,17,3,6,1,17,6,6,7,17,4,6,3,17,3,6,2,17,3,6,2,17,5,6,3,17,6,6,5,17,6,6,1,17,4,6,1,17,4,6,3,17,4,6,7,17,8,6,1,17,3,6,2,17,3,6,1,17,6,6,6,17,4,6,3,17,4,6,1,17,3,6,1,17,3,6,1,17,6,6,5,17,4,6,2,17,0,2,6,17,3,6,1,17,4,6,1,17,8,6,1,17,3,6,2,17,3,6,7,17,3,6,2,17,3,6,2,17,4,6,4,17,3,6,2,17,5,6,3,17,6,6,1,17,6,6,7,17,1,6,2,17,2,6,2,17,0,2,6,17,2,6,1,17,2,6,6,17,2,6,3,17,3,6,0,2,17,6,2,17,2,6,4,17,2,6,1,17,2,6,3,17,2,6,4
	db 17,3,6,5,17,2,6,8,17,1,6,2,17,2,6,2,17,1,6,2,17,2,6,2,17,2,6,3,17,2,6,9,17,3,6,4,17,2,6,3,17,2,6,1,17,2,6,2,17,2,6,1,17,2,6,3,17,2,6,9,17,2,6,5,17,2,6,3,17,2,6,5,17,2,6,8,17,1,6,2,17,2,6,2,17,1,6,2,17,2,6,2,17,2,6,3,17,2,6,10,17,2,6,5,17,2,6,3,17,3,6,0,2,17,6,3,17,2,6,9,17,3,6,1,17,5,6,3,17,2,6,2,17,1,6,2,17,2,6,2,17,1,6,2,17,2,6,2,17,2,6,7,17,2,6,3,17,2,6,1,17,2,6,2,17,2,6,4,17,2,6,1,17,2,6,2,17,2,6,1,17,2,6,3,17,2,6,5,17,2,6,1,17,3,6,9,17,2,6,4,17,2,6,1,17,2,6,6,17,2,6,3,17,5,6,2,17,2,6,4,17,4,6,4,17,4,6,3,17,4,6,3,17,4,6,9,17,2,6,5
	db 17,6,6,3,17,4,6,8,17,4,6,2,17,2,6,3,17,2,6,1,17,2,6,2,17,4,6,4,17,4,6,7,17,4,6,3,17,2,6,3,17,2,6,5,17,2,6,11,17,2,6,5,17,6,6,3,17,4,6,8,17,2,6,5,17,2,6,3,17,5,6,3,17,4,6,7,17,8,6,4,17,2,6,5,17,2,6,5,17,6,6,7,17,2,6,3,17,2,6,1,17,2,6,2,17,2,6,4,17,2,6,1,17,2,6,2,17,4,6,4,17,4,6,3,17,2,6,2,17,2,6,9,17,2,6,4,17,2,6,1,17,2,6,6,17,2,6,3,17,0,2,6,17,3,6,2,17,2,6,4,17,2,6,1,17,2,6,3,17,2,6,7,17,3,6,2,17,2,6,11,17,2,6,5,17,2,6,2,17,2,6,3,17,2,6,12,17,3,6,1,17,2,6,3,17,2,6,1,17,2,6,2,17,2,6,1,17,2,6,3,17,2,6,9,17,2,6,5,17,2,6,3,17,2,6,2,17,1,6,2
	db 17,2,6,2,17,1,6,8,17,2,6,5,17,2,6,2,17,2,6,3,17,2,6,10,17,2,6,2,17,1,6,2,17,2,6,3,17,0,2,6,17,3,6,3,17,2,6,10,17,3,6,1,17,2,6,5,17,2,6,5,17,2,6,5,17,2,6,2,17,2,6,7,17,2,6,3,17,2,6,1,17,2,6,2,17,2,6,2,17,0,2,6,17,2,6,1,17,2,6,2,17,2,6,1,17,2,6,3,17,2,6,5,17,2,6,1,17,3,6,8,17,4,6,4,17,3,6,6,17,4,6,1,17,3,6,1,17,3,6,2,17,3,6,1,17,4,6,1,17,2,6,1,17,6,6,1,17,5,6,2,17,6,6,7,17,4,6,3,17,3,6,2,17,3,6,1,17,6,6,6,17,5,6,3,17,3,6,2,17,3,6,2,17,4,6,1,17,2,6,1,17,6,6,5,17,4,6,3,17,4,6,1,17,6,6,1,17,6,6,7,17,4,6,3,17,3,6,2,17,3,6,1,17,6,6,6,17,6,6,1
	db 17,4,6,1,17,3,6,1,17,3,6,1,17,6,6,8,17,1,6,2,17,2,6,4,17,4,6,3,17,4,6,3,17,3,6,2,17,3,6,7,17,3,6,2,17,3,6,2,17,6,6,2,17,3,6,2,17,4,6,1,17,2,6,1,17,6,6,1,17,6,6,255,17,255,17,137,17,6,6,1,17,4,6,2,17,3,6,1,17,5,6,1,17,3,6,1,17,5,6,3,17,6,6,2,17,4,6,255,17,19,17,2,6,5,17,2,6,2,17,2,6,4,17,3,6,3,17,1,6,3,17,2,6,1,17,2,6,3,17,2,6,4,17,3,6,255,17,21,17,4,6,3,17,2,6,2,17,2,6,1,17,2,6,1,17,3,6,3,17,1,6,3,17,4,6,4,17,4,6,3,17,4,6,255,17,19,17,2,6,5,17,2,6,2,17,2,6,2,17,1,6,2,17,2,6,2,17,2,6,3,17,2,6,1,17,2,6,3,17,2,6,7,17,3,6,255,17,17,17,4,6,3,17,4,6,2,17,3,6,4
	db 17,4,6,3,17,4,6,1,17,2,6,1,17,6,6,1,17,5,6,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,255,17,62,17,7,4,2,17,7,4,4,17,8,4,3,17,6,4,2,17,6,4,14,17,2,4,6,17,4,4,1,17,4,4,1,17,6,4,1,17,4,4,8,17,6,4,2,17,3,4,1,17,8,4,1,17,7,4,1,17,4,4,7,17,10,4,3,17,6,4,11,17,5,4,4,17,6,4,2,17,4,4,1,17,4,4,1,17,10,4,1,17,6,4,1,17,4,4,2,17,3,4,1,17,7,4,1,17,4,4,1,17,8,4,79,17,4,4,1,17,2,4,2,17,3,4,1,17,3,4,4,17,4,4,2,17,1,4,2,17,3,4,5,17,3,4,18,17,3,4,6,17,2,4,3,17,2,4,3,17,4,4,3,17,2,4,10,17,4,4,3,17,2,4,3,17,4,4,2,17,1,4,2,17,5,4,3,17,2,4,8,17,1,4,2,17,4,4,2,17,1
	db 4,2,17,8,4,9,17,7,4,2,17,8,4,2,17,2,4,3,17,2,4,2,17,1,4,2,17,4,4,2,17,1,4,2,17,4,4,3,17,2,4,3,17,2,4,4,17,4,4,3,17,2,4,3,17,4,4,2,17,1,4,79,17,4,4,2,17,2,4,1,17,3,4,2,17,2,4,4,17,4,4,4,17,5,4,3,17,6,4,15,17,5,4,5,17,4,4,1,17,2,4,4,17,7,4,11,17,8,4,4,17,4,4,6,17,8,4,12,17,4,4,2,17,0,2,4,17,4,4,2,17,4,4,7,17,5,4,1,17,2,4,1,17,4,4,2,17,4,4,1,17,4,4,1,17,2,4,5,17,4,4,2,17,1,4,2,17,4,4,3,17,4,4,1,17,2,4,3,17,5,4,4,17,1,4,3,17,4,4,82,17,4,4,1,17,2,4,2,17,3,4,1,17,2,4,5,17,6,4,3,17,6,4,2,17,7,4,12,17,3,4,2,17,2,4,4,17,2,4,1,17,4,4,5,17,5,4,12,17,7
	db 4,5,17,6,4,5,17,6,4,13,17,4,4,4,17,4,4,2,17,4,4,7,17,5,4,2,17,0,2,4,17,4,4,2,17,4,4,1,17,2,4,1,17,4,4,5,17,4,4,5,17,4,4,3,17,2,4,1,17,4,4,3,17,5,4,4,17,1,4,3,17,6,4,80,17,6,4,3,17,7,4,4,17,4,4,6,17,6,4,2,17,7,4,10,17,3,4,2,17,3,4,4,17,2,4,2,17,3,4,6,17,3,4,13,17,8,4,4,17,4,4,8,17,3,4,15,17,4,4,4,17,4,4,2,17,4,4,7,17,5,4,4,17,4,4,2,17,4,4,1,17,2,4,2,17,3,4,5,17,4,4,5,17,4,4,3,17,2,4,2,17,3,4,4,17,4,4,3,17,2,4,3,17,4,4,82,17,4,4,5,17,3,4,2,17,3,4,3,17,4,4,2,17,1,4,6,17,3,4,6,17,3,4,9,17,10,4,3,17,2,4,3,17,2,4,6,17,3,4,13,17,4,4,3,17,2,4,3,17,4
	db 4,2,17,1,4,5,17,3,4,15,17,4,4,5,17,8,4,9,17,7,4,2,17,8,4,2,17,2,4,3,17,2,4,5,17,4,4,5,17,4,4,3,17,2,4,3,17,2,4,5,17,4,4,1,17,2,4,4,17,4,4,2,17,1,4,78,17,6,4,3,17,5,4,3,17,2,4,1,17,8,4,1,17,7,4,2,17,7,4,9,17,6,4,2,17,4,4,1,17,4,4,1,17,4,4,3,17,7,4,10,17,6,4,2,17,3,4,1,17,8,4,3,17,7,4,11,17,8,4,4,17,6,4,11,17,5,4,4,17,6,4,2,17,4,4,1,17,4,4,2,17,8,4,2,17,6,4,1,17,4,4,1,17,4,4,5,17,5,4,4,17,8,4,255,17,255,17,255,17,255,17,255,17,255,17,111,17

	korx_1 dw 0									; Начальная левая верхняя координата рисунка по массиву на оси x
	kory_1 dw 0									; Начальная левая верхняя координата рисунка по массиву на оси x
	dlin_1 dw 320								; Длина картинки по оси x
	di_stop_1 dw ?								; Крайнее правое положение каретки
	kol_array_1 dw ?							; Количество байт в массиве картинки
	offset_array_1 dw ?							; Смещение массива картинки относительно сегмента данных
Pictures ends
End