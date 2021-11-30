#define FOSC 16000000  // 아두이노 작동 클럭. (16MHz)

#define SERVO_1 5 // 서보1(FR) 핀 번호
#define SERVO_2 6 // 서보2(RR) 핀 번호
#define SERVO_3 7 // 서보3(FL) 핀 번호
#define SERVO_4 8 // 서보4(RL) 핀 번호
#define SERVO_5 9 // 서보4(RL) 핀 번호

int number;
int buff[8];
int behind_degree = 0;
double DUTY_dsr;
double DUTY_dsr_1;
double angle_dsr;
double angle_dsr_1;
double angle_dsr_l;
double angle_dsr_r;
double angle_flapping = 0;
double angle_init = 0.0;
double t = 0;
double T = 1.5;
int NUM;
double TRASH;
int CNT = 0;
boolean WHITE_FLAG = 0;
double target_degree;
double pre_degree;

void setup()
{
  Serial1.begin(9600);
  Serial.begin(9600);
  pinMode(SERVO_1, OUTPUT);
  pinMode(SERVO_2, OUTPUT);
  pinMode(SERVO_3, OUTPUT);
  pinMode(SERVO_4, OUTPUT);
  pinMode(SERVO_5, OUTPUT);

  // 인터럽트 설정
  noInterrupts();
  TIME_INTERRUPT_REGISTER();  // 타임 인터럽트 레지스터 적용
  interrupts();

}

void loop() 
{
  GET_MATLAB_GUI_DATA_1();

  Serial.println(angle_flapping);
  Serial.println(behind_degree);
  Serial.println(NUM);

}

ISR(TIMER1_COMPA_vect)
{
  ///Forward////
  if (NUM == 1) 
  {
    t = t + 0.02;
    CNT++;
    // target_degree = 100;

    angle_dsr =  angle_flapping * sin(2 * PI * t / T) + pre_degree;
    // angle_dsr = (target_degree - pre_degree) / 2.0 * (1 - cos(PI / T * t)) + pre_degree;

    REAL_CYCLE(angle_dsr);
    Forward_1(DUTY_dsr);
    Forward_2(DUTY_dsr);
    Serial.println(angle_dsr);
  }

  /////Left/////
  if (NUM == 2) 
  {
    t = t + 0.02;
    CNT++;
    // target_degree = 100;

    angle_dsr_l =  angle_flapping/2 * sin(2 * PI * t / T) + pre_degree;
    angle_dsr_r =  angle_flapping * sin(2 * PI * t / T) + pre_degree;
    // angle_dsr = (target_degree - pre_degree) / 2.0 * (1 - cos(PI / T * t)) + pre_degree;
 
    REAL_CYCLE_l(angle_dsr_l);
    REAL_CYCLE_r(angle_dsr_r);
    Forward_1(DUTY_dsr_l);
    Forward_2(DUTY_dsr_r);

    // angle_dsr_1 = behind_degree;
    // REAL_CYCLE_1(angle_dsr_1);
    // Up(DUTY_dsr_1);
  }

  /////Right/////
  if (NUM == 3) 
  {
    t = t + 0.02;
    CNT++;
    // target_degree = 100;

    angle_dsr_l =  angle_flapping * sin(2 * PI * t / T) + pre_degree;
    angle_dsr_r =  angle_flapping/2 * sin(2 * PI * t / T) + pre_degree;
    // angle_dsr = (target_degree - pre_degree) / 2.0 * (1 - cos(PI / T * t)) + pre_degree;

    REAL_CYCLE_l(angle_dsr_l);
    REAL_CYCLE_r(angle_dsr_r);
    Forward_1(DUTY_dsr_l);
    Forward_2(DUTY_dsr_r);

    // angle_dsr_1 = behind_degree;
    // REAL_CYCLE_1(angle_dsr_1);
    // Up(DUTY_dsr_1)
  }

  ///////Up///////
  if (NUM == 4) 
  {
    t = t + 0.02;
    CNT++;
    // target_degree = 100;

    angle_dsr_l =  angle_flapping * sin(2 * PI * t / T) + pre_degree;
    angle_dsr_r =  angle_flapping * sin(2 * PI * t / T) + pre_degree;
    // angle_dsr = (target_degree - pre_degree) / 2.0 * (1 - cos(PI / T * t)) + pre_degree;
    
    REAL_CYCLE(angle_dsr);

    Forward_1(DUTY_dsr_l);
    Forward_2(DUTY_dsr_r);

    angle_dsr_1 = behind_degree;
    REAL_CYCLE_1(angle_dsr_1);
    Up(DUTY_dsr_1);
  }

 ///////Down///////
  if (NUM == 5) 
  {
    t = t + 0.02;
    CNT++;
    // target_degree = 100;

    angle_dsr_l =  angle_flapping * sin(2 * PI * t / T) + pre_degree;
    angle_dsr_r =  angle_flapping * sin(2 * PI * t / T) + pre_degree;
    // angle_dsr = (target_degree - pre_degree) / 2.0 * (1 - cos(PI / T * t)) + pre_degree;
    
    REAL_CYCLE(angle_dsr);

    Forward_1(DUTY_dsr_l);
    Forward_2(DUTY_dsr_r);

    angle_dsr_1 = -behind_degree;
    REAL_CYCLE_1(angle_dsr_1);
    Up(DUTY_dsr_1);
  }

/////Stop//////
  if (NUM == 6) 
  { 
    REAL_CYCLE(angle_dsr);

    Forward_1(DUTY_dsr);
    Forward_2(DUTY_dsr);

    angle_dsr_1 = behind_degree;
    REAL_CYCLE_1(angle_dsr_1);
    Up(DUTY_dsr_1);
  }
}

void REAL_CYCLE(double servo_degree)
{
  DUTY_dsr = 10 * servo_degree + 1500; // 각도를,,,?
}
void REAL_CYCLE_l(double servo_degree)
{
  DUTY_dsr_l = 10 * servo_degree + 1500; // 각도를,,,?
}
void REAL_CYCLE_r(double servo_degree)
{
  DUTY_dsr_r = 10 * servo_degree + 1500; // 각도를,,,?
}

void REAL_CYCLE_1(double servo_degree)
{
  DUTY_dsr_1 = 10 * servo_degree + 1500;
}

void Forward_1(double DUTY_dsr)
{
  // duty length 만큼 핀에 HIGH 전송
  digitalWrite(SERVO_1, HIGH);
  delayMicroseconds(DUTY_dsr);

  // 20ms에서 남은 시간 만큼 LOW 전송
  digitalWrite(SERVO_1, LOW);
  delayMicroseconds(20000 - DUTY_dsr);
}

void Forward_2(double DUTY_dsr)
{
  // duty length 만큼 핀에 HIGH 전송
  digitalWrite(SERVO_2, HIGH);
  delayMicroseconds(DUTY_dsr);

  // 20ms에서 남은 시간 만큼 LOW 전송
  digitalWrite(SERVO_2, LOW);
  delayMicroseconds(20000 - DUTY_dsr);
}

/////////////////////////////////////////////////////////////////////////////////////
void Up(double DUTY_dsr)
{
  // duty length 만큼 핀에 HIGH 전송
  
  digitalWrite(SERVO_3, HIGH);
  delayMicroseconds(DUTY_dsr);

  // 20ms에서 남은 시간 만큼 LOW 전송

  digitalWrite(SERVO_3, LOW);

  // duty length 만큼 핀에 HIGH 전송

  digitalWrite(SERVO_4, HIGH);
  delayMicroseconds(DUTY_dsr);

  // 20ms에서 남은 시간 만큼 LOW 전송

  digitalWrite(SERVO_4, LOW);
}

///////////매트랩에서 값 받아오기///////////
void GET_MATLAB_GUI_DATA_1() {
  char tmp_buff;

  if (Serial1.available() > 0) { // buff에 값이 들어오면 양수가 돼서 실행

    for (int i = 1; i < 9; i++) {
      buff[i - 1] = buff[i];
    }
    tmp_buff = Serial1.read();
    buff[7] = tmp_buff - '0'; // char로 받아서 0의 아스키코드만큼 빼준다

    if ( buff[0] == 49 && buff[3] == 50 && buff[6] == 51) // 실제 값이 입력되는 곳은 배열의 1,2,4,5이다
    {
      angle_flapping = (buff[1] * 10) + (buff[2] * 1); // 십진수로 변화
      behind_degree = (buff[4] * 10) + (buff[5] * 1);
      NUM = (buff[7]);
    }

  }

}

void TIME_INTERRUPT_REGISTER()
{
  /* CNC 모드: TCNT1이 OCR1A에 도달할 떄마다 토글 */
  TCCR1A = 0;               // 제어 레지스터
  TCNT1 = 0;                // 타이머, 카운터 레지스터
  OCR1A = 39999;            // 출력 비교 레지스터  -   40000 * 8(prescaler) / 16000000(작동클럭) = 0.020 sec(20ms)
  TIMSK1 |= (1 << OCIE1A);  // 마스크 레지스터 (TCNT를 OCRnA레지스터랑 비교하는 모드)

  TCCR1B = 0;             // 제어 레지스터
  TCCR1B |= (1 << WGM12); // 제어 레지스터 - TCCR1B에서 WGM12만큼 이동한 곳을 1로 변경
  TCCR1B |= (0 << CS10) | (1 << CS11) | (0 << CS12); // 제어 레지스터: prescaler = 8
}
