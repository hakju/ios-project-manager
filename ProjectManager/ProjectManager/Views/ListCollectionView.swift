import UIKit

class ListCollectionView: UICollectionView {
    
    let mainViewController = ViewController()
    
    enum Section {
        case main
    }
    
    var collectionType: State
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, Thing> = {
        return UICollectionViewDiffableDataSource<Section, Thing>(collectionView: self) { (collectionView, indexPath, Thing) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            cell.contentView.backgroundColor = .white
            return cell
        }
    }()
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, collectionType: State) {
        self.collectionType = collectionType
        super.init(frame: frame, collectionViewLayout: layout)
        register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        backgroundColor = .systemGray6
        configureLayout()
        configureDataSource()
        // Hide scroll bar
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionViewLayout = layout
    }
    
    func configureDataSource() {
//        let thing = AddTodoViewController.updateDataSource.first
//        guard let updateTitle = things?.title else { return }
//        guard let updateDescription = things?.description else { return }
//        guard (things?.state) != nil else { return }
//        guard let updateDueDate = things?.dueDate else { return }
        
//        var initialSnapShot = NSDiffableDataSourceSnapshot<Section, Thing>()
//        initialSnapShot.appendSections([.main])
//        initialSnapShot.appendItems([.init(title: updateTitle, description: updateDescription, state: .todo, dueDate: updateDueDate)], toSection: .main)
        
        let things = AddTodoViewController.updateDataSource
        var initialSnapShot = NSDiffableDataSourceSnapshot<Section, Thing>()
        initialSnapShot.appendSections([.main])
        initialSnapShot.appendItems(things)
        
        diffableDataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
                return nil
            }
            supplementaryView.configure(headerType: self.collectionType)
            return supplementaryView
        }

        diffableDataSource.apply(initialSnapShot, animatingDifferences: false)
        
        //1. reloadData를 해주는 위치가 잘못되었는지
        //2. diffableDataSource는 snapShot으로 비교하기 때문에 reloadData가 필요없는건지
    }
}
