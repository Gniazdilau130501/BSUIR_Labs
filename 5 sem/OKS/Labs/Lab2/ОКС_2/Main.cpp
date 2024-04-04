#include <iostream>
#include <string>
#include <vector>
#include <windows.h>
using namespace std;

// ������� ��� ���������� ���-���������
vector<unsigned char> bitStuffing(const vector<unsigned char>& data, unsigned char flag) {
    vector<unsigned char> stuffedData;
    int consecutiveOnes = 0;
    stuffedData.push_back(flag);

    for (const auto& byte : data) {
        if (byte == 0x01) {
            consecutiveOnes++;
            if (consecutiveOnes == 5) {
                stuffedData.push_back(0x01);
                consecutiveOnes = 0;
            }
        }
        else {
            consecutiveOnes = 0;
        }
        stuffedData.push_back(byte);
    }

    stuffedData.push_back(flag);
    return stuffedData;
}

int main() {
    setlocale(LC_ALL, "rus");
    // ����� ������ (����� ���� ����� ����� ������)
    int n = 5;
    unsigned char flag = 'z' + n; // ���� �� ��������� 'z' + n
    vector<unsigned char> dataToSend; // ������ ��� ��������

    cout << "������� ������ ��� ��������: ";
    string inputString;
    getline(cin, inputString);

    // �������������� ������ � ������ ������
    vector<unsigned char> byteData(inputString.begin(), inputString.end());

    // ����� ����������� COM-�����
    int sourceAddress = 1;

    // ���������� ������ � ������ ���-���������
    vector<unsigned char> packet = bitStuffing(byteData, flag);

    // ���������� ����� Source Address, Address � FCS (� ������ ������, �������)
    packet.insert(packet.begin(), 0x00); // FCS
    packet.insert(packet.begin(), 0x00); // Address
    packet.insert(packet.begin(), sourceAddress); // Source Address

    const wchar_t* unicodeString = L"COM1";
    HANDLE comPort = CreateFile(unicodeString, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

    if (comPort == INVALID_HANDLE_VALUE) {
        cerr << "������ ��� �������� COM-�����." << endl;
        return 1;
    }

    // ��������� ���������� COM-�����
    DCB dcbSerialParams = { 0 };
    dcbSerialParams.DCBlength = sizeof(dcbSerialParams);

    if (!GetCommState(comPort, &dcbSerialParams)) {
        cerr << "������ ��� ��������� ���������� COM-�����." << endl;
        CloseHandle(comPort);
        return 1;
    }

    dcbSerialParams.BaudRate = CBR_9600;  // �������� �������� ������
    dcbSerialParams.ByteSize = 8;         // ������ �����
    dcbSerialParams.StopBits = ONESTOPBIT; // ���� ����-���
    dcbSerialParams.Parity = NOPARITY;    // ���������� ���� ��������

    if (!SetCommState(comPort, &dcbSerialParams)) {
        cerr << "������ ��� ��������� ���������� COM-�����." << endl;
        CloseHandle(comPort);
        return 1;
    }

    // �������� ������
    DWORD bytesWritten = 0;
    if (!WriteFile(comPort, packet.data(), packet.size(), &bytesWritten, NULL)) {
        cerr << "������ ��� �������� ������ ����� COM-����." << endl;
        CloseHandle(comPort);
        return 1;
    }

    cout << "������ ������� �������� ����� COM-����." << endl;
    cout << "���������� ������: " << inputString << endl;

    // �������� COM-�����
    CloseHandle(comPort);

    return 0;
}
