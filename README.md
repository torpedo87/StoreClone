# StoreClone (toy project)
- [demo link](https://www.youtube.com/watch?v=4ejtuuail0E)

![Alt text](/Screenshots/allshot.png)

## purpose

- 토이프로젝트
- 아이튠즈 검색 API를 통해 데이터를 받아와서 테이블뷰에 나타내기
- unit test 작성
- 외부 라이브러리 사용하지 않기

## review

- 유닛테스트 작성을 위해 고민하다보니 의존성 주입을 통해 테스트하기 좋은 구조로 코드를 개선할 수 있었습니다
- 동적으로 테이블뷰 셀 높이를 조절하는 기능을 구현할 때에 셀 높이에 해당하는 constraint 를 중간에 교체하는 경험을 통해 NSLayoutConstraint 에 대해 알 수 있었고 셀 높이에 대한 constraint 가 서로 충돌하면서 이를 해결하는 과정에서 constriant 의 priority 에 대해서도 알 수 있었습니다
- OperationQueue 를 사용하여 intensive 한 작업을 메인 스레드 이외의 스레드에서 처리 
- 스크롤 시 interactive 한 UI를 유지하기 위해 tableView의 prefetch API 사용하여 화면에 보이기 전에 미리 작업처리 
