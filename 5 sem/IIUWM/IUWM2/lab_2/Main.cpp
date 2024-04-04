#include <Windows.h>     
#include <Setupapi.h>    //для работы с устройствами и драйверами. 
#include <iostream>       
using namespace std;

class PCI
{
private:
    HDEVINFO DeviceDescriptor;  // Дескриптор для хранения информации об устройствах. 
    SP_DEVINFO_DATA DeviceInformation;  // Структура для хранения информации об устройстве. 

public:
    PCI();
    ~PCI();
    void GetData();  // Метод для получения данных об устройстве. 
    bool Bind(DWORD index);  // Метод для привязки к устройству по индексу. 
};

PCI::PCI()
{
    // Инициализация дескриптора устройства для устройств класса "PCI". 
    DeviceDescriptor = SetupDiGetClassDevs(NULL, L"PCI", NULL, DIGCF_PRESENT | DIGCF_ALLCLASSES);

    // Инициализация структуры для хранения информации об устройстве. 
    DeviceInformation.cbSize = sizeof(SP_DEVINFO_DATA);
}

PCI::~PCI()
{
    // Освобождение ресурсов, связанных с дескриптором устройства. 
    SetupDiDestroyDeviceInfoList(DeviceDescriptor);
}

bool PCI::Bind(DWORD index)
{
    // Привязка к устройству по индексу и получение информации об устройстве. 
    return SetupDiEnumDeviceInfo(DeviceDescriptor, index, &DeviceInformation);
}

void PCI::GetData()
{
    TCHAR buffer[1024];  // Буфер для хранения данных. 

    DWORD bufferSize = sizeof(buffer) / sizeof(buffer[0]);  // Вычисление размера буфера. 

    // Получение названия устройства и вывод его в консоль. 
    if (SetupDiGetDeviceRegistryProperty(DeviceDescriptor, &DeviceInformation, SPDRP_DEVICEDESC, NULL, (PBYTE)buffer, bufferSize, NULL))
    {
        wcout << L"Название: " << buffer << endl;
    }

    // Получение аппаратного идентификатора устройства и вывод его в консоль. 
    if (SetupDiGetDeviceRegistryProperty(DeviceDescriptor, &DeviceInformation, SPDRP_HARDWAREID, NULL, (PBYTE)buffer, bufferSize, NULL))
    {
        wstring hardwareId(buffer);

        size_t vendorPos = hardwareId.find(L"VEN_");
        size_t devicePos = hardwareId.find(L"DEV_");

        if (vendorPos != wstring::npos && devicePos != wstring::npos)
        {
            wstring vendorId = hardwareId.substr(vendorPos + 4, 4);
            wstring deviceId = hardwareId.substr(devicePos + 4, 4);

            wcout << L"VendorID: " << vendorId << endl;
            wcout << L"DeviceID: " << deviceId << endl;
        }
    }

    cout << "----------------------------------------------------------" << endl;
}

int main()
{
    setlocale(LC_ALL, "Russian");  // Установка локали для вывода текста на русском языке. 

    PCI devices;  // Создание объекта класса PCI для работы с устройствами. 
    DWORD i = 0;  // Индекс устройства. 

    // Перебор устройств и вывод информации о каждом из них. 
    while (devices.Bind(i++))
    {
        cout << "Устройство №" << i << ":" << endl;
        devices.GetData();
    }

    return 0;
}