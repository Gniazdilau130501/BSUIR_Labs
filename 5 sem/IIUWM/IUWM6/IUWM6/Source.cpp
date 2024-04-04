#include <iostream>
#include <locale>
#include <iomanip>
#include <WinSock2.h>
#include <ws2bth.h>
#include <windows.h>
#include <BluetoothAPIs.h>
#include <vector>
#include <commdlg.h>                     //��� �������� ���� ���������� � ������ �����!
#include <fstream>
#include <WS2tcpip.h>
//��� ������ � �����
#include <MMDeviceAPI.h>
#include <AudioClient.h>



#pragma comment(lib, "ws2_32.lib")        //��� �������������� ������� �������
#pragma comment(lib, "Bthprops.lib")

BLUETOOTH_FIND_RADIO_PARAMS m_bt_find_radio = { sizeof(BLUETOOTH_FIND_RADIO_PARAMS) };
BLUETOOTH_RADIO_INFO m_bt_info = { sizeof(BLUETOOTH_RADIO_INFO), 0, };
BLUETOOTH_DEVICE_SEARCH_PARAMS m_search_params = {
  sizeof(BLUETOOTH_DEVICE_SEARCH_PARAMS),
  1,
  0,
  1,
  1,
  1,
    15,
  NULL
};
BLUETOOTH_DEVICE_INFO m_device_info{ sizeof(BLUETOOTH_DEVICE_INFO), 0, };

//�������:
//RADIO - ��������� ������������� Bluetooth ������
//Device - ���������� ������������ � bluetooth
//��������� � BLUETOOTH_DEVICE_SEARCH_PARAMS ��� ������ �������� �� �����-�� ��������� 

using namespace std;

vector <BLUETOOTH_DEVICE_INFO> test_device_list;

BOOL CALLBACK bluetoothAuthCallback(LPVOID param, PBLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS params)
{
    cout << "������� ����������� ��������� ������ ������� �������!" << endl;
    return TRUE;
}

int main() {
    setlocale(LC_ALL, "rus");

    cout << "������ � ����������� Bluetooth!" << endl;
    HANDLE m_radio = NULL;                                  //���������� ����������, ������� ������ ����������� �� ����������
    HBLUETOOTH_RADIO_FIND m_bt = NULL;
    HBLUETOOTH_DEVICE_FIND m_bt_dev = NULL;
    int m_radio_id;
    int m_device_id;
    DWORD mbtinfo_ret;
    while (true) {
        m_bt = BluetoothFindFirstRadio(&m_bt_find_radio, &m_radio);    //��������� ����������� �������������� bluetooth 
        if (m_bt != NULL) {
            cout << "������� ������ ��������� ��������������� Bluetooth �� ����������!" << endl;
        }
        else cerr << "���������� �� �������!" << endl;
        m_radio_id = 0;
        do {        //������ Do
            mbtinfo_ret = BluetoothGetRadioInfo(m_radio, &m_bt_info);
            if (mbtinfo_ret == ERROR_SUCCESS) {
                cout << "��������� ���������� � ������������ �������!" << endl;
            }
            else cerr << "� ��������� ���������� �������� ������ � �����: " << mbtinfo_ret << endl;
            //����� �������� � ������
            cout << "Radio: " << m_radio_id << endl;
            wcout << L"Instance Name: " << m_bt_info.szName << endl;
            wcout << L"Address: " << hex << uppercase << setfill(L'0') << setw(2) << static_cast<int>(m_bt_info.address.rgBytes[5])
                << L":" << setw(2) << static_cast<int>(m_bt_info.address.rgBytes[4]) << L":" << setw(2) << static_cast<int>(m_bt_info.address.rgBytes[3])
                << L":" << setw(2) << static_cast<int>(m_bt_info.address.rgBytes[2]) << L":" << setw(2) << static_cast<int>(m_bt_info.address.rgBytes[1])
                << L":" << setw(2) << static_cast<int>(m_bt_info.address.rgBytes[0]) << setfill(L' ') << endl;
            wcout << L"Class: " << hex << m_bt_info.ulClassofDevice << endl;
            wcout << L"Manufacture: " << hex << m_bt_info.manufacturer << endl;
            m_search_params.hRadio = m_radio;
            ZeroMemory(&m_device_info, sizeof(BLUETOOTH_DEVICE_INFO));
            m_device_info.dwSize = sizeof(BLUETOOTH_DEVICE_INFO);
            m_bt_dev = BluetoothFindFirstDevice(&m_search_params, &m_device_info);
            if (m_bt_dev != NULL) {
                cout << "������ ���������� ������� ����������!" << endl;
            }
            else cerr << "������ ������ ������� ����������: " << GetLastError() << endl;
            m_radio_id++;
            m_device_id = 0;
            //��������� ���������� �� ���������!
            do {            //����� Do
                cout << "==============================================" << endl;
                wcout << L"Device: " << m_device_id << endl;
                wcout << L"Instance name: " << m_device_info.szName << endl;
                wcout << "Address: " << hex << uppercase << setw(2) << m_device_info.Address.rgBytes[5]
                    << L":" << m_device_info.Address.rgBytes[4] << L":" << setw(2) << m_device_info.Address.rgBytes[3]
                    << L":" << setw(2) << m_device_info.Address.rgBytes[2] << L":" << m_device_info.Address.rgBytes[1]
                    << L":" << setw(2) << m_device_info.Address.rgBytes[0] << endl;
                wcout << L"Class: " << m_device_info.ulClassofDevice << endl;
                wcout << L"Connected: " << (m_device_info.fConnected ? L"True" : L"False") << endl;
                wcout << L"Autentificated: " << (m_device_info.fAuthenticated ? L"True" : L"Flase") << endl;
                wcout << L"Remembered: " << (m_device_info.fRemembered ? L"True" : L"False") << endl;
                cout << "==============================================" << endl;
                m_device_id++;
                test_device_list.push_back(m_device_info);
                //����� ��������� ��������� ����������, ����� ������������� ��� ��������� ������������� �������!

                if (!BluetoothFindNextDevice(m_bt_dev, &m_device_info)) break;
            } while (BluetoothFindNextDevice(m_bt_dev, &m_device_info)); //������ Do
            cout << "�������� ���������� ��� �����������: ";
            int choise;
            cin >> choise;

            BLUETOOTH_DEVICE_INFO device_connection = test_device_list.at(choise);

            cout << "������� ����� ��� ������ ����� >>>" << endl;
            system("pause");

            BLUETOOTH_AUTHENTICATE_RESPONSE response;
            cout << "�����������..." << endl;
            if (BluetoothAuthenticateDeviceEx(NULL, m_radio, &device_connection, NULL, MITMProtectionRequired) == ERROR_SUCCESS) {
                cout << "���������� ����������� �������!" << endl;
            }
            else cerr << "���������� �� �����������!" << endl;

            //�������� �������, ��� �������� ������
            WSADATA wsdata;
            int erStat = WSAStartup(MAKEWORD(2, 2), &wsdata);
            if (erStat != 0) {
                cerr << "������ ������������� ���������� �������!" << endl;
                cerr << "��������� ������: " << WSAGetLastError() << endl;
            }
            else {
                cout << "����������� ������� �������������������!" << endl;
            }
            int sock = socket(AF_BTH, SOCK_STREAM, BTHPROTO_RFCOMM);
            if (sock < 0) {
                cerr << "������ �������� ������ ��� �����������!" << endl;
                cout << "=======================================" << endl;
            }
            else cout << "����� ������� ������!" << endl;
            SOCKADDR_BTH addr = { 0 };
            addr.addressFamily = AF_BTH;
            addr.btAddr = device_connection.Address.ullLong;
            addr.serviceClassId = /*RFCOMM_PROTOCOL_UUID*/ SerialPortServiceClass_UUID /*L2CAP_PROTOCOL_UUID*/;
            addr.port = BT_PORT_ANY;
            //����������� ������ � �������� �������!
            int result = connect(sock, (SOCKADDR*)&addr, sizeof(SOCKADDR_BTH));


            //�������� �����-���������� �� ���������




            cout << "������� ����������� � ����������..." << endl;
            if (result < 0) {
                cerr << "������ ���������� � ����������� ����� �����!" << endl;
            }
            else {
                system("cls");
                cout << "���������� ������� ���������� ����� ������!" << endl;
                cout << "������� ����� ��� �������� ������ �� ����������" << endl;
                system("pause");
                ifstream file("D:\�����_����������\�����\IUWM6\music.mp3", ios::binary | ios::ate);
                if (!file.is_open()) {
                    cerr << "������ �������� �����!" << endl;
                }
                else cout << "���� ������� ������!" << endl;
                streamsize size = file.tellg();
                file.seekg(0, ios::beg);
                vector<char> buffer_music_information(size);
                if (!file.read(buffer_music_information.data(), size)) {
                    cerr << "������ ������ ���������� � �����!" << endl;
                    closesocket(sock);
                }
                else {
                    cout << "���������� ������� ���������!" << endl;
                    if (send(sock, buffer_music_information.data(), buffer_music_information.size(), 0) == ERROR_SUCCESS) {
                        cerr << "������ �������� ������ ������! ������ ��� �������: " << WSAGetLastError() << endl;

                    }
                    else {
                        cout << "������ ������� ����������!" << endl;
                    }
                }
                Sleep(20000);
                closesocket(sock);
                file.close();
            }
            if (BluetoothFindDeviceClose(m_bt_dev) == TRUE) cout << "�������� �������� ����������!" << endl;
            else cerr << "�������� ���������� - ����������� ��� ����������, ������!" << endl;

        } while (BluetoothFindNextRadio(&m_bt_find_radio, &m_radio));      //������ Do
        if (BluetoothFindRadioClose(m_bt) == TRUE) {
            cout << "�������� �������� ����������� ���������� �����-���������!" << endl;
        }
        else cerr << "������ �������� ����������� !" << endl;
        if (!BluetoothFindNextRadio(&m_bt_find_radio, &m_radio)) break;
        Sleep(1000);
    }
    cout << "��������� ������� ������ ��� ��������� ���������� Bluetooth!" << endl;
    return 0;
}