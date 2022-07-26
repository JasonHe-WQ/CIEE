#include "led.h"
#include "delay.h"
#include "key.h"
#include "sys.h"
#include "usart.h"	 
#include "dht11.h" 	 
#include "oled.h"
 
 

 
 int main(void)
 {	 
	u8 t=0;			    
	u8 temperature;  	    
	u8 humidity;    	   

	delay_init();	    	 //延时函数初始化	  
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);//设置中断优先级分组为组2：2位抢占优先级，2位响应优先级
	uart_init(115200);	 	//串口初始化为115200
	LED_Init();		  		//初始化与LED连接的硬件接口
	OLED_Init();			   	//初始化OLED 
	OLED_Clear();
	OLED_Refresh();
	OLED_ColorTurn(0);//0正常显示，1 反色显示
    OLED_DisplayTurn(0);//0正常显示 1 屏幕翻转显示
 	
			  
 	while(DHT11_Init())	//DHT11初始化	
	{
		OLED_ShowString(0,0,"DHT11 Error",16,1);
		OLED_Refresh();
		//delay_ms(200);
		GPIO_SetBits(GPIOA,GPIO_Pin_5);
		delay_ms(300);
		GPIO_ResetBits(GPIOA,GPIO_Pin_5);
		delay_ms(200);
		
		
	}		
	
	
	
	while(1)
	{	 
	    
	
		
 		if(t%10==0)			//每100ms读取一次
		{			
			OLED_ShowString(0,0,"DHT11 OK",16,1);
			OLED_Refresh();
			DHT11_Read_Data(&temperature,&humidity);	//读取温湿度值	
			printf("\r\ntemp=%d\r\nhumi=%d",temperature,humidity);
//          OLED_ShowString();		
//			LCD_ShowNum(30+40,150,temperature,2,16);	//显示温度	
//			OLED_ShowString();
//			LCD_ShowNum(30+40,170,humidity,2,16);		//显示湿度	 	   
		}				   
	 	delay_ms(10);
		t++;
		if(t==20)
		{
			t=0;
			LED0=!LED0;
		}
	}
}




