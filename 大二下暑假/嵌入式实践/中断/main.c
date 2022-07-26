#include "stm32f10x.h"
#include "Delay.h"

GPIO_InitTypeDef GPIO_InitStructure;

void KEY_Init()  	//按键初始化	
	{ 
	GPIO_InitTypeDef GPIO_InitStructure; 
		
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB,ENABLE);//使能外设时钟
	 		
 	GPIO_InitStructure.GPIO_Pin =GPIO_Pin_1;//B端口的1号脚
 	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;//上拉输入
 	GPIO_Init(GPIOB, &GPIO_InitStructure);//将上述的参数和模式初始化用在GPIOB口上	
	}

void EXTIX_Init()	//中断初始化
	{
			EXTI_InitTypeDef EXTI_InitStructure; 
		  NVIC_InitTypeDef NVIC_InitStructure; 
		  
		  KEY_Init();
	
      GPIO_EXTILineConfig(GPIO_PortSourceGPIOB,GPIO_PinSource1);
		
	EXTI_InitStructure.EXTI_Line =EXTI_Line1;//使能外部线路
 	EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;//设置线路为中断请求
	EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;//下降沿触发
	EXTI_InitStructure.EXTI_LineCmd=ENABLE;
	EXTI_Init(&EXTI_InitStructure);
		NVIC_InitStructure.NVIC_IRQChannel=EXTI1_IRQn;//外部中断线1中断
		NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=0x02;//抢占优先级取值2
		NVIC_InitStructure.NVIC_IRQChannelSubPriority=0x03;//响应优先级取值3
		NVIC_InitStructure.NVIC_IRQChannelCmd=ENABLE;
		NVIC_Init(&NVIC_InitStructure);	
	}
	
	
void LED_Init()	 //亮灯初始化
{
	GPIO_InitTypeDef GPIO_InitStructure; 
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);//使能外设时钟
	 		
 	GPIO_InitStructure.GPIO_Pin =GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3;//A端口0~3四个管脚
 	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;//推挽输出
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;//最高输出频率50MHz
		
 	GPIO_Init(GPIOA, &GPIO_InitStructure);//将上述的参数和模式初始化用在GPIOA口上	
}
int main()
	 {
		 EXTIX_Init();
		 LED_Init();
			while(1)
			{
GPIO_SetBits(GPIOA,GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3)	;			          
				Delay_ms(10000);				
GPIO_ResetBits(GPIOA,GPIO_Pin_0);
	  	  Delay_ms(10000);				

GPIO_SetBits(GPIOA,GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3)		;		           
				Delay_ms(10000);
GPIO_ResetBits(GPIOA,GPIO_Pin_1);
	  	  Delay_ms(10000);				

GPIO_SetBits(GPIOA,GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3)		;		           
				Delay_ms(10000);
GPIO_ResetBits(GPIOA,GPIO_Pin_2);
	  	  Delay_ms(10000);				

GPIO_SetBits(GPIOA,GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3);
				Delay_ms(10000);
GPIO_ResetBits(GPIOA,GPIO_Pin_3);
	  	  Delay_ms(10000);				
			}				
} 
	 
void EXTI1_IRQHandler() //中断服务函数
{     
	    Delay_ms(10);
	    if(GPIO_ReadInputDataBit(GPIOB,GPIO_Pin_1)==1);
			{
				for (int i=0;i<4;i++)
				{
				GPIO_ResetBits(GPIOA,GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3);//执行全亮操作
			  Delay_ms(10000);
				}
			}
			EXTI_ClearITPendingBit(EXTI_Line1);//清除Line1上的中断标志位
}
