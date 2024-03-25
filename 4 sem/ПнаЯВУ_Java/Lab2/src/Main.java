public class Main {
    public static void main(String[] args)
    {
        User a = new User();
        Computer acer = new Computer();
        Scanint num = new Scanint();
        Scanstr str = new Scanstr();
        while(true) {
            System.out.println("Меню:\n1)Программы\n2)Скачать файл\n3)Использовать\n4)Выход\n");
            switch (num.scanInt()) {
                case 1:
                    System.out.println("1)Добавить программу\n2)Удалить программу\n3)Просмотреть\n");
                    switch(num.scanInt())
                    {
                        case 1:
                            acer.see();
                            System.out.println("1)Браузер или 2)Плеер ");
                            int y = num.scanInt();
                            if (y==1) {
                                System.out.println("Введите Автора; Название; Путь файла; Дата создания");
                                acer.addApp(y, str.scanStr(), str.scanStr(), str.scanStr(), str.scanStr(),"-");
                            }
                            else if(y==2)
                            {
                                System.out.println("Введите Автора; Название; Путь файла; Дата создания;Поддерживаемый формат");
                                acer.addApp(y, str.scanStr(), str.scanStr(), str.scanStr(), str.scanStr(),str.scanStr());
                            }
                            else{
                                System.out.println("Введено невозможное число");
                            }
                        System.out.println("Добавлен!\n");
                        break;
                        case 2:
                            int i, t;
                            boolean flag = false;
                            while(flag == false) {
                                acer.see();
                                System.out.println("1)Браузер\n2)Плеер\n");
                                i = num.scanInt();
                                System.out.println("Какой желаете удалить?");
                                t = num.scanInt();
                                if (acer.delApp(i, t) == 0) {
                                    System.out.println("Ошибка:Вы ввели не верное число или коллекция пуста");
                                }else{
                                    flag = true;
                                }
                            }
                        break;
                        case 3: acer.see();
                        break;
                        default:System.out.println("Ошибка, введите число из предложенных!");
                    }
                    break;
                case 2:
                    acer.see();
                    System.out.println("Выберете браузер\n-введите путь загрузки; дату создания; длину видео; формат файла");
                   if( acer.download(num.scanInt(), str.scanStr(), str.scanStr(), num.scanInt(), str.scanStr())==0)
                   {
                       System.out.println("Ошибка:Коллекция пуста");
                   }
                    break;
                case 3:
                    acer.see();
                        System.out.println("Выберете плеер и видео");
                        if (acer.use(num.scanInt(), num.scanInt()) == 0) {
                            System.out.println("Ошибка:Одна из коллекций пуста или несовместимость форматов");
                        }

                    break;
                case 4:
                    System.exit(0);
                    break;
                default:
                    System.out.println("Ошибка, введите число из предложенных!");
            }
        }
    }
}