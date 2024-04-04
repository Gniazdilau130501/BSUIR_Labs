#include "libraries.h"

class WEB
{
private:
	HDEVINFO DeviceDisckriptor;
	SP_DEVINFO_DATA DeviceInformation;
public:
	WEB();
	~WEB();
	void GetData();
	void TakeVideo();
};
