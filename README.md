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
- API 문서를 기준으로 할 일에 대한 모델을 정의하였다.
- 할 일을 스와이프하여 삭제가능하게 하였다.
- 기한 날짜가 과거의 날짜면 빨간색으로 표시하게 하였다.
- 할 일을 터치하면 상세보기로 전환하고 수정버튼을 누르기 전까지 수정되지 않는다.
- 수정 버튼을 누르면 할 일을 수정가능하게 하였다.
- 할 일을 드래그하여 다른 영역으로 이동가능하게 하였다.

---

## 💡 어떻게 구현할까? 💡
### UI
- Project Manager는 칸반보드 형식이며 아이패드 전용 앱이다. 처음 UI를 구현하고자 할때 TableView와 CollectionView 둘 중 무엇으로 구현할 지, 고민이 앞섰다.
  - #### TableView vs CollectionView
  |  | 장점 | 단점 |
  | :---- | ---- | ---- |
  | **TableView** | 익숙하게 사용할 수 있다. | 수평 스크롤이 불가하다. |
  | **CollectionView** | 수직, 수평 스크롤이 가능하다. | 사용한 경험이 없어서 미숙하다. | 
  - 우리는 **신기술을 두려워하지 않고 적용해보고자** 한번도 사용해보지 않은 CollectionView를 사용하기로 하였다.
  - (CollectionView로 TableView의 모든 부분을 수용할 수 있는데 TableView를 사용해야하는 이유가 무엇일까?)
  - 추가로 경험해보지 못한 **DiffableDataSource를** 사용해보기로 하였다.

- Create 기능
  - 할 일을 추가할 수 있게 하였다.
  - modal 방식으로 view를 보여주며 할 일의 제목, 기한, 상세 내용을 입력할 수 있다.
  - <img src = "https://user-images.githubusercontent.com/50835836/120988336-6efec680-c7b9-11eb-9c8f-92dd801b5946.gif" alt = "InAppCreate" width = "600" height = "450">
  ``` swift
  //PopOverViewController.swift
  @objc private func didTappedAddDoneButton() {
      let thing = Thing(id: UUID().uuidString, title: textField.text, description: textView.text, state: .todo, dueDate: datePicker.date.timeIntervalSince1970, updatedAt: "\(Date())")
      self.dismiss(animated: true) {
          self.delegate?.addThingToDataSource(self, thing: thing)
      }
  }
    
  @objc private func didTappedCancelButton() {
      self.dismiss(animated: true, completion: nil)
  }
  ```

- 할 일의 기한이 지나면 기한의 글자 색상을 빨간색으로 바꿔주게 하였다.
  ``` swift
  //ListCollectionView.swift
  private func checkIsDatePassed(_ date: Double) -> Bool {
      let currentDate = Date().timeIntervalSince1970
      return date < currentDate
  }
  ```

- Drag & Drop 기능
  - 할 일을 드래그하여 현재 상태에 맞는 영역으로 드롭할 수 있게 하였다.
  - <img src = "https://user-images.githubusercontent.com/50835836/120988672-bedd8d80-c7b9-11eb-8480-900497ef0d5a.gif" alt = "InAppDrag" width = "600" height = "450">
  ``` swift 
  //MARK: - UICollectionViewDragDelegate -
  extension ViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
      guard let collectionView = collectionView as? ListCollectionView,
            let thing = collectionView.diffableDataSource.itemIdentifier(for: indexPath) else {
        return []
      }
        
      let itemProvider = NSItemProvider(object: thing)
      let dragItem = UIDragItem(itemProvider: itemProvider)
        
      return [dragItem]
    }
  }

  //MARK: - UICollectionViewDropDelegate -
  extension ViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
    var dropProposal = UICollectionViewDropProposal(operation: .cancel)
    guard session.items.count == 1 else {
      return dropProposal
    }
    if collectionView.hasActiveDrag {
      dropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    } else {
      dropProposal = UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
    return dropProposal
  }
    
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    guard let collectionView = collectionView as? ListCollectionView else {
      return
    }
        
    let destinationIndexPath: IndexPath
        
    if let indexPath = coordinator.destinationIndexPath {
      destinationIndexPath = indexPath
    } else {
      let section = collectionView.numberOfSections - 1
      let row = collectionView.numberOfItems(inSection: section)
      destinationIndexPath = IndexPath(row: row, section: section)
    }
        
    coordinator.session.loadObjects(ofClass: Thing.self) { [weak self] (items) in
      guard let self = self else { return }
      guard let thingItem = items as? [Thing],
            let thing = thingItem.first else { return }
      let state = collectionView.collectionType
            
      self.deleteFromBefore(thing: thing)
      thing.state = state
      collectionView.reorderDataSource(destinationIndexPath: destinationIndexPath, thing: thing)
      }
    }
  }
  ```
  
- Edit 기능
  - 할 일을 선택하면 제목, 기한, 상세 내용을 보여주는 view를 modal 방식으로 보여준다.
  - edit 버튼을 클릭 시 제목, 기한, 상세 내용을 수정할 수 있게 하였다.
  - <img src = "https://user-images.githubusercontent.com/50835836/120991929-0f0a1f00-c7bd-11eb-9375-6e7f44fcb2dc.gif" alt = "InAppEdit" width = "600" height = "450">
  ``` swift
  //PopOverViewController.swift
  @objc private func didTappedEditButton() {
      guard let contentView = self.navigationController?.viewControllers.last as? PopOverViewController else { return }
      contentView.textField.isUserInteractionEnabled = true
      contentView.datePicker.isUserInteractionEnabled = true
      contentView.textView.isUserInteractionEnabled = true
        
      contentView.textField.becomeFirstResponder()
  }
  
  @objc private func didTappedEditDoneButton() {
      guard let contentView = self.navigationController?.viewControllers.last as? PopOverViewController else { return }
      guard let thing = self.thing else {
          return
      }
      self.dismiss(animated: true) {
          thing.title = contentView.textField.text
          thing.detail = contentView.textView.text
          thing.dueDate = contentView.datePicker.date.timeIntervalSince1970
          self.delegate?.editThingToDataSource(self, thing: thing)
      }
  }
  
  //ViewController.swift
  func editThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing) {
      guard let state = thing.state else { return }
      switch state {
      case .todo:
          todoCollectionView.updateThing(thing: thing)
      case .doing:
          doingCollectionView.updateThing(thing: thing)
      case .done:
          doneCollectionView.updateThing(thing: thing)
      }
  }
  ```

- PopOverViewController가 화면에 보여지지 않을 CollectionView를 들고 다녀서 발생하는 문제가 있었고 PopOverViewController의 view들을 private으로 설정할 수 없었다.
  - 기존에 PopOverViewController의 view들은 ViewController에서 접근하고 있었기 때문에 private으로 설정해줄 수 없었다. 그래서 ViewController에서는 PopOverViewController에 사용할 Thing만 넘겨주고, 그 Thing의 유무에 따라 Add를 위한 PopOverViewController인지 Edit를 위한 PopOverViewController인지 결정하게 하였다. 그래서 기존에 ViewController에서 접근하여 설정했던 값들을 PopOverViewController에서 설정하여 View들에게 접근제한자를 설정해줄 수 있게 하였다.
  - 기존에 PopOverViewController가 화면에 보여지지 않을 CollectionView를 소유하고 있었는데 이를 PopOverViewController에 Protocol을 생성해주면서 Delegate 패턴을 사용하여 해결했다.
  ``` swift
  // 변경 전
  func didTapAddButton(with collectionView: ListCollectionView) {
      let addTodoViewController = AddTodoViewController(collectionView: collectionView)
      addTodoViewController.modalPresentationStyle = .formSheet
      self.present(UINavigationController(rootViewController: addTodoViewController), animated: true, completion: nil)
  }

  // 변경 후
  private func didTapAddButton(with collectionView: ListCollectionView) {
      let popOverViewController = PopOverViewController(thing: nil)
      popOverViewController.modalPresentationStyle = .formSheet
      popOverViewController.delegate = self
      self.present(UINavigationController(rootViewController: popOverViewController), animated: true, completion: nil)
  }
  
  protocol PopOverViewDelegate: AnyObject {
    func addThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing)
    func editThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing)
  }
  
  @objc private func didTappedAddDoneButton() {
      let thing = Thing(id: UUID().uuidString, title: textField.text, description: textView.text, state: .todo, dueDate: datePicker.date.timeIntervalSince1970, updatedAt: "\(Date())")
      self.dismiss(animated: true) {
          self.delegate?.addThingToDataSource(self, thing: thing)
      }
  }
  ```
  
- Delete 기능
  - 할 일을 스와이프하면 삭제할 수 있게 하였다.
  - 1번 스와이프시, 삭제 버튼이 생기고 버튼을 클릭하거나 1번 더 스와이프하게되면 삭제가 된다.
  - <img src = "https://user-images.githubusercontent.com/50835836/120988245-58f10600-c7b9-11eb-9f74-21c43a731cd7.gif" alt = "InAppDelete" width = "600" height = "450">
  ``` swift
  // ListCollectionView.swift
  func deleteDataSource(thing: Thing) {
    var snapshot = diffableDataSource.snapshot()
    snapshot.deleteItems([thing])
    diffableDataSource.apply(snapshot, animatingDifferences: true)
  }
  
  // UIHelper.swift
  var listConfigration = UICollectionLayoutListConfiguration(appearance: .plain)
  listConfigration.trailingSwipeActionsConfigurationProvider = { indexPath in
    guard let thing = collectionView.diffableDataSource.itemIdentifier(for: indexPath) else {
      return nil
    }
    let actionHandler: UIContextualAction.Handler = { action, view, completion in
      collectionView.deleteDataSource(thing: thing)
    }
    let action = UIContextualAction(style: .destructive, title: "Delete", handler: actionHandler)
    return UISwipeActionsConfiguration(actions: [action])
  }
  let layout = UICollectionViewCompositionalLayout.list(using: listConfigration)
  ```
  
