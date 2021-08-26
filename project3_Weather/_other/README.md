# edwithStudy-project-4

- - -

# 3. 기상 정보 애플리케이션

- - -

## 프로젝트C. WeatherToday

- - -

### edwith boostcourse iOS Programming 세 번째 프로젝트 입니다.

- 기간 : 2019.12.29 ~ 2020.01.09
- 역활 : 앱 전체 구현
- 사용기술 : Swift, Foundation
- 프로젝트 인원 : 1명

- - -

### 앱 설명

- 1) 세계 국가 리스트 화면
  - 테이블뷰 셀 왼쪽에는 국기 이미지를 보여주며, 국기 이미지 오른쪽에는 국가 이름을 보여줍니다.
  - 셀의 악세서리뷰를 통해 다음 화면으로 이동 가능함을 표시합니다.
  - 테이블뷰 셀을 선택하면 도시 목록 화면으로 전환됩니다.
  
- 2) 도시 목록 화면
  - 내비게이션 아이템의 타이틀은 이전 화면에서 선택된 국가 이름입니다.
  - 셀 왼쪽에 해당 날씨에 맞는 이미지(비/구름/해/눈)를 보여줍니다.
  - 이미지 오른쪽에 도시명, 온도(섭씨/화씨), 강수확률을 보여줍니다.
  - 셀의 악세서리뷰를 표시해 다음 화면으로 이동 가능함을 나타냅니다.
  - 내비게이션 이전 버튼을 누르면 이전 화면(세계 국가 리스트 화면)으로 되돌아가며, 테이블뷰 셀을 선택하면 날씨 세부 정보 화면으로 전환됩니다.
  
- 3) 날씨 세부 정보 화면
  - 내비게이션 아이템의 타이틀은 이전 화면에서 선택된 도시 이름입니다.
  - 화면 상단에는 날씨 이미지를 보여주고, 화면 하단에는 날씨 세부 정보를 문자열로 나타냅니다.

- JSON
  - 화면에 나타나는 국가, 국기, 날씨, 온도, 습도등 모든 정보들은 주어진 JSON 데이터 에셋의 JSON 데이터를 디코딩 하여 테이블 뷰에 뿌려주어 만들었습니다.
- - -

### 앱 실행 화면

<img width="200" alt="image" src="https://github.com/VincentGeranium/Resume/blob/master/IMAGE/weatherToday-4.gif?raw=true">

<img width="200" alt="image" src="https://github.com/VincentGeranium/Resume/blob/master/IMAGE/weatherToday-1.PNG?raw=true"><img width="200" alt="image" src="https://github.com/VincentGeranium/Resume/blob/master/IMAGE/weatherToday-2.PNG?raw=true"><img width="200" alt="image" src="https://github.com/VincentGeranium/Resume/blob/master/IMAGE/weatherToday-3.PNG?raw=true">

- - -
