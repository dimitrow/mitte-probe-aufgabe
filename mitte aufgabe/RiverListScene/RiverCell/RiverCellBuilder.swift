//
//  RiverCellBuilder.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 23.08.21.
//

import UIKit
import SDWebImage

class RiverCellBuilder {

    func buildCell(for tableView: UITableView, river: RiverModel, measureUnit: MeasureUnit) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RiverCell.identifier) as? RiverCell

        cell?.riverNameLabel.text = river.name
        
        var riverLenth = ""
        
        switch measureUnit {
        case .kilometers:
            riverLenth = "\(river.length.km) km."
            break
        case .miles:
            riverLenth = "\(river.length.miles) mi."
            break
        }
        
        cell?.riverLengthLabel.attributedText = buildAttributedTextForLenght(riverLenth)
        
        let imageURL = URL(string: river.imageURL)
        
        cell?.riverThumbnailImageView.sd_setImage(with: imageURL, placeholderImage: nil) { image, error, cache, url in
            
            cell?.riverThumbnailImageView.image  = image
        }

        return cell ?? UITableViewCell()
    }
    
    private func buildAttributedTextForLenght(_ value: String) -> NSAttributedString {
        
        let boldAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold)]
        let titleString = NSMutableAttributedString(string: "Length: ", attributes: boldAttributes)
        let valueString = NSMutableAttributedString(string: value)
        
        titleString.append(valueString)
        return titleString
    }
}
