//
//  UICollectionView+Extension.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import UIKit

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }

    public func register(reusableViewType: UICollectionReusableView.Type, ofKind kind: String = UICollectionView.elementKindSectionHeader) {
        register(UINib(nibName: String(describing: reusableViewType), bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: reusableViewType))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }
    
    func setEmptyView(title: String, message: String, imageName: String) {
            let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.frame.size.width, height: self.frame.size.height))
            
            let titleLabel = UILabel()
            let messageLabel = UILabel()
            let imageView = UIImageView(image: UIImage(imageLiteralResourceName: imageName))
            
            imageView.backgroundColor = .clear
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
            
            
            emptyView.addSubview(titleLabel)
            emptyView.addSubview(messageLabel)
            emptyView.addSubview(imageView)
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: 10).isActive = true
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: -10).isActive = true
            
            imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            titleLabel.text = title
            messageLabel.text = message
            
            titleLabel.textAlignment = .center
            messageLabel.textAlignment = .center
            
            titleLabel.numberOfLines = 0
            messageLabel.numberOfLines = 0
            
            self.backgroundView = emptyView
        }
        func restore() {
            self.backgroundView = nil
        }
}
/*extension UIView {
func setEmptyView(title: String, message: String, imageName: String){
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        let imageView = UIImageView(image: UIImage(imageLiteralResourceName: imageName))
        
        imageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
        
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(imageView)
        
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
       // messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: 10).isActive = true
        //messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.text = title
        messageLabel.text = message
        
        titleLabel.textAlignment = .center
        messageLabel.textAlignment = .center
        
        titleLabel.numberOfLines = 0
        messageLabel.numberOfLines = 0
        addSubview(emptyView)
    }
    func restore() {
        removeFromSuperview()
    }
}*/
