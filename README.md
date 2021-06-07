# 👨🏻‍💼 프로젝트 매니저 👨🏻‍💼
- 소개: 칸반보드 형식의 프로젝트를 관리해주는 아이패드 전용 앱이다.
- 기간: 2021. 03. 29 ~ 2021. 04. 18
- 팀원: [꼬말](https://github.com/hakju), [글렌](https://github.com/Journey36), [준스](https://github.com/elddy0948)

## 팀 프로젝트 그라운드 룰
- 팀원 : 글렌, 꼬말, 준스
- 기간 : 2021. 03. 29 ~ 2021. 04. 18

- 우리 팀만의 규칙
  - 디스코드에 있을 때는 언제든지 편하게 연락
  - github에서 project, issue, milestone, dicussions 적극활용해서 프로젝트 진행하기

- 스크럼
  - 스크럼 시간은 오전 11시 (월, 화, 목, 금)
  - 나눌 내용
  - 컨디션 공유
  - 어제 공부한 내용 공유
  - 오늘 할 일 공유
  - 프로젝트 진행사항 공유

- 프로젝트
  - Commit
  - 커밋단위 : 빌드되는 상태에서, 기능단위로 커밋하기.
  - Type 규칙 (커밋 메세지에 이슈 번호를 추가하면 해당 이슈로 commit이 넘어감)
  - 예시 → Type종류 #이슈번호 - commit 내용
  - Feat: 기능 구현
  - Refactor: 기능 수정
  - Fix: 버그 수정
  - Style: 동작에 영향없는 코드변경, 이름변경
  - Docs: 문서수정
  - Chore: 기타

- 코딩 컨벤션
  - Swift API 디자인 가이드라인을 준수하기
  - naming에 신경쓰기.
  - 의미없는 띄어쓰기 안하도록 주의하기.
  - 기능 분리 잘 되도록 주의하기. (1 함수 1 기능 지향) 
---
 
## 📱 앱 동작화면 📱
<img src = "https://user-images.githubusercontent.com/50835836/120988672-bedd8d80-c7b9-11eb-8480-900497ef0d5a.gif" alt = "InAppDrag" width = "600" height = "450">
<img src = "https://user-images.githubusercontent.com/50835836/120991929-0f0a1f00-c7bd-11eb-9375-6e7f44fcb2dc.gif" alt = "InAppEdit" width = "600" height = "450">
<img src = "https://user-images.githubusercontent.com/50835836/120988245-58f10600-c7b9-11eb-9f74-21c43a731cd7.gif" alt = "InAppDelete" width = "600" height = "450">
<img src = "https://user-images.githubusercontent.com/50835836/120988336-6efec680-c7b9-11eb-9c8f-92dd801b5946.gif" alt = "InAppCreate" width = "600" height = "450">

---

## 👨🏻‍💻 구현 내용 👨🏻‍💻
- 할 일을 스와이프하여 삭제가능하게 하였다.
- 기한 날짜가 과거의 날짜면 빨간색으로 표시하게 하였다.
- 할 일을 터치하면 상세보기로 전환하고 수정버튼을 누르기 전까지 수정되지 않는다.
- 수정 버튼을 누르면 할 일을 수정가능하게 하였다.
- 할 일을 드래그하여 다른 영역으로 이동가능하게 하였다.

---

## 💡 어떻게 구현할까? 💡
### UI
- Project Manager는 칸반보드 형식이며 아이패드 전용 앱이다. 처음 UI를 구현하고자 할때 TableView와 CollectionView 둘 중 무엇으로 구현할 지, 고민이 앞섰다.
