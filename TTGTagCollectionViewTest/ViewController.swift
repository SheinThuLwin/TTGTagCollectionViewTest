//
//  ViewController.swift
//  TTGTagCollectionViewTest
//
//  Created by ut-i02 on 08/02/2022.
//

import UIKit
import TTGTags

class ViewController: UIViewController {

    @IBOutlet weak var tagView: TTGTextTagCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTagView(tagView: tagView)
    }
    
    private func loadTagView(tagView: TTGTextTagCollectionView){
        let fontSize: CGFloat = 20
        let extraSpace = CGSize.init(width: 8, height: 8)
        
        let tagsTitle = "Brand:"
        let strings = ["Audi", "Bentley", "BMW", "Cadillac", "Chevrolet",
                       "Dodge", "Ford", "GMC", "Honda", "Hyundai", "Jaguar", "Jeep", "KIA",
                       "Land Rover", "Lotus", "Mazda", "Mercedes-Benz", "Mitsubishi", "Nissan",
                       "Porsche", "Roll-Royce", "Subaru", "Suzuki", "Tesla", "Toyota",
                       "Volkswagen", "Volvo"]
        
        
        tagView.scrollDirection = TTGTagCollectionScrollDirection.horizontal
        tagView.delegate = self
        
        let count = strings.count
        
        for i in 0...count {
            if i != 0{
                let tag = getTag(text: strings[i - 1], fontSize: fontSize, extraSpace: extraSpace)
                tagView.addTag(tag)
            }else{//For title
                let tag = getTagTitle(title: tagsTitle, fontSize: fontSize, extraSpace: extraSpace)
                tagView.addTag(tag)
            }
        }
        
        tagView.reload()
    }
    
    private func getTagTitle(title: String, fontSize: CGFloat, extraSpace: CGSize) -> TTGTextTag{
        
        let content = TTGTextTagStringContent.init(text: title)
        content.textColor = UIColor.black
        content.textFont = UIFont.boldSystemFont(ofSize: fontSize)
        
        let selectedContent = TTGTextTagStringContent.init(text: title)
        selectedContent.textColor = UIColor.black
        selectedContent.textFont = UIFont.boldSystemFont(ofSize: fontSize)
        
        let normalStyle = TTGTextTagStyle.init()
        normalStyle.backgroundColor = UIColor.clear
        normalStyle.shadowOpacity = 0
        normalStyle.textAlignment = .center
        normalStyle.extraSpace = extraSpace
        
        let selectedStyle = TTGTextTagStyle.init()
        selectedStyle.backgroundColor = UIColor.clear
        selectedStyle.shadowOpacity = 0
        selectedStyle.textAlignment = .center
        selectedStyle.extraSpace = extraSpace
        
        let tag = TTGTextTag.init()
        tag.content = content
        tag.selectedContent = selectedContent
        tag.style = normalStyle
        tag.selectedStyle = selectedStyle
        
        return tag
    }
    
    private func getTag(text: String, fontSize: CGFloat, extraSpace: CGSize) -> TTGTextTag{
        let content = TTGTextTagStringContent.init(text: text)
        content.textColor = UIColor.black
        content.textFont = UIFont.boldSystemFont(ofSize: fontSize)
        
        let selectedContent = TTGTextTagStringContent.init(text: text)
        selectedContent.textColor = UIColor.red
        selectedContent.textFont = UIFont.boldSystemFont(ofSize: fontSize)
        
        let normalStyle = TTGTextTagStyle.init()
        normalStyle.backgroundColor = UIColor.lightGray
        normalStyle.shadowOpacity = 0
        normalStyle.textAlignment = .center
        normalStyle.extraSpace = extraSpace
        
        let selectedStyle = TTGTextTagStyle.init()
        selectedStyle.backgroundColor = UIColor.green
        selectedStyle.shadowOpacity = 0
        selectedStyle.textAlignment = .center
        selectedStyle.extraSpace = extraSpace
        
        let tag = TTGTextTag.init()
        tag.content = content
        tag.selectedContent = selectedContent
        tag.style = normalStyle
        tag.selectedStyle = selectedStyle
        
        return tag
    }
}

extension ViewController: TTGTextTagCollectionViewDelegate{
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        guard index != 0 else{
            return
        }
        let selectedTags = tagView.allSelectedTags()
        let count = selectedTags?.count ?? 0
        print("Tag Tap Index>> \(index)")
        
        if let selectedTags = selectedTags, selectedTags.count > 0{
            var selectedInfo = ""
            for selectedTag in selectedTags {
                if let tag = selectedTag.selectedContent as? TTGTextTagStringContent{
                    selectedInfo += "\(selectedTag.tagId): \(tag.text), "
                }
            }
            print("Selected \(count) tag(s) >> \(selectedInfo)")
        }
    }
}
