#include "WEB.h"

WEB::WEB()
{
	DeviceDisckriptor = SetupDiGetClassDevsW(NULL, TEXT("USB"), NULL, DIGCF_PRESENT | DIGCF_ALLCLASSES);
	DeviceInformation.cbSize = sizeof(SP_DEVINFO_DATA);
	SetupDiEnumDeviceInfo(DeviceDisckriptor, 4, &DeviceInformation);
}

WEB::~WEB()
{
	SetupDiDestroyDeviceInfoList(DeviceDisckriptor);
}

void WEB::GetData()
{
	TCHAR buffer[1024];
	SetupDiGetDeviceRegistryPropertyW(DeviceDisckriptor, &DeviceInformation, SPDRP_FRIENDLYNAME, NULL, (BYTE*)buffer, 1024, NULL);
	cout << "Имя: "; wcout << buffer << endl;
	SetupDiGetDeviceRegistryPropertyW(DeviceDisckriptor, &DeviceInformation, SPDRP_HARDWAREID, NULL, (BYTE*)buffer, 1024, NULL);
	cout << "VID: "; wcout << wstring{ buffer }.substr(wstring{ buffer }.find(L"VID_") + 4, 4) << endl;
	cout << "PID: "; wcout << wstring{ buffer }.substr(wstring{ buffer }.find(L"PID_") + 4, 4) << endl;
}

void WEB::TakeVideo()
{
	CoInitializeEx(NULL, COINIT_APARTMENTTHREADED);

	ICaptureGraphBuilder2* builder = nullptr;
	IGraphBuilder* graph = nullptr;

	CoCreateInstance(CLSID_CaptureGraphBuilder2, NULL, CLSCTX_INPROC_SERVER, IID_ICaptureGraphBuilder2, reinterpret_cast<void**>(&builder));

	CoCreateInstance(CLSID_FilterGraph, 0, CLSCTX_INPROC_SERVER, IID_IGraphBuilder, reinterpret_cast<void**>(&graph));

	builder->SetFiltergraph(graph);

	ICreateDevEnum* dev_enum = nullptr;

	CoCreateInstance(CLSID_SystemDeviceEnum, NULL, CLSCTX_INPROC_SERVER, IID_PPV_ARGS(&dev_enum));

	IEnumMoniker* enum_moniker;

	dev_enum->CreateClassEnumerator(CLSID_VideoInputDeviceCategory, &enum_moniker, 0);
	dev_enum->Release();

	IMoniker* moniker = nullptr;
	IBaseFilter* filter = nullptr;

	enum_moniker->Next(1, &moniker, NULL);
	moniker->BindToObject(0, 0, IID_IBaseFilter, reinterpret_cast<void**>(&filter));
	graph->AddFilter(filter, L"Capture Filter");

	string name_file = "video.avi";

	CreateFileA(name_file.c_str(), GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);

	IBaseFilter* mux = nullptr;
	wstring w_name_file(name_file.begin(), name_file.end());
	builder->SetOutputFileName(&MEDIASUBTYPE_Avi, w_name_file.c_str(), &mux, NULL);
	builder->RenderStream(&PIN_CATEGORY_CAPTURE, &MEDIATYPE_Video, filter, NULL, mux);
	mux->Release();
	IMediaControl* control = nullptr;
	graph->QueryInterface(IID_IMediaControl, reinterpret_cast<void**>(&control));

	system("cls");

	int lenght = 0;
	cout << "Продолжительность видео: ";
	cin >> lenght;

	system("cls");

	control->Run();
	cout << "Идет запись видео... ";
	Sleep(lenght * 1000);
	control->Stop();
	control->Release();
}