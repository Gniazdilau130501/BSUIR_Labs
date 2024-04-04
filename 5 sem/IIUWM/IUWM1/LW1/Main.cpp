#include <iostream>
#include <windows.h>
#include <winbase.h>
#include <powrprof.h> // ��� ������� SetSuspendState

#pragma comment(lib, "PowrProf.lib") // ����������� ���������� ��� SetSuspendState
using namespace std;
int main() {
    setlocale(LC_ALL, "rus");
    SYSTEM_POWER_STATUS status;
    int sleepTimeout = 5000; // 5 ������
        //cout << "��� �������� � ������ ����� ������� 'sleep': ";
        string command;
       

       
    while (true) {
        if (GetSystemPowerStatus(&status)) {
            // ��� �������������
            cout << "��� �������������: ";
            switch (status.ACLineStatus) {
            case 0:
                cout << "�������";
                break;
            case 1:
               cout << "���������� � ��������� �������";
                break;
            default:
                cout << "����������";
                break;
            }

            // ��� �������
            cout << "\n��� �������: ";
            switch (status.BatteryFlag) {
            case 1:
                cout << "������� �����������";
                break;
            case 2:
               cout << "������� � ���������� ���������";
                break;
            case 4:
               cout << "����������";
                break;
            case 8:
               cout << "����������� ������� ������";
                break;
            default:
                cout << "����������";
                break;
            }

            // ������� ������ �������
            cout << "\n������� ������ �������: " << static_cast<int>(status.BatteryLifePercent) << "%";

            // ������� ����� ����������������
           cout << "\n������� ����� ����������������: ";
            switch (status.SystemStatusFlag) {
            case 1:
               cout << "������� ����� ����������� �����������������";
                break;
            case 2:
                cout << "����������";
                break;
            default:
                cout << "���������������� ���������";
                break;
            }

            // ����� ������ ������������ ��� ����������� � �������
            cout << "\n����� ������ ������������ ��� ����������� � �������: " << status.BatteryLifeTime / 3600 << " ����� " << (status.BatteryLifeTime % 3600) / 60 << " �����";

            // ���������� ����� ������ ������������ ����� ���������� ��������� ����������
            cout << "\n���������� ����� ������ ������������ ����� ���������� ��������� ����������: " << status.BatteryFullLifeTime / 3600 << " ����� " << (status.BatteryFullLifeTime % 3600) / 60 << " �����";

            cout << std::endl;
        }
        else {
            cerr << "������ ��� ��������� ���������� �� �������������." << std::endl;
        }
        if (command == "sleep") {
            std::cout << "������� � ������ �����..." << std::endl;
            SetSuspendState(FALSE, FALSE, FALSE);
        }
        cout << "��� �������� � ������ ����� ������� 'sleep'����� ���������� - ����� ������� : ";
        cin >> command;
        Sleep(sleepTimeout); // �������� ����� ��������� ������� (5 ������)
        system("cls");
    }

    return 0;
}