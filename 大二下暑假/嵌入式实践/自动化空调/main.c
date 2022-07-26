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

	delay_init();	    	 //��ʱ������ʼ��	  
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);//�����ж����ȼ�����Ϊ��2��2λ��ռ���ȼ���2λ��Ӧ���ȼ�
	uart_init(115200);	 	//���ڳ�ʼ��Ϊ115200
	LED_Init();		  		//��ʼ����LED���ӵ�Ӳ���ӿ�
	OLED_Init();			   	//��ʼ��OLED 
	OLED_Clear();
	OLED_Refresh();
	OLED_ColorTurn(0);//0������ʾ��1 ��ɫ��ʾ
    OLED_DisplayTurn(0);//0������ʾ 1 ��Ļ��ת��ʾ
 	
			  
 	while(DHT11_Init())	//DHT11��ʼ��	
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
	    
	
		
 		if(t%10==0)			//ÿ100ms��ȡһ��
		{			
			OLED_ShowString(0,0,"DHT11 OK",16,1);
			OLED_Refresh();
			DHT11_Read_Data(&temperature,&humidity);	//��ȡ��ʪ��ֵ	
			printf("\r\ntemp=%d\r\nhumi=%d",temperature,humidity);
//          OLED_ShowString();		
//			LCD_ShowNum(30+40,150,temperature,2,16);	//��ʾ�¶�	
//			OLED_ShowString();
//			LCD_ShowNum(30+40,170,humidity,2,16);		//��ʾʪ��	 	   
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




