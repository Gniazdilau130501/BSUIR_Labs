#include <Windows.h>     
#include <Setupapi.h>    //��� ������ � ������������ � ����������. 
#include <iostream>       
using namespace std;

class PCI
{
private:
    HDEVINFO DeviceDescriptor;  // ���������� ��� �������� ���������� �� �����������. 
    SP_DEVINFO_DATA DeviceInformation;  // ��������� ��� �������� ���������� �� ����������. 

public:
    PCI();
    ~PCI();
    void GetData();  // ����� ��� ��������� ������ �� ����������. 
    bool Bind(DWORD index);  // ����� ��� �������� � ���������� �� �������. 
};

PCI::PCI()
{
    // ������������� ����������� ���������� ��� ��������� ������ "PCI". 
    DeviceDescriptor = SetupDiGetClassDevs(NULL, L"PCI", NULL, DIGCF_PRESENT | DIGCF_ALLCLASSES);

    // ������������� ��������� ��� �������� ���������� �� ����������. 
    DeviceInformation.cbSize = sizeof(SP_DEVINFO_DATA);
}

PCI::~PCI()
{
    // ������������ ��������, ��������� � ������������ ����������. 
    SetupDiDestroyDeviceInfoList(DeviceDescriptor);
}

bool PCI::Bind(DWORD index)
{
    // �������� � ���������� �� ������� � ��������� ���������� �� ����������. 
    return SetupDiEnumDeviceInfo(DeviceDescriptor, index, &DeviceInformation);
}

void PCI::GetData()
{
    TCHAR buffer[1024];  // ����� ��� �������� ������. 

    DWORD bufferSize = sizeof(buffer) / sizeof(buffer[0]);  // ���������� ������� ������. 

    // ��������� �������� ���������� � ����� ��� � �������. 
    if (SetupDiGetDeviceRegistryProperty(DeviceDescriptor, &DeviceInformation, SPDRP_DEVICEDESC, NULL, (PBYTE)buffer, bufferSize, NULL))
    {
        wcout << L"��������: " << buffer << endl;
    }

    // ��������� ����������� �������������� ���������� � ����� ��� � �������. 
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
    setlocale(LC_ALL, "Russian");  // ��������� ������ ��� ������ ������ �� ������� �����. 

    PCI devices;  // �������� ������� ������ PCI ��� ������ � ������������. 
    DWORD i = 0;  // ������ ����������. 

    // ������� ��������� � ����� ���������� � ������ �� ���. 
    while (devices.Bind(i++))
    {
        cout << "���������� �" << i << ":" << endl;
        devices.GetData();
    }

    return 0;
}