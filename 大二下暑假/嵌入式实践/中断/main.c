#include "stm32f10x.h"
#include "Delay.h"

GPIO_InitTypeDef GPIO_InitStructure;

void KEY_Init()  	//������ʼ��	
	{ 
	GPIO_InitTypeDef GPIO_InitStructure; 
		
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB,ENABLE);//ʹ������ʱ��
	 		
 	GPIO_InitStructure.GPIO_Pin =GPIO_Pin_1;//B�˿ڵ�1�Ž�
 	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;//��������
 	GPIO_Init(GPIOB, &GPIO_InitStructure);//�������Ĳ�����ģʽ��ʼ������GPIOB����	
	}

void EXTIX_Init()	//�жϳ�ʼ��
	{
			EXTI_InitTypeDef EXTI_InitStructure; 
		  NVIC_InitTypeDef NVIC_InitStructure; 
		  
		  KEY_Init();
	
      GPIO_EXTILineConfig(GPIO_PortSourceGPIOB,GPIO_PinSource1);
		
	EXTI_InitStructure.EXTI_Line =EXTI_Line1;//ʹ���ⲿ��·
 	EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;//������·Ϊ�ж�����
	EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;//�½��ش���
	EXTI_InitStructure.EXTI_LineCmd=ENABLE;
	EXTI_Init(&EXTI_InitStructure);
		NVIC_InitStructure.NVIC_IRQChannel=EXTI1_IRQn;//�ⲿ�ж���1�ж�
		NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=0x02;//��ռ���ȼ�ȡֵ2
		NVIC_InitStructure.NVIC_IRQChannelSubPriority=0x03;//��Ӧ���ȼ�ȡֵ3
		NVIC_InitStructure.NVIC_IRQChannelCmd=ENABLE;
		NVIC_Init(&NVIC_InitStructure);	
	}
	
	
void LED_Init()	 //���Ƴ�ʼ��
{
	GPIO_InitTypeDef GPIO_InitStructure; 
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);//ʹ������ʱ��
	 		
 	GPIO_InitStructure.GPIO_Pin =GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3;//A�˿�0~3�ĸ��ܽ�
 	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;//�������
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;//������Ƶ��50MHz
		
 	GPIO_Init(GPIOA, &GPIO_InitStructure);//�������Ĳ�����ģʽ��ʼ������GPIOA����	
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
	 
void EXTI1_IRQHandler() //�жϷ�����
{     
	    Delay_ms(10);
	    if(GPIO_ReadInputDataBit(GPIOB,GPIO_Pin_1)==1);
			{
				for (int i=0;i<4;i++)
				{
				GPIO_ResetBits(GPIOA,GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3);//ִ��ȫ������
			  Delay_ms(10000);
				}
			}
			EXTI_ClearITPendingBit(EXTI_Line1);//���Line1�ϵ��жϱ�־λ
}
