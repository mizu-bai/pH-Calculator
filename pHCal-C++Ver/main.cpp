#include "ComplieConfigure.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#ifdef SYSTEM_WINDOWS
	#include <Windows.h>
	#define WINDOW_W 800
	#define WINDOW_H 450
	#ifdef GUI_EASYX
		#include <conio.h>
		#include <graphics.h>
	#endif // GUI_EASYX
#endif // SYSTEM_WINDOWS

#ifdef SYSTEM_WINDOWS
	int WindowMain()
	{
		cleardevice();
		//每次调用窗口都需要初始化
		TCHAR WindosMainSlogan[] = { TEXT("好了那开始计算吧（挠头）") };
		outtextxy(100, 200, WindosMainSlogan);
		return 0;
	}
#endif // SYSTEM_WINDOWS


int main(int argc,char *argv[])
{
	printf("Hello World!");
	//接下来根据不同的系统进入不同的入口

	#ifdef SYSETM_MACOS
		printf("去用Mizu大佬的版本吧555宝宝不会");
		return 0；
	#endif // SYSETM_MACOS

	#ifdef SYSETM_IOS
		printf("去用Mizu大佬的版本吧555宝宝不会");
		return 0；
    #endif // SYSETM_IOS

	#ifdef SYSETM_ANDROID
		printf("宝宝懒，而且你估计也没法编译");
		return 0；
	#endif // SYSETM_IOS

	#ifdef SYSETM_LINUX
		printf("那就只有TUI了，是最简单的计算器");
		return 0；
	#endif // SYSETM_IOS

	#ifdef SYSTEM_WINDOWS
		#ifdef GUI_EASYX
			initgraph(WINDOW_W, WINDOW_H, SHOWCONSOLE);
			cleardevice();
			TCHAR Slogan[] = { TEXT("溶液计算程序") };
			outtextxy(0, 0, Slogan);
			WindowMain();
			system("PAUSE");
		#endif // GUI_EASYX
		//

	    return 0;
	#endif // SYSTEM_WINDOWS
}
