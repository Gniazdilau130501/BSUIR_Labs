#include <Windows.h> 
#include <iostream> 
#include <setupapi.h> 
#include <devguid.h> 
#include <locale.h> 

#pragma comment(lib, "setupapi.lib") 

int main() {
    setlocale(LC_ALL, "RUS");

    // Получение информации о физических дисках 
    HDEVINFO deviceInfoSet = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0, DIGCF_DEVICEINTERFACE | DIGCF_PRESENT);
    if (deviceInfoSet == INVALID_HANDLE_VALUE) {
        std::cerr << "Ошибка при получении информации об устройствах." << std::endl;
        return 1;
    }

    SP_DEVICE_INTERFACE_DATA deviceInterfaceData = { 0 };
    deviceInterfaceData.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);

    for (DWORD index = 0; SetupDiEnumDeviceInterfaces(deviceInfoSet, 0, &GUID_DEVINTERFACE_DISK, index, &deviceInterfaceData); ++index) {
        DWORD requiredSize = 0;
        SetupDiGetDeviceInterfaceDetail(deviceInfoSet, &deviceInterfaceData, NULL, 0, &requiredSize, NULL);
        if (requiredSize == 0) {
            std::cerr << "Ошибка при получении информации о размере буфера." << std::endl;
            return 1;
        }

        SP_DEVICE_INTERFACE_DETAIL_DATA* deviceInterfaceDetailData = (SP_DEVICE_INTERFACE_DETAIL_DATA*)malloc(requiredSize);
        deviceInterfaceDetailData->cbSize = sizeof(SP_DEVICE_INTERFACE_DETAIL_DATA);

        if (SetupDiGetDeviceInterfaceDetail(deviceInfoSet, &deviceInterfaceData, deviceInterfaceDetailData, requiredSize, NULL, NULL)) {
            HANDLE hDevice = CreateFile(deviceInterfaceDetailData->DevicePath, GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);

            if (hDevice != INVALID_HANDLE_VALUE) {
                STORAGE_PROPERTY_QUERY query = { 0 };
                query.PropertyId = StorageDeviceProperty;
                query.QueryType = PropertyStandardQuery;

                STORAGE_DESCRIPTOR_HEADER header = { 0 };
                DWORD bytesReturned = 0;

                if (DeviceIoControl(hDevice, IOCTL_STORAGE_QUERY_PROPERTY, &query, sizeof(query), &header, sizeof(header), &bytesReturned, NULL)) {
                    const DWORD dataSize = header.Size;
                    BYTE* buffer = new BYTE[dataSize];

                    if (DeviceIoControl(hDevice, IOCTL_STORAGE_QUERY_PROPERTY, &query, sizeof(query), buffer, dataSize, &bytesReturned, NULL)) {
                        STORAGE_DEVICE_DESCRIPTOR* deviceDescriptor = (STORAGE_DEVICE_DESCRIPTOR*)buffer;

                        std::cout << "------------------------------------" << std::endl;
                        std::cout << "Диск " << deviceInterfaceDetailData->DevicePath << ":" << std::endl;
                        std::cout << "Изготовитель: ";
                        switch (deviceDescriptor->BusType) {
                        case BusTypeSata: std::cout << "SATA"; break;
                        case BusTypeNvme: std::cout << "NVMe"; break;
                        default: std::cout << "Неизвестный";
                        }
                        std::cout << std::endl;

                        if (deviceDescriptor->ProductIdOffset > 0) {
                            std::cout << "Модель: " << (char*)(buffer + deviceDescriptor->ProductIdOffset) << std::endl;
                        }

                        if (deviceDescriptor->VendorIdOffset > 0) {
                            std::cout << "Тип интерфейса: " << (char*)(buffer + deviceDescriptor->VendorIdOffset) << std::endl;
                        }
                        else {
                            std::cout << "Тип интерфейса: Неизвестен" << std::endl;
                        }

                        if (deviceDescriptor->SerialNumberOffset > 0) {
                            std::cout << "Серийный номер: " << (char*)(buffer + deviceDescriptor->SerialNumberOffset) << std::endl;
                        }

                        // Получение информации о памяти 
                        DISK_GEOMETRY diskGeometry;
                        ZeroMemory(&diskGeometry, sizeof(diskGeometry));

                        if (DeviceIoControl(hDevice, IOCTL_DISK_GET_DRIVE_GEOMETRY, NULL, 0, &diskGeometry, sizeof(diskGeometry), &bytesReturned, NULL)) {
                            ULONGLONG totalBytes = diskGeometry.Cylinders.QuadPart * diskGeometry.TracksPerCylinder * diskGeometry.SectorsPerTrack * diskGeometry.BytesPerSector;
                            std::cout << "Объем диска: " << totalBytes << " байт" << std::endl;
                            std::cout << "------------------------------------" << std::endl;
                        }
                    }
                    free(buffer);
                }

                CloseHandle(hDevice);
            }
        }
        free(deviceInterfaceDetailData);
    }

    SetupDiDestroyDeviceInfoList(deviceInfoSet);
    return 0;
}