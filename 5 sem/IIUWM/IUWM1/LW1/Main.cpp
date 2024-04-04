#include <iostream>
#include <windows.h>
#include <winbase.h>
#include <powrprof.h> // Для функции SetSuspendState

#pragma comment(lib, "PowrProf.lib") // Подключение библиотеки для SetSuspendState
using namespace std;
int main() {
    setlocale(LC_ALL, "rus");
    SYSTEM_POWER_STATUS status;
    int sleepTimeout = 5000; // 5 секунд
        //cout << "Для перехода в спящий режим введите 'sleep': ";
        string command;
       

       
    while (true) {
        if (GetSystemPowerStatus(&status)) {
            // Тип энергопитания
            cout << "Тип энергопитания: ";
            switch (status.ACLineStatus) {
            case 0:
                cout << "Батарея";
                break;
            case 1:
               cout << "Подключено к источнику питания";
                break;
            default:
                cout << "Неизвестно";
                break;
            }

            // Тип батареи
            cout << "\nТип батареи: ";
            switch (status.BatteryFlag) {
            case 1:
                cout << "Батарея отсутствует";
                break;
            case 2:
               cout << "Батарея в нормальном состоянии";
                break;
            case 4:
               cout << "Заряжается";
                break;
            case 8:
               cout << "Критический уровень заряда";
                break;
            default:
                cout << "Неизвестно";
                break;
            }

            // Уровень заряда батареи
            cout << "\nУровень заряда батареи: " << static_cast<int>(status.BatteryLifePercent) << "%";

            // Текущий режим энергосбережения
           cout << "\nТекущий режим энергосбережения: ";
            switch (status.SystemStatusFlag) {
            case 1:
               cout << "Активен режим пониженного энергопотребления";
                break;
            case 2:
                cout << "Неизвестно";
                break;
            default:
                cout << "Энергосбережение отключено";
                break;
            }

            // Время работы аккумулятора без подключения к зарядке
            cout << "\nВремя работы аккумулятора без подключения к зарядке: " << status.BatteryLifeTime / 3600 << " часов " << (status.BatteryLifeTime % 3600) / 60 << " минут";

            // Оставшееся время работы аккумулятора после отключения зарядного устройства
            cout << "\nОставшееся время работы аккумулятора после отключения зарядного устройства: " << status.BatteryFullLifeTime / 3600 << " часов " << (status.BatteryFullLifeTime % 3600) / 60 << " минут";

            cout << std::endl;
        }
        else {
            cerr << "Ошибка при получении информации об энергопитании." << std::endl;
        }
        if (command == "sleep") {
            std::cout << "Переход в спящий режим..." << std::endl;
            SetSuspendState(FALSE, FALSE, FALSE);
        }
        cout << "Для перехода в спящий режим введите 'sleep'чтобы пропустить - любую клавишу : ";
        cin >> command;
        Sleep(sleepTimeout); // Задержка перед следующим опросом (5 секунд)
        system("cls");
    }

    return 0;
}