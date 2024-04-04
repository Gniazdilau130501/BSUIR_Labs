#include <iostream>
#include <string>
#include <vector>
#include <windows.h>
using namespace std;

// Функция для выполнения бит-стаффинга
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
    // Номер группы (может быть любым целым числом)
    int n = 5;
    unsigned char flag = 'z' + n; // Флаг со значением 'z' + n
    vector<unsigned char> dataToSend; // Данные для передачи

    cout << "Введите строку для передачи: ";
    string inputString;
    getline(cin, inputString);

    // Преобразование строки в вектор байтов
    vector<unsigned char> byteData(inputString.begin(), inputString.end());

    // Номер передающего COM-порта
    int sourceAddress = 1;

    // Подготовка данных с учетом бит-стаффинга
    vector<unsigned char> packet = bitStuffing(byteData, flag);

    // Добавление полей Source Address, Address и FCS (в данном случае, нулевых)
    packet.insert(packet.begin(), 0x00); // FCS
    packet.insert(packet.begin(), 0x00); // Address
    packet.insert(packet.begin(), sourceAddress); // Source Address

    const wchar_t* unicodeString = L"COM1";
    HANDLE comPort = CreateFile(unicodeString, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

    if (comPort == INVALID_HANDLE_VALUE) {
        cerr << "Ошибка при открытии COM-порта." << endl;
        return 1;
    }

    // Настройка параметров COM-порта
    DCB dcbSerialParams = { 0 };
    dcbSerialParams.DCBlength = sizeof(dcbSerialParams);

    if (!GetCommState(comPort, &dcbSerialParams)) {
        cerr << "Ошибка при получении параметров COM-порта." << endl;
        CloseHandle(comPort);
        return 1;
    }

    dcbSerialParams.BaudRate = CBR_9600;  // Скорость передачи данных
    dcbSerialParams.ByteSize = 8;         // Размер байта
    dcbSerialParams.StopBits = ONESTOPBIT; // Один стоп-бит
    dcbSerialParams.Parity = NOPARITY;    // Отсутствие бита паритета

    if (!SetCommState(comPort, &dcbSerialParams)) {
        cerr << "Ошибка при установке параметров COM-порта." << endl;
        CloseHandle(comPort);
        return 1;
    }

    // Передача данных
    DWORD bytesWritten = 0;
    if (!WriteFile(comPort, packet.data(), packet.size(), &bytesWritten, NULL)) {
        cerr << "Ошибка при передаче данных через COM-порт." << endl;
        CloseHandle(comPort);
        return 1;
    }

    cout << "Данные успешно переданы через COM-порт." << endl;
    cout << "Переданная строка: " << inputString << endl;

    // Закрытие COM-порта
    CloseHandle(comPort);

    return 0;
}
